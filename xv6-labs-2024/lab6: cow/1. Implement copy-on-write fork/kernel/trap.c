// handle an interrupt, exception, or system call from user space.
// called from trampoline.S
//
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

  int scause = r_scause();
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
  } else if(scause == 12 || scause == 13 || scause == 15) {
     uint64 va = r_stval();
//      printf("usertrap(): unexpected scause %d va=%p\n", scause, (void*)va);
     uint64 up = PGROUNDDOWN(p->trapframe->sp);
     uint64 down = up - PGSIZE; // 不能在保护页分配
     if (va < 0 || va >= MAXVA || (va >= down && va <= up)){
        setkilled(p);
     } else if (cowhandle(p->pagetable, va) != 0){
        setkilled(p);
     }
  } else {
    uint64 va = r_stval();
    printf("usertrap(): unexpected scause 0x%lx pid=%d va=%p\n", r_scause(), p->pid, (void*)va);
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