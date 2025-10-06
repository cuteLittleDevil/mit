
user/_call:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <g>:
#include "kernel/param.h"
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int g(int x) {
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  return x+3;
}
   8:	250d                	addiw	a0,a0,3
   a:	60a2                	ld	ra,8(sp)
   c:	6402                	ld	s0,0(sp)
   e:	0141                	addi	sp,sp,16
  10:	8082                	ret

0000000000000012 <f>:

int f(int x) {
  12:	1141                	addi	sp,sp,-16
  14:	e406                	sd	ra,8(sp)
  16:	e022                	sd	s0,0(sp)
  18:	0800                	addi	s0,sp,16
  return g(x);
  1a:	fe7ff0ef          	jal	0 <g>
}
  1e:	60a2                	ld	ra,8(sp)
  20:	6402                	ld	s0,0(sp)
  22:	0141                	addi	sp,sp,16
  24:	8082                	ret

0000000000000026 <main>:

void main(void) {
  26:	1141                	addi	sp,sp,-16
  28:	e406                	sd	ra,8(sp)
  2a:	e022                	sd	s0,0(sp)
  2c:	0800                	addi	s0,sp,16
  printf("%d %d\n", f(8)+1, 13);
  2e:	4521                	li	a0,8
  30:	fe3ff0ef          	jal	12 <f>
  34:	4635                	li	a2,13
  36:	0015059b          	addiw	a1,a0,1
  3a:	00001517          	auipc	a0,0x1
  3e:	88650513          	addi	a0,a0,-1914 # 8c0 <malloc+0xb6>
  42:	6d0000ef          	jal	712 <printf>
  exit(0);
  46:	4501                	li	a0,0
  48:	2a2000ef          	jal	2ea <exit>

000000000000004c <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  4c:	1141                	addi	sp,sp,-16
  4e:	e406                	sd	ra,8(sp)
  50:	e022                	sd	s0,0(sp)
  52:	0800                	addi	s0,sp,16
  extern int main();
  main();
  54:	fd3ff0ef          	jal	26 <main>
  exit(0);
  58:	4501                	li	a0,0
  5a:	290000ef          	jal	2ea <exit>

000000000000005e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  5e:	1141                	addi	sp,sp,-16
  60:	e406                	sd	ra,8(sp)
  62:	e022                	sd	s0,0(sp)
  64:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  66:	87aa                	mv	a5,a0
  68:	0585                	addi	a1,a1,1
  6a:	0785                	addi	a5,a5,1
  6c:	fff5c703          	lbu	a4,-1(a1)
  70:	fee78fa3          	sb	a4,-1(a5)
  74:	fb75                	bnez	a4,68 <strcpy+0xa>
    ;
  return os;
}
  76:	60a2                	ld	ra,8(sp)
  78:	6402                	ld	s0,0(sp)
  7a:	0141                	addi	sp,sp,16
  7c:	8082                	ret

000000000000007e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  7e:	1141                	addi	sp,sp,-16
  80:	e406                	sd	ra,8(sp)
  82:	e022                	sd	s0,0(sp)
  84:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  86:	00054783          	lbu	a5,0(a0)
  8a:	cb91                	beqz	a5,9e <strcmp+0x20>
  8c:	0005c703          	lbu	a4,0(a1)
  90:	00f71763          	bne	a4,a5,9e <strcmp+0x20>
    p++, q++;
  94:	0505                	addi	a0,a0,1
  96:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  98:	00054783          	lbu	a5,0(a0)
  9c:	fbe5                	bnez	a5,8c <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  9e:	0005c503          	lbu	a0,0(a1)
}
  a2:	40a7853b          	subw	a0,a5,a0
  a6:	60a2                	ld	ra,8(sp)
  a8:	6402                	ld	s0,0(sp)
  aa:	0141                	addi	sp,sp,16
  ac:	8082                	ret

00000000000000ae <strlen>:

uint
strlen(const char *s)
{
  ae:	1141                	addi	sp,sp,-16
  b0:	e406                	sd	ra,8(sp)
  b2:	e022                	sd	s0,0(sp)
  b4:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  b6:	00054783          	lbu	a5,0(a0)
  ba:	cf99                	beqz	a5,d8 <strlen+0x2a>
  bc:	0505                	addi	a0,a0,1
  be:	87aa                	mv	a5,a0
  c0:	86be                	mv	a3,a5
  c2:	0785                	addi	a5,a5,1
  c4:	fff7c703          	lbu	a4,-1(a5)
  c8:	ff65                	bnez	a4,c0 <strlen+0x12>
  ca:	40a6853b          	subw	a0,a3,a0
  ce:	2505                	addiw	a0,a0,1
    ;
  return n;
}
  d0:	60a2                	ld	ra,8(sp)
  d2:	6402                	ld	s0,0(sp)
  d4:	0141                	addi	sp,sp,16
  d6:	8082                	ret
  for(n = 0; s[n]; n++)
  d8:	4501                	li	a0,0
  da:	bfdd                	j	d0 <strlen+0x22>

