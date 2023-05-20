/**S definiciones\n**/
%{
#include "syntactic.tab.h"
%}
/**S de reglas**/
identifiervar v[0-9]+
float -?[0-9]+\.[0-9]*
int -?[0-9]+ 
string \"[^(\n|\")]*\"
identifierfun fun[0-9]+
parameter \(("var v"[0-9]+" "?)*\)
argument \[("v"[0-9]+" "?)*\]
%%
\?                              {return SEP;}
"var"                           {return VAR;}
{identifiervar}                 {return IVR;}
{string}                        {return STR;}
{float}                         {return FLO;}
{int}                           {return INT;}
=			        {return ASS;}
\+			        {return ADD;}
\*			        {return MUL;}
\-			        {return SUB;}
\/			        {return DIV;}
"<"                             {return SMR;}
"<="                            {return SAE;}
">"                             {return GRT;}
">="                            {return GAE;}
"=="                            {return EQU;}
"/="                            {return NEQ;}
"whether"                       {return WHE;}
"("                             {return OPP;}
")"                             {return CLP;}
"end"                           {return END;}
"no"                            {return NOO;}
"until"                         {return UNT;}
"function"                      {return FUN;}
{identifierfun}                 {return IFU;}
{parameter}                     {return PAR;}
{argument}                      {return ARG;}
"back"                          {return BCK;}
"seek"                          {return SEK;}
"funcEnd"                       {return FUE;}
"capture"                       {return CAP;}
[ \t\n]			       	{/*ingonar espacios*/}
.			        {printf("Error léxico: %s\n", yytext);}
%%
/**Sección de codigo de usaurio**/
int yywrap(){return 1;}
