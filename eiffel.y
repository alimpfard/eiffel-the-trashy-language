%{

%}

%token ACROSS                            /* across */
%token AGENT                             /* agent */
%token ALIAS                             /* alias */
%token ALL                               /* all */
%token AND                               /* and */
%token ARROW                             /* -> */
%token AS                                /* as */
%token ASSIGN                            /* assign */
%token ATTRIBUTE                         /* attribute */
%token BANG                              /* ! */
%token BRACKET                           /* [] */
%token CARET                             /* ^ */
%token CHARACTER                         /* <char> */
%token CHECK                             /* check */
%token CKW                               /* C */
%token CLASS                             /* class */
%token COLON                             /* : */
%token COLONEQ                           /* := */
%token COMMA                             /* , */
%token COMMENT                           /* -- <.*> */
%token CONVERT                           /* convert */
%token CPPKW                             /* C++ */
%token CREATE                            /* create */
%token CURRENT                           /* current */
%token DEBUG                             /* debug */
%token DEFERRED                          /* deferred */
%token DIVIDE                            /* / */
%token DLL                               /* dll */
%token DO                                /* do */
%token DOLLAR                            /* $ */
%token DOT                               /* . */
%token DOTDOT                            /* .. */
%token DQUOT                             /* " */
%token ELSE                              /* else */
%token ELSEIF                            /* elseif */
%token END                               /* end */
%token ENSURE                            /* ensure */
%token EQUALS                            /* = */
%token EXPANDED                          /* expanded */
%token EXPORT                            /* export */
%token EXTERNAL                          /* external */
%token FALSE                             /* false */
%token FEATURE                           /* feature */
%token FLOORDIV                          /* // */
%token FROM                              /* from */
%token FROZEN                            /* frozen */
%token IDENTIFIER                        /* <ident> */
%token IF                                /* if */
%token IMPLIES                           /* implies */
%token INHERIT                           /* inherit */
%token INLINE                            /* inline */
%token INSPECT                           /* inspect */
%token INTEGER                           /* <digitseq> */
%token INVARIANT                         /* invariant */
%token LBRACE                            /* { */
%token LBRACK                            /* [ */
%token LESS                              /* < */
%token LESSEQ                            /* <= */
%token LIKE                              /* like */
%token LINE_SEQUENCE                     /* .+ */
%token LINE_WRAPPING_PART                /* %? */
%token LOCAL                             /* local */
%token LOOP                              /* loop */
%token LPAREN                            /* ( */
%token MINUS                             /* - */
%token MODULO                            /* \\ */
%token MORE                              /* > */
%token MOREEQ                            /* >= */
%token MULTIPLY                          /* * */
%token NONE                              /* none */
%token NOT                               /* not */
%token NOTE                              /* note */
%token NOTEQUALS                         /* /= */
%token NOTTILDE                          /* /~ */
%token OBSOLETE                          /* obsolete */
%token OLD                               /* old */
%token ONCE                              /* once */
%token ONLY                              /* only */
%token OR                                /* or */
%token PLUS                              /* + */
%token PRECURSOR                         /* precursor */
%token QUESTION                          /* ? */
%token RBRACE                            /* } */
%token RBRACK                            /* ] */
%token REAL                              /* <real> */
%token REDEFINE                          /* redefine */
%token RENAME                            /* rename */
%token REQUIRE                           /* require */
%token RESUCE                            /* rescue */
%token RESULT                            /* result */
%token RETRY                             /* retry */
%token RPAREN                            /* ) */
%token SELECT                            /* select */
%token SEMI                              /* ; */
%token SIGNATURE                         /* signature */
%token SIMPLE_STRING                     /* <str> */
%token SOME                              /* some */
%token SQUOT                             /* ' */
%token THEN                              /* then */
%token TILDE                             /* ~ */
%token TRUE                              /* true */
%token TUPLE                             /* TUPLE */ 
%token UNDEFINE                          /* undefine */
%token UNTIL                             /* until */
%token USE                               /* use */
%token VARIANT                           /* variant */
%token WHEN                              /* when */
%token WINDOWS                           /* windows */
%token XOR                               /* xor */

