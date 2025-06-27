%{
#include <stdio.h>
#include <stdlib.h>
%}

%token ID NUMBER
%left '+' '-'
%left '*' '/'
%right '^'
%right UMINUS

%%

input:
    | input line
    ;

line:
      expr '\n'   { printf("Parsed derivative expression.\n"); }
    ;

expr:
      'D' '[' expr ',' expr ']'    { /* Derivative operator */ }
    | 'Cosh' '[' expr ']'          { /* Hyperbolic cosine */ }
    | 'E' '^' '(' expr ')'         { /* Exponential */ }
    | 'O' '[' expr ']'             { /* Big O notation */ }
    | expr '+' expr                { }
    | expr '-' expr                { }
    | expr '*' expr                { }
    | expr '/' expr                { }
    | expr '^' expr                { }
    | '-' expr %prec UMINUS        { }
    | '(' expr ')'                 { }
    | ID                           { }
    | NUMBER                       { }
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