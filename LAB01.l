%{
#include <stdbool.h>
#include <stdio.h>
#include <string.h>

#define MAX_SIZE 100

int error_count = 0;
int id_count;
bool error_flag = false;

char *stringArray[MAX_SIZE];
int arraySize = 0;

int find (char *array[], int *size, const char *target) {
    for (int i = 0; i < *size; i++) {
        if (strcmp(array[i], target) == 0) {
            return i;
        }
    }
    if (*size < MAX_SIZE) {
        array[*size] = strdup(target); 
        if (array[*size] != NULL) {
            (*size)++;
            return (*size - 1);
        } else {
            return -1;
        }
    } else {
        return -1;
    }
}

%}

%%
"CREATE"                                       fprintf(yyout, "CREATE "); error_flag = false;
"DROP"                                         fprintf(yyout, "DROP "); error_flag = false;
"Table"|"TABLE"|"table"                        fprintf(yyout, "TABLE "); error_flag = false;
"SELECT"                                       fprintf(yyout, "SELECT "); error_flag = false;
"WHERE"                                        fprintf(yyout, "WHERE "); error_flag = false;
"GROUP BY"                                     fprintf(yyout, "GROUP BY "); error_flag = false;
"ORDER BY"                                     fprintf(yyout, "ORDER BY "); error_flag = false;
"INSERT"                                       fprintf(yyout, "INSERT "); error_flag = false;
"DELETE"                                       fprintf(yyout, "DELETE "); error_flag = false;
"UPDATE"                                       fprintf(yyout, "UPDATE "); error_flag = false;
"MAX"                                          fprintf(yyout, "MAX "); error_flag = false;
"MIN"                                          fprintf(yyout, "MIN "); error_flag = false;
"AVG"                                          fprintf(yyout, "AVG "); error_flag = false;
"COUNT"                                        fprintf(yyout, "COUNT "); error_flag = false;
"INTO"                                         fprintf(yyout, "INTO "); error_flag = false;
"VALUES"                                       fprintf(yyout, "VALUES "); error_flag = false;
"FROM"                                         fprintf(yyout, "FROM "); error_flag = false;
"SET"                                          fprintf(yyout, "SET "); error_flag = false;
"ASC"                                          fprintf(yyout, "ASC "); error_flag = false;
"DESC"                                         fprintf(yyout, "DESC "); error_flag = false;

"INTEGER"                                      fprintf(yyout, "INTEGER "); error_flag = false;
"DECIMAL"                                      fprintf(yyout, "DECIMAL "); error_flag = false;
"VARCHAR"                                      fprintf(yyout, "VARCHAR "); error_flag = false;

"AND"|"and"|"And"                              fprintf(yyout, "op-and=and "); error_flag = false;
"OR"|"or"|"Or"                                 fprintf(yyout, "op-or=or "); error_flag = false;

[a-zA-Z][_a-zA-Z0-9]*                          {id_count=find(stringArray, &arraySize, yytext);fprintf(yyout, "id%d=%s ", (id_count+1), yytext); error_flag = false;}
[0-9]+                                         fprintf(yyout, "entero=%s ", yytext); error_flag = false;
[0-9]+(".")[0-9]+                          fprintf(yyout, "decimal=%s ", yytext); error_flag = false;
[0-9]+[_a-zA-Z0-9]+                            if(!error_flag){fprintf(yyout, "ERROR=%s ", yytext); error_flag = true;} ++error_count;

"+"                                            fprintf(yyout, "op-mas=+ "); error_flag = false;
"-"                                            fprintf(yyout, "op-menos=- "); error_flag = false;
"*"                                            fprintf(yyout, "op-mul=* "); error_flag = false;
"/"                                            fprintf(yyout, "op-div=/ "); error_flag = false;

"=="                                           fprintf(yyout, "op-igualdad = == "); error_flag = false;
"<>"                                           fprintf(yyout, "op-diff = <> "); error_flag = false;
">"                                            fprintf(yyout, "op-mayorq = > "); error_flag = false;
"<"                                            fprintf(yyout, "op-menorq = < "); error_flag = false;
">="                                           fprintf(yyout, "op-mayorigual = >= "); error_flag = false;
"<="                                           fprintf(yyout, "op-menorigual = <= "); error_flag = false;

"("                                            fprintf(yyout, "parabre=( " ); error_flag = false;
")"                                            fprintf(yyout, "parcierr=) "); error_flag = false;
","                                            fprintf(yyout, "coma=, "); error_flag = false;
";"                                            fprintf(yyout, "puntcoma=;\n"); error_flag = false;
"="                                            fprintf(yyout, "asig= = "); error_flag = false;

" * "                                          fprintf(yyout, "asterisco=* "); error_flag = false;

(\"[^"]*\")|(\'[^']*\')                        fprintf(yyout, "cadena=%s ", yytext); error_flag = false;

[ \t\n]                                        ;
.                                              if(!error_flag){fprintf(yyout, "ERROR=%s ", yytext); error_flag = true;} ++error_count;
%%

int main(int argc, char **argv){

    extern FILE *yyin, *yyout;

    yyin = fopen(argv[1], "r");
    yyout = fopen(argv[3], "w");

    yylex();
    printf("\n%d Identificadores\n\n", arraySize);
    int j;
    for (int i = 0; i < arraySize; i++) {
        j = i+1;
        printf("id%d=%s\n", j, stringArray[i]);
        free(stringArray[i]);
    }
    printf("\n%d Errores\n", error_count);
    return 0;
}

int yywrap(void){
    return 1;
}