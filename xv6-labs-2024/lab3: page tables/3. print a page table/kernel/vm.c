#ifdef LAB_PGTBL
void
vmprint(pagetable_t pagetable) {
  // your code here
  printf("page table %p\n", pagetable);
  vmprintkpgtbl(pagetable, 0, 0);
}
#endif

void
vmprintkpgtbl(pagetable_t pagetable, int depth, uint64 recordvpn) {
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
     pte_t pte = pagetable[i];
     if (pte & PTE_V) {
       uint64 pa = PTE2PA(pte);
       for (int j = 0; j < depth; j++) {
         printf(".. ");
       }

       uint64 vpn = recordvpn | i << PXSHIFT(2-depth);
       if (depth == 0 ){
        // RISC-V SV39中 偏移量是0
         uint64 offset = pa & 0xFFF;
         vpn |= offset;
       }
       printf("..%p: pte %p pa %p\n", (void*)vpn, (void*)pte, (void*)pa);
       if ((pte & (PTE_R|PTE_W|PTE_X)) == 0) {
        vmprintkpgtbl((pagetable_t)pa, depth + 1, vpn);
       }
     }
  }
}
