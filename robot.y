%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);
FILE *outputFile;
%}

%union {
    int num;
}

%token <num> NUMBER
%token MOVE TURN AHEAD BLOCKS DEGREES
%token AND_THEN 

%type <num> command sequence

%%

program:
    | program sequence
    ;

sequence:
      command
    | sequence AND_THEN command
    ;

command:
      MOVE NUMBER BLOCKS AHEAD { fprintf(outputFile, "MOV,%d\n", $2); }
    | TURN NUMBER DEGREES      { fprintf(outputFile, "TURN,%d\n", $2); }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    outputFile = fopen("instructions.asm", "w");
    if (!outputFile) {
        perror("Failed to open file");
        exit(EXIT_FAILURE);
    }
    yyparse();
    fclose(outputFile);
    return 0;
}