00000000000000dc <memset>:

void*
memset(void *dst, int c, uint n)
{
  dc:	1141                	addi	sp,sp,-16
  de:	e406                	sd	ra,8(sp)
  e0:	e022                	sd	s0,0(sp)
  e2:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  e4:	ca19                	beqz	a2,fa <memset+0x1e>
  e6:	87aa                	mv	a5,a0
  e8:	1602                	slli	a2,a2,0x20
  ea:	9201                	srli	a2,a2,0x20
  ec:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  f0:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  f4:	0785                	addi	a5,a5,1
  f6:	fee79de3          	bne	a5,a4,f0 <memset+0x14>
  }
  return dst;
}
  fa:	60a2                	ld	ra,8(sp)
  fc:	6402                	ld	s0,0(sp)
  fe:	0141                	addi	sp,sp,16
 100:	8082                	ret

0000000000000102 <strchr>:

char*
strchr(const char *s, char c)
{
 102:	1141                	addi	sp,sp,-16
 104:	e406                	sd	ra,8(sp)
 106:	e022                	sd	s0,0(sp)
 108:	0800                	addi	s0,sp,16
  for(; *s; s++)
 10a:	00054783          	lbu	a5,0(a0)
 10e:	cf81                	beqz	a5,126 <strchr+0x24>
    if(*s == c)
 110:	00f58763          	beq	a1,a5,11e <strchr+0x1c>
  for(; *s; s++)
 114:	0505                	addi	a0,a0,1
 116:	00054783          	lbu	a5,0(a0)
 11a:	fbfd                	bnez	a5,110 <strchr+0xe>
      return (char*)s;
  return 0;
 11c:	4501                	li	a0,0
}
 11e:	60a2                	ld	ra,8(sp)
 120:	6402                	ld	s0,0(sp)
 122:	0141                	addi	sp,sp,16
 124:	8082                	ret
  return 0;
 126:	4501                	li	a0,0
 128:	bfdd                	j	11e <strchr+0x1c>

000000000000012a <gets>:

char*
gets(char *buf, int max)
{
 12a:	7159                	addi	sp,sp,-112
 12c:	f486                	sd	ra,104(sp)
 12e:	f0a2                	sd	s0,96(sp)
 130:	eca6                	sd	s1,88(sp)
 132:	e8ca                	sd	s2,80(sp)
 134:	e4ce                	sd	s3,72(sp)
 136:	e0d2                	sd	s4,64(sp)
 138:	fc56                	sd	s5,56(sp)
 13a:	f85a                	sd	s6,48(sp)
 13c:	f45e                	sd	s7,40(sp)
 13e:	f062                	sd	s8,32(sp)
 140:	ec66                	sd	s9,24(sp)
 142:	e86a                	sd	s10,16(sp)
 144:	1880                	addi	s0,sp,112
 146:	8caa                	mv	s9,a0
 148:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 14a:	892a                	mv	s2,a0
 14c:	4481                	li	s1,0
    cc = read(0, &c, 1);
 14e:	f9f40b13          	addi	s6,s0,-97
 152:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 154:	4ba9                	li	s7,10
 156:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 158:	8d26                	mv	s10,s1
 15a:	0014899b          	addiw	s3,s1,1
 15e:	84ce                	mv	s1,s3
 160:	0349d563          	bge	s3,s4,18a <gets+0x60>
    cc = read(0, &c, 1);
 164:	8656                	mv	a2,s5
 166:	85da                	mv	a1,s6
 168:	4501                	li	a0,0
 16a:	198000ef          	jal	302 <read>
    if(cc < 1)
 16e:	00a05e63          	blez	a0,18a <gets+0x60>
    buf[i++] = c;
 172:	f9f44783          	lbu	a5,-97(s0)
 176:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 17a:	01778763          	beq	a5,s7,188 <gets+0x5e>
 17e:	0905                	addi	s2,s2,1
 180:	fd879ce3          	bne	a5,s8,158 <gets+0x2e>
    buf[i++] = c;
 184:	8d4e                	mv	s10,s3
 186:	a011                	j	18a <gets+0x60>
 188:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 18a:	9d66                	add	s10,s10,s9
 18c:	000d0023          	sb	zero,0(s10)
  return buf;
}
 190:	8566                	mv	a0,s9
 192:	70a6                	ld	ra,104(sp)
 194:	7406                	ld	s0,96(sp)
 196:	64e6                	ld	s1,88(sp)
 198:	6946                	ld	s2,80(sp)
 19a:	69a6                	ld	s3,72(sp)
 19c:	6a06                	ld	s4,64(sp)
 19e:	7ae2                	ld	s5,56(sp)
 1a0:	7b42                	ld	s6,48(sp)
 1a2:	7ba2                	ld	s7,40(sp)
 1a4:	7c02                	ld	s8,32(sp)
 1a6:	6ce2                	ld	s9,24(sp)
 1a8:	6d42                	ld	s10,16(sp)
 1aa:	6165                	addi	sp,sp,112
 1ac:	8082                	ret

