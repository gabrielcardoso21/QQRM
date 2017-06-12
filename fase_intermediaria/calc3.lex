%{
#include <stdio.h>
#include <stdlib.h>
#include "calc3.h"
#include "y.tab.h"
void yyerror(char *);
%}

%%

[a-z][a-z_A-Z]*   {
            yylval.sIndex = *yytext - 'a';
            return VARIABLE;
        }

0       {
            yylval.iValue = atoi(yytext);
            return INTEGER;
        }

[1-9][0-9]* {
                yylval.iValue = atoi(yytext);
                return INTEGER;
            }

[-()<>=+*/\n{}.] {
                return *yytext;
            }

">="    return GE;
"<="    return LE;
"=="    return EQ;
"!="    return LE;
"|" return WHILE;
"?"    return IF;
"::"  return ELSE;
"!<" return PRINT;
"?<" return READ;

[ \t]+ ;

"//".* ;

.       yyerror("Unknown character");

%%

int yywrap(void) {
    return 1;
}
