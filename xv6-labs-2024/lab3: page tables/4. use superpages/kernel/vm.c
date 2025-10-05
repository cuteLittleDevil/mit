pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
  if(va >= MAXVA)
    panic("walk");

  for(int level = 2; level > 0; level--) {
    pte_t *pte = &pagetable[PX(level, va)];
    if(*pte & PTE_V) {
      pagetable = (pagetable_t)PTE2PA(*pte);
      // todo 超级页的情况 直接返回
      if(*pte & PTE_S) {
        return pte;
      }
#ifdef LAB_PGTBL
      if(PTE_LEAF(*pte)) {
        return pte;
      }
#endif
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
           return 0;
      memset(pagetable, 0, PGSIZE);
      *pte = PA2PTE(pagetable) | PTE_V;
    }
  }
  return &pagetable[PX(0, va)];
}

// todo 超级页是2MB 2的21次方 从L2开始查询到L1(即L1的pte指向超级页)就可以了
pte_t *
superwalk(pagetable_t pagetable, uint64 va, int alloc)
{
  if(va >= MAXVA)
    panic("walk");

  pte_t *pte = &pagetable[PX(2, va)];
  if(*pte & PTE_V) {
      pagetable = (pagetable_t)PTE2PA(*pte);
  } else {
        if(!alloc || (pagetable = (pde_t*)superkalloc()) == 0) {
          printf("superwalk: superkalloc fail\n");
          return 0;
        }
        memset(pagetable, 0, SUPERPGSIZE);
        *pte = PA2PTE(pagetable) | PTE_V | PTE_S;
  }
  return &pagetable[PX(1, va)];
}

// todo 参考mappages修改
int
supermappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
  uint64 a, last;
  pte_t *pte;

  if((va % SUPERPGSIZE) != 0)
    panic("super mappages: va not aligned");

  if((size % SUPERPGSIZE) != 0)
    panic("super mappages: size not aligned");

  if(size == 0)
    panic("super mappages: size");

  a = va;
  last = va + size - SUPERPGSIZE;
  for(;;){
    if((pte = superwalk(pagetable, a, 1)) == 0)
      return -1;
    if(*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V | PTE_S;
    if(a == last)
      break;
    a += SUPERPGSIZE;
    pa += SUPERPGSIZE;
  }
  return 0;
}

void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
  uint64 a;
  pte_t *pte;
  int sz;

  if((va % PGSIZE) != 0)
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += sz){
    if((pte = walk(pagetable, a, 0)) == 0)
      panic("uvmunmap: walk");
    if((*pte & PTE_V) == 0) {
      printf("va=%ld pte=%p\n", a, (void*)pte);
      panic("uvmunmap: not mapped");
    }
    if(PTE_FLAGS(*pte) == PTE_V)
      panic("uvmunmap: not a leaf");
    // todo 额外处理超级页的情况
    if(do_free){
      uint64 pa = PTE2PA(*pte);
      if(*pte & PTE_S) {
        superkfree((void*)pa);
      } else {
        kfree((void*)pa);
      }
    }
    sz = PGSIZE;
    if(*pte & PTE_S) {
      sz = SUPERPGSIZE;
    }
//      printf("va = %ld sz=%d\n", a, sz);
    *pte = 0;
  }
}

