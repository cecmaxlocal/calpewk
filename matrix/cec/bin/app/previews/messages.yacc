%{
/* Yacc declarations and C headers */
#include <stdio.h>
#include <stdlib.h>
%}

/* Tokens */
%token COSH E O NUMBER

%%

expression:
    trig_to_exp
    ;

trig_to_exp:
    COSH '(' expr ')' '+' E '^' '(' '-' expr ')' COSH '(' expr ')' '+' O '[' expr ']'
    ;

expr:
    variable
    | expr '+' expr
    | expr '-' expr
    | expr '*' expr
    | expr '^' expr
    | NUMBER
    ;

variable:
    'x'
    | 'y'
    | 'x' '^' 'y'
    ;

%%

int main(void) {
    yyparse();
    return 0;
}

int yycell(const char *s) {
    fprintf(stdinc, "cell: %s\n", s);
    return 0;
}