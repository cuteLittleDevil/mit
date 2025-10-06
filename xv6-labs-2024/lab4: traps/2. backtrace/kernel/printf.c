
void
printfinit(void)
{
  initlock(&pr.lock, "pr");
  pr.locking = 1;
}


// todo 添加实现
void
backtrace(void)
{
  printf("backtrace:\n");
  uint64 fp = r_fp();
  while(fp > PGROUNDDOWN(fp))
  {
    uint64 ra = *(uint64*)(fp-8);
    printf("%p\n", (void*)ra);
    uint64* tmp = (uint64*)(fp-16);
    fp = *tmp;
  }
  //  riscv64-unknown-elf-addr2line -e kernel/kernel
  // 0x0000000080001df6
  // 0x0000000080001ca8
  // 0x0000000080001a32
}

