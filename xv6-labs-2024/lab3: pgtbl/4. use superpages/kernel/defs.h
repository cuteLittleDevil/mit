
// kalloc.c
void*           kalloc(void);
void            kfree(void *);
// todo 添加超级页表的分配和释放
void*           superkalloc(void);
void            superkfree(void *);
void            kinit(void);

// vm.c
void            kvminit(void);
void            kvminithart(void);
void            kvmmap(pagetable_t, uint64, uint64, uint64, int);
int             mappages(pagetable_t, uint64, uint64, uint64, int);
pagetable_t     uvmcreate(void);
void            uvmfirst(pagetable_t, uchar *, uint);
uint64          uvmalloc(pagetable_t, uint64, uint64, int);
// todo make grade中 sbrkmuch 实验使用 获取分配的超级页 普通页信息
struct sbrkhelp sbrksuperuvmalloc(pagetable_t, uint64, uint64, int);

uint64          uvmdealloc(pagetable_t, uint64, uint64);
int             uvmcopy(pagetable_t, pagetable_t, uint64);
void            uvmfree(pagetable_t, uint64);
void            uvmunmap(pagetable_t, uint64, uint64, int);
void            uvmclear(pagetable_t, uint64);
pte_t *         walk(pagetable_t, uint64, int);
uint64          walkaddr(pagetable_t, uint64);
int             copyout(pagetable_t, uint64, char *, uint64);
int             copyin(pagetable_t, char *, uint64, uint64);
int             copyinstr(pagetable_t, char *, uint64, uint64);
#if defined(LAB_PGTBL) || defined(SOL_MMAP)
void            vmprint(pagetable_t);
// todo lab3: print a page table
void            vmprintkpgtbl(pagetable_t, int, uint64);