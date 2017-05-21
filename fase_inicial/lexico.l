
%{
    #include<stdio.h>
    #include<stdlib.h>
    #include "y.tab.h"
%}

alfa [A-Za-z]
digito [0-9]
comentarios "//".*
id {alfa}({alfa}|{digito})*
caracter (\\n|\\t|\\'|\\\\|\\\"|[^\\"'])

%%

"!(" { return DECLV;}
"(" { return APAR;}
")" { return FPAR;}
"[" { return ACOL;}
"]" { return FCOL;}
"{" { return ACHA;}
"}" { return FCHA;}
"<" { return AFUN;}
">" { return FFUN;}
":" { return DP;}

"=" { return IGUAL;}
"+" { return MAIS;}
"-" { return MENOS;}
"*" { return VEZES;}
"/" { return DIVID;}

"!<" { return IMPR;}
"?<" { return LEIA;}

"    " { return QE;}
"\n" { return NL;}

{id} { return ID;}

[-+]?{digito}+(\.{digito}+)?([eE]"-"?{digito}+)? { 
    yylval = atof(yytext); 
    return NUM;
}
"'"{caracter}"'" { return CHAR;}
"," { return VRG;}
\"{caracter}*\" { return STR;}

%%

int yywrap() {
    return 1;
}

