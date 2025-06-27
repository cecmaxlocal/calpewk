/* jetbrains.yacc - Yacc grammar for parsing Taylor series expressions */

%{
#include <stdio.h>
#include <math.h>
%}

%token NUMBER ID OPRIME LOG LPAREN RPAREN PLUS MINUS TIMES DIVIDE POWER EXP SINH COSH

%%

series
    : expr
    ;

expr
    : expr PLUS term         { /* addition */ }
    | expr MINUS term        { /* subtraction */ }
    | term
    ;

term
    : term TIMES factor      { /* multiplication */ }
    | term DIVIDE factor     { /* division */ }
    | factor
    ;

factor
    : base POWER factor      { /* exponentiation */ }
    | base
    ;

base
    : NUMBER
    | ID
    | OPRIME LPAREN NUMBER RPAREN
    | OPRIME POWER NUMBER LPAREN NUMBER RPAREN
    | LOG LPAREN expr RPAREN
    | EXP LPAREN expr RPAREN
    | SINH LPAREN expr RPAREN
    | COSH LPAREN expr RPAREN
    | LPAREN expr RPAREN
    ;

%%

/* Lexer and main() would be implemented in the corresponding .l and .c files */