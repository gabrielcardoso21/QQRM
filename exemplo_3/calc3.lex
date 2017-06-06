%{
#include <stdio.h>
#include <stdlib.h>
#include "calc3.h"
#include "y.tab.h"
void yyerror(char *);
char buf[100];
char *s;
%}
%x STRING

%%

\" { BEGIN STRING; s = buf; }
<STRING>\\n { *s++ = '\n'; }
<STRING>\\t { *s++ = '\t'; }
<STRING>\\\" { *s++ = '\"'; }
<STRING>\" { 
            *s = 0; 
            BEGIN 0; 
            printf("found '%s'\n", buf); 
            yylval.string=malloc(yyleng);
            sprintf(yylval.string,"%s",yytext); 
            return STR;
}

<STRING>\n { printf("invalid string"); exit(1); }
<STRING>. { *s++ = *yytext; }

[a-zA-Z]   {
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

[-()<>=+*/;{}.] {
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

[ \t\n]+ ;

.       yyerror("Unknown character");

%%

int yywrap(void) {
    return 1;
}
