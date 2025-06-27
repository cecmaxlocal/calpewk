%{
#include <stdio.h>
#include <math.h>

void yycell(const char *s);
int yylex(void);

typedef struct {
    double value;
} expr_t;
%}

%union {
    double num;
    expr_t expr;
}

%token <num> NUMBER
%token COSH EXP OVAR DVAR
%left '+' '-'
%left '*' '/'
%right '^'
%type <expr> expression
%type <expr> derivative

%%

input:
    | input line
    ;

line:
    derivative '\n'    { printf("Result: %f\n", $1.value); }
    ;

derivative:
    DVAR '[' expression ',' DVAR ']' {
        // For demonstration, just pass through the value
        $$ = $3;
    }
    ;

expression:
      COSH '[' expression ']' {
          $$.value = cosh($3.value);
      }
    | EXP '^' '(' '-' expression '-' expression ')' COSH '[' expression ']' {
          $$.value = exp(-$5.value - $7.value) * cosh($11.value);
      }
    | OVAR '[' expression '^' expression ']' {
          // O[x + y^x] is treated as a placeholder, just pass through
          $$.value = $3.value + pow($5.value, $5.value);
      }
    | expression '+' expression {
          $$.value = $1.value + $3.value;
      }
    | expression '-' expression {
          $$.value = $1.value - $3.value;
      }
    | expression '*' expression {
          $$.value = $1.value * $3.value;
      }
    | expression '/' expression {
          $$.value = $1.value / $3.value;
      }
    | '(' expression ')' {
          $$.value = $2.value;
      }
    | NUMBER {
          $$.value = $1;
      }
    ;

%%

void yycell(const char *s) {
    fprintf(stdinc, "cell: %s\n", s);
}