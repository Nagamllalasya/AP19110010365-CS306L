%{
#include<stdio.h>
%}

%token NUMBER
%token DECIMAL
%token STRING
%token IDENTIFIER
%token OP
%token EITHER
%token ORELSE
%token OR
%token STARTPRINT
%token ENDPRINT
%token SP
%token EP
%%

S:SP L EP { printf("correct");}
;
N:NUMBER 
|DECIMAL 
;
T:IDENTIFIER  
|N 
;
EX:T 
|T OP EX 
;
PS: STARTPRINT '('EX')' ENDPRINT 
;
L:EITHER '('EX ')' ':' PS 
|EITHER '('EX')' ':' PS OR ':' PS 
|EITHER  '('EX')' ':' PS ORELSE  '('EX')' ':' PS OR ':' PS 
|
;
%%

int main(){
yyparse();
}
int yywrap(){
return 1;
}
void yyerror(char *s){
printf("Error %s",s);
}