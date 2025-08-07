#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"
#include "kernel/fcntl.h"

char* get_file_name(char *path) {
  char *p;
  for (p=path+strlen(path); p >= path && *p != '/'; p--)
    ;
  p++;
  return p;
}

void find(char *path, char *file_name) {
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if ((fd = open(path, O_RDONLY)) < 0){
    fprintf(2, "find: cannot open %s\n", path);
    return;
  }

  if (fstat(fd, &st) < 0){
    fprintf(2, "find: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type) {
    case T_FILE:
      // 查看这个文件是不是符合要求
      if (strcmp(get_file_name(path), file_name) == 0) {
          printf("%s\n", path);
      }
      break;
    case T_DIR:
        if (strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
          printf("find: path too long\n");
          break;
        }
        strcpy(buf, path);
        p = buf+strlen(buf);
        *p = '/';
        p++;
        // 遍历这级目录
        while (read(fd, &de, sizeof(de)) == sizeof(de)){
          if (de.inum == 0) {
            continue;
          }
          if (strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0) {
            continue;
          }
          memmove(p, de.name, DIRSIZ);
          p[DIRSIZ] = 0;
          find(buf, file_name);
        }
        break;
    default:
      break;
  }

  close(fd);
}

int main(int argc, char *argv[]) {
  if (argc != 3) {
      exit(0);
  }

	char *path = argv[1];
	char *file_name = argv[2];
	find(path, file_name);
  exit(0);
}
