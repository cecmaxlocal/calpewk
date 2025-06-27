%{
#include <stdio.h>
#include <math.h>
%}

%token NUMBER IDENTIFIER PLUS MINUS TIMES DIVIDE POWER LPAREN RPAREN COMMA LBRACE RBRACE LBRACKET RBRACKET

%%
input:
    | input line
    ;

line:
      expr '\n'   { printf("Parsed successfully.\n"); }
    ;

expr:
      IDENTIFIER LBRACKET expr_list ',' series_range RBRACKET
    | expr PLUS expr
    | expr MINUS expr
    | expr TIMES expr
    | expr DIVIDE expr
    | expr POWER expr
    | MINUS expr
    | LPAREN expr RPAREN
    | NUMBER
    | IDENTIFIER
    | IDENTIFIER LPAREN expr_list RPAREN
    | IDENTIFIER LBRACKET expr_list RBRACKET
    ;

expr_list:
      expr
    | expr_list ',' expr
    ;

series_range:
      LBRACE IDENTIFIER COMMA NUMBER COMMA NUMBER RBRACE
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