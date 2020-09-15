package com.lightteam.language.javascript.styler.lexer;

%%

%public
%class JavaScriptLexer
%unicode
%type JavaScriptToken
%function advance
%line
%column
%char

%{
  public final int getTokenStart() {
      return (int) yychar;
  }

  public final int getTokenEnd() {
      return getTokenStart() + yylength();
  }
%}

IDENTIFIER = [:jletter:] [:jletterdigit:]*

DIGIT = [0-9]
DIGIT_OR_UNDERSCORE = [_0-9]
DIGITS = {DIGIT} | {DIGIT} {DIGIT_OR_UNDERSCORE}*
HEX_DIGIT_OR_UNDERSCORE = [_0-9A-Fa-f]

INTEGER_LITERAL = {DIGITS} | {HEX_INTEGER_LITERAL} | {BIN_INTEGER_LITERAL}
LONG_LITERAL = {INTEGER_LITERAL} [Ll]
HEX_INTEGER_LITERAL = 0 [Xx] {HEX_DIGIT_OR_UNDERSCORE}*
BIN_INTEGER_LITERAL = 0 [Bb] {DIGIT_OR_UNDERSCORE}*

FLOAT_LITERAL = ({DEC_FP_LITERAL} | {HEX_FP_LITERAL}) [Ff] | {DIGITS} [Ff]
DOUBLE_LITERAL = ({DEC_FP_LITERAL} | {HEX_FP_LITERAL}) [Dd]? | {DIGITS} [Dd]
DEC_FP_LITERAL = {DIGITS} {DEC_EXPONENT} | {DEC_SIGNIFICAND} {DEC_EXPONENT}?
DEC_SIGNIFICAND = "." {DIGITS} | {DIGITS} "." {DIGIT_OR_UNDERSCORE}*
DEC_EXPONENT = [Ee] [+-]? {DIGIT_OR_UNDERSCORE}*
HEX_FP_LITERAL = {HEX_SIGNIFICAND} {HEX_EXPONENT}
HEX_SIGNIFICAND = 0 [Xx] ({HEX_DIGIT_OR_UNDERSCORE}+ "."? | {HEX_DIGIT_OR_UNDERSCORE}* "." {HEX_DIGIT_OR_UNDERSCORE}+)
HEX_EXPONENT = [Pp] [+-]? {DIGIT_OR_UNDERSCORE}*

