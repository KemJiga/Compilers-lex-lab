%{
#include "myScanner.h"
%}

%%
"CREATE TABLE "    return CREATE;
"DROP TABLE"      return DROP;
"SELECT"|"GROUP BY"|"ORDER BY"     return SEARCH;
"INSERT INTO"|"DELETE FROM"|"UPDATE"  return MANIPULATE;
"MAX"|"MIN"|"AVG"|"COUNT"   return FUNCTION;
"WHERE"|"VALUES"|"FROM"|"SET"|"ASC"|"DESC"   return RESERVED;
CREATE|DROP|SEARCH|MANIPULATE|FUNCTION|RESERVED return COMMAND;
"INTEGER"|"DECIMAL"|"VARCHAR"       return TYPE;

"+"|"-"|"*"|"/"                                                       return OP_MATH;
"=="|"<>"|">"|"<"|">="|"<="                                           return OP_CON;
"AND"|"OR"                                                            return OP_LOG;

"("                 return PARABRE;
")"                 return PARACIERRA;
","                 return COMA;
";"                 return PUNTCOMA;
"="                 return EQ;
"."                 return PUNTO;
                  
" * "                               return AST;
[0-9]+[a-zA-Z]+                     return ERROR;
[a-zA-Z][_a-zA-Z0-9]*               return ID;
[0-9]+                              return ENTERO;
[0-9]+PUNTO|COMA[0-9]+              return DECIMAL;
(\"[^"]*\")|(\'[^']*\')             return STRING;
[ \t\n]                         ;
.                                   return ERROR;

%%
CREATE ID PARABRE ID TYPE PARABRE ENTERO PARACIERRA[COMA ID TYPE PARABRE INT PARACIERRA]* PARACIERRA PUNTOCOMA
DROP ID PUNTOCOMA
cASO Insert MANIPULATE ID[ID]* RESERVED [PARABRE ID [COMA ID]* PARACIERRA|]





int yywrap(void)
{
    return 1;
}


