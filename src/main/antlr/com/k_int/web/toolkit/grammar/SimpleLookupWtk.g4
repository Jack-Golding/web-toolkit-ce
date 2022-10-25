grammar SimpleLookupWtk;

@header {
  package com.k_int.web.toolkit.grammar;
}

/* Case insensitive fragments */
//fragment A       : [aA];
//fragment B       : [bB];
//fragment C       : [cC];
//fragment D       : [dD];
fragment E          : [eE];
//fragment F       : [fF];
//fragment G       : [gG];
//fragment H       : [hH];
fragment I          : [iI];
//fragment J       : [jJ];
//fragment K       : [kK];
fragment L          : [lL];
fragment M          : [mM];
fragment N          : [nN];
fragment O          : [oO];
fragment P          : [pP];
//fragment Q       : [qQ];
//fragment R       : [rR];
fragment S          : [sS];
fragment T          : [tT];
fragment U          : [uU];
//fragment V       : [vV];
//fragment W       : [wW];
//fragment X       : [xX];
fragment Y          : [yY];
//fragment Z       : [zZ];

fragment LOWERCASE  : [a-z];
fragment UPPERCASE  : [A-Z];
fragment DIGIT      : [0-9];

/** Operators **/

// Match any escaped character
ESCAPED_SPECIAL      : '\\' ~[\r\n\t];

NEGATED              : '!';
GROUP_START          : '(';
GROUP_END            : ')';

AND                  : '&&';
OR                   : '||';

IS                   : I S ;
NOT                  : N O T ;

NULL                 : N U L L;
EMPTY                : E M P T Y;
SET                  : S E T;

EQ                   : '=';
EQEQ                 : '==';
CIEQ                 : '=i=' ;
NEQ                  : '!=' | '<>' ;
GT                   : '>' ;
GE                   : '>=' ;
LT                   : '<' ;
LE                   : '<=' ;
NLIKE                : '!~' ;
LIKE                 : '=~' ;

SPECIAL_OPERATOR     : IS NOT? (NULL | EMPTY | SET);

WHITESPACE           : (' ' | '\t') ;
NEWLINE              : ('\r'? '\n' | '\r')+;
SUBJECT              : (LOWERCASE | UPPERCASE) ((LOWERCASE | UPPERCASE | DIGIT | '_' | '.')* (LOWERCASE | UPPERCASE | DIGIT))? ;

// Capture any that haven't explicitly matched above
ANY                  :  .;

// Match any TOKEN except the single tokens that need escaping in regular values 
value_exp
  : ~( NEGATED | GROUP_START | GROUP_END | GT | LT | EQ | '\\' )+?
;
    
operator
  : GT | GE | LT | LE | EQ | EQEQ | CIEQ | NEQ | NLIKE | LIKE;

special_op_expr
  : subject=SUBJECT WHITESPACE op=SPECIAL_OPERATOR;
    
range_expr
  : lhval=value_exp lhop=(GT | GE | LT | LE) subject=SUBJECT rhop=(GT | GE | LT | LE) rhval=value_exp;

standard_expr
  : lhs=SUBJECT op=operator rhs=SUBJECT                 #ambiguousFilter
  | subject=SUBJECT op=operator value=value_exp         #subjectFirstFilter
  | value=value_exp op=operator subject=SUBJECT         #valueFirstFilter
;

filter_expr
    : NEGATED filter_expr                               #negatedExpression
    | GROUP_START group_criteria=filter_expr GROUP_END  #filterGroup
    | filter_expr (AND filter_expr)+                    #conjunctiveFilter
    | filter_expr (OR filter_expr)+                     #disjunctiveFilter
    | special_op_expr                                   #specialFilter
    | range_expr                                        #rangeFilter
    | standard_expr                                     #standardFilter
;


filters
  : filter_expr (NEWLINE filter_expr)* EOF
;

