void
usertrap(void)
{
  int which_dev = 0;

  if((r_sstatus() & SSTATUS_SPP) != 0)
    panic("usertrap: not from user mode");

  // send interrupts and exceptions to kerneltrap(),
  // since we're now in the kernel.
  w_stvec((uint64)kernelvec);

  struct proc *p = myproc();
  
  // save user program counter.
  p->trapframe->epc = r_sepc();

  uint64 scause = r_scause();
  // todo 根据make grade中错误情况 处理特殊情况 0xd 0xf
  if(scause == 8){
    // system call

    if(killed(p))
      exit(-1);

    // sepc points to the ecall instruction,
    // but we want to return to the next instruction.
    p->trapframe->epc += 4;

    // an interrupt will change sepc, scause, and sstatus,
    // so enable only now that we're done with those registers.
    intr_on();

    syscall();
  } else if((which_dev = devintr()) != 0){
    // ok
  } else if (scause == 0xd) {
      uint64 stval = r_stval(); // 获取导致页错误的地址
      if (stval >= KERNBASE) {
          exit(-1);
      }else {
          setkilled(p);
      }
  } else if (scause == 0xf) {
      uint64 stval = r_stval(); // 获取导致故障的地址
      if (stval >= MAXVA) {
         exit(-1);
      } else {
         setkilled(p);
      }
  }else {
    printf("usertrap(): unexpected scause 0x%lx pid=%d\n", r_scause(), p->pid);
    printf("            sepc=0x%lx stval=0x%lx\n", r_sepc(), r_stval());
    setkilled(p);
  }

  if(killed(p))
    exit(-1);

  // give up the CPU if this is a timer interrupt.
  if(which_dev == 2)
    yield();

  usertrapret();
}