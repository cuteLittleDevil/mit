#define PTE_V (1L << 0) // valid
#define PTE_R (1L << 1)
#define PTE_W (1L << 2)
#define PTE_X (1L << 3)
#define PTE_U (1L << 4) // user can access
// todo 是否是超级页 8-9 保留给软件使用 xv6中可自定义（如用于写时复制或页面状态跟踪)
#define PTE_S (1L << 8)

