#include<stdio.h>
#include<ctype.h>
#include<string.h>
char keyword[30][30]={"int","while","break","for","do","if","float","char","switch","double","short","long","unsigned","sizeof","else","register","extern","static","auto","case","break","volatile","enum","typedef"};
char id[20], num[10], rel[10];
char identifier[30][30];
//declare symbol table as a doubly dimensional array of characters.
int check_keyword(char s[])
{
int i;
for(i=0;i<24;i++)
if(strcmp(s,keyword[i])==0)
return 1;
return 0;
}
/*write a function to store identifier in symbol table
void store_symb_tab(char id[], char symb_tab[][20])
{
Check whether the id is already available in the symbol table, if available,
ignore. otherwise add it.
}
*/
int main()
{
FILE *fp1,*fp2;
char c;
int state=0;
int i=0,j=0,k=0,n=0;
fp1=fopen("file1.txt","r");//input file containing src prog
fp2=fopen("file2.txt","w");//output file name

while((c=fgetc(fp1))!=EOF)
{
switch(state)
{
case 0: if(isalpha(c)){
state=1; id[i++]=c;}
else if(isdigit(c)){
state=3; num[j++]=c;}
else if(c=='<' || c=='>'){
state=5; rel[k++]=c;}
else if(c=='=' || c=='!'){
state=8; rel[k++]=c;}
else if(c=='/')
state=10;
else if(c==' ' || c=='\t' || c=='\n')
state=0;
else
fprintf(fp2,"\n%c",c);
break;


case 1:if(isalnum(c)){
state=1; id[i++]=c;
}
else{
id[i]='\0';
if(check_keyword(id))
fprintf(fp2," \n %s : keyword ",id);
else 
{
fprintf(fp2,"\n %s : identifier",id);
int flag=0,p;
for(p=0;p<n;p++)
{
    if (strcmp(identifier[p], id) == 0)
    {
        flag = 1;
        break;
    }
}
if (flag == 0)
{
    strcpy(identifier[n++], id);
}
}
state=0;
i=0;
ungetc(c,fp1);
}
break;


case 3:if(isdigit(c)){
num[j++]=c;
state=3;
}
else{
num[j]='\0';
fprintf(fp2," \n%s : number",num);
state=0;
j=0;
ungetc(c,fp1);

}
break;
case 5:if(c=='='){
rel[k++]=c;
rel[k]='\0';
if (rel[0] == '<'){
    fprintf(fp2,"\n%s : relational operator ",rel);
}
else{
    fprintf(fp2,"\n%s : relational operator ",rel);
}
//write code to print specific operator like <= or >=
state=0;
k=0;
}
else{
rel[k]='\0';
if (rel[0] == '<'){
    fprintf(fp2,"\n%s : relational operator",rel);
}
else{
    fprintf(fp2,"\n%s : relational operator ",rel);
}
//write code to print specific operator like <, >, <= or >=
state=0;
k=0;
ungetc(c,fp1);
}
break;
case 8:if(c=='='){
rel[k++]=c;
rel[k]='\0';
if (rel[0] == '='){
    fprintf(fp2,"\n%s : relational operator",rel);
}
else{
    fprintf(fp2,"\n%s : relational operator",rel);
}
//write code to print specific operator like == or !=
state=0;
k=0;
}
else{
ungetc(c,fp1);
state=0;
}
break;
case 10:if(c=='*')
state=11;
else
fprintf(fp2,"\n invalid lexeme");
break;
case 11: if(c=='*')
state=12;
else
state=11;
break;
case 12:if(c=='*')
state=12;
else if(c=='/')
state=0;
else
state=11;
break;

}//End of switch
}//end of while
if(state==11)
fprintf(fp2,"\n comment did not close");
fprintf(fp2, "\n Symbol Table");
if (n > 0)
{
    for(i=0; i< n; i++)
    {
        fprintf(fp2, "\n identifier %d - %s", i+1, identifier[i]);
    }
}
else
{
    fprintf(fp2, "\n There are no identifiers");
}
fclose(fp1);
fclose(fp2);
return 0;
}