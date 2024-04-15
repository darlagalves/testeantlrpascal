grammar PascalSimplificado;

options {
    caseInsensitive = true;
}

/**Regras gramaticais */

programa : PROGRAM IDENT PONTOEVIRGULA corpo PONTO;
corpo : declara BEGIN sentencas END;
declara : (VAR dvar mais_dc)?;
mais_dc :  PONTOEVIRGULA cont_dc;
cont_dc : (dvar mais_dc)?;
dvar : variaveis DOISPONTOS tipo_var;
tipo_var : INTEGER;
variaveis : IDENT mais_var;
mais_var :  (VIRGULA  variaveis)?;
sentencas : comando mais_sentencas;
mais_sentencas : PONTOEVIRGULA cont_sentencas;
cont_sentencas : (sentencas)?;
var_read : IDENT mais_var_read;
mais_var_read : (VIRGULA var_read)?;
exp_write : IDENT mais_exp_write |
                STRING_LITERAL mais_exp_write |
                INTEIRO mais_exp_write;
mais_exp_write : (VIRGULA exp_write)?;
comando :
   READ PARENTESESESQUERDO var_read PARENTESESDIREITO |
   WRITE PARENTESESESQUERDO exp_write PARENTESESDIREITO |
   WRITELN PARENTESESESQUERDO exp_write PARENTESESDIREITO |
   FOR IDENT ATRIBUICAO expressao TO expressao DO BEGIN sentencas END |
   REPEAT  sentencas UNTIL PARENTESESESQUERDO expressao_logica PARENTESESDIREITO  |
   WHILE  PARENTESESESQUERDO expressao_logica PARENTESESDIREITO  DO BEGIN sentencas END |
   IF PARENTESESESQUERDO expressao_logica PARENTESESDIREITO THEN BEGIN sentencas END pfalsa |
   IDENT ATRIBUICAO expressao;
pfalsa : (ELSE BEGIN sentencas END)?;
expressao_logica : termo_logico mais_expr_logica;
mais_expr_logica : (OR termo_logico mais_expr_logica)?;
termo_logico : fator_logico mais_termo_logico;
mais_termo_logico : (AND fator_logico mais_termo_logico)?;
fator_logico : relacional |
                   PARENTESESESQUERDO expressao_logica PARENTESESDIREITO|
                   NOT fator_logico |
                   TRUE  |
                   FALSE;
relacional : expressao IGUAL  expressao  |
                 expressao  MAIOR expressao |
                 expressao MAIORIGUAL expressao |
                 expressao MENOR  expressao  |
                 expressao MENORIGUAL expressao  |
                 expressao DIFERENTE expressao;
expressao : termo mais_expressao;
mais_expressao : (SOMA termo mais_expressao)?  |
                 (SUBTRACAO termo mais_expressao)?;
termo : fator mais_termo;
mais_termo : (MULTIPLICACAO fator mais_termo)? |
             (DIVISAO fator mais_termo)?;
fator : IDENT | INTEIRO | PARENTESESESQUERDO expressao PARENTESESDIREITO;

/** Itens léxicos */

AND: 'AND';
ARRAY: 'ARRAY';
BEGIN: 'BEGIN';
CASE: 'CASE';
CONST: 'CONST';
DIV: 'DIV';
DO: 'DO';
DOWNTO: 'DOWNTO';
ELSE: 'ELSE';
END: 'END';
WRITE:'WRITE';
FILE: 'FILE';
FOR: 'FOR';
FUNCTION: 'FUNCTION';
GOTO: 'GOTO';
IF: 'IF';
IN: 'IN';
LABEL: 'LABEL';
MOD: 'MOD';
NIL: 'NIL';
NOT: 'NOT';
WRITELN: 'WRITELN';
OF: 'OF';
OR: 'OR';
PACKED: 'PACKED';
PROCEDURE: 'PROCEDURE';
PROGRAM: 'PROGRAM';
RECORD: 'RECORD';
REPEAT: 'REPEAT';
SET: 'SET';
THEN: 'THEN';
TO: 'TO';
READ:'READ';
TYPE: 'TYPE';
UNTIL: 'UNTIL';
VAR: 'VAR';
WHILE: 'WHILE';
WITH: 'WITH';
INTEGER: 'INTEGER';
REAL: 'REAL';
BOOLEAN: 'BOOLEAN';
CHAR: 'CHAR';
STRING: 'STRING';
TRUE: 'TRUE';
FALSE: 'FALSE';

SOMA: '+';
SUBTRACAO: '-';
MULTIPLICACAO: '*';
DIVISAO: '/';
MAIOR: '>';
MENOR: '<';
MAIORIGUAL: '>=';
MENORIGUAL: '<=';
DIFERENTE: '<>';
IGUAL: '=';
ATRIBUICAO: ':=';
PONTOEVIRGULA: ';';
VIRGULA: ',';
PONTO: '.';
DOISPONTOS: ':';
PARENTESESESQUERDO: '(';
PARENTESESDIREITO: ')';

IDENT: ('A' .. 'Z') ('A' .. 'Z' | '0' .. '9' | '_')*;
STRING_LITERAL: '\'' ('\'\'' | ~ ('\''))* '\'';
INTEIRO: ('0' .. '9')+;

WS         : [ \t\r\n] -> skip;
COMENTARIO : '{' .*? '}' -> skip;












