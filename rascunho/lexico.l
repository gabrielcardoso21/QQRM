
%{
#include<stdio.h>
#include ".tab.h"    

extern int yylex();
%}

delim [ ]
alfa [A-Za-z]
digitos [0-9]
id {alfa}({alfa}|{digitos})*

"<<" { return DEFCI;}
">>" { return DEFCF;}
":" { return DP;}
"<{}>" { return PRI;}
"<[]>" { return PRO;}
"<()>" { return PUB;}
"!(" { return DECLV;}
"(" { return APAR;}
")" { return FPAR;}
"[" { return ACOL;}
"]" { return FCOL;}
"{" { return ACHA;}
"}" { return FCHA;}
"<" { return AFUN;}
">" { return FFUN;}
"=" { return IGUAL;}
"" { return ;}
"" { return ;}
"" { return ;}
"" { return ;}



"," return VRG;
{id} return ID;