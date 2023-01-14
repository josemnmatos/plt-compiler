%{
   //DECLARATIONS

%}
   //DEFINITIONS

%union{
   int num;
   char sym;
}

%token EOL
%token T_INTEGER
%token T_ASSIGNMENT
%token T_EQUAL
%token T_GREATEREQUAL
%token T_LESSEREQUAL      
%token T_GREATER
%token T_LESSER     
%token T_ADDITION           
%token T_SUBTRACTION       
%token T_MULTIPLICATION
%token T_DIVISION          
%token T_REMAINDER         
%token T_INCREMENT
%token T_DECREMENT
%token T_OPENBRACE        
%token T_CLOSEBRACE       
%token T_OPENPARENTHESIS  
%token T_CLOSEPARENTHESIS 
%token T_BINARYAND        
%token T_BINARYOR          
%token T_FUNCTION
%token T_IF    
%token T_ELSE
%token T_FOR
%token T_RETURN
%token T_TRUE
%token T_FALSE
%token T_SEMICOLON
%token T_IDENTIFIER


%%
   //PRODUCTIONS


input: expression EOL|EOL

expression: 


%%
   //USER SUBROUTINES

int main(){
   return yyparse();
}