%start Class_declaration

%define lr.type ielr

%%

Class_name : IDENTIFIER             { }
           ;

Class_declaration :
    Notesm Class_header Formal_genericsm Obsoletem Inheritancem Creatorsm Convertersm Featuresm Notesm Invariantm Notesm END
        { }
                  ;

Notesm : 
       | Notes
       ;

Notes  : NOTE Note_list
       ;

Note_list : Note_entry SEMI Note_list
          | 
          ;
Note_entry: Note_name Note_values
          ;

Note_name : IDENTIFIER COLON
          ;
Note_values: Note_item COMMA Note_values
           | Note_item
           ;
Note_item: IDENTIFIER
         | Manifest_constant
         ;

Class_header : Header_markm CLASS Class_name
             ;

Header_markm : DEFERRED
             | EXPANDED
             | FROZEN
             ;

Obsoletem :
          | Obsolete
          ;
Obsolete: OBSOLETE Message
        ;

Message: Manifest_string
       ;

Featuresm :
          | Features
          ;

Features: Feature_clause
        | Feature_clause Features
        ;

Feature_clause: FEATURE Clientsm Header_commentm Feature_declaration_list
              ;

Feature_declaration_list : Feature_declaration SEMI Feature_declaration_list
                         | 
                         ;

Header_commentm : Commentm
                ;

Commentm:
        | COMMENT
        ;

Feature_declaration: New_feature_list Declaration_body
                   ;
Declaration_body: Formal_argumentsm Query_markm Feature_valuem
                ;

Query_markm:
           | Type_mark Assigner_markm
           ;
Type_mark: COMMA Type
         ;
Feature_valuem: 
              | Explicit_valuem Obsoletem Header_commentm Attribute_or_routinem
              ;
Explicit_valuem:
               | Manifest_constant
               ;

New_feature_list: New_feature
                | New_feature COMMA New_feature_list
                ;
New_feature: FROZEN Extended_feature_name
           | Extended_feature_name
           ;

Attribute_or_routinem: Attribute_or_routine
                     |
                     ;

Attribute_or_routine: Preconditionm Local_declarationsm Feature_body Postconditionm Rescuem END
                    ;

Feature_body: Deferred 
            | Effective_routine
            | Attribute
            ;

Extended_feature_name: Feature_name Aliasm
                     ;

Feature_name: IDENTIFIER
            ;

Aliasm: ALIAS DQUOT Alias_name DQUOT CONVERT
      | ALIAS DQUOT Alias_name DQUOT
      ;

Alias_name: Operator
          | Bracket
          ;

Bracket: BRACKET
       ;

Operator: Unary
        | Binary
        ;

Unary: NOT 
     | PLUS
     | MINUS
     /* Free_unary */
     ;
Binary: PLUS
      | MINUS
      | MULTIPLY
      | DIVIDE
      | FLOORDIV
      | MODULO
      | CARET
      | DOTDOT
      | LESS
      | MORE
      | LESSEQ
      | MOREEQ
      | AND
      | OR
      | XOR
      | AND THEN
      | OR ELSE
      | IMPLIES
      /* Free_binary */
      ;
Assigner_markm: 
              | ASSIGN Feature_name
              ;

Inheritancem:
            | Inheritance
            ;

Inheritance: Inherit_clause Inheritance
           | Inherit_clause
           ;

Inherit_clause: INHERIT Non_conformancem Parent_list
              ;
Non_conformancem: 
                | LBRACE NONE RBRACE
                ;

Parent_list: Parent SEMI Parent_list
           | Parent
           ;

Parent: Class_type Feature_adaptationm
      ;

Feature_adaptationm:
                   | Undefinem Redefinem Renamem New_exportsm Selectm END
                   ;

