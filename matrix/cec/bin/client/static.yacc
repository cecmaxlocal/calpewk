%{
#include <stdio.h>
#include <math.h>
%}

%token COSH EXP OVAR VAR PLUS POWER

%%
expr
    : term
    | expr PLUS term        { printf("+ "); }
    ;

term
    : factor
    | term '/' factor       { printf("/ "); }
    ;

factor
    : COSH '[' sum ']'             { printf("Cosh "); }
    | COSH '[' sum ']' '/' EXP '[' sum ']'   { printf("Cosh/Exp "); }
    | OVAR '[' sum ']'             { printf("O-term "); }
    | sum
    ;

sum
    : VAR
    | VAR PLUS VAR
    | VAR POWER VAR
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