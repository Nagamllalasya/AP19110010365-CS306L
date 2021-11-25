%{
#include<stdio.h>
%}

%token NUMBER
%token DECIMAL
%token STRING
%token IDENTIFIER
%token RELOP 
%token FOR
%token STARTPRINT
%token ENDPRINT
%token SP
%token EP
%token IN

%%

L: SP FOR '(' I ')' IN  S ':' P EP { printf("correct"); }
;

I: IDENTIFIER
;

S: IDENTIFIER 
| V
;

V: '('A')'
;

A : 
| STRING
| NUMBER 
| DECIMAL 
| STRING','A  
| NUMBER','A
| DECIMAL','A
;

P: STARTPRINT '(' IDENTIFIER ')' ENDPRINT
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