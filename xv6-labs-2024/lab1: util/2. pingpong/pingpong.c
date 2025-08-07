#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, char *argv[]) {
  // 不考虑读写失败的情况
  int p1[2]; // 父进程写给子进程的
  pipe(p1);
  int p2[2]; // 子进程写给父进程的
  pipe(p2);
  const int contentLen = 12;
  char buf[contentLen];

  int pid = fork();
  switch (pid) {
    case -1:
      exit(1);
    case 0:
      // 子进程的情况
      // 不需要父进程读写
      close(p1[1]); // 父进程写通道1
      close(p2[0]); // 父进程读通道2

      read(p1[0], buf, contentLen);
      printf("%d: received ping\n", getpid());

      write(p2[1], "hello world\n", contentLen);
      close(p1[0]);
      close(p2[1]);
      exit(0);
    default:
      // 父进程的情况
      // 不需要子进程的读写
      close(p1[0]); // 子进程读通道1
      close(p2[1]); // 子进程写通道2
      write(p1[1], "hello world\n", contentLen);

      read(p2[0], buf, contentLen);
      close(p1[1]);
      close(p2[0]);
      printf("%d: received pong\n", getpid());

      exit(0);
  }
}
