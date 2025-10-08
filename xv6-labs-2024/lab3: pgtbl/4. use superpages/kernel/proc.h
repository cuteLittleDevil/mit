// Per-process state
struct proc {
  struct spinlock lock;

  // p->lock must be held when using these:
  enum procstate state;        // Process state
  void *chan;                  // If non-zero, sleeping on chan
  int killed;                  // If non-zero, have been killed
  int xstate;                  // Exit status to be returned to parent's wait
  int pid;                     // Process ID

  // wait_lock must be held when using this:
  struct proc *parent;         // Parent process

  // these are private to the process, so p->lock need not be held.
  uint64 kstack;               // Virtual address of kernel stack
  uint64 sz;                   // Size of process memory (bytes)
  pagetable_t pagetable;       // User page table
  struct trapframe *trapframe; // data page for trampoline.S
  struct context context;      // swtch() here to run process
  struct file *ofile[NOFILE];  // Open files
  struct inode *cwd;           // Current directory
  char name[16];               // Process name (debugging)

  // todo lab3: speed up system calls
  struct usyscall *usyscall;

  // todo  动态数组麻烦 直接加个普通的 0=普通页 1=超级页 或者连续的0和1压缩一下
  char record[10000];
  int next;
};

struct sbrkhelp {
  int sz;
  int state;
  int startpages; // 内存对齐 分配超级页表之前分配了多少普通页
  int superpages; // 分配了多少超级页
  int endpages; // 超级页不够的情况 剩余分配了多少普通页 (目前未实现 简化实现 超级页选择够用)
};
