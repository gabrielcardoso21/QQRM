
%{
    #include<stdio.h>
    int yylex();
    void yyerror(const char * s ){printf("ERROR: %s\n",s);}
%}

%token DEFCI DEFCF PROGRAMA ID DP DDP NL QE VRG PRI PRO PUB IGUAL

%start programa
%glr-parser

%%

program: DEFCI ID DEFCF DP NL escopo {
       Identifier * id = new Identifier($2);
       reverse($6->begin(), $6->end());
       MAIN = new ASTProgram(id, $6);
       };

escopo: escopo escopo | QE nivelseg DP NL membros NL

nivelseg: PRI | PRO | PUB

membros: membros membros | QE QE declvar NL | QE QE declfuncao NL

declvar: DECLV ID IGUAL valor FPAR

declfuncao: AFUN ID FFUN DP lparam comandos

lparam: NL | declvar NL | declvar VRG lparam

comandos: NL | comandos comandos | QE QE QE comando NL

comando: declvar | atrib | expr

atrib: ID IGUAL expr

expr: ID
    | ID ACOL expr FCOL
    | 
