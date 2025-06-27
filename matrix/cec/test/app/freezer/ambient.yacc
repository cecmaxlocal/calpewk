%{
#include <stdio.h>
#include <math.h>
%}

/* Define the types of semantic values */
%union {
    double dval;
    char* sval;
}

%token <dval> NUMBER
%token <sval> VARIABLE
%token E O
%left '+' '-'
%left '*' '/'
%right '^'
%nonassoc UMINUS

%type <dval> expr

%%

input:
    expr '\n'   { printf("Result: %f\n", $1); }
  | expr        { printf("Result: %f\n", $1); }
  ;

expr:
    expr '+' expr      { $$ = $1 + $3; }
  | expr '-' expr      { $$ = $1 - $3; }
  | expr '*' expr      { $$ = $1 * $3; }
  | expr '/' expr      { $$ = $1 / $3; }
  | expr '^' expr      { $$ = pow($1, $3); }
  | '-' expr %prec UMINUS { $$ = -$2; }
  | '(' expr ')'       { $$ = $2; }
  | NUMBER             { $$ = $1; }
  | E '^' '(' expr ')' { $$ = exp($4); }
  | O '[' expr ']'     { printf("Big O term: O[%f]\n", $3); $$ = 0; }
  | VARIABLE           { $$ = 0; /* Placeholder for variable handling */ }
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