// todo 额外处理超级页的情况
uint64
uvmalloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz, int xperm)
{
  char *mem;
  uint64 a;
  int sz;

  if(newsz < oldsz)
    return oldsz;

  oldsz = PGROUNDUP(oldsz);;
  for(a = oldsz; a < newsz; a += sz){
    // 够分配超级页表就分配超级页表
    if((a % SUPERPGSIZE == 0) && (newsz - a >= SUPERPGSIZE)) {
      sz = SUPERPGSIZE;
      mem = superkalloc();
    } else {
      sz = PGSIZE;
      mem = kalloc();
    }
    if(mem == 0){
      uvmdealloc(pagetable, a, oldsz);
      return 0;
    }
#ifndef LAB_SYSCALL
    memset(mem, 0, sz);
#endif
    if(sz == SUPERPGSIZE) {
          if(supermappages(pagetable, a, sz, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
            superkfree(mem);
            uvmdealloc(pagetable, a, oldsz);
            return 0;
          }
    }else {
      if(mappages(pagetable, a, sz, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
        kfree(mem);
        uvmdealloc(pagetable, a, oldsz);
        return 0;
      }
    }
  }
  return newsz;
}

// todo 选择在sbrk的时候 记录超姐页 普通页情况的方案
struct sbrkhelp
sbrksuperuvmalloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz, int xperm)
{
  struct sbrkhelp help = {
      .sz = 0,
      .state = 0,
      .startpages = 0,
      .superpages = 0,
      .endpages = 0
  };
  char *mem;
  uint64 a;
  int sz;

  if(newsz < oldsz) {
      help.sz = oldsz;
      return help;
  }

  oldsz = PGROUNDUP(oldsz);;
  for(a = oldsz; a < newsz; a += sz){
    // 够分配超级页表就分配超级页表
    if((a % SUPERPGSIZE == 0) && (newsz - a >= SUPERPGSIZE)) {
      sz = SUPERPGSIZE;
      mem = superkalloc();
      help.superpages++;
    } else {
      sz = PGSIZE;
      mem = kalloc();
      if (help.superpages == 0) {
        help.startpages++;
      }else {
        help.endpages++;
      }
    }
    if(mem == 0){
      uvmdealloc(pagetable, a, oldsz);
      help.state = 0;
      return help;
    }
#ifndef LAB_SYSCALL
    memset(mem, 0, sz);
#endif
    if(sz == SUPERPGSIZE) {
          if(supermappages(pagetable, a, sz, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
            superkfree(mem);
            uvmdealloc(pagetable, a, oldsz);
            help.state = 0;
            return help;
          }
    }else {
      if(mappages(pagetable, a, sz, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
        kfree(mem);
        uvmdealloc(pagetable, a, oldsz);
        help.state = 0;
        return help;
      }
    }
  }
  help.sz = newsz;
  help.state = 1;
  return help;
}

// todo 处理超级页的情况
int
uvmcopy(pagetable_t old, pagetable_t new, uint64 sz)
{
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;
  int szinc;

  for(i = 0; i < sz; i += szinc){
    szinc = PGSIZE;
    if((pte = walk(old, i, 0)) == 0)
      panic("uvmcopy: pte should exist");
    if((*pte & PTE_V) == 0)
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);
    flags = PTE_FLAGS(*pte);

    if (*pte & PTE_S) {
//        printf("fork super page\n");
        szinc = SUPERPGSIZE;
        if((mem = superkalloc()) == 0) {
          printf("fork super page mem\n");
          goto err;
        }
        memmove(mem, (char*)pa, SUPERPGSIZE);
        if(supermappages(new, i, SUPERPGSIZE, (uint64)mem, flags) != 0){
          printf("fork super page superkfree\n");
          superkfree(mem);
          goto err;
        }
    } else {
      if((mem = kalloc()) == 0)
        goto err;
      memmove(mem, (char*)pa, PGSIZE);
      if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
        kfree(mem);
        goto err;
      }
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, (i + szinc -1) / PGSIZE, 1);
  return -1;
}

// todo lab3: print a page table
#ifdef LAB_PGTBL
void
vmprint(pagetable_t pagetable) {
  // your code here
  printf("page table %p\n", pagetable);
  vmprintkpgtbl(pagetable, 0, 0);
}
#endif

void
vmprintkpgtbl(pagetable_t pagetable, int depth, uint64 recordvpn) {
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
     pte_t pte = pagetable[i];
     if (pte & PTE_V) {
       uint64 pa = PTE2PA(pte);

       printf(" ");
       for (int j = 0; j < depth; j++) {
         printf(".. ");
       }

       uint64 vpn = recordvpn | i << PXSHIFT(2-depth);
       if (depth == 0 ){
        // RISC-V SV39中 偏移量是0
         uint64 offset = pa & 0xFFF;
         vpn |= offset;
       }
       printf("..%p: pte %p pa %p\n", (void*)vpn, (void*)pte, (void*)pa);
       if ((pte & (PTE_R|PTE_W|PTE_X)) == 0) {
        vmprintkpgtbl((pagetable_t)pa, depth + 1, vpn);
       }
     }
  }
}
