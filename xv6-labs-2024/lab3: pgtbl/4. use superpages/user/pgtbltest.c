int
main(int argc, char *argv[])
{
  if (argc > 1 && strcmp(argv[1], "s") == 0 ) {
    superpg_test();
    printf("pgtbltest: superpg_test succeeded\n");
  } else if (argc > 1 && strcmp(argv[1], "k") == 0 ) {
     print_kpgtbl();
     printf("pgtbltest: print_kpgtbl succeeded\n");
  }  else {
    print_pgtbl();
    ugetpid_test();
    print_kpgtbl();
    superpg_test();
    printf("pgtbltest: all tests succeeded\n");
  }
  exit(0);
}

