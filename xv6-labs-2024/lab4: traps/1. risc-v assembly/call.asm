
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
}
  1a:	250d                	addiw	a0,a0,3
  1c:	60a2                	ld	ra,8(sp)
  1e:	6402                	ld	s0,0(sp)
  20:	0141                	addi	sp,sp,16
  22:	8082                	ret

0000000000000024 <main>:

void main(void) {
  24:	1141                	addi	sp,sp,-16
  26:	e406                	sd	ra,8(sp)
  28:	e022                	sd	s0,0(sp)
  2a:	0800                	addi	s0,sp,16
  printf("%d %d\n", f(8)+1, 13);
  2c:	4635                	li	a2,13
  2e:	45b1                	li	a1,12
  30:	00001517          	auipc	a0,0x1
  34:	86050513          	addi	a0,a0,-1952 # 890 <malloc+0xf6>
  38:	6aa000ef          	jal	6e2 <printf>
  exit(0);
  3c:	4501                	li	a0,0
  3e:	2a2000ef          	jal	2e0 <exit>

0000000000000042 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  42:	1141                	addi	sp,sp,-16
  44:	e406                	sd	ra,8(sp)
  46:	e022                	sd	s0,0(sp)
  48:	0800                	addi	s0,sp,16
  extern int main();
  main();
  4a:	fdbff0ef          	jal	24 <main>
  exit(0);
  4e:	4501                	li	a0,0
  50:	290000ef          	jal	2e0 <exit>

0000000000000054 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  54:	1141                	addi	sp,sp,-16
  56:	e406                	sd	ra,8(sp)
  58:	e022                	sd	s0,0(sp)
  5a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  5c:	87aa                	mv	a5,a0
  5e:	0585                	addi	a1,a1,1
  60:	0785                	addi	a5,a5,1
  62:	fff5c703          	lbu	a4,-1(a1)
  66:	fee78fa3          	sb	a4,-1(a5)
  6a:	fb75                	bnez	a4,5e <strcpy+0xa>
    ;
  return os;
}
  6c:	60a2                	ld	ra,8(sp)
  6e:	6402                	ld	s0,0(sp)
  70:	0141                	addi	sp,sp,16
  72:	8082                	ret

0000000000000074 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  74:	1141                	addi	sp,sp,-16
  76:	e406                	sd	ra,8(sp)
  78:	e022                	sd	s0,0(sp)
  7a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  7c:	00054783          	lbu	a5,0(a0)
  80:	cb91                	beqz	a5,94 <strcmp+0x20>
  82:	0005c703          	lbu	a4,0(a1)
  86:	00f71763          	bne	a4,a5,94 <strcmp+0x20>
    p++, q++;
  8a:	0505                	addi	a0,a0,1
  8c:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  8e:	00054783          	lbu	a5,0(a0)
  92:	fbe5                	bnez	a5,82 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  94:	0005c503          	lbu	a0,0(a1)
}
  98:	40a7853b          	subw	a0,a5,a0
  9c:	60a2                	ld	ra,8(sp)
  9e:	6402                	ld	s0,0(sp)
  a0:	0141                	addi	sp,sp,16
  a2:	8082                	ret

00000000000000a4 <strlen>:

uint
strlen(const char *s)
{
  a4:	1141                	addi	sp,sp,-16
  a6:	e406                	sd	ra,8(sp)
  a8:	e022                	sd	s0,0(sp)
  aa:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  ac:	00054783          	lbu	a5,0(a0)
  b0:	cf99                	beqz	a5,ce <strlen+0x2a>
  b2:	0505                	addi	a0,a0,1
  b4:	87aa                	mv	a5,a0
  b6:	86be                	mv	a3,a5
  b8:	0785                	addi	a5,a5,1
  ba:	fff7c703          	lbu	a4,-1(a5)
  be:	ff65                	bnez	a4,b6 <strlen+0x12>
  c0:	40a6853b          	subw	a0,a3,a0
  c4:	2505                	addiw	a0,a0,1
    ;
  return n;
}
  c6:	60a2                	ld	ra,8(sp)
  c8:	6402                	ld	s0,0(sp)
  ca:	0141                	addi	sp,sp,16
  cc:	8082                	ret
  for(n = 0; s[n]; n++)
  ce:	4501                	li	a0,0
  d0:	bfdd                	j	c6 <strlen+0x22>

00000000000000d2 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d2:	1141                	addi	sp,sp,-16
  d4:	e406                	sd	ra,8(sp)
  d6:	e022                	sd	s0,0(sp)
  d8:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  da:	ca19                	beqz	a2,f0 <memset+0x1e>
  dc:	87aa                	mv	a5,a0
  de:	1602                	slli	a2,a2,0x20
  e0:	9201                	srli	a2,a2,0x20
  e2:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  e6:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  ea:	0785                	addi	a5,a5,1
  ec:	fee79de3          	bne	a5,a4,e6 <memset+0x14>
  }
  return dst;
}
  f0:	60a2                	ld	ra,8(sp)
  f2:	6402                	ld	s0,0(sp)
  f4:	0141                	addi	sp,sp,16
  f6:	8082                	ret

00000000000000f8 <strchr>:

