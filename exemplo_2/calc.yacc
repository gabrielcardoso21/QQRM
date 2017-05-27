%{
#include<stdio.h>

int regs[26];
int base;

%}

%start list

%union { int a; }


%token DIGIT LETTER EXIT

%left '|'
%left '&'
%left '+' '-'
%left '*' '/' '%'
%left UMINUS  /*supplies precedence for unary minus */

%%                   /* beginning of rules section */

list:                       /*empty */
         |
        list stat '\n'
         |
        list error '\n'
         {
           yyerrok;
         }
         |
        EXIT '\n'
         {
           yywrap();
         }
         ;
stat:    expr
         {
           printf("%d\n",$1);
         }
         |
         LETTER '=' expr
         {
           regs[$1.a] = $3.a;
         }

         ;

expr:    '(' expr ')'
         {
           $$ = $2;
         }
         |
         expr '*' expr
         {

           $$.a = $1.a * $3.a;
         }
         |
         expr '/' expr
         {
           $$.a = $1.a / $3.a;
         }
         |
         expr '%' expr
         {
           $$.a = $1.a % $3.a;
         }
         |
         expr '+' expr
         {
           $$.a = $1.a + $3.a;
         }
         |
         expr '-' expr
         {
           $$.a = $1.a - $3.a;
         }
         |
         expr '&' expr
         {
           $$.a = $1.a & $3.a;
         }
         |
         expr '|' expr
         {
           $$.a = $1.a | $3.a;
         }
         |

        '-' expr %prec UMINUS
         {
           $$.a = -$2.a;
         }
         |
         LETTER
         {
           $$.a = regs[$1.a];
         }

         |
         number
         ;

number:  DIGIT
         {
           $$ = $1;
           base = ($1.a==0) ? 8 : 10;
         }       |
         number DIGIT
         {
           $$.a = base * $1.a + $2.a;
         }
         ;

%%
int main(int argc, char *argv[])
{
 FILE *yyin = fopen(argv[1], "r");
 yylex();
 yyparse();
 fclose(yyin);
 return(0);
}

yyerror(s)
char *s;
{
  fprintf(stderr, "%s\n",s);
}

yywrap()
{
  return(1);
}
