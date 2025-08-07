#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"


int main(int argc, char *argv[]){
	char *args[32];
	// 0的时候是原程序名 从1开始 如(echo 1 ; echo 2) | xargs echo
	// 0=xargs 1=echo
	for (int i = 1; i < argc; i++) {
	  args[i-1] = argv[i];
	}

  char buf[1024];
  char *p = buf;
  int n;
  // 处理 1\n2\n -> echo 1\0 echo 2\0
  // 相当于把数据也读到buf了 因为是实验 就不判断越界问题了
  while ((n = read(0, p, 1)) > 0) {
      if (*p == '\n') {
          *p = '\0';     // 添加字符串结束符
          int pid = fork();
          if (pid == 0) {
              args[argc-1] = buf;
              args[argc] = '\0';
              exec(args[0], args);
          } else if (pid > 0){
              wait(0);
              p = buf;
          }
      } else {
         p++;
      }
  }
  exit(0);
}