char*
strchr(const char *s, char c)
{
  f8:	1141                	addi	sp,sp,-16
  fa:	e406                	sd	ra,8(sp)
  fc:	e022                	sd	s0,0(sp)
  fe:	0800                	addi	s0,sp,16
  for(; *s; s++)
 100:	00054783          	lbu	a5,0(a0)
 104:	cf81                	beqz	a5,11c <strchr+0x24>
    if(*s == c)
 106:	00f58763          	beq	a1,a5,114 <strchr+0x1c>
  for(; *s; s++)
 10a:	0505                	addi	a0,a0,1
 10c:	00054783          	lbu	a5,0(a0)
 110:	fbfd                	bnez	a5,106 <strchr+0xe>
      return (char*)s;
  return 0;
 112:	4501                	li	a0,0
}
 114:	60a2                	ld	ra,8(sp)
 116:	6402                	ld	s0,0(sp)
 118:	0141                	addi	sp,sp,16
 11a:	8082                	ret
  return 0;
 11c:	4501                	li	a0,0
 11e:	bfdd                	j	114 <strchr+0x1c>

0000000000000120 <gets>:

char*
gets(char *buf, int max)
{
 120:	7159                	addi	sp,sp,-112
 122:	f486                	sd	ra,104(sp)
 124:	f0a2                	sd	s0,96(sp)
 126:	eca6                	sd	s1,88(sp)
 128:	e8ca                	sd	s2,80(sp)
 12a:	e4ce                	sd	s3,72(sp)
 12c:	e0d2                	sd	s4,64(sp)
 12e:	fc56                	sd	s5,56(sp)
 130:	f85a                	sd	s6,48(sp)
 132:	f45e                	sd	s7,40(sp)
 134:	f062                	sd	s8,32(sp)
 136:	ec66                	sd	s9,24(sp)
 138:	e86a                	sd	s10,16(sp)
 13a:	1880                	addi	s0,sp,112
 13c:	8caa                	mv	s9,a0
 13e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 140:	892a                	mv	s2,a0
 142:	4481                	li	s1,0
    cc = read(0, &c, 1);
 144:	f9f40b13          	addi	s6,s0,-97
 148:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 14a:	4ba9                	li	s7,10
 14c:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 14e:	8d26                	mv	s10,s1
 150:	0014899b          	addiw	s3,s1,1
 154:	84ce                	mv	s1,s3
 156:	0349d563          	bge	s3,s4,180 <gets+0x60>
    cc = read(0, &c, 1);
 15a:	8656                	mv	a2,s5
 15c:	85da                	mv	a1,s6
 15e:	4501                	li	a0,0
 160:	198000ef          	jal	2f8 <read>
    if(cc < 1)
 164:	00a05e63          	blez	a0,180 <gets+0x60>
    buf[i++] = c;
 168:	f9f44783          	lbu	a5,-97(s0)
 16c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 170:	01778763          	beq	a5,s7,17e <gets+0x5e>
 174:	0905                	addi	s2,s2,1
 176:	fd879ce3          	bne	a5,s8,14e <gets+0x2e>
    buf[i++] = c;
 17a:	8d4e                	mv	s10,s3
 17c:	a011                	j	180 <gets+0x60>
 17e:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 180:	9d66                	add	s10,s10,s9
 182:	000d0023          	sb	zero,0(s10)
  return buf;
}
 186:	8566                	mv	a0,s9
 188:	70a6                	ld	ra,104(sp)
 18a:	7406                	ld	s0,96(sp)
 18c:	64e6                	ld	s1,88(sp)
 18e:	6946                	ld	s2,80(sp)
 190:	69a6                	ld	s3,72(sp)
 192:	6a06                	ld	s4,64(sp)
 194:	7ae2                	ld	s5,56(sp)
 196:	7b42                	ld	s6,48(sp)
 198:	7ba2                	ld	s7,40(sp)
 19a:	7c02                	ld	s8,32(sp)
 19c:	6ce2                	ld	s9,24(sp)
 19e:	6d42                	ld	s10,16(sp)
 1a0:	6165                	addi	sp,sp,112
 1a2:	8082                	ret

00000000000001a4 <stat>:

int
stat(const char *n, struct stat *st)
{
 1a4:	1101                	addi	sp,sp,-32
 1a6:	ec06                	sd	ra,24(sp)
 1a8:	e822                	sd	s0,16(sp)
 1aa:	e04a                	sd	s2,0(sp)
 1ac:	1000                	addi	s0,sp,32
 1ae:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1b0:	4581                	li	a1,0
 1b2:	16e000ef          	jal	320 <open>
  if(fd < 0)
 1b6:	02054263          	bltz	a0,1da <stat+0x36>
 1ba:	e426                	sd	s1,8(sp)
 1bc:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1be:	85ca                	mv	a1,s2
 1c0:	178000ef          	jal	338 <fstat>
 1c4:	892a                	mv	s2,a0
  close(fd);
 1c6:	8526                	mv	a0,s1
 1c8:	140000ef          	jal	308 <close>
  return r;
 1cc:	64a2                	ld	s1,8(sp)
}
 1ce:	854a                	mv	a0,s2
 1d0:	60e2                	ld	ra,24(sp)
 1d2:	6442                	ld	s0,16(sp)
 1d4:	6902                	ld	s2,0(sp)
 1d6:	6105                	addi	sp,sp,32
 1d8:	8082                	ret
    return -1;
 1da:	597d                	li	s2,-1
 1dc:	bfcd                	j	1ce <stat+0x2a>

00000000000001de <atoi>:

