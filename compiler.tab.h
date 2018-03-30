/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     tIF = 258,
     tWHILE = 259,
     tELSE = 260,
     tMAIN = 261,
     tQUOTE = 262,
     tCONST = 263,
     tINTEGER = 264,
     tRETURN = 265,
     tPRINTF = 266,
     tSTRING = 267,
     tAG = 268,
     tAD = 269,
     tSEMICOLON = 270,
     tCOMMA = 271,
     tPLUS = 272,
     tMINUS = 273,
     tSLASH = 274,
     tMUL = 275,
     tEQUAL = 276,
     tPG = 277,
     tPD = 278,
     tINT = 279,
     tVARIABLE = 280,
     tEXP = 281,
     tFIRSTARG = 282,
     tPERCENTINT = 283
   };
#endif
/* Tokens.  */
#define tIF 258
#define tWHILE 259
#define tELSE 260
#define tMAIN 261
#define tQUOTE 262
#define tCONST 263
#define tINTEGER 264
#define tRETURN 265
#define tPRINTF 266
#define tSTRING 267
#define tAG 268
#define tAD 269
#define tSEMICOLON 270
#define tCOMMA 271
#define tPLUS 272
#define tMINUS 273
#define tSLASH 274
#define tMUL 275
#define tEQUAL 276
#define tPG 277
#define tPD 278
#define tINT 279
#define tVARIABLE 280
#define tEXP 281
#define tFIRSTARG 282
#define tPERCENTINT 283




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 10 "compiler.y"
{ char* str; int nb; }
/* Line 1529 of yacc.c.  */
#line 107 "compiler.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

