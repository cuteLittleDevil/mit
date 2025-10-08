// exec.c
int             exec(char*, char**);
// todo 处理fork cow的情况 成功返回0
int             cowhandle(pagetable_t, uint64);
void            refcadd(void*);
void            refcremove(void*);
int             refcget(void*);