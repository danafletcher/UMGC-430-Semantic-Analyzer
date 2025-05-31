/* CMSC 430 Compiler Theory and Design
   Project 3 Skeleton
   UMGC CITE
   Summer 2023 */

/* This file contains flex input file */

%{
#include <cstdio>
#include <string>
#include <vector>

using namespace std;

#include "values.h"
#include "listing.h"
#include "tokens.h"

%}

%option noyywrap

ws		[ \t\r]+
comment		("//".*\n|"--".*\n)
line		[\n]
id       [A-Za-z][A-Za-z0-9]*(_{1,2}[A-Za-z0-9]+)*[A-Za-z0-9]?
digit		[0-9]
hectal	[0-9A-Fa-f]
hex		#({hectal})+
dec		{digit}+(\.{digit}+)?
char     '([\\][btnrf\'"\\]|[^\\'])'
punc		[\(\),:;]
real     [0-9]*\.[0-9]+([eE][+-]?[0-9]+)?
%%

{ws}		   { ECHO; }
{comment}	{ ECHO; nextLine(); }
{line}		{ ECHO; nextLine(); }


"=>"		   { ECHO; return(ARROW); }
begin		   { ECHO; return(BEGIN_); }
case		   { ECHO; return(CASE); }
character	{ ECHO; return(CHARACTER); }
end		   { ECHO; return(END); }
endswitch	{ ECHO; return(ENDSWITCH); }
function	   { ECHO; return(FUNCTION); }
integer		{ ECHO; return(INTEGER); }
is		      { ECHO; return(IS); }
list		   { ECHO; return(LIST); }
of		      { ECHO; return(OF); }
others		{ ECHO; return(OTHERS); }
returns		{ ECHO; return(RETURNS); }
switch		{ ECHO; return(SWITCH); }
when		   { ECHO; return(WHEN); }


"<"         { ECHO; yylval.oper = LESS; return(RELOP); }
"="         { ECHO; yylval.oper = EQUAL; return(RELOP); }
"<>"        { ECHO; yylval.oper = NOT_EQUAL; return(RELOP); }
">"         { ECHO; yylval.oper = GREATER; return(RELOP); }
">="        { ECHO; yylval.oper = GREATER_EQUAL; return(RELOP); }
"<=" 		   { ECHO; yylval.oper = LESS_EQUAL; return(RELOP); }

"+"		   { ECHO; yylval.oper = ADD; return(ADDOP); }
"*"		   { ECHO; yylval.oper = MULTIPLY; return(MULOP); }
"&"		   { ECHO; yylval.oper = AND; return(ANDOP); }
"|"		   { ECHO; yylval.oper = OR; return(OROP); }
"!"		   { ECHO; yylval.oper = NOT; return(NOTOP); }
"-"		   { ECHO; yylval.oper = SUBTRACT; return(ADDOP); }
"/"		   { ECHO; yylval.oper = DIVIDE; return(MULOP); }
"%"		   { ECHO; yylval.oper = MOD; return(REMOP); }
"^"		   { ECHO; yylval.oper = EXP; return(EXPOP); }
"~"		   { ECHO; yylval.oper = NEG; return(NEGOP); }
"if" 	      { ECHO; return(IF); } 
"else"	   { ECHO; return(ELSE); } 
"elsif"		{ ECHO; return(ELSIF); } 
"endfold"	{ ECHO; return(ENDFOLD); }
"fold"		{ ECHO; return(FOLD); }
"left"		{ ECHO; return(LEFT); }
"right"		{ ECHO; return(RIGHT); }
"endcase" 	{ ECHO; return(ENDCASE); } 
"endif" 	   { ECHO; return(ENDIF); } 
"others" 	{ ECHO; return(OTHERS); } 
"real" 		{ ECHO; return(REAL); } 
"then" 		{ ECHO; return(THEN); } 
"when" 		{ ECHO; return(WHEN); } 

{hex}		   { ECHO; yylval.value = hex_to_int(yytext); return(INT_LITERAL);}
{real}		{ ECHO; yylval.value = atof(yytext); return(REAL_LITERAL);}
{id}		   { ECHO; yylval.iden = (CharPtr)malloc(yyleng + 1); 
			      strcpy(yylval.iden, yytext); return(IDENTIFIER);}
{dec}		   { ECHO; yylval.value = atoi(yytext); return(INT_LITERAL); }
{char}		{ ECHO; yylval.value = char_to_int(yytext); return(CHAR_LITERAL); }
{punc}		{ ECHO; return(yytext[0]); }
.		      { ECHO; appendError(LEXICAL, yytext); }

%%

