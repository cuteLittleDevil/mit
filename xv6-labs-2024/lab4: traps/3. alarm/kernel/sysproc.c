// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}


uint64
sys_sigalarm(void)
{
  int ticks;
  uint64 fnaddr;
  argint(0, &ticks);
  argaddr(1, &fnaddr);
  if (ticks < 0 || fnaddr < 0) {
    return -1;
  }
  struct proc *p = myproc();
  p->ticks = ticks;
  p->handler = fnaddr;
  return 0;
}

uint64
sys_sigreturn(void)
{
  struct proc *p = myproc();
  memmove(p->trapframe, p->originaltrapframe, sizeof(struct trapframe));
  p->run = 0;
  return p->trapframe->a0; // test3 测试需要返回a0
}