Rename: RENAME Rename_list
      ;

Renamem: Rename
       |
       ;

Rename_list: Rename_pair COMMA Rename_list
           | Rename_pair
           ;

Rename_pair: Feature_name AS Extended_feature_name
           ;

Clients: LBRACE Class_list RBRACE
       ;
Clientsm: Clients
        |
        ;

Class_list: Class_name COMMA Class_list
          | Class_name
          ;

New_exportsm:
            | EXPORT New_export_list
            ;

New_export_list: New_export_item SEMI New_export_list
               | New_export_item
               ;

New_export_item: Clients Header_commentm Feature_set
               ;

Feature_set: Feature_list 
           | ALL
           ;

Feature_list: Feature_name COMMA Feature_list
            | Feature_name
            ;

Formal_argumentsm:
                 | Formal_arguments
                 ;

Formal_arguments: LPAREN Entity_declaration_list RPAREN
                ;

Entity_declaration_list: Entity_declaration_group SEMI Entity_declaration_list
                       | Entity_declaration_list
                       ;

Entity_declaration_group: Identifier_list Type_mark
                        ;

Identifier_list: IDENTIFIER COMMA Identifier_list
               | IDENTIFIER
               ;

Deferred: DEFERRED
        ;

Effective_routine: Internal
                 | External
                 ;

Internal: Routine_mark Compound
        ;

Routine_mark: DO
            | Once
            ;

Once: ONCE Key_list_lm
    ;

Key_list_lm:
           | Key_list_l
           ;

Key_list_l: LPAREN Key_list RPAREN
          ;

Key_list: Manifest_string COMMA Key_list
        | Manifest_string
        ;

Local_declarationsm: Local_declarations
                   |
                   ;
Local_declarations: LOCAL Entity_declaration_list
                  ;
Compound: 
        | Instruction SEMI Compound
        ;
Instruction: Creation_instruction
           | Call
           | Assignment
           | Assigner_call
           | Conditional
           | Multi_branch
           | Loop
           | Debug
           | Precursor
           | Check
           | Retry
           ;

Preconditionm:
            | REQUIRE ELSE Assertion
            | REQUIRE Assertion
            ;

Postconditionm:
              | ENSURE THEN Assertion Onlym
              | ENSURE Assertion Onlym
              ;

Onlym: 
     | Only
     ;

Invariantm:
          | INVARIANT Assertion
          ;

Assertion: Assertion_clause SEMI Assertion
         | 
         ;

Assertion_clause: Tag_markm Unlabeled_assertion_clause
                ;
Tag_markm: Tag_mark
         | 
         ;
Unlabeled_assertion_clause: Boolean_expression | COMMENT
                          ;
Tag_mark: Tag COLON
        ;
Tag: IDENTIFIER
   ;

Old: OLD Expression
   ;

Only: ONLY Feature_listm
    ;
Feature_listm:
             | Feature_list
             ;

Check: CHECK Assertion Notesm END
     ;
Variant: VARIANT Tag_markm Expression
       ;

Variantm:
        | Variant
        ;

Precursor: PRECURSOR Parent_qualificationm Actualsm
         ;

Parent_qualificationm:
                     | LBRACE Class_name RBRACE
                     ;

Redefinem:
         |REDEFINE Feature_list
         ;

Undefinem:
         | UNDEFINE Feature_list
         ;

Type: Class_or_tuple_type
    | Formal_generic_name
    | Anchored
    ;

Class_or_tuple_type: Class_type
                   | Tuple_type
                   ;
Class_type: Attachment_markm Class_name Actual_genericsm
          ;

Attachment_markm:
                | Attachment_mark;

Attachment_mark: QUESTION
               | BANG
               ;

Anchored: Attachment_markm LIKE Anchor
        ;

Anchor: Feature_name | CURRENT
      ;

Actual_genericsm:
                | Actual_generics
                ;

Actual_generics: LBRACK Type_list RBRACK
               ;