int
atoi(const char *s)
{
 1de:	1141                	addi	sp,sp,-16
 1e0:	e406                	sd	ra,8(sp)
 1e2:	e022                	sd	s0,0(sp)
 1e4:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1e6:	00054683          	lbu	a3,0(a0)
 1ea:	fd06879b          	addiw	a5,a3,-48
 1ee:	0ff7f793          	zext.b	a5,a5
 1f2:	4625                	li	a2,9
 1f4:	02f66963          	bltu	a2,a5,226 <atoi+0x48>
 1f8:	872a                	mv	a4,a0
  n = 0;
 1fa:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 1fc:	0705                	addi	a4,a4,1
 1fe:	0025179b          	slliw	a5,a0,0x2
 202:	9fa9                	addw	a5,a5,a0
 204:	0017979b          	slliw	a5,a5,0x1
 208:	9fb5                	addw	a5,a5,a3
 20a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 20e:	00074683          	lbu	a3,0(a4)
 212:	fd06879b          	addiw	a5,a3,-48
 216:	0ff7f793          	zext.b	a5,a5
 21a:	fef671e3          	bgeu	a2,a5,1fc <atoi+0x1e>
  return n;
}
 21e:	60a2                	ld	ra,8(sp)
 220:	6402                	ld	s0,0(sp)
 222:	0141                	addi	sp,sp,16
 224:	8082                	ret
  n = 0;
 226:	4501                	li	a0,0
 228:	bfdd                	j	21e <atoi+0x40>

000000000000022a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 22a:	1141                	addi	sp,sp,-16
 22c:	e406                	sd	ra,8(sp)
 22e:	e022                	sd	s0,0(sp)
 230:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 232:	02b57563          	bgeu	a0,a1,25c <memmove+0x32>
    while(n-- > 0)
 236:	00c05f63          	blez	a2,254 <memmove+0x2a>
 23a:	1602                	slli	a2,a2,0x20
 23c:	9201                	srli	a2,a2,0x20
 23e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 242:	872a                	mv	a4,a0
      *dst++ = *src++;
 244:	0585                	addi	a1,a1,1
 246:	0705                	addi	a4,a4,1
 248:	fff5c683          	lbu	a3,-1(a1)
 24c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 250:	fee79ae3          	bne	a5,a4,244 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 254:	60a2                	ld	ra,8(sp)
 256:	6402                	ld	s0,0(sp)
 258:	0141                	addi	sp,sp,16
 25a:	8082                	ret
    dst += n;
 25c:	00c50733          	add	a4,a0,a2
    src += n;
 260:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 262:	fec059e3          	blez	a2,254 <memmove+0x2a>
 266:	fff6079b          	addiw	a5,a2,-1
 26a:	1782                	slli	a5,a5,0x20
 26c:	9381                	srli	a5,a5,0x20
 26e:	fff7c793          	not	a5,a5
 272:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 274:	15fd                	addi	a1,a1,-1
 276:	177d                	addi	a4,a4,-1
 278:	0005c683          	lbu	a3,0(a1)
 27c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 280:	fef71ae3          	bne	a4,a5,274 <memmove+0x4a>
 284:	bfc1                	j	254 <memmove+0x2a>

0000000000000286 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 286:	1141                	addi	sp,sp,-16
 288:	e406                	sd	ra,8(sp)
 28a:	e022                	sd	s0,0(sp)
 28c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 28e:	ca0d                	beqz	a2,2c0 <memcmp+0x3a>
 290:	fff6069b          	addiw	a3,a2,-1
 294:	1682                	slli	a3,a3,0x20
 296:	9281                	srli	a3,a3,0x20
 298:	0685                	addi	a3,a3,1
 29a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 29c:	00054783          	lbu	a5,0(a0)
 2a0:	0005c703          	lbu	a4,0(a1)
 2a4:	00e79863          	bne	a5,a4,2b4 <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 2a8:	0505                	addi	a0,a0,1
    p2++;
 2aa:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2ac:	fed518e3          	bne	a0,a3,29c <memcmp+0x16>
  }
  return 0;
 2b0:	4501                	li	a0,0
 2b2:	a019                	j	2b8 <memcmp+0x32>
      return *p1 - *p2;
 2b4:	40e7853b          	subw	a0,a5,a4
}
 2b8:	60a2                	ld	ra,8(sp)
 2ba:	6402                	ld	s0,0(sp)
 2bc:	0141                	addi	sp,sp,16
 2be:	8082                	ret
  return 0;
 2c0:	4501                	li	a0,0
 2c2:	bfdd                	j	2b8 <memcmp+0x32>

00000000000002c4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2c4:	1141                	addi	sp,sp,-16
 2c6:	e406                	sd	ra,8(sp)
 2c8:	e022                	sd	s0,0(sp)
 2ca:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2cc:	f5fff0ef          	jal	22a <memmove>
}
 2d0:	60a2                	ld	ra,8(sp)
 2d2:	6402                	ld	s0,0(sp)
 2d4:	0141                	addi	sp,sp,16
 2d6:	8082                	ret

00000000000002d8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2d8:	4885                	li	a7,1
 ecall
 2da:	00000073          	ecall
 ret
 2de:	8082                	ret

00000000000002e0 <exit>:
.global exit
exit:
 li a7, SYS_exit
 2e0:	4889                	li	a7,2
 ecall
 2e2:	00000073          	ecall
 ret
 2e6:	8082                	ret

00000000000002e8 <wait>:
.global wait
wait:
 li a7, SYS_wait
 2e8:	488d                	li	a7,3
 ecall
 2ea:	00000073          	ecall
 ret
 2ee:	8082                	ret

