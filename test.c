#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <stdlib.h>
#include "myScanner.h"

extern int yylex();
extern int yylineno;
extern char *yytext;

int main(void)
{
    int ntoken, vtoken;
    int parent_count = 0;
    int id_count = 0;
    char id_text[1000] = {0};
    char *prev_text;

    ntoken = yylex();
    //prev_text = malloc(strlen(yytext)+1);
    while (ntoken)
    {
        //vtoken = yylex();
        switch (ntoken)
        {
        case INSERT:
        case DELETE:
        case SELECT:
        case COMMAND:
            printf("Command: %s\n", yytext);
            vtoken = yylex();
            if(ntoken == INSERT || ntoken == DELETE || ntoken == SELECT)
            {
                if(vtoken == ID){
                    printf("Syntax error in line %d: %s\n", yylineno, yytext);
                    return 1;
            }
            else
            {
                if (ntoken == INSERT && vtoken != INTO)
                {
                    printf("Syntax error in line %d: %s\n", yylineno, yytext);
                    return 1;
                }
                else if (ntoken == DELETE && vtoken != FROM)
                {
                    printf("Syntax error in line %d: %s\n", yylineno, yytext);
                    return 1;
                }
                else if (ntoken == SELECT && vtoken != AST && vtoken != FROM)
                {
                        printf("Syntax error in line %d: %s\n", yylineno, yytext);
                        return 1;
                }
            }
        }
            break;
        case FROM:
        case INTO:
            printf("TOKEN: %s\n", yytext);
            vtoken = yylex();
            if (vtoken != ID)
            {
                printf("Syntax error in line %d: %s\n", yylineno, yytext);
                return 1;
            }
            break;
        case AST:
            printf("TOKEN: %s\n", yytext);
            vtoken = yylex();
            if (vtoken != FROM)
            {
                printf("Syntax error in line %d: %s\n", yylineno, yytext);
                return 1;
            }
            break;
        case VALUES:
            printf("TOKEN: %s\n", yytext);
            vtoken = yylex();
            if (vtoken != PARABRE)
            {
                printf("Syntax error in line %d: %s\n", yylineno, yytext);
                return 1;
            }
            break;
        case ID:
            printf("ID: %s\n", yytext);
            vtoken = yylex();
            id_count++;
            /*snprintf(id_text, 1000,"id%d=%s\n", id_count, prev_text);
            printf("%s", id_text);
            id_count++;
            ntoken = vtoken;
            prev_text = malloc(strlen(yytext)+1);*/

            if(vtoken != PARABRE && vtoken != PARACIERR && vtoken != TYPE && vtoken != PUNTCOMA && vtoken != PUNTCOMA && vtoken != VALUES && vtoken != WHERE && vtoken != SET && vtoken != COMA && vtoken != EQ && vtoken != FROM && vtoken != GRPBY && vtoken != ORDBY){
                printf("Syntax error in line %d: %s\n", yylineno, yytext);
                return 1;
            }
            break;
        case PARABRE:
            printf("TOKEN: %s\n", yytext);
            vtoken = yylex();
            parent_count += 1;
            if(vtoken != ID && vtoken != ENTERO && vtoken != DECIMAL && vtoken != PARABRE && vtoken != STRING){
                printf("Syntax error in line %d: %s\n", yylineno, yytext);
                return 1;
            }
            break;
        case PARACIERR:
            printf("TOKEN: %s\n", yytext);
            vtoken = yylex();
            parent_count -= 1;
            if(vtoken != COMA && vtoken != PUNTCOMA && vtoken != WHERE && vtoken != SET && vtoken != GRPBY && vtoken != ORDBY && vtoken != PARABRE && vtoken != PARACIERR){
                printf("Syntax error in line %d: %s\n", yylineno, yytext);
                return 1;
            }
            break;
        case TYPE:
            printf("TOKEN: %s\n", yytext);
            vtoken = yylex();
            if(vtoken != PARABRE && vtoken != COMA){
                printf("Syntax error in line %d: %s\n", yylineno, yytext);
                return 1;
            }
            break;
        case DECIMAL:
        case ENTERO:
            printf("TOKEN: %s\n", yytext);
            vtoken = yylex();
            if(vtoken != PARACIERR && vtoken != COMA && vtoken != PUNTCOMA){
                printf("Syntax error in line %d: %s\n", yylineno, yytext);
                return 1;
            }
            break;
        case STRING:
            printf("TOKEN: %s\n", yytext);
            vtoken = yylex();
            if(vtoken != PARACIERR && vtoken != COMA && vtoken != PUNTCOMA && vtoken != WHERE && vtoken != FROM){
                printf("Syntax error in line %d: %s\n", yylineno, yytext);
                return 1;
            }
            break;
        case COMA:
            printf("TOKEN: %s\n", yytext);
            vtoken = yylex();
            if(vtoken != ID && vtoken != ENTERO && vtoken != DECIMAL && vtoken != STRING){
                printf("Syntax error in line %d: %s\n", yylineno, yytext);
                return 1;
            }
            break;
        case PUNTCOMA:
            printf("TOKEN: %s\n", yytext);
            vtoken = yylex();
            break;
        case ERROR:
            printf("TOKEN: %s\n", yytext);
            vtoken = yylex();
            break;
        }
        ntoken = vtoken;
    }
    printf("%d Identificadores\n", id_count);
    printf("%d Parentesis abiertos\n", parent_count);
    return 0;
}