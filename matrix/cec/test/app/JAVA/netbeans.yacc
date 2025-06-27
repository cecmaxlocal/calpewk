%{
#include <stdio.h>
#include <math.h>

double O_prime(double z); // Forward declaration for O'[x + y^x]
%}

/* Declare the type of semantic values */
%union {
    double dval;
    int ival;
    char *sval;
}

%token <dval> NUMBER
%token <sval> ID
%left '+' '-'
%left '*' '/'
%right '^'
%left UMINUS
%type <dval> expr

%%

input:
    expr { printf("Result: %lf\n", $1); }
    ;

expr:
      expr '+' expr      { $$ = $1 + $3; }
    | expr '-' expr      { $$ = $1 - $3; }
    | expr '*' expr      { $$ = $1 * $3; }
    | expr '/' expr      { $$ = $1 / $3; }
    | expr '^' expr      { $$ = pow($1, $3); }
    | '-' expr %prec UMINUS { $$ = -$2; }
    | '(' expr ')'       { $$ = $2; }
    | 'E' '^' '(' '-' expr '-' expr ')' 
        { $$ = exp(-$5 - $7); }
    | '-' 'C' 'o' 's' 'h' '[' expr '+' expr ']' 
        { $$ = -cosh($7 + $9); }
    | '(' '1' '+' 'E' '^' '(' expr '+' expr ')' ')' 'S' 'i' 'n' 'h' '[' expr '+' expr ']' 
        { $$ = (1 + exp($7 + $9)) * sinh($15 + $17); }
    | expr '*' expr      { $$ = $1 * $3; }
    | expr 'y' '^' '(' '-' '1' '+' expr ')' 
        { $$ = $1 * pow($2, -1 + $6); }
    | 'O' '\'' '[' expr '+' expr ']' 
        { $$ = O_prime($5 + $7); }
    | NUMBER             { $$ = $1; }
    | ID                 { $$ = 0; /* Placeholder for variables */ }
    ;

%%

double O_prime(double z) {
    // Placeholder for O'[z]
    return 0.0;
}

int main(void) {
    yyparse();
    return 0;
}

int yycell(const char *s) {
    fprintf(stdinc, "cell: %s\n", s);
    return 0;
}