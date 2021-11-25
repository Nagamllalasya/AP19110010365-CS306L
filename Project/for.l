%{
#include "for.tab.h"
%}

%%

"for" { return FOR; }

"in" { return IN; }

"<print>" { return STARTPRINT; }

"</print>" { return ENDPRINT; }

"<python>" { return SP; }

"</python>" { return EP; }

[0-9]* { return NUMBER; }

[0-9]*\.[0-9]* { return DECIMAL; }

\'[a-zA-Z]*\' { return STRING; }

[a-zA-Z][a-zA-Z0-9]* { return IDENTIFIER; }

["<"|">"|"<="|">="|"="|"=="|"<>"] { return RELOP; }

\n return 0;

. return yytext[0];

%%