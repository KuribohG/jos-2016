// buggy program - causes a divide by zero exception

#include <inc/lib.h>

int zero;

void
umain(int argc, char **argv)
{
   char s[1][50] = {
    "/hello"
   };
   char *argv2[2] = {s[0], 0};
 
   cprintf("hello, world\n");
   cprintf("i am environment %08x\n", thisenv->env_id);
   exec("/hello", (const char**) argv2);
	// zero = 0;
	// cprintf("1/0 is %08x!\n", 1/zero);
}