00000000000002f0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2f0:	4891                	li	a7,4
 ecall
 2f2:	00000073          	ecall
 ret
 2f6:	8082                	ret

00000000000002f8 <read>:
.global read
read:
 li a7, SYS_read
 2f8:	4895                	li	a7,5
 ecall
 2fa:	00000073          	ecall
 ret
 2fe:	8082                	ret

0000000000000300 <write>:
.global write
write:
 li a7, SYS_write
 300:	48c1                	li	a7,16
 ecall
 302:	00000073          	ecall
 ret
 306:	8082                	ret

0000000000000308 <close>:
.global close
close:
 li a7, SYS_close
 308:	48d5                	li	a7,21
 ecall
 30a:	00000073          	ecall
 ret
 30e:	8082                	ret

0000000000000310 <kill>:
.global kill
kill:
 li a7, SYS_kill
 310:	4899                	li	a7,6
 ecall
 312:	00000073          	ecall
 ret
 316:	8082                	ret

0000000000000318 <exec>:
.global exec
exec:
 li a7, SYS_exec
 318:	489d                	li	a7,7
 ecall
 31a:	00000073          	ecall
 ret
 31e:	8082                	ret

0000000000000320 <open>:
.global open
open:
 li a7, SYS_open
 320:	48bd                	li	a7,15
 ecall
 322:	00000073          	ecall
 ret
 326:	8082                	ret

0000000000000328 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 328:	48c5                	li	a7,17
 ecall
 32a:	00000073          	ecall
 ret
 32e:	8082                	ret

0000000000000330 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 330:	48c9                	li	a7,18
 ecall
 332:	00000073          	ecall
 ret
 336:	8082                	ret

0000000000000338 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 338:	48a1                	li	a7,8
 ecall
 33a:	00000073          	ecall
 ret
 33e:	8082                	ret

0000000000000340 <link>:
.global link
link:
 li a7, SYS_link
 340:	48cd                	li	a7,19
 ecall
 342:	00000073          	ecall
 ret
 346:	8082                	ret

0000000000000348 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 348:	48d1                	li	a7,20
 ecall
 34a:	00000073          	ecall
 ret
 34e:	8082                	ret

0000000000000350 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 350:	48a5                	li	a7,9
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <dup>:
.global dup
dup:
 li a7, SYS_dup
 358:	48a9                	li	a7,10
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 360:	48ad                	li	a7,11
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 368:	48b1                	li	a7,12
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 370:	48b5                	li	a7,13
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 378:	48b9                	li	a7,14
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 380:	1101                	addi	sp,sp,-32
 382:	ec06                	sd	ra,24(sp)
 384:	e822                	sd	s0,16(sp)
 386:	1000                	addi	s0,sp,32
 388:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 38c:	4605                	li	a2,1
 38e:	fef40593          	addi	a1,s0,-17
 392:	f6fff0ef          	jal	300 <write>
}
 396:	60e2                	ld	ra,24(sp)
 398:	6442                	ld	s0,16(sp)
 39a:	6105                	addi	sp,sp,32
 39c:	8082                	ret

000000000000039e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 39e:	7139                	addi	sp,sp,-64
 3a0:	fc06                	sd	ra,56(sp)
 3a2:	f822                	sd	s0,48(sp)
 3a4:	f426                	sd	s1,40(sp)
 3a6:	f04a                	sd	s2,32(sp)
 3a8:	ec4e                	sd	s3,24(sp)
 3aa:	0080                	addi	s0,sp,64
 3ac:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3ae:	c299                	beqz	a3,3b4 <printint+0x16>
 3b0:	0605ce63          	bltz	a1,42c <printint+0x8e>
  neg = 0;
 3b4:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 3b6:	fc040313          	addi	t1,s0,-64
  neg = 0;
 3ba:	869a                	mv	a3,t1
  i = 0;
 3bc:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 3be:	00000817          	auipc	a6,0x0
 3c2:	4e280813          	addi	a6,a6,1250 # 8a0 <digits>
 3c6:	88be                	mv	a7,a5
 3c8:	0017851b          	addiw	a0,a5,1
 3cc:	87aa                	mv	a5,a0
 3ce:	02c5f73b          	remuw	a4,a1,a2
 3d2:	1702                	slli	a4,a4,0x20
 3d4:	9301                	srli	a4,a4,0x20
 3d6:	9742                	add	a4,a4,a6
 3d8:	00074703          	lbu	a4,0(a4)
 3dc:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 3e0:	872e                	mv	a4,a1
 3e2:	02c5d5bb          	divuw	a1,a1,a2
 3e6:	0685                	addi	a3,a3,1
 3e8:	fcc77fe3          	bgeu	a4,a2,3c6 <printint+0x28>
  if(neg)
 3ec:	000e0c63          	beqz	t3,404 <printint+0x66>
    buf[i++] = '-';
 3f0:	fd050793          	addi	a5,a0,-48
 3f4:	00878533          	add	a0,a5,s0
 3f8:	02d00793          	li	a5,45
 3fc:	fef50823          	sb	a5,-16(a0)
 400:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 404:	fff7899b          	addiw	s3,a5,-1
 408:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 40c:	fff4c583          	lbu	a1,-1(s1)
 410:	854a                	mv	a0,s2
 412:	f6fff0ef          	jal	380 <putc>
  while(--i >= 0)
 416:	39fd                	addiw	s3,s3,-1
 418:	14fd                	addi	s1,s1,-1
 41a:	fe09d9e3          	bgez	s3,40c <printint+0x6e>
}
 41e:	70e2                	ld	ra,56(sp)
 420:	7442                	ld	s0,48(sp)
 422:	74a2                	ld	s1,40(sp)
 424:	7902                	ld	s2,32(sp)
 426:	69e2                	ld	s3,24(sp)
 428:	6121                	addi	sp,sp,64
 42a:	8082                	ret
    x = -xx;
 42c:	40b005bb          	negw	a1,a1
    neg = 1;
 430:	4e05                	li	t3,1
    x = -xx;
 432:	b751                	j	3b6 <printint+0x18>

