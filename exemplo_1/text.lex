%{
#include <stdio.h>
#include "y.tab.h"
%}
  
%% 
set       return SET;
state     return STATE;
mode      return MODE;
get       return GET;
[a-zA-Z]+  { yylval=strdup(yytext); return STRING; }
%%