00000000000001ae <stat>:

int
stat(const char *n, struct stat *st)
{
 1ae:	1101                	addi	sp,sp,-32
 1b0:	ec06                	sd	ra,24(sp)
 1b2:	e822                	sd	s0,16(sp)
 1b4:	e04a                	sd	s2,0(sp)
 1b6:	1000                	addi	s0,sp,32
 1b8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1ba:	4581                	li	a1,0
 1bc:	16e000ef          	jal	32a <open>
  if(fd < 0)
 1c0:	02054263          	bltz	a0,1e4 <stat+0x36>
 1c4:	e426                	sd	s1,8(sp)
 1c6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1c8:	85ca                	mv	a1,s2
 1ca:	178000ef          	jal	342 <fstat>
 1ce:	892a                	mv	s2,a0
  close(fd);
 1d0:	8526                	mv	a0,s1
 1d2:	140000ef          	jal	312 <close>
  return r;
 1d6:	64a2                	ld	s1,8(sp)
}
 1d8:	854a                	mv	a0,s2
 1da:	60e2                	ld	ra,24(sp)
 1dc:	6442                	ld	s0,16(sp)
 1de:	6902                	ld	s2,0(sp)
 1e0:	6105                	addi	sp,sp,32
 1e2:	8082                	ret
    return -1;
 1e4:	597d                	li	s2,-1
 1e6:	bfcd                	j	1d8 <stat+0x2a>

00000000000001e8 <atoi>:

int
atoi(const char *s)
{
 1e8:	1141                	addi	sp,sp,-16
 1ea:	e406                	sd	ra,8(sp)
 1ec:	e022                	sd	s0,0(sp)
 1ee:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1f0:	00054683          	lbu	a3,0(a0)
 1f4:	fd06879b          	addiw	a5,a3,-48
 1f8:	0ff7f793          	zext.b	a5,a5
 1fc:	4625                	li	a2,9
 1fe:	02f66963          	bltu	a2,a5,230 <atoi+0x48>
 202:	872a                	mv	a4,a0
  n = 0;
 204:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 206:	0705                	addi	a4,a4,1
 208:	0025179b          	slliw	a5,a0,0x2
 20c:	9fa9                	addw	a5,a5,a0
 20e:	0017979b          	slliw	a5,a5,0x1
 212:	9fb5                	addw	a5,a5,a3
 214:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 218:	00074683          	lbu	a3,0(a4)
 21c:	fd06879b          	addiw	a5,a3,-48
 220:	0ff7f793          	zext.b	a5,a5
 224:	fef671e3          	bgeu	a2,a5,206 <atoi+0x1e>
  return n;
}
 228:	60a2                	ld	ra,8(sp)
 22a:	6402                	ld	s0,0(sp)
 22c:	0141                	addi	sp,sp,16
 22e:	8082                	ret
  n = 0;
 230:	4501                	li	a0,0
 232:	bfdd                	j	228 <atoi+0x40>

