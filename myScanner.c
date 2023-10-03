#include <stdio.h>
#include <stdbool.h>
#include "myScanner.h"

extern int yylex();
extern int yylineno;
extern char* yytext;

//char *names[] = {NULL, "COMMAND", "ID", "NUMBER", "STRING", "TYPE", "OPERATOR", "SEP", "AST"};

int main(void)
{
    int ntoken, vtoken;
    int parent_count=0;
    bool command_up = false;

    ntoken = yylex();
    while(ntoken){
        switch(ntoken){
            case INSERT:
            case DELETE:
            case SELECT:
            case COMMAND:
                /*if(!command_up){
                    command_up = true;
                }else{
                    printf("No se inicio por un comando\n");
                    return 1;
                }*/
                printf("Comando: %s\n",yytext);
                vtoken = yylex();
                if(ntoken == INSERT || ntoken == DELETE){
                    /*if(vtoken != SCDCOMMAND){
                    printf("Syntax error in line %d: %s\n",yylineno, yytext);
                    return 1;
                    }*/
                }else if(ntoken == SELECT){
                    if(vtoken != AST){
                    printf("Syntax error in line %d: %s\n",yylineno, yytext);
                    return 1;
                    }
                }else if(vtoken != ID){
                    printf("Syntax error in line %d: %s\n",yylineno, yytext);
                    return 1;
                }
                ntoken = vtoken;
                break;
            /*case SCDCOMMAND:
                printf("Continuacion del comando:%s\n",yytext);
                vtoken = yylex();
                if(vtoken != ID){
                    printf("Syntax error in line %d: %s\n",yylineno, yytext);
                    return 1;
                }
                ntoken = vtoken;
                break;*/
            case ID:
                //if(command_up){
                    printf("Identifier: %s\n",yytext);
                    ntoken = yylex();
                /*}else{
                    printf("No se comenzo por un comando\n");
                    return 1;
                }*/
                break;
            case PARABRE:
                printf("Parentesis: %s\n", yytext);
                parent_count += 1;
                ntoken = yylex();
                break;
            case PARACIERR:
                printf("Parentesis: %s\n", yytext);
                parent_count -= 1;
                ntoken = yylex();
                break;
            case TYPE:
                printf("Type: %s\n", yytext);
                ntoken = yylex();
                break;
            case ENTERO:
                printf("Entero: %s\n", yytext);
                ntoken = yylex();
                break;
            case DECIMAL:
                printf("Decimal: %s\n", yytext);
                ntoken = yylex();
                break;
            case COMA:
                printf("Coma\n");
                ntoken = yylex();
                break;
            case PUNTCOMA:
                printf("Punto y coma\n");
                ntoken = yylex();
                break;
            case AST:
                printf("Asterisco\n");
                ntoken = yylex();
                break;
            default:
                printf("Syntax error in line %d: %s\n",yylineno, yytext);
                return 1;
        }
    }
    printf("conteo de parentesis: %d\n", parent_count);
    return 0;
}