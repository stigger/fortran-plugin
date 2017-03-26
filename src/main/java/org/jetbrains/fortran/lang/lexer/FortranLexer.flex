package org.jetbrains.fortran.lang.lexer;

import com.intellij.lexer.FlexLexer;
import com.intellij.psi.tree.IElementType;
import com.intellij.psi.TokenType;
import java.util.Stack;

import static com.intellij.psi.TokenType.*;
import static org.jetbrains.fortran.lang.FortranTypes.*;
%%

%class _FortranLexer
%implements FlexLexer
%unicode
%caseless
%function advance
%type IElementType
%eof{  return;
%eof}

IDENTIFIER_PART=[:digit:]|[:letter:]|_
IDENTIFIER=[:letter:]{IDENTIFIER_PART}*

LINE_COMMENT="!"[^\r\n]*
WHITE_SPACE_CHAR=[\ \t\f]
EOL=(\n|\r|\r\n)

OPERATOR='.'[:letter:]+'.'

DIGIT=[0-9](\040*[0-9])*
SIGNIFICAND={DIGIT}\040*\.(\040*[0-9])*|\.\040*{DIGIT}
FLOATING_POINT_EXPONENT_PART=[e]\040*(\+|\-)?\040*{DIGIT}
DOUBLE_PRECISION_EXPONENT_PART=[d]\040*(\+|\-)?\040*{DIGIT}

//xIcon
INTEGER_LITERAL={DIGIT}
//xRcon
FLOATING_POINT_LITERAL={DIGIT}{FLOATING_POINT_EXPONENT_PART}|{SIGNIFICAND}({FLOATING_POINT_EXPONENT_PART})?
//xDcon
DOUBLE_PRECISION_LITERAL={DIGIT}{DOUBLE_PRECISION_EXPONENT_PART}|{SIGNIFICAND}{DOUBLE_PRECISION_EXPONENT_PART}

