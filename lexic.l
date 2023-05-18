/**S definiciones**/
%{
#include "syntactic.tab.h"
%}
/**S de reglas**/
identifier var[0-9]+
float [0-9]+\.[0-9]*
int [0-9]+ 
String "[^\n']" 
separator \.

%%
{separator}         {return SEP;}
{identifier}	    {return VID;}
{float}             {return FLO;}
{int}               {return INT;}
{string}            {return STR;}
=			        {return ASS;}
\+			        {return ADD;}
\*			        {return MUL;}
\-			        {return SUB;}
\/			        {return DIV;}
(                   {return OPP;}    
)                   {return CLP;}  
"<"                 {return GRT;}
"<="                {return GAE;}
">"                 {return SMT;}
">="                {return SAE;}
"=="                {return EQU;}
"/="                {return NEQ;}
[ \t\n]			    {/*ingonar espacios*/}
.			        {printf("Error léxico: %s\n", yytext);}
%%
/**Sección de codigo de uaurio**/
int yywrap(){return 1;}
