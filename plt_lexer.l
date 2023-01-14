/*
Lexical Analyzer for PLT subject
José Matos

To run:

-> comm: "lex plt_lexer.l"
-> compile generated C file (lex.yy.c)
-> comm: "./executable_file <input_file>" 
*/

%{
   #include <stdio.h>
   #include <unistd.h>
   int error_no=0;
   int line=1; 
   int column = 0;
%}

Integer                                [0-9]+
Assignment                              "="
Equal                                  "=="
Greater                                ">"
Lesser                                 "<"
Greater_Equal                          ">="
Lesser_Equal                           "<="          
Addition                               "+"           
Subtraction                            "-"       
Multiplication                         "*"    
Division                               "/"          
Remainder                              "%"         
Increment                              "++"
Decrement                              "--"       
Open_Brace                             "{"        
Close_Brace                            "}"       
Open_Parenthesis                       "("  
Close_Parenthesis                      ")" 
Binary_And                             "&&"        
Binary_Or                              "||"          
Function                               function
If                                     if    
Else                                   else
For                                    for
Return                                 return
True                                   true
False                                  false
Identifier                             [a-zA-Z_][a-zA-Z0-9_]*
Semicolon                              ";"

%X PANIC_MODE

%%
"\n"                                   {line++;column=0;return EOL;} /*count line number*/   
[ \t]+                                 {column+=yyleng;} /*ignore spaces and tabs*/
{Integer}                              {fprintf(yyout,"Integer  %d  %s\n",line,yytext);column+=yyleng;return T_INTEGER;}
{Assignment}                            {fprintf(yyout,"Assigment  %d  %s\n",line,yytext);column+=yyleng;return T_ASSIGNMENT; }
{Equal}                                {fprintf(yyout,"Equal  %d  %s\n",line,yytext);column+=yyleng; return T_EQUAL; }
{Greater_Equal}                        {fprintf(yyout,"Greater_Equal  %d  %s\n",line,yytext);column+=yyleng; return T_GREATEREQUAL; }
{Lesser_Equal}                         {fprintf(yyout,"Lesser_Equal  %d  %s\n",line,yytext);column+=yyleng; return T_LESSEREQUAL;}      
{Greater}                              {fprintf(yyout,"Greater  %d  %s\n",line,yytext);column+=yyleng; return T_GREATER;}
{Lesser}                               {fprintf(yyout,"Lesser  %d  %s\n",line,yytext);column+=yyleng; return T_LESSER;}     
{Addition}                             {fprintf(yyout,"Addition  %d  %s\n",line,yytext);column+=yyleng; return T_ADDITION;}           
{Subtraction}                          {fprintf(yyout,"Subtraction  %d  %s\n",line,yytext);column+=yyleng; return T_SUBTRACTION;}       
{Multiplication}                       {fprintf(yyout,"Multiplication  %d  %s\n",line,yytext);column+=yyleng; return T_MULTIPLICATION;}
{Division}                             {fprintf(yyout,"Division  %d  %s\n",line,yytext);column+=yyleng; return T_DIVISION;}          
{Remainder}                            {fprintf(yyout,"Remainder  %d  %s\n",line,yytext);column+=yyleng; return T_REMAINDER;}         
{Increment}                            {fprintf(yyout,"Increment  %d  %s\n",line,yytext);column+=yyleng; return T_INCREMENT;}
{Decrement}                            {fprintf(yyout,"Decrement  %d  %s\n",line,yytext);column+=yyleng; return T_DECREMENT;}
{Open_Brace}                           {fprintf(yyout,"Open_Brace  %d  %s\n",line,yytext);column+=yyleng; return T_OPENBRACE;}        
{Close_Brace}                          {fprintf(yyout,"Close_Brace  %d  %s\n",line,yytext);column+=yyleng; return T_CLOSEBRACE;}       
{Open_Parenthesis}                     {fprintf(yyout,"Open_Parenthesis  %d  %s\n",line,yytext);column+=yyleng; return T_OPENPARENTHESIS;}  
{Close_Parenthesis}                    {fprintf(yyout,"Close_Parenthesis  %d  %s\n",line,yytext);column+=yyleng; return T_CLOSEPARENTHESIS;} 
{Binary_And}                           {fprintf(yyout,"Binary_And  %d  %s\n",line,yytext);column+=yyleng; return T_BINARYAND;}        
{Binary_Or}                            {fprintf(yyout,"Binary_Or  %d  %s\n",line,yytext);column+=yyleng; return T_BINARYOR;}          
{Function}                             {fprintf(yyout,"Function  %d  %s\n",line,yytext);column+=yyleng; return T_FUNCTION;}
{If}                                   {fprintf(yyout,"If  %d  %s\n",line,yytext);column+=yyleng; return T_IF;}    
{Else}                                 {fprintf(yyout,"Else  %d  %s\n",line,yytext);column+=yyleng; return T_ELSE;}
{For}                                  {fprintf(yyout,"For  %d  %s\n",line,yytext);column+=yyleng; return T_FOR;}
{Return}                               {fprintf(yyout,"Return  %d  %s\n",line,yytext);column+=yyleng; return T_RETURN;}
{True}                                 {fprintf(yyout,"True  %d  %s\n",line,yytext);column+=yyleng; return T_TRUE;}
{False}                                {fprintf(yyout,"False  %d  %s\n",line,yytext);column+=yyleng; return T_FALSE;}
{Semicolon}                            {fprintf(yyout,"Semicolon  %d  %s\n",line,yytext);column+=yyleng; return T_SEMICOLON;}
{Identifier}                           {fprintf(yyout,"Identifier  %d  %s\n",line,yytext);column+=yyleng; return T_IDENTIFIER;}
.                                      {printf("Error: Invalid character %s in line %d, column %d\n",yytext,line,column);column+=yyleng; error_no++; BEGIN PANIC_MODE;}


<PANIC_MODE>"\n"                       {line++;column=0;} /*count line number*/ 
<PANIC_MODE>[^};]                      {column+=yyleng;} /*Reject everything that is not a delimiter*/
<PANIC_MODE>{Close_Brace}              {fprintf(yyout,"Close_Brace  %d  %s\n",line,yytext);column+=yyleng;BEGIN 0; return T_CLOSEBRACE;} 
<PANIC_MODE>{Semicolon}                {fprintf(yyout,"Semicolon  %d  %s\n",line,yytext);column+=yyleng;BEGIN 0; return T_SEMICOLON;}


%%
int main(int argc, char *argv[]){
    /* yyin and yyout as pointer
    of File type */
    extern FILE *yyin, *yyout;

    /*check command usage*/
    if(argc != 2){
      printf("Wrong usage, should be: ./lex_analyzer <plt_source_file>\n");
      return 0;
    }

    /*check if file exists*/
    if (access(argv[1], F_OK) == 0) {
      ;
   } else {
      /*file doesn't exist*/
      printf("Given file does not exist.\n");
      return 0;
   }
 
    /* yyin points to the file input.txt
    and opens it in read mode*/
    yyin = fopen(argv[1], "r");
 
    /* yyout points to the file output.txt
    and opens it in write mode*/
    yyout = fopen("plt_tokens.txt", "w");

   /*function which calls automata to do lexical analysis*/
   yylex(); 
   return 0;
}

 /*is called when input ends 
 and returns 1 if there's 
 nothing more to process*/
int yywrap(){
   return 1;
}

