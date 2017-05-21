%{
#include<stdio.h>
#define YYSTYPE double
int yylex();
 void yyerror (char const *s) {
   fprintf (stderr, "%s\n", s);
 }
%}

%token VRG ID NUM CHAR STR DP QE NL MAIS MENOS VEZES DIVID 
%token DECLV AFUN FFUN ACOL FCOL APAR FPAR ACHA FCHA
%token IGUAL IMPR LEIA

%left MAIS MENOS
%left VEZES DIVID

%right UMINUS

%%

/*declfuncao: AFUN ID FFUN DP lparam comandos

declvar: DECLV ID IGUAL valor FPAR

comandos: NL | comandos comandos | QE QE QE comando NL

lparam: NL | declvar NL | declvar VRG lparam

comando: declvar | atrib | expr

atrib: ID IGUAL expr

*/

comandos:
        | NL 
        | QE expr NL comandos { printf("%f\n", $4); }
        ;

/*comando: expr ; */

expr: expr MAIS expr { $$ = $1 + $3; }
    | expr MENOS expr { $$ = $1 - $3; }
    | expr VEZES expr { $$ = $1 * $3; }
    | expr DIVID expr { $$ = $1 / $3; }
    | APAR expr FPAR { $$ = $2; }
    | MENOS expr %prec UMINUS { $$ = - $2; }
    | NUM
    ;

