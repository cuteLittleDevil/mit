// todo 新增的
uint64
sys_trace(void)
{
  int n;
  argint(0, &n);
  if(n < 0) {
      n = 0;
  }
  struct proc *p = myproc();
  p->traceid = n;
  return 0;
}
