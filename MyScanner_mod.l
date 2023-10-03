%{
#include "myScanner.h"
%}

%%
"CREATE TABLE "                     return CREATE;
"DROP TABLE"                        return DROP;
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
"COUNT"|"MAX"|"MIN"|"AVG"           return FUNCTION;
"ASC"|"DESC"                        return ORDER;

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

ID OP_CON [ENTERO|DECIMAL|ID]   return CONDICIONAL;

%%
CREATE ID PARABRE ID TYPE PARABRE ENTERO PARACIERRA[COMA ID TYPE PARABRE INT PARACIERRA]* PARACIERRA PUNTOCOMA
DROP ID PUNTOCOMA
INSERT INTO ID[ID]* VALUES PARABRE ID [COMA ID]* PARACIERRA PUNTOCOMA
DELETE FROM ID WHERE CONDICIONAL[OP_LOG CONDICIONAL]* PUNTOCOMA
UPDATE ID SET ID EQ [ID|ENTERO] WHERE CONDICIONAL [OP_LOG CONDICIONAL]* PUNTOCOMA

SELECT [AST|ID[COMA ID]*] FROM ID PUNTOCOMA
SELECT FUNCTION PARABRE ID PARACIERRA FROM ID PUNTOCOMA
SELECT [FUNCTION PARABRE ID PARACIERRA|ID[COMA FUNCTION PARABRE ID PARACIERRA|ID]*] FROM ID PUNTOCOMA

SELECT [AST|ID[COMA ID]*] FROM ID WHERE CONDICIONAL[OP_LOG CONDICIONAL]* PUNTOCOMA
SELECT [AST|ID[COMA ID]*] FROM ID GRPBY ID PUNTOCOMA
SELECT [AST|ID[COMA ID]*] FROM ID ORDBY ID [COMA ID]* ORDER PUNTOCOMA
SELECT [AST|ID[COMA ID]*] FROM ID [WHERE CONDICIONAL[OP_LOG CONDICIONAL]*] [GRPBY ID] [ORDBY ID [COMA ID]* ORDER] PUNTOCOMA




int yywrap(void)
{
    return 1;
}


