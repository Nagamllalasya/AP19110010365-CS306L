digit [+-]?[0-9]+
id [a-zA-Z][a-zA-Z0-9]*
num [+-]?[0-9]+(\.[0-9])?(\E[+-]?[0-9])?
%{
#include<stdio.h>
#include<string.h>
int i=0,j=0,cnt=0,n=0,com=0,scom=0;
char st[10][10];
int look_up(char st[10][10],char *id,int n);
%}

%%
\n   {scom=0;n++;}
"//" {scom=1;fprintf(yyout,"\n single line comment\n\n");}
"/*" {com=1;fprintf(yyout,"\n comment start\n");}
"*/" {com=0;fprintf(yyout,"\n comment end\n");}
int |
float |
char |
double |
return |
long |
if |
else |
while |
void {if(!com&&!scom) fprintf(yyout," \n %s is keyword",yytext);}
"<=" {if(!com&&!scom) fprintf(yyout,"\n %s is Relational operator Lessthan or Equal to",yytext);}
"<" {if(!com&&!scom) fprintf(yyout,"\n %s is Relational operator Lessthan",yytext);}
">=" {if(!com&&!scom) fprintf(yyout,"\n %s is Relational operator Greaterthan or Equal to",yytext);}
">" {if(!com&&!scom) fprintf(yyout,"\n %s is Relational operator Greaterthan",yytext);}
"==" {if(!com&&!scom) fprintf(yyout,"\n %s is Relational operator Equal to",yytext);}
"!=" {if(!com&&!scom) fprintf(yyout,"\n %s is Relational operator Not Equal to",yytext);}
"=" {if(!com&&!scom) fprintf(yyout,"\n %s is Assignment Operator",yytext);}
{id} {if(!com&&!scom) fprintf(yyout,"\n %s is identifier",yytext);
                         if(!com&&!scom){
                         if (!lookup(st,yytext,i)){
                         strcpy(st[i++],yytext);cnt++;}
                      }}
{digit} {if (!com&&!scom) fprintf(yyout,"\n %s is integer",yytext);}
{num} {if(!com&&!scom) fprintf(yyout,"\n %s is float",yytext);}
.
%%
main()
{
  yyin =fopen("input.txt","r");
  yyout=fopen("output.txt","w");
  yylex();
  printf(" No of id are : %d ",cnt);
  printf("\n the contents of symbol table are :\n");
  for(j=0;j<i;j++)
     printf("\n %s",st[j]);
  printf(" \n\n\n no of lines = %d\n\n",n);
  return 0;
}
int yywrap()
{
return 1;
}

int lookup(char st[10][10],char *id,int n)
{
for(j=0;j<n;j++)
if(!strcmp(st[j],id))
return 1;
return 0;
}