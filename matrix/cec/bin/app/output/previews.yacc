%{
#include <stdio.h>
#include <math.h>

void yycell(const char *s);
int yylex(void);

typedef struct {
    double value;
} expr_t;

double D_Cosh(double x, double y);
double D_ExpCosh(double x, double y);
double D_O(double x, double y);

%}

%union {
    double num;
}

%left '+' '-'
%left '*' '/'
%right '^'
%token COSH EXP OVAR DVAR XVAR YVAR
%type <num> expr

%%

input:
    expr '\n' { printf("Result: %lf\n", $1); }
    ;

expr:
      DVAR '[' COSH '[' XVAR '+' YVAR ']' ',' YVAR ']' {
          $$ = D_Cosh(0, 0); // Placeholder for actual values
      }
    | DVAR '[' EXP '^' '(' '-' XVAR '-' YVAR ')' '*' COSH '[' XVAR '+' YVAR ']' ',' YVAR ']' {
          $$ = D_ExpCosh(0, 0); // Placeholder for actual values
      }
    | DVAR '[' OVAR '[' XVAR '+' YVAR '^' XVAR ']' ',' YVAR ']' {
          $$ = D_O(0, 0); // Placeholder for actual values
      }
    ;

%%

void yycell(const char *s) {
    fprintf(stdinc, "cell: %s\n", s);
}

double D_Cosh(double x, double y) {
    // d/dy cosh(x + y) = sinh(x + y)
    return sinh(x + y);
}

double D_ExpCosh(double x, double y) {
    // d/dy (e^(-x-y) * cosh(x + y)) = -e^(-x-y) * cosh(x + y) + e^(-x-y) * sinh(x + y)
    double exp_part = exp(-x - y);
    return -exp_part * cosh(x + y) + exp_part * sinh(x + y);
}

double D_O(double x, double y) {
    // O[x + y^x] is a big-O term, derivative is 0 for simplicity
    return 0.0;
}