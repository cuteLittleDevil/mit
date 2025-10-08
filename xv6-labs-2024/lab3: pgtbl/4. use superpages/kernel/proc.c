static struct proc*
allocproc(void)
{
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    acquire(&p->lock);
    if(p->state == UNUSED) {
      goto found;
    } else {
      release(&p->lock);
    }
  }
  return 0;

found:
  p->pid = allocpid();
  p->state = USED;

  // Allocate a trapframe page.
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    freeproc(p);
    release(&p->lock);
    return 0;
  }

  // todo lab3: speed up system calls
  if((p->usyscall = (struct usyscall *)kalloc()) == 0){
    freeproc(p);
    release(&p->lock);
    return 0;
  }
  p->usyscall->pid =  p->pid;

  // An empty user page table.
  p->pagetable = proc_pagetable(p);
  if(p->pagetable == 0){
    freeproc(p);
    release(&p->lock);
    return 0;
  }

  // Set up new context to start executing at forkret,
  // which returns to user space.
  memset(&p->context, 0, sizeof(p->context));
  p->context.ra = (uint64)forkret;
  p->context.sp = p->kstack + PGSIZE;

  return p;
}

static void
freeproc(struct proc *p)
{
  if(p->trapframe)
    kfree((void*)p->trapframe);
  p->trapframe = 0;
  if(p->usyscall)
    kfree((void*)p->usyscall);
  p->usyscall = 0;
  if(p->pagetable)
    proc_freepagetable(p->pagetable, p->sz);
  p->pagetable = 0;
  p->sz = 0;
  p->pid = 0;
  p->parent = 0;
  p->name[0] = 0;
  p->chan = 0;
  p->killed = 0;
  p->xstate = 0;
  p->state = UNUSED;
  // todo 用于记录超级页情况的
  p->next = 0;
}

pagetable_t
proc_pagetable(struct proc *p)
{
  pagetable_t pagetable;

  // An empty page table.
  pagetable = uvmcreate();
  if(pagetable == 0)
    return 0;

  // map the trampoline code (for system call return)
  // at the highest user virtual address.
  // only the supervisor uses it, on the way
  // to/from user space, so not PTE_U.
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
              (uint64)trampoline, PTE_R | PTE_X) < 0){
    uvmfree(pagetable, 0);
    return 0;
  }

  // map the trapframe page just below the trampoline page, for
  // trampoline.S.
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
              (uint64)(p->trapframe), PTE_R | PTE_W) < 0){
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    uvmfree(pagetable, 0);
    return 0;
  }
  // todo lab3: speed up system calls
  if(mappages(pagetable, USYSCALL, PGSIZE,
              (uint64)(p->usyscall), PTE_R | PTE_U) < 0){
    uvmunmap(pagetable, USYSCALL, 1, 0);
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    uvmfree(pagetable, 0);
    return 0;
  }
  return pagetable;
}

void
proc_freepagetable(pagetable_t pagetable, uint64 sz)
{
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
  // todo lab3: speed up system calls
  uvmunmap(pagetable, USYSCALL, 1, 0);
  uvmfree(pagetable, sz);
}

// todo 为了完成 make grade中 sbrkmuch实验 选择分配的时候记录页表顺序
// 处理超级也退化到多个普通页等情况
int
growproc(int n)
{
  uint64 sz;
  struct proc *p = myproc();
  sz = p->sz;
  if(n > 0){
       struct sbrkhelp help = sbrksuperuvmalloc(p->pagetable, sz, sz + n, PTE_W);
       sz = help.sz;
       if (help.state == 0) {
          return -1;
       }
       for (int i = 0; i < help.startpages; i++) {
          p->record[p->next] = '0';
          p->next++;
       }
       // 需要内存对齐 可能有10个空间 实际是9个超级页
       for (int i = 0; i < help.superpages; i++) {
          p->record[p->next] = '1';
          p->next++;
       }

       for (int i = 0; i < help.endpages; i++) {
          p->record[p->next] = '0';
          p->next++;
       }
//       if (n > 4096) {
//        printf("1=%d 2=%d 3=%d n=%d next=%d %ld\n",help.startpages,  help.superpages, help.endpages, n, p->next, sz);
//       }
  } else if(n < 0){
//    printf("释放%d next=%d %d\n", n, p->next, p->record[p->next -1]);
    for (int i = p->next-1; i >= 0; i--) {
      if (p->record[i] == '1') {
        if ((n + SUPERPGSIZE) > 0 ) {
           // 当前是超级表 但是不够释放的时候 就释放一个超级表 然后添加普通页表
           sz = uvmdealloc(p->pagetable, sz, sz - SUPERPGSIZE);
           // 不考虑可能分配失败的情况
           sz = uvmalloc(p->pagetable, sz, sz + SUPERPGSIZE + n, PTE_W);
           p->record[i] = '0';
           p->next -= 1;
           int count = (n + SUPERPGSIZE) / PGSIZE;
            p->next += count;
           break;
        }else {
            sz = uvmdealloc(p->pagetable, sz, sz - SUPERPGSIZE);
            n += SUPERPGSIZE;
        }
      }else {
         // 释放的没有一页 那还是至少需要释放一页
         sz = uvmdealloc(p->pagetable, sz, sz - PGSIZE);
         n += PGSIZE;
         if (n > 0 ) {
           p->next = i - 1;
           break;
         }
      }
      if (n == 0) {
        p -> next = i;
        break;
      }
    }
  }
  p->sz = sz;
  return 0;
}