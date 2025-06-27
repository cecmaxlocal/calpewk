%{
/* C declarations and headers */
#include <stdio.h>
#include <math.h>
%}

/* Yacc declarations */
%union {
    double dval;
    /* add more types if needed */
}

%token <dval> NUMBER
%token ID
%type <dval> expr

%left '+' '-'
%left '*' '/'
%right '^'
%nonassoc UMINUS

%%

input:
    expr '\n'   { printf("Result: %lf\n", $1); }
    ;

expr:
      expr '+' expr      { $$ = $1 + $3; }
    | expr '-' expr      { $$ = $1 - $3; }
    | expr '*' expr      { $$ = $1 * $3; }
    | expr '/' expr      { $$ = $1 / $3; }
    | '-' expr %prec UMINUS { $$ = -$2; }
    | expr '^' expr      { $$ = pow($1, $3); }
    | '(' expr ')'       { $$ = $2; }
    | NUMBER             { $$ = $1; }
    | ID                 { /* handle variables */ }
    | 'O' '(' expr ')'   { /* handle O(expr) */ }
    | 'O''\'' '(' expr ')' { /* handle O'(expr) */ }
    | 'e' '^' '(' expr ')' { $$ = exp($4); }
    | 'sinh' '(' expr ')' { $$ = sinh($3); }
    | 'cosh' '(' expr ')' { $$ = cosh($3); }
    | 'log' '(' expr ')'  { $$ = log($3); }
    ;

%%

/* C code for main and yylex() would go here */