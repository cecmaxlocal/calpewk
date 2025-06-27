%{
#include <stdio.h>
#include <math.h>
%}

%union {
    double dval;
}

%token <dval> NUMBER
%token VARIABLE
%token COSH EXP OVAR
%left '+' '-'
%left '*' '/'
%right '^'
%type <dval> expr

%%

input:
    expr '\n'    { printf("Result: %f\n", $1); }
    ;

expr:
      COSH '(' expr ')'                { $$ = cosh($3); }
    | COSH '(' expr '+' expr ')'       { $$ = cosh($3 + $5); }
    | expr '+' expr                    { $$ = $1 + $3; }
    | expr '-' expr                    { $$ = $1 - $3; }
    | expr '*' expr                    { $$ = $1 * $3; }
    | expr '/' expr                    { $$ = $1 / $3; }
    | expr '^' expr                    { $$ = pow($1, $3); }
    | EXP '(' expr ')'                 { $$ = exp($3); }
    | OVAR '(' expr ')'                { /* Big O notation, placeholder */ $$ = 0; }
    | NUMBER                           { $$ = $1; }
    | VARIABLE                         { /* Variable value, placeholder */ $$ = 0; }
    | '(' expr ')'                     { $$ = $2; }
    ;

%%

int main(void) {
    yyparse();
    return 0;
}

int yycell(char *s) {
    fprintf(stdinc, "cell: %s\n", s);
    return 0;
}
