%{
#include <stdlib.h>
#include <string.h>
#define YYSTYPE char *
char mode[20];
char state[20];
%}

%start list
 
%token SET STATE MODE GET STRING EOLN
%%
list:   /* nothing */
        | list getorset
        ;
getorset: getvalue 
         | setvalue 
         ;
setvalue: 
        SET STATE STRING  { state = $3; printf("State set\n"); }
        | SET MODE STRING { strcpy(mode,$3); printf("Mode set\n"); }
        ;
getvalue: 
        GET STATE  { printf("State: %s\n",state); }
        | GET MODE { printf("Mode: %s\n",mode); }
        ;
 
%%
 
#include <stdio.h>
#include <ctype.h>
char *progname;

int yywrap() {
    return 1;
}
 
main( argc, argv )
char *argv[];
{
  progname = argv[0];
  yyparse();
}
 
yyerror( s )
char *s;
{
  fprintf( stderr ,"%s: %s\n" , progname , s );
}