0000000000000434 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 434:	711d                	addi	sp,sp,-96
 436:	ec86                	sd	ra,88(sp)
 438:	e8a2                	sd	s0,80(sp)
 43a:	e4a6                	sd	s1,72(sp)
 43c:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 43e:	0005c483          	lbu	s1,0(a1)
 442:	26048663          	beqz	s1,6ae <vprintf+0x27a>
 446:	e0ca                	sd	s2,64(sp)
 448:	fc4e                	sd	s3,56(sp)
 44a:	f852                	sd	s4,48(sp)
 44c:	f456                	sd	s5,40(sp)
 44e:	f05a                	sd	s6,32(sp)
 450:	ec5e                	sd	s7,24(sp)
 452:	e862                	sd	s8,16(sp)
 454:	e466                	sd	s9,8(sp)
 456:	8b2a                	mv	s6,a0
 458:	8a2e                	mv	s4,a1
 45a:	8bb2                	mv	s7,a2
  state = 0;
 45c:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 45e:	4901                	li	s2,0
 460:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 462:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 466:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 46a:	06c00c93          	li	s9,108
 46e:	a00d                	j	490 <vprintf+0x5c>
        putc(fd, c0);
 470:	85a6                	mv	a1,s1
 472:	855a                	mv	a0,s6
 474:	f0dff0ef          	jal	380 <putc>
 478:	a019                	j	47e <vprintf+0x4a>
    } else if(state == '%'){
 47a:	03598363          	beq	s3,s5,4a0 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 47e:	0019079b          	addiw	a5,s2,1
 482:	893e                	mv	s2,a5
 484:	873e                	mv	a4,a5
 486:	97d2                	add	a5,a5,s4
 488:	0007c483          	lbu	s1,0(a5)
 48c:	20048963          	beqz	s1,69e <vprintf+0x26a>
    c0 = fmt[i] & 0xff;
 490:	0004879b          	sext.w	a5,s1
    if(state == 0){
 494:	fe0993e3          	bnez	s3,47a <vprintf+0x46>
      if(c0 == '%'){
 498:	fd579ce3          	bne	a5,s5,470 <vprintf+0x3c>
        state = '%';
 49c:	89be                	mv	s3,a5
 49e:	b7c5                	j	47e <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 4a0:	00ea06b3          	add	a3,s4,a4
 4a4:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 4a8:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 4aa:	c681                	beqz	a3,4b2 <vprintf+0x7e>
 4ac:	9752                	add	a4,a4,s4
 4ae:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 4b2:	03878e63          	beq	a5,s8,4ee <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 4b6:	05978863          	beq	a5,s9,506 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 4ba:	07500713          	li	a4,117
 4be:	0ee78263          	beq	a5,a4,5a2 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 4c2:	07800713          	li	a4,120
 4c6:	12e78463          	beq	a5,a4,5ee <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 4ca:	07000713          	li	a4,112
 4ce:	14e78963          	beq	a5,a4,620 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 4d2:	07300713          	li	a4,115
 4d6:	18e78863          	beq	a5,a4,666 <vprintf+0x232>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 4da:	02500713          	li	a4,37
 4de:	04e79463          	bne	a5,a4,526 <vprintf+0xf2>
        putc(fd, '%');
 4e2:	85ba                	mv	a1,a4
 4e4:	855a                	mv	a0,s6
 4e6:	e9bff0ef          	jal	380 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 4ea:	4981                	li	s3,0
 4ec:	bf49                	j	47e <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 4ee:	008b8493          	addi	s1,s7,8
 4f2:	4685                	li	a3,1
 4f4:	4629                	li	a2,10
 4f6:	000ba583          	lw	a1,0(s7)
 4fa:	855a                	mv	a0,s6
 4fc:	ea3ff0ef          	jal	39e <printint>
 500:	8ba6                	mv	s7,s1
      state = 0;
 502:	4981                	li	s3,0
 504:	bfad                	j	47e <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 506:	06400793          	li	a5,100
 50a:	02f68963          	beq	a3,a5,53c <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 50e:	06c00793          	li	a5,108
 512:	04f68263          	beq	a3,a5,556 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 516:	07500793          	li	a5,117
 51a:	0af68063          	beq	a3,a5,5ba <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 51e:	07800793          	li	a5,120
 522:	0ef68263          	beq	a3,a5,606 <vprintf+0x1d2>
        putc(fd, '%');
 526:	02500593          	li	a1,37
 52a:	855a                	mv	a0,s6
 52c:	e55ff0ef          	jal	380 <putc>
        putc(fd, c0);
 530:	85a6                	mv	a1,s1
 532:	855a                	mv	a0,s6
 534:	e4dff0ef          	jal	380 <putc>
      state = 0;
 538:	4981                	li	s3,0
 53a:	b791                	j	47e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 53c:	008b8493          	addi	s1,s7,8
 540:	4685                	li	a3,1
 542:	4629                	li	a2,10
 544:	000ba583          	lw	a1,0(s7)
 548:	855a                	mv	a0,s6
 54a:	e55ff0ef          	jal	39e <printint>
        i += 1;
 54e:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 550:	8ba6                	mv	s7,s1
      state = 0;
 552:	4981                	li	s3,0
        i += 1;
 554:	b72d                	j	47e <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 556:	06400793          	li	a5,100
 55a:	02f60763          	beq	a2,a5,588 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 55e:	07500793          	li	a5,117
 562:	06f60963          	beq	a2,a5,5d4 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 566:	07800793          	li	a5,120
 56a:	faf61ee3          	bne	a2,a5,526 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 56e:	008b8493          	addi	s1,s7,8
 572:	4681                	li	a3,0
 574:	4641                	li	a2,16
 576:	000ba583          	lw	a1,0(s7)
 57a:	855a                	mv	a0,s6
 57c:	e23ff0ef          	jal	39e <printint>
        i += 2;
 580:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 582:	8ba6                	mv	s7,s1
      state = 0;
 584:	4981                	li	s3,0
        i += 2;
 586:	bde5                	j	47e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 588:	008b8493          	addi	s1,s7,8
 58c:	4685                	li	a3,1
 58e:	4629                	li	a2,10
 590:	000ba583          	lw	a1,0(s7)
 594:	855a                	mv	a0,s6
 596:	e09ff0ef          	jal	39e <printint>
        i += 2;
 59a:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 59c:	8ba6                	mv	s7,s1
      state = 0;
 59e:	4981                	li	s3,0
        i += 2;
 5a0:	bdf9                	j	47e <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 5a2:	008b8493          	addi	s1,s7,8
 5a6:	4681                	li	a3,0
 5a8:	4629                	li	a2,10
 5aa:	000ba583          	lw	a1,0(s7)
 5ae:	855a                	mv	a0,s6
 5b0:	defff0ef          	jal	39e <printint>
 5b4:	8ba6                	mv	s7,s1
      state = 0;
 5b6:	4981                	li	s3,0
 5b8:	b5d9                	j	47e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5ba:	008b8493          	addi	s1,s7,8
 5be:	4681                	li	a3,0
 5c0:	4629                	li	a2,10
 5c2:	000ba583          	lw	a1,0(s7)
 5c6:	855a                	mv	a0,s6
 5c8:	dd7ff0ef          	jal	39e <printint>
        i += 1;
 5cc:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 5ce:	8ba6                	mv	s7,s1
      state = 0;
 5d0:	4981                	li	s3,0
        i += 1;
 5d2:	b575                	j	47e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5d4:	008b8493          	addi	s1,s7,8
 5d8:	4681                	li	a3,0
 5da:	4629                	li	a2,10
 5dc:	000ba583          	lw	a1,0(s7)
 5e0:	855a                	mv	a0,s6
 5e2:	dbdff0ef          	jal	39e <printint>
        i += 2;
 5e6:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 5e8:	8ba6                	mv	s7,s1
      state = 0;
 5ea:	4981                	li	s3,0
        i += 2;
 5ec:	bd49                	j	47e <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 5ee:	008b8493          	addi	s1,s7,8
 5f2:	4681                	li	a3,0
 5f4:	4641                	li	a2,16
 5f6:	000ba583          	lw	a1,0(s7)
 5fa:	855a                	mv	a0,s6
 5fc:	da3ff0ef          	jal	39e <printint>
 600:	8ba6                	mv	s7,s1
      state = 0;
 602:	4981                	li	s3,0
 604:	bdad                	j	47e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 606:	008b8493          	addi	s1,s7,8
 60a:	4681                	li	a3,0
 60c:	4641                	li	a2,16
 60e:	000ba583          	lw	a1,0(s7)
 612:	855a                	mv	a0,s6
 614:	d8bff0ef          	jal	39e <printint>
        i += 1;
 618:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 61a:	8ba6                	mv	s7,s1
      state = 0;
 61c:	4981                	li	s3,0
        i += 1;
 61e:	b585                	j	47e <vprintf+0x4a>
 620:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 622:	008b8d13          	addi	s10,s7,8
 626:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 62a:	03000593          	li	a1,48
 62e:	855a                	mv	a0,s6
 630:	d51ff0ef          	jal	380 <putc>
  putc(fd, 'x');
 634:	07800593          	li	a1,120
 638:	855a                	mv	a0,s6
 63a:	d47ff0ef          	jal	380 <putc>
 63e:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 640:	00000b97          	auipc	s7,0x0
 644:	260b8b93          	addi	s7,s7,608 # 8a0 <digits>
 648:	03c9d793          	srli	a5,s3,0x3c
 64c:	97de                	add	a5,a5,s7
 64e:	0007c583          	lbu	a1,0(a5)
 652:	855a                	mv	a0,s6
 654:	d2dff0ef          	jal	380 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 658:	0992                	slli	s3,s3,0x4
 65a:	34fd                	addiw	s1,s1,-1
 65c:	f4f5                	bnez	s1,648 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 65e:	8bea                	mv	s7,s10
      state = 0;
 660:	4981                	li	s3,0
 662:	6d02                	ld	s10,0(sp)
 664:	bd29                	j	47e <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 666:	008b8993          	addi	s3,s7,8
 66a:	000bb483          	ld	s1,0(s7)
 66e:	cc91                	beqz	s1,68a <vprintf+0x256>
        for(; *s; s++)
 670:	0004c583          	lbu	a1,0(s1)
 674:	c195                	beqz	a1,698 <vprintf+0x264>
          putc(fd, *s);
 676:	855a                	mv	a0,s6
 678:	d09ff0ef          	jal	380 <putc>
        for(; *s; s++)
 67c:	0485                	addi	s1,s1,1
 67e:	0004c583          	lbu	a1,0(s1)
 682:	f9f5                	bnez	a1,676 <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 684:	8bce                	mv	s7,s3
      state = 0;
 686:	4981                	li	s3,0
 688:	bbdd                	j	47e <vprintf+0x4a>
          s = "(null)";
 68a:	00000497          	auipc	s1,0x0
 68e:	20e48493          	addi	s1,s1,526 # 898 <malloc+0xfe>
        for(; *s; s++)
 692:	02800593          	li	a1,40
 696:	b7c5                	j	676 <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 698:	8bce                	mv	s7,s3
      state = 0;
 69a:	4981                	li	s3,0
 69c:	b3cd                	j	47e <vprintf+0x4a>
 69e:	6906                	ld	s2,64(sp)
 6a0:	79e2                	ld	s3,56(sp)
 6a2:	7a42                	ld	s4,48(sp)
 6a4:	7aa2                	ld	s5,40(sp)
 6a6:	7b02                	ld	s6,32(sp)
 6a8:	6be2                	ld	s7,24(sp)
 6aa:	6c42                	ld	s8,16(sp)
 6ac:	6ca2                	ld	s9,8(sp)
    }
  }
}
 6ae:	60e6                	ld	ra,88(sp)
 6b0:	6446                	ld	s0,80(sp)
 6b2:	64a6                	ld	s1,72(sp)
 6b4:	6125                	addi	sp,sp,96
 6b6:	8082                	ret

