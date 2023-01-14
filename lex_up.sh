#!/bin/bash
lex plt_lexer.l
gcc lex.yy.c 
./a.out input.txt