EOL_ESC=\\[\ \t]*\n
ESCAPE_SEQUENCE=\\[^\n]|{EOL_ESC}
STRING_LITERAL=(\"([^\\\"\n]|{ESCAPE_SEQUENCE})*(\"|\\)?)| ('([^\\'\n]|{ESCAPE_SEQUENCE})*('|\\)?)

//REGULAR_STRING_PART=[^\\\'\n]+
//REGULAR_DQ_STRING_PART=[^\\\"\n]+

%%

(("&"){WHITE_SPACE_CHAR}*{EOL}) { return WHITE_SPACE; }
({WHITE_SPACE_CHAR})+ { return WHITE_SPACE; }
(({WHITE_SPACE_CHAR})*({EOL}|(";")))+ { return EOL; }
{LINE_COMMENT} { return LINE_COMMENT; }

{STRING_LITERAL} { return STRING_LITERAL; }
{INTEGER_LITERAL} { return INTEGER_LITERAL; }
{FLOATING_POINT_LITERAL} { return FLOATING_POINT_LITERAL; }
{DOUBLE_PRECISION_LITERAL} { return DOUBLE_PRECISION_LITERAL; }

"=" { return EQ; }
"==" { return EQEQ; }
"/=" { return NEQ; }
":" { return COLON; }
"::" { return COLONCOLON; }
"+" { return PLUS; }
"-" { return MINUS; }
"*" { return MUL; }
"**" { return POWER; }
"/" { return DIV; }
"//" { return DIVDIV; }
"(" { return LPAR; }
")" { return RPAR; }
"[" { return LBRACKET; }
"]" { return RBRACKET; }
"," { return COMMA; }
"." { return DOT; }
"$" { return DOLLAR; }
"%" { return PERC; }
"&" { return AMP; }
//";" { return SEMICOLON; }
"<" { return LT; }
"<=" { return LE; }
">" { return GT; }
">=" { return GE; }
"=>" { return POINTER_ASSMNT; }
"?" { return QUEST; }

".eqv." { return LOGICAL_EQ; }
".neqv." { return LOGICAL_NEQ; }
".and." { return AND; }
".or." { return OR; }
".not." { return NOT; }
".eq." { return EQEQ; }
".ne." { return NEQ; }
".lt." { return LT; }
".le." { return LE; }
".gt." { return GT; }
".ge." { return GE; }

".true." { return TRUE_KEYWORD; }
".false." { return FALSE_KEYWORD; }

"access" { return ACCESS; }
"action" { return ACTION; }
"advance" { return ADVANCE; }
"allocatable" { return ALLOCATABLE; }/*
"allocate" { return FortranTokens.ALLOCATE_KEYWORD; }
"assign" { return FortranTokens.ASSIGN_KEYWORD; }*/
"assignment" { return ASSIGNMENT; }
"associate" { return ASSOCIATE; }
"asynchronous" { return ASYNCHRONOUS; }
"backspace" { return BACKSPACE; }
"bind" { return BIND; }
"blank" { return BLANK; }
"block" { return BLOCK; }
/*"blockdata" { return FortranTokens.BLOCKDATA_KEYWORD; }
"call" { return FortranTokens.CALL_KEYWORD; }*/
"case" { return CASE; }
"character" { return CHARACTER; }
"class" { return FCLASS; }
"close" { return CLOSE; }
"codimension" { return CODIMENSION; } /*
"common" { return FortranTokens.COMMON_KEYWORD; }*/
"complex" { return COMPLEX; }
"concurrent" { return CONCURRENT; } /*
"contains" { return FortranTokens.CONTAINS_KEYWORD; }*/
"contiguous" { return CONTIGUOUS; }
"continue" { return CONTINUE; }
"critical" { return CRITICAL; }
"cycle" { return CYCLE; }/*
"data" { return FortranTokens.DATA_KEYWORD; }*/
"decimal" { return DECIMAL; }
"delim" { return DELIM; } /*
"deallocate" { return FortranTokens.DEALLOCATE_KEYWORD; }*/
"default" { return DEFAULT; }
"dimension" { return DIMENSION; }
"direct" { return DIRECT; }
"do" { return DO; }
"double" { return DOUBLE; }
"precision" { return PRECISION; }
"else" { return ELSE; }
"elseif" { return ELSEIF; }
/*"elsewhere" { return FortranTokens.ELSEWHERE_KEYWORD; }*/
"encoding" { return ENCODING; }/*
"entry" { return FortranTokens.ENTRY_KEYWORD; }*/
"eor" { return EOR; }
"err" { return ERR; }/*
"equivalence" { return FortranTokens.EQUIVALENCE_KEYWORD; }*/
"exist" { return EXIST; }/*
"exit" { return FortranTokens.EXIT_KEYWORD; }*/
"external" { return EXTERNAL; }
"flush" { return FLUSH; }
"file" { return FILE; }/*
"function" { return FortranTokens.FUNCTION_KEYWORD; }*/
"fmt" { return FMT; }
"form" { return FORM; }
"formatted" { return FORMATTED; }
/*
"go" { return FortranTokens.GO_KEYWORD; }
"to" { return FortranTokens.TO_KEYWORD; }
"goto" { return FortranTokens.GOTO_KEYWORD; }*/
"id" { return ID; }
"if" { return IF; }
"implicit" { return IMPLICIT; }
"import" { return IMPORT; }
"in" { return IN; }
"inout" { return INOUT; }
"integer" { return INTEGER; }
"intent" { return INTENT; }/*
"interface" { return FortranTokens.INTERFACE_KEYWORD; }*/
"intrinsic" { return INTRINSIC; }
"inquire" { return INQUIRE; }
"iolength" { return IOLENGTH; }
"iomsg" { return IOMSG; }
"iostat" { return IOSTAT; }
"kind" { return KIND; }
/*"len" { return FortranTokens.LEN_KEYWORD; }*/
"logical" { return LOGICAL; }/*
"module" { return FortranTokens.MODULE_KEYWORD; }*/
"name" { return FNAME; }
"named" { return NAMED; }/*
"namelist" { return FortranTokens.NAMELIST_KEYWORD; }*/
"nextrec" { return NEXTREC; }
"newunit" { return NEWUNIT; }
"nml" { return NML; }
"none" { return NONE; }
"non_intrinsic" { return NON_INTRINSIC; } /*
"nullify" { return FortranTokens.NULLIFY_KEYWORD; }*/
"number" { return NUMBER; }
"only" { return ONLY; }
"open" { return OPEN; }
"opened" { return OPENED; }
"operator" { return OPERATOR; }
"optional" { return OPTIONAL; }
"out" { return OUT; }
"parameter" { return PARAMETER; }
"pad" { return PAD; }
"pending" { return PENDING; }
"pos" { return POS; }
"position" { return POSITION; }/*
"pause" { return FortranTokens.PAUSE_KEYWORD; }*/
"pointer" { return POINTER; }
"print" { return PRINT; }
"private" { return PRIVATE; }
"program" { return PROGRAM; }
"protected" { return PROTECTED; }
"public" { return PUBLIC; }
"read" { return READ; }
"readwrite" { return READWRITE; }
"real" { return REAL; }
"rec" { return REC; }
"recl" { return RECL; }/*
"recursive" { return FortranTokens.RECURSIVE_KEYWORD; }
"result" { return FortranTokens.RESULT_KEYWORD; }
"return" { return FortranTokens.RETURN_KEYWORD; }*/
"round" { return ROUND; }
"save" { return SAVE; }
"sequential" { return SEQUENTIAL; }
"select" { return SELECT; }
"sign" { return SIGN; }
"size" { return SIZE; }
"strem" { return STREAM; }/*
"case" { return FortranTokens.CASE_KEYWORD; }*/
"status" { return STATUS; }/*
"stop" { return FortranTokens.STOP_KEYWORD; }
"subroutine" { return FortranTokens.SUBROUTINE_KEYWORD; }*/
"target" { return TARGET; }
"then" { return THEN; }
/*"type" { return FortranTokens.TYPE_KEYWORD; }*/
"use" { return USE; }
"unformatted" {return UNFORMATTED; }
"value" { return VALUE; }
"volatile" { return VOLATILE; }
"wait" { return WAIT; }
/*
"where" { return FortranTokens.WHERE_KEYWORD; }*/
"while" { return WHILE; }/*
"format" { return FortranTokens.FORMAT_KEYWORD; }*/
/*
"inquire" { return FortranTokens.INQUIRE_KEYWORD; }*/
"rewind" { return REWIND; }
"unit" { return UNIT; }
"write" { return WRITE; }

"end" { return END; }
"endassociate" { return ENDASSOCIATE; }
"endblock" { return ENDBLOCK; }
"endcritical" { return ENDCRITICAL; }
"endfile" { return ENDFILE; }
"endif" { return ENDIF; }
"endprogram" { return ENDPROGRAM; }
/*
"endfunction" { return FortranTokens.ENDFUNCTION_KEYWORD; }
"endsubroutine" { return FortranTokens.ENDSUBROUTINE_KEYWORD; }
"endtype" { return FortranTokens.ENDTYPE_KEYWORD; }
"endwhere" { return FortranTokens.ENDWHERE_KEYWORD; }*/
"endselect" { return ENDSELECT; }
"enddo" { return ENDDO; }/*
"endmodule" { return FortranTokens.ENDMODULE_KEYWORD; }
"endblockdata"    { return FortranTokens.ENDBLOCKDATA_KEYWORD; }
"endblock"    { return FortranTokens.ENDBLOCK_KEYWORD; }
"endinterface"    { return FortranTokens.ENDINTERFACE_KEYWORD; }*/

{IDENTIFIER} { return IDENTIFIER; }
{OPERATOR} { return DEFOPERATOR; }

. { return BAD_CHARACTER; }