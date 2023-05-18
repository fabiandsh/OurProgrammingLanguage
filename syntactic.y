/*S definiciones*/
%{
#include <stdio.h>
extern int yylex(void);
extern char *yytext;
void yyerror(char *s);
%}
%token SEP
%token VID
%token FLO
%token INT
%token STR
%token ASS
%token ADD
%token MUL
%token SUB
%token DIV
%token OPP    
%token CLP  
%token GRT
%token GAE
%token SMT
%token SAE
%token EQU
%token NEQ

/**S de reglas**/
%%


%%
/**S codigo de usuario**/

void yyerror(char *s){
	printf("Error Sintáctico: %s\n", s);
}

int main(){
	printf("Inicio del programa: \n");
	yyparse();
return 0;
}
