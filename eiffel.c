#include <stdio.h>

extern int yyparse();


int yyerror(char* err) {
    printf("Error: %s\n", err);
}

int main() {
    yyparse();
    return 0;
}
