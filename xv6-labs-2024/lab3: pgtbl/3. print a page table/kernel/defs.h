
#if defined(LAB_PGTBL) || defined(SOL_MMAP)
void            vmprint(pagetable_t);
// todo 申明新函数方便实现
void            vmprintkpgtbl(pagetable_t, int, uint64);

