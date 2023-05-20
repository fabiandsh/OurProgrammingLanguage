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
	  	| sentence {printf("se encontro una sentencia sola\n");}
	  	| decfun   {printf("se encontro una función\n");}
		| sentences sentence {printf("concatenacion de sentencias con sentencia");}
		| sentences decfun {printf("funcion en sentencias");}


sentence	: decvar {printf(" se declara una variable y es sentencia\n");}
	 	| asigvar {printf(" se asigna una variable y es sentencia \n");}
		| initvar {printf(" se inicia variable y es sentencia\n");}
		| operation SEP {printf(" se hace una operación y es sentencia\n");}
		| whether {printf("se hace un if y es sentencia\n");}
		| until {printf("se hace un for y es sentencia\n");}
		| err {printf("se hace manejo error y es sentencia\n");}
		| callfuntion  {printf("se hace llamado a la función y es sentencia\n");}

decvar		: VAR IVR SEP {printf("se declara una variable\n");} 

initvar		: VAR IVR ASS STR SEP {printf("se inicia la variable como string\n ");}
		| VAR IVR ASS INT SEP {printf("se inicia la variable con entero\n");}
		| VAR IVR ASS FLO SEP {printf("se inica la variable con float\n");}

asigvar		: IVR ASS callfuntion {printf("se asigna variable con llamadofuncion\n");}
		| IVR ASS operation SEP {printf("se asigna variable con operación\n");}
		| IVR ASS value SEP {printf("Se asigna valriable con valor\n");}

value		: INT {printf("es entero\n");}
       		| FLO {printf("es flotante\n");}
		| STR {printf("es string\n");}
		| IVR {printf("es identificador variable\n");}

operation 	: value ADD value  {printf("suma\n");}
		| value SUB value {printf("resta\n");}
		| value MUL value {printf("multiplicacion\n");}
		| value DIV value {printf("division\n");}

callfuntion 	: IFU ARG SEP {printf("llamada funcion\n");}

whether		: WHE OPP condition CLP sentences END {printf("Declaración Si\n");}
		| WHE OPP condition CLP sentences NOO sentences END {printf("Declaración SINO\n");}

until 		: UNT OPP condition CLP sentences END {printf("bucle\n");}

condition	: value SMR value {printf("menor que\n");}
		| value SAE value {printf("menor igual que\n");}
		| value GRT value {printf("mayor que\n");}
		| value GAE value {printf("mayor igual que\n");}
		| value EQU value {printf("igual\n");}
		| value NEQ value {printf("no igual\n");}

decfun		: FUN IFU PAR sentences back FUE  {printf("Declaración función\n");}

back 		: BCK value SEP {printf("retorno valor\n");}
		| BCK operation SEP {printf("retorno operacion\n");}

err 		: SEK sentences CAP sentences END {printf("error\n");}
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
