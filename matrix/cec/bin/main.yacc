%{
#include <stdio.h>
#include <math.h>
%}


%%
input:
    expr '\n'    { printf("Parsed successfully.\n"); }
    ;

expr:
      COSH LPAREN sum RPAREN
    | expr PLUS expr
    | expr DIV expr
    | expr POWER expr
    | OVAR LPAREN sum RPAREN
    | VAR
    | NUMBER
    ;

sum:
      expr
    | expr PLUS expr
    ;

%token DIV VAR NUMBER COSH OVAR PLUS POWER LPAREN RPAREN

%%

int main(void) {
    yyparse();
    return 0;
}

int yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
    return 0;
}