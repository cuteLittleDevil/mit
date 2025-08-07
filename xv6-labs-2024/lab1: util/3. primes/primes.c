#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

void handle(int nums);

int main(int argc, char const *argv[]) {
	  int p1[2];
	  pipe(p1);

	  int pid = fork();
    switch (pid) {
      case -1:
        exit(1);
      case 0:
        close(p1[1]); // 不需要写
        handle(p1[0]);
        close(p1[0]);
        exit(0);
      default:
        close(p1[0]); // 不需要读
        for (int i = 2; i <= 280; i++) {
            write(p1[1], &i, sizeof(int));
        }
        close(p1[1]);
        wait(0);
        exit(0);
    }
}

void handle(int nums) {
    int prime;
    int ok = read(nums, &prime, sizeof(int));
    if (ok <= 0) {
      close(nums);
      return;
    }
    printf("prime %d\n", prime);

    int p2[2];
    pipe(p2);

	  int pid = fork();
    switch (pid) {
      case -1:
        exit(1);
      case 0:
        close(nums);
        close(p2[1]);
        handle(p2[0]);
        close(p2[0]);
        exit(0);
      default:
        close(p2[0]); // 不需要读
        while (1) {
          int num;
          int ok = read(nums, &num, sizeof(int));
          if (ok <= 0) {
                close(nums);
                break;
          }
          if (num % prime != 0) {
              write(p2[1], &num, sizeof(int));
          }
        }
        close(p2[1]);
        wait(0);
        exit(0);
    }
}
