// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  static char *states[] = {
  [UNUSED]    "unused",
  [USED]      "used",
  [SLEEPING]  "sleep ",
  [RUNNABLE]  "runble",
  [RUNNING]   "run   ",
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
  for(p = proc; p < &proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";
    printf("%d %s %s", p->pid, state, p->name);
    printf("\n");
  }
}

// todo cow处理
int
cowhandle(pagetable_t pagetable, uint64 va)
{
//    printf("va %p\n", (void*)va);
  pte_t *pte = walk(pagetable, va, 0);
  if (pte == 0 || (*pte & PTE_V) == 0 || (*pte & PTE_COW) == 0) {
    return -1;
  }

  // usertests nowrite 测试补充
  if (va == 0) {
    return -1;
  }

  uint64 pa = PTE2PA(*pte);
  // 新申请一个内存使用 同时把原来的物理内存计数减一 如果不使用就释放回收了
  char *mem = kalloc();
  if (mem == 0) {
     return -1;
  }

  uint64 flags = PTE_FLAGS(*pte);
  memmove(mem, (char*)pa, PGSIZE);
  *pte = PA2PTE(mem);
  flags = (flags & ~PTE_COW) | PTE_W;
  *pte |= flags;
  kfree((void*)pa);
  return 0;
}