0000000000000234 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 234:	1141                	addi	sp,sp,-16
 236:	e406                	sd	ra,8(sp)
 238:	e022                	sd	s0,0(sp)
 23a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 23c:	02b57563          	bgeu	a0,a1,266 <memmove+0x32>
    while(n-- > 0)
 240:	00c05f63          	blez	a2,25e <memmove+0x2a>
 244:	1602                	slli	a2,a2,0x20
 246:	9201                	srli	a2,a2,0x20
 248:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 24c:	872a                	mv	a4,a0
      *dst++ = *src++;
 24e:	0585                	addi	a1,a1,1
 250:	0705                	addi	a4,a4,1
 252:	fff5c683          	lbu	a3,-1(a1)
 256:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 25a:	fee79ae3          	bne	a5,a4,24e <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 25e:	60a2                	ld	ra,8(sp)
 260:	6402                	ld	s0,0(sp)
 262:	0141                	addi	sp,sp,16
 264:	8082                	ret
    dst += n;
 266:	00c50733          	add	a4,a0,a2
    src += n;
 26a:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 26c:	fec059e3          	blez	a2,25e <memmove+0x2a>
 270:	fff6079b          	addiw	a5,a2,-1
 274:	1782                	slli	a5,a5,0x20
 276:	9381                	srli	a5,a5,0x20
 278:	fff7c793          	not	a5,a5
 27c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 27e:	15fd                	addi	a1,a1,-1
 280:	177d                	addi	a4,a4,-1
 282:	0005c683          	lbu	a3,0(a1)
 286:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 28a:	fef71ae3          	bne	a4,a5,27e <memmove+0x4a>
 28e:	bfc1                	j	25e <memmove+0x2a>

0000000000000290 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 290:	1141                	addi	sp,sp,-16
 292:	e406                	sd	ra,8(sp)
 294:	e022                	sd	s0,0(sp)
 296:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 298:	ca0d                	beqz	a2,2ca <memcmp+0x3a>
 29a:	fff6069b          	addiw	a3,a2,-1
 29e:	1682                	slli	a3,a3,0x20
 2a0:	9281                	srli	a3,a3,0x20
 2a2:	0685                	addi	a3,a3,1
 2a4:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2a6:	00054783          	lbu	a5,0(a0)
 2aa:	0005c703          	lbu	a4,0(a1)
 2ae:	00e79863          	bne	a5,a4,2be <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 2b2:	0505                	addi	a0,a0,1
    p2++;
 2b4:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2b6:	fed518e3          	bne	a0,a3,2a6 <memcmp+0x16>
  }
  return 0;
 2ba:	4501                	li	a0,0
 2bc:	a019                	j	2c2 <memcmp+0x32>
      return *p1 - *p2;
 2be:	40e7853b          	subw	a0,a5,a4
}
 2c2:	60a2                	ld	ra,8(sp)
 2c4:	6402                	ld	s0,0(sp)
 2c6:	0141                	addi	sp,sp,16
 2c8:	8082                	ret
  return 0;
 2ca:	4501                	li	a0,0
 2cc:	bfdd                	j	2c2 <memcmp+0x32>

00000000000002ce <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2ce:	1141                	addi	sp,sp,-16
 2d0:	e406                	sd	ra,8(sp)
 2d2:	e022                	sd	s0,0(sp)
 2d4:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2d6:	f5fff0ef          	jal	234 <memmove>
}
 2da:	60a2                	ld	ra,8(sp)
 2dc:	6402                	ld	s0,0(sp)
 2de:	0141                	addi	sp,sp,16
 2e0:	8082                	ret

00000000000002e2 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2e2:	4885                	li	a7,1
 ecall
 2e4:	00000073          	ecall
 ret
 2e8:	8082                	ret

00000000000002ea <exit>:
.global exit
exit:
 li a7, SYS_exit
 2ea:	4889                	li	a7,2
 ecall
 2ec:	00000073          	ecall
 ret
 2f0:	8082                	ret

00000000000002f2 <wait>:
.global wait
wait:
 li a7, SYS_wait
 2f2:	488d                	li	a7,3
 ecall
 2f4:	00000073          	ecall
 ret
 2f8:	8082                	ret

00000000000002fa <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2fa:	4891                	li	a7,4
 ecall
 2fc:	00000073          	ecall
 ret
 300:	8082                	ret

0000000000000302 <read>:
.global read
read:
 li a7, SYS_read
 302:	4895                	li	a7,5
 ecall
 304:	00000073          	ecall
 ret
 308:	8082                	ret

000000000000030a <write>:
.global write
write:
 li a7, SYS_write
 30a:	48c1                	li	a7,16
 ecall
 30c:	00000073          	ecall
 ret
 310:	8082                	ret

0000000000000312 <close>:
.global close
close:
 li a7, SYS_close
 312:	48d5                	li	a7,21
 ecall
 314:	00000073          	ecall
 ret
 318:	8082                	ret

