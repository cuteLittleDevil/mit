#include "kernel/types.h"
#include "kernel/fcntl.h"
#include "user/user.h"
#include "kernel/riscv.h"

int
main(int argc, char *argv[])
{
  // your code here.  you should write the secret to fd 2 using write
  // (e.g., write(2, secret, 8)
  printf("执行了attack\n");
  char *a = sbrk(0);
  char *c = sbrk(PGSIZE*32);

  if(c != a || sbrk(0) != a + PGSIZE*32){
    printf("attack: sbrk re-allocation failed\n");
    exit(1);
  }
  char *secret = c + 16 * PGSIZE + 32;

  printf("secret content as string: %s\n", secret);
  write(2, secret, 8);
  exit(1);
}
