%{
#include "y.tab.h"
%}

%%

[ \t\n]+                { /* Skip whitespace */ }
"Robot please"          { /* Match the polite start */ }
"move"                  { return MOVE; }
"and then"              { return AND_THEN; } // Corrected token
"turn"                  { return TURN; }
[0-9]+                  { yylval.num = atoi(yytext); return NUMBER; }
"ahead"                 { return AHEAD; }
"blocks"                { return BLOCKS; }
"degrees"               { return DEGREES; }
.                       { /* Ignore unrecognized characters */ }

%%

int yywrap(void) {
    return 1;
}