000000000000031a <kill>:
.global kill
kill:
 li a7, SYS_kill
 31a:	4899                	li	a7,6
 ecall
 31c:	00000073          	ecall
 ret
 320:	8082                	ret

0000000000000322 <exec>:
.global exec
exec:
 li a7, SYS_exec
 322:	489d                	li	a7,7
 ecall
 324:	00000073          	ecall
 ret
 328:	8082                	ret

000000000000032a <open>:
.global open
open:
 li a7, SYS_open
 32a:	48bd                	li	a7,15
 ecall
 32c:	00000073          	ecall
 ret
 330:	8082                	ret

0000000000000332 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 332:	48c5                	li	a7,17
 ecall
 334:	00000073          	ecall
 ret
 338:	8082                	ret

000000000000033a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 33a:	48c9                	li	a7,18
 ecall
 33c:	00000073          	ecall
 ret
 340:	8082                	ret

0000000000000342 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 342:	48a1                	li	a7,8
 ecall
 344:	00000073          	ecall
 ret
 348:	8082                	ret

000000000000034a <link>:
.global link
link:
 li a7, SYS_link
 34a:	48cd                	li	a7,19
 ecall
 34c:	00000073          	ecall
 ret
 350:	8082                	ret

0000000000000352 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 352:	48d1                	li	a7,20
 ecall
 354:	00000073          	ecall
 ret
 358:	8082                	ret

000000000000035a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 35a:	48a5                	li	a7,9
 ecall
 35c:	00000073          	ecall
 ret
 360:	8082                	ret

0000000000000362 <dup>:
.global dup
dup:
 li a7, SYS_dup
 362:	48a9                	li	a7,10
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 36a:	48ad                	li	a7,11
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 372:	48b1                	li	a7,12
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 37a:	48b5                	li	a7,13
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 382:	48b9                	li	a7,14
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 38a:	1101                	addi	sp,sp,-32
 38c:	ec06                	sd	ra,24(sp)
 38e:	e822                	sd	s0,16(sp)
 390:	1000                	addi	s0,sp,32
 392:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 396:	4605                	li	a2,1
 398:	fef40593          	addi	a1,s0,-17
 39c:	f6fff0ef          	jal	30a <write>
}
 3a0:	60e2                	ld	ra,24(sp)
 3a2:	6442                	ld	s0,16(sp)
 3a4:	6105                	addi	sp,sp,32
 3a6:	8082                	ret

00000000000003a8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3a8:	7139                	addi	sp,sp,-64
 3aa:	fc06                	sd	ra,56(sp)
 3ac:	f822                	sd	s0,48(sp)
 3ae:	f426                	sd	s1,40(sp)
 3b0:	f04a                	sd	s2,32(sp)
 3b2:	ec4e                	sd	s3,24(sp)
 3b4:	0080                	addi	s0,sp,64
 3b6:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3b8:	c299                	beqz	a3,3be <printint+0x16>
 3ba:	0605ce63          	bltz	a1,436 <printint+0x8e>
  neg = 0;
 3be:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 3c0:	fc040313          	addi	t1,s0,-64
  neg = 0;
 3c4:	869a                	mv	a3,t1
  i = 0;
 3c6:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 3c8:	00000817          	auipc	a6,0x0
 3cc:	50880813          	addi	a6,a6,1288 # 8d0 <digits>
 3d0:	88be                	mv	a7,a5
 3d2:	0017851b          	addiw	a0,a5,1
 3d6:	87aa                	mv	a5,a0
 3d8:	02c5f73b          	remuw	a4,a1,a2
 3dc:	1702                	slli	a4,a4,0x20
 3de:	9301                	srli	a4,a4,0x20
 3e0:	9742                	add	a4,a4,a6
 3e2:	00074703          	lbu	a4,0(a4)
 3e6:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 3ea:	872e                	mv	a4,a1
 3ec:	02c5d5bb          	divuw	a1,a1,a2
 3f0:	0685                	addi	a3,a3,1
 3f2:	fcc77fe3          	bgeu	a4,a2,3d0 <printint+0x28>
  if(neg)
 3f6:	000e0c63          	beqz	t3,40e <printint+0x66>
    buf[i++] = '-';
 3fa:	fd050793          	addi	a5,a0,-48
 3fe:	00878533          	add	a0,a5,s0
 402:	02d00793          	li	a5,45
 406:	fef50823          	sb	a5,-16(a0)
 40a:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 40e:	fff7899b          	addiw	s3,a5,-1
 412:	006784b3          	add	s1,a5,t1
