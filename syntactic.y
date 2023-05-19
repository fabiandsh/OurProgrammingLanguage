/*S definiciones*/
%{
#include <stdio.h>
extern int yylex(void);
extern char *yytext;
void yyerror(char *s);
extern FILE *yyin;
%}

%token SEP VAR IVR STR FLO INT ASS ADD MUL SUB DIV SMR SAE GRT GAE EQU NEQ WHE OPP CLP END NOO UNT FUN PAR BCK IFU SEK FUE CAP 
/**S de reglas**/
%%

sentences	:	
			| sentences decvar
			| sentences asigvar
			| sentences initvar
			| sentences operation SEP
			| sentences whether
			| sentences until
			| sentences error

decvar : VAR IVR SEP

initvar	: VAR IVR ASS STR SEP
		| VAR IVR ASS INT SEP
		| VAR IVR ASS FLO SEP

asigvar	: IVR ASS callfuntion 
		| IVR ASS operation SEP 

operation 	: INT
			| FLO
			| STR
			| IVR 
			| operation ADD operation  
			| operation SUB operation
			| operation MUL operation
			| operation DIV operation

callfuntion : IFU PAR SEP

whether		: WHE OPP condition CLP sentences END
			| WHE OPP condition CLP sentences NOO sentences END

until 		: UNT OPP condition CLP sentences END

condition	: operation SMR operation 
			| operation SAE operation
			| operation GRT operation
			| operation GAE operation
			| operation EQU operation
			| operation NQU operation



decfun		: FUN IFU PAR sentences back FUE 

back 		: BCK operation SEP

error 		: SEK sentences CAP sentences END

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
