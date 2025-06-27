%{
#include <math.h>
#include <stdio.h>

double O_prime(double z); // Forward declaration for O'[x + y^x]
%}

/* Declare the type of semantic values */
%union {
    double dval;
    char* sval;
}

%token <dval> NUMBER
%token <sval> IDENTIFIER
%token COSH
%token SINH
%token LOG
%token OPRIME
%token Cosh
%token Sinh
%token Log
%token O
%type  <dval> expr
%left '+' '-'
%left '*' '/'
%right '^'

%%

input:
    expr { printf("Result: %g\n", $1); }
    ;

expr:
      expr '+' expr   { $$ = $1 + $3; }
    | expr '-' expr   { $$ = $1 - $3; }
    | expr '*' expr   { $$ = $1 * $3; }
    | expr '/' expr   { $$ = $1 / $3; }
    | COSH '[' expr ']' { $$ = cosh($3); }
    | SINH '[' expr ']' { $$ = sinh($3); }
    | LOG '[' expr ']'  { $$ = log($3); }
    | OPRIME '[' expr ']'   { $$ = O_prime($3); }
    | Cosh '[' expr ']' { $$ = cosh($3); }
    | Sinh '[' expr ']' { $$ = sinh($3); }
    | Log '[' expr ']'  { $$ = log($3); }
    | O '[' expr ']'   { $$ = O_prime($3); }
    | NUMBER           { $$ = $1; }
    | IDENTIFIER       { /* handle variables if needed */ }
    ;

%%

/* Dummy implementation for O'[z] */
double O_prime(double z) {
    // Replace with actual derivative logic if needed
    return 0.0;
}