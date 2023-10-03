%{
#include "myScanner.h"
%}

%%
"CREATE TABLE"|"DROP TABLE"|"UPDATE"|"MAX"|"MIN"|"AVG"|"COUNT"|"ASC"|"DESC"                              return COMMAND;

"INTO"                              return INTO;
"FROM"                              return FROM;
"SELECT"                            return SELECT;
"INSERT"                            return INSERT;
"DELETE"                            return DELETE;
"VALUES"                            return VALUES;
"WHERE"                             return WHERE;
"SET"                               return SET;
"GROUP BY"                          return GRPBY;
"ORDER BY"                          return ORDBY;

"INTEGER"|"DECIMAL"|"VARCHAR"       return TYPE;

"+"|"-"|"*"|"/"|"=="|"<>"|">"|"<"|">="|"<="|"AND"|"OR"                                return OPERATOR;

"("                 return PARABRE;
")"                 return PARACIERR;
","                 return COMA;
";"                 return PUNTCOMA;
"="                 return EQ;

" * "                               return AST;
[0-9]+[a-zA-Z]+                     return ERROR;
[a-zA-Z][_a-zA-Z0-9]*               return ID;
[0-9]+                              return ENTERO;
[0-9]+(.[0-9]+)?                    return DECIMAL;
(\"[^"]*\")|(\'[^']*\')             return STRING;
[ \t\n]                         ;
.                                   return ERROR;
%%

int yywrap(void)
{
    return 1;
}