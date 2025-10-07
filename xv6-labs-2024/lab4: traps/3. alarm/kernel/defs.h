// exec.c
int             exec(char*, char**);
void            backtrace(void);
// todo 定时执行某函数
int             sigalarm(int, void*);
int             sigreturn(void); // 恢复寄存器上的原始值