DOUBLE_QUOTE_STRING = [^\r\n\"\\]
SINGLE_QUOTE_STRING = [^\r\n\'\\]

LINE_TERMINATOR = \r|\n|\r\n
INPUT_CHARACTER = [^\r\n]
WHITESPACE = {LINE_TERMINATOR} | [ \t\f]

MULTILINE_COMMENT = "/*" [^*] ~"*/" | "/*" "*"+ "/"
EOL_COMMENT = "//" {INPUT_CHARACTER}* {LINE_TERMINATOR}?
DOC_COMMENT = "/*" "*"+ [^/*] ~"*/"
COMMENT = {MULTILINE_COMMENT} | {EOL_COMMENT} | {DOC_COMMENT}

%state DOUBLE_QUOTE_STRING, SINGLE_QUOTE_STRING

%%

<YYINITIAL> {

  {LONG_LITERAL} { return JavaScriptToken.LONG_LITERAL; }
  {INTEGER_LITERAL} { return JavaScriptToken.INTEGER_LITERAL; }
  {FLOAT_LITERAL} { return JavaScriptToken.FLOAT_LITERAL; }
  {DOUBLE_LITERAL} { return JavaScriptToken.DOUBLE_LITERAL; }

  "function" { return JavaScriptToken.FUNCTION; }
  "prototype" { return JavaScriptToken.PROTOTYPE; }
  "debugger" { return JavaScriptToken.DEBUGGER; }
  "super" { return JavaScriptToken.SUPER; }
  "this" { return JavaScriptToken.THIS; }
  "async" { return JavaScriptToken.ASYNC; }
  "await" { return JavaScriptToken.AWAIT; }
  "export" { return JavaScriptToken.EXPORT; }
  "from" { return JavaScriptToken.FROM; }
  "extends" { return JavaScriptToken.EXTENDS; }
  "final" { return JavaScriptToken.FINAL; }
  "implements" { return JavaScriptToken.IMPLEMENTS; }
  "native" { return JavaScriptToken.NATIVE; }
  "private" { return JavaScriptToken.PRIVATE; }
  "protected" { return JavaScriptToken.PROTECTED; }
  "public" { return JavaScriptToken.PUBLIC; }
  "static" { return JavaScriptToken.STATIC; }
  "synchronized" { return JavaScriptToken.SYNCHRONIZED; }
  "throws" { return JavaScriptToken.THROWS; }
  "transient" { return JavaScriptToken.TRANSIENT; }
  "volatile" { return JavaScriptToken.VOLATILE; }
  "yield" { return JavaScriptToken.YIELD; }
  "delete" { return JavaScriptToken.DELETE; }
  "new" { return JavaScriptToken.NEW; }
  "in" { return JavaScriptToken.IN; }
  "instanceof" { return JavaScriptToken.INSTANCEOF; }
  "typeof" { return JavaScriptToken.TYPEOF; }
  "of" { return JavaScriptToken.OF; }
  "with" { return JavaScriptToken.WITH; }
  "break" { return JavaScriptToken.BREAK; }
  "case" { return JavaScriptToken.CASE; }
  "catch" { return JavaScriptToken.CATCH; }
  "continue" { return JavaScriptToken.CONTINUE; }
  "default" { return JavaScriptToken.DEFAULT; }
  "do" { return JavaScriptToken.DO; }
  "else" { return JavaScriptToken.ELSE; }
  "finally" { return JavaScriptToken.FINALLY; }
  "for" { return JavaScriptToken.FOR; }
  "goto" { return JavaScriptToken.GOTO; }
  "if" { return JavaScriptToken.IF; }
  "import" { return JavaScriptToken.IMPORT; }
  "package" { return JavaScriptToken.PACKAGE; }
  "return" { return JavaScriptToken.RETURN; }
  "switch" { return JavaScriptToken.SWITCH; }
  "throw" { return JavaScriptToken.THROW; }
  "try" { return JavaScriptToken.TRY; }
  "while" { return JavaScriptToken.WHILE; }

  "class" { return JavaScriptToken.CLASS; }
  "interface" { return JavaScriptToken.INTERFACE; }
  "enum" { return JavaScriptToken.ENUM; }
  "boolean" { return JavaScriptToken.BOOLEAN; }
  "byte" { return JavaScriptToken.BYTE; }
  "char" { return JavaScriptToken.CHAR; }
  "double" { return JavaScriptToken.DOUBLE; }
  "float" { return JavaScriptToken.FLOAT; }
  "int" { return JavaScriptToken.INT; }
  "long" { return JavaScriptToken.LONG; }
  "short" { return JavaScriptToken.SHORT; }
  "void" { return JavaScriptToken.VOID; }
  "const" { return JavaScriptToken.CONST; }
  "var" { return JavaScriptToken.VAR; }
  "let" { return JavaScriptToken.LET; }

  "true" { return JavaScriptToken.TRUE; }
  "false" { return JavaScriptToken.FALSE; }
  "null" { return JavaScriptToken.NULL; }
  "NaN" { return JavaScriptToken.NAN; }

  "==" { return JavaScriptToken.EQEQ; }
  "!=" { return JavaScriptToken.NOTEQ; }
  "||" { return JavaScriptToken.OROR; }
  "++" { return JavaScriptToken.PLUSPLUS; }
  "--" { return JavaScriptToken.MINUSMINUS; }

  "<" { return JavaScriptToken.LT; }
  "<<" { return JavaScriptToken.LTLT; }
  "<=" { return JavaScriptToken.LTEQ; }
  "<<=" { return JavaScriptToken.LTLTEQ; }

  ">" { return JavaScriptToken.GT; }
  ">>" { return JavaScriptToken.GTGT; }
  ">>>" { return JavaScriptToken.GTGTGT; }
  ">=" { return JavaScriptToken.GTEQ; }
  ">>=" { return JavaScriptToken.GTGTEQ; }
  ">>>=" { return JavaScriptToken.GTGTGTEQ; }

  "&" { return JavaScriptToken.AND; }
  "&&" { return JavaScriptToken.ANDAND; }

  "+=" { return JavaScriptToken.PLUSEQ; }
  "-=" { return JavaScriptToken.MINUSEQ; }
  "*=" { return JavaScriptToken.MULTEQ; }
  "/=" { return JavaScriptToken.DIVEQ; }
  "&=" { return JavaScriptToken.ANDEQ; }
  "|=" { return JavaScriptToken.OREQ; }
  "^=" { return JavaScriptToken.XOREQ; }
  "%=" { return JavaScriptToken.MODEQ; }

  "(" { return JavaScriptToken.LPAREN; }
  ")" { return JavaScriptToken.RPAREN; }
  "{" { return JavaScriptToken.LBRACE; }
  "}" { return JavaScriptToken.RBRACE; }
  "[" { return JavaScriptToken.LBRACK; }
  "]" { return JavaScriptToken.RBRACK; }
  ";" { return JavaScriptToken.SEMICOLON; }
  "," { return JavaScriptToken.COMMA; }
  "." { return JavaScriptToken.DOT; }

  "=" { return JavaScriptToken.EQ; }
  "!" { return JavaScriptToken.NOT; }
  "~" { return JavaScriptToken.TILDE; }
  "?" { return JavaScriptToken.QUEST; }
  ":" { return JavaScriptToken.COLON; }
  "+" { return JavaScriptToken.PLUS; }
  "-" { return JavaScriptToken.MINUS; }
  "*" { return JavaScriptToken.MULT; }
  "/" { return JavaScriptToken.DIV; }
  "|" { return JavaScriptToken.OR; }
  "^" { return JavaScriptToken.XOR; }
  "%" { return JavaScriptToken.MOD; }

  "=>" { return JavaScriptToken.ARROW; }

  \" { yybegin(DOUBLE_QUOTE_STRING); return JavaScriptToken.STRING_LITERAL; }
  \' { yybegin(SINGLE_QUOTE_STRING); return JavaScriptToken.STRING_LITERAL; }

  {IDENTIFIER} { return JavaScriptToken.IDENTIFIER; }
  {COMMENT} { return JavaScriptToken.COMMENT; }
  {WHITESPACE} { return JavaScriptToken.WHITESPACE; }
}

<DOUBLE_QUOTE_STRING> {
  \" { yybegin(YYINITIAL); return JavaScriptToken.STRING_LITERAL; }

  {DOUBLE_QUOTE_STRING}+ { return JavaScriptToken.STRING_LITERAL; }

  "\\b" { return JavaScriptToken.STRING_LITERAL; }
  "\\t" { return JavaScriptToken.STRING_LITERAL; }
  "\\n" { return JavaScriptToken.STRING_LITERAL; }
  "\\f" { return JavaScriptToken.STRING_LITERAL; }
  "\\r" { return JavaScriptToken.STRING_LITERAL; }
  "\\\"" { return JavaScriptToken.STRING_LITERAL; }
  "\\'" { return JavaScriptToken.STRING_LITERAL; }
  "\\\\" { return JavaScriptToken.STRING_LITERAL; }

  \\. { throw new RuntimeException("Illegal escape sequence \""+yytext()+"\""); }
  {LINE_TERMINATOR} { throw new RuntimeException("Unterminated string at end of line"); }
}

<SINGLE_QUOTE_STRING> {
  \' { yybegin(YYINITIAL); return JavaScriptToken.STRING_LITERAL; }

  {SINGLE_QUOTE_STRING}+ { return JavaScriptToken.STRING_LITERAL; }

  "\\b" { return JavaScriptToken.STRING_LITERAL; }
  "\\t" { return JavaScriptToken.STRING_LITERAL; }
  "\\n" { return JavaScriptToken.STRING_LITERAL; }
  "\\f" { return JavaScriptToken.STRING_LITERAL; }
  "\\r" { return JavaScriptToken.STRING_LITERAL; }
  "\\\"" { return JavaScriptToken.STRING_LITERAL; }
  "\\'" { return JavaScriptToken.STRING_LITERAL; }
  "\\\\" { return JavaScriptToken.STRING_LITERAL; }

  \\. { throw new RuntimeException("Illegal escape sequence \""+yytext()+"\""); }
  {LINE_TERMINATOR} { throw new RuntimeException("Unterminated string at end of line"); }
}

[^] { return JavaScriptToken.BAD_CHARACTER; }

<<EOF>> { return JavaScriptToken.EOF; }