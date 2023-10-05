#!/bin/bash
lex LAB01.l
gcc lex.yy.c -o LAB01
./LAB01 entrada1.txt>salida1.txt
./LAB01 entrada2.txt>salida2.txt
./LAB01 entrada3.txt>salida3.txt
./LAB01 entrada4.txt>salida4.txt
echo "Ejecucion terminada"