Type_list: Type COMMA Type_list
         | Type
         ;

Formal_genericsm:
                | Formal_generics
                ;
Formal_generics: LBRACK Formal_generics_list RBRACK
               ;

Formal_generics_list: Formal_generic COMMA Formal_generics_list
                    | Formal_generic
                    ;

Formal_generic: FROZEN Formal_generic_name Constraintm
              | Formal_generic_name Constraintm
              ;

Formal_generic_name: QUESTION IDENTIFIER
                   | IDENTIFIER
                   ;

Constraint: ARROW Constraining_types 
          | ARROW Constraining_types Constraint_creators
          ;

Constraintm:
           | Constraint
           ;

Constraining_types: Single_constraint
                  | Multiple_constraint
                  ;

Single_constraint: Type 
                 | Type Renaming
                 ;

Renaming: Rename END
        ;

Multiple_constraint: LBRACE Constraint_list RBRACE
                   ;

Constraint_list: Single_constraint COMMA Constraint_list
               | Single_constraint
               ;

Constraint_creators: CREATE Feature_list END
                   ;

Manifest_array: Manifest_array_typem LESS LESS Expression_list MORE MORE
              ;

Manifest_array_typem:
                    | Manifest_array_type
                    ;

Manifest_array_type: LBRACE Type RBRACE
                   ;

Expression_list: Expression COMMA Expression_list 
               | 
               ;

Tuple_type: TUPLE Tuple_parameter_listm
          ;

Tuple_parameter_listm:
                     | Tuple_parameter_list
                     ;

Tuple_parameter_list: LBRACK Tuple_parameters RBRACK
                    ;

Tuple_parameters: Type_list
                | Entity_declaration_list
                ;

Manifest_tuple: LBRACK Expression_list RBRACK
              ;

Convertersm:
           | Converters
           ;

Converters: CONVERT Converter_list
          ;

Converter_list: Converter COMMA Converter_list
              | Converter
              ;

Converter: Conversion_procedure
         | Conversion_query
         ;

Conversion_procedure: Feature_name LPAREN LBRACE Type_list RBRACE RPAREN
                    ;

Conversion_query: Feature_name COLON LBRACE Type_list RBRACE
                ;

Selectm:
       | Select
       ;

Select: SELECT Feature_list
      ;

Conditional: IF Then_part_list Else_part END
           | IF Then_part_list END
           ;

Then_part_list: Then_part ELSEIF Then_part_list
              | Then_part
              ;

Then_part: Boolean_expression THEN Compound
         ;

Else_part: ELSE Compound
         ;

Conditional_expression: IF Then_part_expression_list ELSE Expression END
                      ;

Then_part_expression_list: Then_part_list ELSEIF Then_part_expression_list
                         | Then_part_list
                         ;

Then_part_expression: Boolean_expression THEN Expression
                    ;

Multi_branch: INSPECT Expression When_part_listm Else_partm END
            ;
When_part_listm: 
               | When_part_list
               ;
Else_partm: 
          | Else_part
          ;

When_part_list: When_part When_part_list
              | When_part
              ;

When_part: WHEN Choices THEN Compound
        ;

Choices: Choice COMMA Choices
       | Choice
       ;
Choice: Constant 
      | Manifest_type 
      | Constant_interval
      | Type_interval
      ;

Constant_interval: Constant DOTDOT Constant
                 ;

Type_interval: Manifest_type DOTDOT Manifest_type
             ;

Loop: Iterationm Initializationm Invariantm Exit_conditionm Loop_body Variantm END
    ;

Iterationm: 
          | ACROSS Expression AS IDENTIFIER
          ;

Initializationm:
               | FROM Compound
               ;

Exit_conditionm:
               | UNTIL Boolean_expression
               ;

Loop_body: LOOP Compound
         | ALL Boolean_expression
         | SOME Boolean_expression
         ;

Debug: DEBUG LPAREN Key_list RPAREN Compound END
     | DEBUG Compound END
     ;

