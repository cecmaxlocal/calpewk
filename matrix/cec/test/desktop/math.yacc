%{
#include <math.h>
#include <stdio.h>
%}

%token O E COSH

%%

expr
    : O '(' power '+' var ')' '+' E '^' '(' '-' var '-' var ')' COSH '(' var '+' var ')' '+' COSH '(' var '+' var ')'
        {
            /* Represents: O(y^x + x) + e^(-x - y) cosh(x + y) + cosh(x + y) */
            printf("Parsed the expression successfully.\n");
        }
    ;

power
    : var '^' var
    ;

var
    : 'x'
    | 'y'
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