00000000000006b8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6b8:	715d                	addi	sp,sp,-80
 6ba:	ec06                	sd	ra,24(sp)
 6bc:	e822                	sd	s0,16(sp)
 6be:	1000                	addi	s0,sp,32
 6c0:	e010                	sd	a2,0(s0)
 6c2:	e414                	sd	a3,8(s0)
 6c4:	e818                	sd	a4,16(s0)
 6c6:	ec1c                	sd	a5,24(s0)
 6c8:	03043023          	sd	a6,32(s0)
 6cc:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6d0:	8622                	mv	a2,s0
 6d2:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6d6:	d5fff0ef          	jal	434 <vprintf>
}
 6da:	60e2                	ld	ra,24(sp)
 6dc:	6442                	ld	s0,16(sp)
 6de:	6161                	addi	sp,sp,80
 6e0:	8082                	ret

00000000000006e2 <printf>:

void
printf(const char *fmt, ...)
{
 6e2:	711d                	addi	sp,sp,-96
 6e4:	ec06                	sd	ra,24(sp)
 6e6:	e822                	sd	s0,16(sp)
 6e8:	1000                	addi	s0,sp,32
 6ea:	e40c                	sd	a1,8(s0)
 6ec:	e810                	sd	a2,16(s0)
 6ee:	ec14                	sd	a3,24(s0)
 6f0:	f018                	sd	a4,32(s0)
 6f2:	f41c                	sd	a5,40(s0)
 6f4:	03043823          	sd	a6,48(s0)
 6f8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6fc:	00840613          	addi	a2,s0,8
 700:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 704:	85aa                	mv	a1,a0
 706:	4505                	li	a0,1
 708:	d2dff0ef          	jal	434 <vprintf>
}
 70c:	60e2                	ld	ra,24(sp)
 70e:	6442                	ld	s0,16(sp)
 710:	6125                	addi	sp,sp,96
 712:	8082                	ret