Attribute: ATTRIBUTE Compound
         ;

Entity: Variable 
      | Read_only
      ;

Variable: Variable_attribute 
        | Local
        ;

Variable_attribute: Feature_name
                  ;

Local: RESULT
     ;

Read_only: Constant_attribute
         | CURRENT
         ;

Constant_attribute: Feature_name
                  ;

Creatorsm: 
         | Creators
         ;

Creators: Creation_clause Creators
        | Creation_clause
        ;

Creation_clause: CREATE Clientsm Header_commentm Creation_procedure_list
               ;

Creation_procedure_list: Creation_procedure COMMA Creation_procedure_list
                       | Creation_procedure
                       ;

Creation_procedure: Feature_name
                  ;

Creation_instruction: CREATE Explicit_creation_typem Creation_call
                    ;

Explicit_creation_typem:
                       | Explicit_creation_type
                       ;

Explicit_creation_type: LBRACE Type RBRACE
                      ;

Creation_call: Variable Explicit_creation_callm
             ;

Explicit_creation_callm:
                       | Explicit_creation_call
                       ;

Explicit_creation_call: DOT Unqualified_call
                      ;

Creation_expression: CREATE Explicit_creation_type Explicit_creation_callm
                   ;

Equality: Expression Comparison Expression
        ;

Comparison: EQUALS
          | NOTEQUALS
          | TILDE
          | NOTTILDE
          ;

Assignment: Variable COLONEQ Expression
          ;

Assigner_call: Expression COLONEQ Expression
             ;

Call: Object_call 
    | Non_object_call
    ;

Object_call: Target DOT Unqualified_call
           | Unqualified_call
           ;

Unqualified_call: Feature_name Actualsm
                ;

Target: Local
      | Read_only
      | Call
      | Parenthesized_target
      ;

Parenthesized_target: LPAREN Expression RPAREN
                    ;

Non_object_call: LBRACE Type RBRACE DOT Unqualified_call
               ;

Actualsm:
        | Actuals
        ;

Actuals: LPAREN Actual_list RPAREN
       ;

Actual_list: Expression COMMA Actual_list
           | Expression
           ;

Object_test: LBRACE IDENTIFIER COLON Type RBRACE Expression
           ;

Rescuem: 
       | Rescue
       ;

Rescue: RESUCE Compound
      ;

Retry: RETRY
     ;

Agent: Call_agent
     | Inline_agent
     ;

Call_agent: AGENT Call_agent_body
          ;

Inline_agent: AGENT Formal_arguments Type_markm Attribute_or_routinem Agent_actualsm
            ;

Type_markm: 
          | Type_mark
          ;

Call_agent_body: Agent_qualified
               | Agent_unqualified
               ;

Agent_qualified: Agent_target DOT Agent_unqualified
               ;

Agent_unqualified: Feature_name Agent_actualsm
                 ;

Agent_target: Entity 
            | Parenthesized
            | Manifest_type
            ;

Agent_actualsm:
              | Agent_actuals
              ;
Agent_actuals: LPAREN Agent_actual_list RPAREN
             ;

Agent_actual_list: Agent_actual COMMA Agent_actual_list
                 | Agent_actual
                 ;
Agent_actual: Expression 
            | Placeholder
            ;

Placeholder: Manifest_typem QUESTION
           ;

Manifest_typem:
              | Manifest_type
              ;

Expression: Basic_expression
          | Special_expression
          ;

Basic_expression: Read_only
                | Local
                | Call
                | Precursor 
                | Equality
                | Parenthesized 
                | Old
                | Operator_expression
                | Bracket_expression
                | Creation_expression
                | Conditional_expression 
                ;

Special_expression: Manifest_constant
                  | Manifest_array 
                  | Manifest_tuple 
                  | Agent
                  | Object_test
                  | Once_string
                  | Address
                  ;

Parenthesized: LPAREN Expression RPAREN
             ;

