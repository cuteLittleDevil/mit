uint64
sys_sbrk(void)
{
  uint64 addr;
  int n;

  argint(0, &n);
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;

   // todo 如果 n > 0，表示堆扩展，打印新分配内存的虚拟和物理地址
  if (n > 0) {
    uint64 new_sz = myproc()->sz; // 扩展后的堆顶
    uint64 va;

    // 按页面遍历新分配的虚拟地址范围 [addr, new_sz)
    for (va = addr; va < new_sz; va += PGSIZE) {
      uint64 pa = walkaddr(myproc()->pagetable, va);
      if (pa > 0) {
        printf("VA %lx -> %lx\n", (unsigned long)va, (unsigned long)pa);
      }
    }
  }

  return addr;
}