0000000000000714 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 714:	1141                	addi	sp,sp,-16
 716:	e406                	sd	ra,8(sp)
 718:	e022                	sd	s0,0(sp)
 71a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 71c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 720:	00001797          	auipc	a5,0x1
 724:	8e07b783          	ld	a5,-1824(a5) # 1000 <freep>
 728:	a02d                	j	752 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 72a:	4618                	lw	a4,8(a2)
 72c:	9f2d                	addw	a4,a4,a1
 72e:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 732:	6398                	ld	a4,0(a5)
 734:	6310                	ld	a2,0(a4)
 736:	a83d                	j	774 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 738:	ff852703          	lw	a4,-8(a0)
 73c:	9f31                	addw	a4,a4,a2
 73e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 740:	ff053683          	ld	a3,-16(a0)
 744:	a091                	j	788 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 746:	6398                	ld	a4,0(a5)
 748:	00e7e463          	bltu	a5,a4,750 <free+0x3c>
 74c:	00e6ea63          	bltu	a3,a4,760 <free+0x4c>
{
 750:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 752:	fed7fae3          	bgeu	a5,a3,746 <free+0x32>
 756:	6398                	ld	a4,0(a5)
 758:	00e6e463          	bltu	a3,a4,760 <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 75c:	fee7eae3          	bltu	a5,a4,750 <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 760:	ff852583          	lw	a1,-8(a0)
 764:	6390                	ld	a2,0(a5)
 766:	02059813          	slli	a6,a1,0x20
 76a:	01c85713          	srli	a4,a6,0x1c
 76e:	9736                	add	a4,a4,a3
 770:	fae60de3          	beq	a2,a4,72a <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 774:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 778:	4790                	lw	a2,8(a5)
 77a:	02061593          	slli	a1,a2,0x20
 77e:	01c5d713          	srli	a4,a1,0x1c
 782:	973e                	add	a4,a4,a5
 784:	fae68ae3          	beq	a3,a4,738 <free+0x24>
    p->s.ptr = bp->s.ptr;
 788:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 78a:	00001717          	auipc	a4,0x1
 78e:	86f73b23          	sd	a5,-1930(a4) # 1000 <freep>
}
 792:	60a2                	ld	ra,8(sp)
 794:	6402                	ld	s0,0(sp)
 796:	0141                	addi	sp,sp,16
 798:	8082                	ret

