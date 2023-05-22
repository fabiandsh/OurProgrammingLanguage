/*S definiciones*/
%{
#include <stdio.h>
extern int yylex(void);
extern char *yytext;
void yyerror(char *s);
extern FILE *yyin;
%}

%token SEP VAR IVR STR FLO INT ASS ADD MUL SUB DIV SMR SAE GRT GAE EQU NEQ WHE OPP CLP END NOO UNT FUN PAR BCK IFU SEK FUE CAP ARG
/**S de reglas**/
%%


sentences	: 
	  		| sentence 
		  	| decfun   
			| sentences sentence 
			| sentences decfun 


sentence	: decvar
	 		| asigvar 
			| initvar 
			| operation SEP 
			| whether 
			| until 
			| err 
			| callfuntion  

decvar		: VAR IVR SEP 

initvar		: VAR IVR ASS STR SEP 
			| VAR IVR ASS INT SEP 
			| VAR IVR ASS FLO SEP 

asigvar		: IVR ASS callfuntion 
			| IVR ASS operation SEP 
			| IVR ASS value SEP 

value		: INT 
       		| FLO 
			| STR 
			| IVR 

operation 	: value ADD value 
			| value SUB value 
			| value MUL value 
			| value DIV value 

callfuntion : IFU ARG SEP 

whether		: WHE OPP condition CLP sentences END 
			| WHE OPP condition CLP sentences NOO sentences END 

until 		: UNT OPP condition CLP sentences END 

condition	: value SMR value 
			| value SAE value 
			| value GRT value 
			| value GAE value 
			| value EQU value 
			| value NEQ value 

decfun		: FUN IFU PAR sentences back FUE 

back 		: BCK value SEP 
			| BCK operation SEP 

err 		: SEK sentences CAP sentences END 
%%
/**S codigo de usuario**/

void yyerror(char *s){
	printf("Error Sintáctico: %s\n", s);
}

int main(int argc, char **argv){
	printf("Inicio del programa: \n");
	if(argc>1)
		yyin=fopen(argv[1],"rt");
	else
		yyin=stdin;
	yyparse();
return 0;
}
