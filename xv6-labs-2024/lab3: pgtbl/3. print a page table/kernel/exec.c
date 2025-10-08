
int
exec(char *path, char **argv)
{
 ...
  p->trapframe->sp = sp; // initial stack pointer
  proc_freepagetable(oldpagetable, oldsz);
  // todo 添加如下 方便测试 make clean时 自动测试
  if (p->pid == 1) {
      vmprint(p->pagetable);  // 这会打印 init 进程的页表
  }
  return argc; // this ends up in a0, the first argument to main(argc, argv)

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    end_op();
  }
  return -1;
}