Address: DOLLAR Variable
       ;

Once_string: ONCE Manifest_string 
           ;

Boolean_expression: Basic_expression 
                  | Boolean_constant
                  | Object_test 
                  ;

Operator_expression: Unary_expression
                   | Binary_expression
                   ;

Unary_expression: Unary Expression
                ;

Binary_expression: Expression Binary Expression 
                 ;

Bracket_expression: Bracket_target LBRACK Actualsm RBRACK
                  ;

Bracket_target: Target 
              | Once_string
              | Manifest_constant 
              | Manifest_tuple
              ;

Constant: Manifest_constant
        | Feature_name 
        ;

Manifest_constant: Manifest_typem Manifest_value
                 ;

Manifest_type: LBRACE Type RBRACE
             ;

Manifest_value: Boolean_constant 
              | Character_constant
              | Integer_constant
              | Real_constant
              | Manifest_string
              | Manifest_type
              ;

Sign: PLUS
    | MINUS
    ;

Integer_constant: Sign INTEGER
                | INTEGER
                ;

Character_constant: SQUOT CHARACTER SQUOT
                  ;

Boolean_constant: TRUE 
                | FALSE
                ;

Real_constant: Sign REAL
             | REAL
             ;

Manifest_string: Basic_manifest_string
               | Verbatim_string
               ;

Basic_manifest_string: DQUOT String_content DQUOT
                     ;

String_content: SIMPLE_STRING LINE_WRAPPING_PART String_content
              | SIMPLE_STRING LINE_WRAPPING_PART
              ;

Verbatim_string: Verbatim_string_opener LINE_SEQUENCE Verbatim_string_closer
               ;

Verbatim_string_opener: DQUOT SIMPLE_STRING Open_bracket
                      | DQUOT Open_bracket
                      ;

Verbatim_string_closer: Close_bracket SIMPLE_STRING DQUOT
                      | Close_bracket DQUOT
                      ;

Open_bracket: LBRACK
            | LBRACE
            ;

Close_bracket: RBRACK
             | RBRACE
             ;

External: EXTERNAL External_language External_name
        | EXTERNAL External_language
        ;

External_language: Unregistered_language 
                 | Registered_language
                 ;

Unregistered_language: Manifest_string
                     ;

External_name: ALIAS Manifest_string
             ;

Registered_language: C_external
                   | Cpp_external
                   | DLL_external
                   ;

External_signature: SIGNATURE External_argument_typesm COLON External_type
                  | SIGNATURE External_argument_typesm
                  ;

External_signaturem: 
                  | External_signature
                  ;

External_argument_typesm:
                        | External_argument_types
                        ;

External_argument_types: LPAREN External_type_list RPAREN
                       ;

External_type_list: External_type COMMA External_type_list
                  | 
                  ;

External_type: SIMPLE_STRING
             ;

External_file_use: USE External_file_list
                 ;

External_file_usem: 
                  | External_file_use
                  ;

External_file_list: External_file COMMA External_file_list
                  | External_file
                  ;

External_file: External_user_file
             | External_system_file
             ;

External_user_file: DQUOT SIMPLE_STRING DQUOT
                  ;

External_system_file: LESS SIMPLE_STRING MORE
                    ;

C_external: DQUOT CKW INLINE External_signaturem External_file_usem DQUOT
          | DQUOT CKW External_signaturem External_file_usem DQUOT
          ;

Cpp_external: DQUOT CPPKW INLINE External_signaturem External_file_usem DQUOT
            | DQUOT CPPKW External_signaturem External_file_usem DQUOT
            ;

DLL_external: DQUOT DLL WINDOWS DLL_identifier DLL_index External_signaturem External_file_usem DQUOT
            | DQUOT DLL WINDOWS DLL_identifier External_signaturem External_file_usem DQUOT
            ;

DLL_identifier: SIMPLE_STRING
              ;

DLL_index: INTEGER
         ;

%%