000000000000079a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 79a:	7139                	addi	sp,sp,-64
 79c:	fc06                	sd	ra,56(sp)
 79e:	f822                	sd	s0,48(sp)
 7a0:	f04a                	sd	s2,32(sp)
 7a2:	ec4e                	sd	s3,24(sp)
 7a4:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a6:	02051993          	slli	s3,a0,0x20
 7aa:	0209d993          	srli	s3,s3,0x20
 7ae:	09bd                	addi	s3,s3,15
 7b0:	0049d993          	srli	s3,s3,0x4
 7b4:	2985                	addiw	s3,s3,1
 7b6:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 7b8:	00001517          	auipc	a0,0x1
 7bc:	84853503          	ld	a0,-1976(a0) # 1000 <freep>
 7c0:	c905                	beqz	a0,7f0 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7c4:	4798                	lw	a4,8(a5)
 7c6:	09377663          	bgeu	a4,s3,852 <malloc+0xb8>
 7ca:	f426                	sd	s1,40(sp)
 7cc:	e852                	sd	s4,16(sp)
 7ce:	e456                	sd	s5,8(sp)
 7d0:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 7d2:	8a4e                	mv	s4,s3
 7d4:	6705                	lui	a4,0x1
 7d6:	00e9f363          	bgeu	s3,a4,7dc <malloc+0x42>
 7da:	6a05                	lui	s4,0x1
 7dc:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 7e0:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7e4:	00001497          	auipc	s1,0x1
 7e8:	81c48493          	addi	s1,s1,-2020 # 1000 <freep>
  if(p == (char*)-1)
 7ec:	5afd                	li	s5,-1
 7ee:	a83d                	j	82c <malloc+0x92>
 7f0:	f426                	sd	s1,40(sp)
 7f2:	e852                	sd	s4,16(sp)
 7f4:	e456                	sd	s5,8(sp)
 7f6:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 7f8:	00001797          	auipc	a5,0x1
 7fc:	81878793          	addi	a5,a5,-2024 # 1010 <base>
 800:	00001717          	auipc	a4,0x1
 804:	80f73023          	sd	a5,-2048(a4) # 1000 <freep>
 808:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 80a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 80e:	b7d1                	j	7d2 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 810:	6398                	ld	a4,0(a5)
 812:	e118                	sd	a4,0(a0)
 814:	a899                	j	86a <malloc+0xd0>
  hp->s.size = nu;
 816:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 81a:	0541                	addi	a0,a0,16
 81c:	ef9ff0ef          	jal	714 <free>
  return freep;
 820:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 822:	c125                	beqz	a0,882 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 824:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 826:	4798                	lw	a4,8(a5)
 828:	03277163          	bgeu	a4,s2,84a <malloc+0xb0>
    if(p == freep)
 82c:	6098                	ld	a4,0(s1)
 82e:	853e                	mv	a0,a5
 830:	fef71ae3          	bne	a4,a5,824 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 834:	8552                	mv	a0,s4
 836:	b33ff0ef          	jal	368 <sbrk>
  if(p == (char*)-1)
 83a:	fd551ee3          	bne	a0,s5,816 <malloc+0x7c>
        return 0;
 83e:	4501                	li	a0,0
 840:	74a2                	ld	s1,40(sp)
 842:	6a42                	ld	s4,16(sp)
 844:	6aa2                	ld	s5,8(sp)
 846:	6b02                	ld	s6,0(sp)
 848:	a03d                	j	876 <malloc+0xdc>
 84a:	74a2                	ld	s1,40(sp)
 84c:	6a42                	ld	s4,16(sp)
 84e:	6aa2                	ld	s5,8(sp)
 850:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 852:	fae90fe3          	beq	s2,a4,810 <malloc+0x76>
        p->s.size -= nunits;
 856:	4137073b          	subw	a4,a4,s3
 85a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 85c:	02071693          	slli	a3,a4,0x20
 860:	01c6d713          	srli	a4,a3,0x1c
 864:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 866:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 86a:	00000717          	auipc	a4,0x0
 86e:	78a73b23          	sd	a0,1942(a4) # 1000 <freep>
      return (void*)(p + 1);
 872:	01078513          	addi	a0,a5,16
  }
}
 876:	70e2                	ld	ra,56(sp)
 878:	7442                	ld	s0,48(sp)
 87a:	7902                	ld	s2,32(sp)
 87c:	69e2                	ld	s3,24(sp)
 87e:	6121                	addi	sp,sp,64
 880:	8082                	ret
 882:	74a2                	ld	s1,40(sp)
 884:	6a42                	ld	s4,16(sp)
 886:	6aa2                	ld	s5,8(sp)
 888:	6b02                	ld	s6,0(sp)
 88a:	b7f5                	j	876 <malloc+0xdc>
