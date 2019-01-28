%{
    #include "eiffel.tab.h"
    #define TOKEN(what) (yylval = what)
%}

%start COMMENT
space     [\s\r\t]
spaceStar {space}*

digit     [0-9a-f]
digitseq  {digit}+
integer   -?{digitseq}

real      -?{digitseq}(\.{digitseq})?
ident     [a-zA-Z][a-zA-Z0-9_]*
%%

"across"                                   return TOKEN(ACROSS);
"agent"                                    return TOKEN(AGENT);
"alias"                                    return TOKEN(ALIAS);
"all"                                      return TOKEN(ALL);
"and"                                      return TOKEN(AND);
"->"                                       return TOKEN(ARROW);
"as"                                       return TOKEN(AS);
"assign"                                   return TOKEN(ASSIGN);
"attribute"                                return TOKEN(ATTRIBUTE);
"!"                                        return TOKEN(BANG);
"[]"                                       return TOKEN(BRACKET);
"^"                                        return TOKEN(CARET);
"check"                                    return TOKEN(CHECK);
"C"                                        return TOKEN(CKW);
"class"                                    return TOKEN(CLASS);
":"                                        return TOKEN(COLON);
":="                                       return TOKEN(COLONEQ);
","                                        return TOKEN(COMMA);
"--"                                       BEGIN COMMENT; REJECT;
<COMMENT>--.*\n       
<COMMENT>--.*\n{spaceStar}--               BEGIN COMMENT; yymore();
<COMMENT>--.*\n                            return TOKEN(COMMENT);
"convert"                                  return TOKEN(CONVERT);
"C++"                                      return TOKEN(CPPKW);
"create"                                   return TOKEN(CREATE);
"current"                                  return TOKEN(CURRENT);
"debug"                                    return TOKEN(DEBUG);
"deferred"                                 return TOKEN(DEFERRED);
"/"                                        return TOKEN(DIVIDE);
"dll"                                      return TOKEN(DLL);
"do"                                       return TOKEN(DO);
"$"                                        return TOKEN(DOLLAR);
"."                                        return TOKEN(DOT);
".."                                       return TOKEN(DOTDOT);
"\""                                       return TOKEN(DQUOT);
"else"                                     return TOKEN(ELSE);
"elseif"                                   return TOKEN(ELSEIF);
"end"                                      return TOKEN(END);
"ensure"                                   return TOKEN(ENSURE);
"="                                        return TOKEN(EQUALS);
"expanded"                                 return TOKEN(EXPANDED);
"export"                                   return TOKEN(EXPORT);
"external"                                 return TOKEN(EXTERNAL);
"false"                                    return TOKEN(FALSE);
"feature"                                  return TOKEN(FEATURE);
"//"                                       return TOKEN(FLOORDIV);
"from"                                     return TOKEN(FROM);
"frozen"                                   return TOKEN(FROZEN);
{ident}                                    return TOKEN(IDENTIFIER);
"if"                                       return TOKEN(IF);
"implies"                                  return TOKEN(IMPLIES);
"inherit"                                  return TOKEN(INHERIT);
"inline"                                   return TOKEN(INLINE);
"inspect"                                  return TOKEN(INSPECT);
{integer}                                  return TOKEN(INTEGER);
"invariant"                                return TOKEN(INVARIANT);
"{"                                        return TOKEN(LBRACE);
"["                                        return TOKEN(LBRACK);
"<"                                        return TOKEN(LESS);
"<="                                       return TOKEN(LESSEQ);
"like"                                     return TOKEN(LIKE);
".+"                                       return TOKEN(LINE_SEQUENCE);
"%?"                                       return TOKEN(LINE_WRAPPING_PART);
"local"                                    return TOKEN(LOCAL);
"loop"                                     return TOKEN(LOOP);
"("                                        return TOKEN(LPAREN);
"-"                                        return TOKEN(MINUS);
"\\\\"                                     return TOKEN(MODULO);
">"                                        return TOKEN(MORE);
">="                                       return TOKEN(MOREEQ);
"*"                                        return TOKEN(MULTIPLY);
"none"                                     return TOKEN(NONE);
"not"                                      return TOKEN(NOT);
"note"                                     return TOKEN(NOTE);
"/="                                       return TOKEN(NOTEQUALS);
"/~"                                       return TOKEN(NOTTILDE);
"obsolete"                                 return TOKEN(OBSOLETE);
"old"                                      return TOKEN(OLD);
"once"                                     return TOKEN(ONCE);
"only"                                     return TOKEN(ONLY);
"or"                                       return TOKEN(OR);
"+"                                        return TOKEN(PLUS);
"precursor"                                return TOKEN(PRECURSOR);
"?"                                        return TOKEN(QUESTION);
"}"                                        return TOKEN(RBRACE);
"]"                                        return TOKEN(RBRACK);
{real}                                     return TOKEN(REAL);
"redefine"                                 return TOKEN(REDEFINE);
"rename"                                   return TOKEN(RENAME);
"require"                                  return TOKEN(REQUIRE);
"rescue"                                   return TOKEN(RESUCE);
"result"                                   return TOKEN(RESULT);
"retry"                                    return TOKEN(RETRY);
")"                                        return TOKEN(RPAREN);
"select"                                   return TOKEN(SELECT);
";"                                        return TOKEN(SEMI);
"signature"                                return TOKEN(SIGNATURE);
.*                                         return TOKEN(SIMPLE_STRING);
"some"                                     return TOKEN(SOME);
"'"                                        return TOKEN(SQUOT);
"then"                                     return TOKEN(THEN);
"~"                                        return TOKEN(TILDE);
"true"                                     return TOKEN(TRUE);
"TUPLE"                                    return TOKEN(TUPLE);
"undefine"                                 return TOKEN(UNDEFINE);
"until"                                    return TOKEN(UNTIL);
"use"                                      return TOKEN(USE);
"variant"                                  return TOKEN(VARIANT);
"when"                                     return TOKEN(WHEN);
"windows"                                  return TOKEN(WINDOWS);
"xor"                                      return TOKEN(XOR);
.                                          return TOKEN(CHARACTER);
