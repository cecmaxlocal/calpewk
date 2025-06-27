%{
#include <stdio.h>
#include <math.h>
%}

%token COSH E POW PLUS MINUS LPAREN RPAREN ID NUMBER O

%%
expr
    : COSH LPAREN expr RPAREN                { printf("cosh("); }
    | E POW LPAREN MINUS expr RPAREN         { printf("exp(-"); }
    | expr PLUS expr                         { printf("+"); }
    | expr MINUS expr                        { printf("-"); }
    | expr POW expr                          { printf("^"); }
    | O LPAREN expr RPAREN                   { printf("O("); }
    | ID                                     { printf("id"); }
    | NUMBER                                 { printf("num"); }
    | LPAREN expr RPAREN                     { }
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