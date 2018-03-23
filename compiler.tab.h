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
     tAG = 267,
     tAD = 268,
     tSEMICOLON = 269,
     tCOMMA = 270,
     tPLUS = 271,
     tMINUS = 272,
     tSLASH = 273,
     tMUL = 274,
     tEQUAL = 275,
     tPG = 276,
     tPD = 277,
     tINT = 278,
     tVARIABLE = 279,
     tEXP = 280,
     tFIRSTARG = 281,
     tPERCENTINT = 282
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
#define tAG 267
#define tAD 268
#define tSEMICOLON 269
#define tCOMMA 270
#define tPLUS 271
#define tMINUS 272
#define tSLASH 273
#define tMUL 274
#define tEQUAL 275
#define tPG 276
#define tPD 277
#define tINT 278
#define tVARIABLE 279
#define tEXP 280
#define tFIRSTARG 281
#define tPERCENTINT 282




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 8 "compiler.y"
{ char* str; int nb; }
/* Line 1529 of yacc.c.  */
#line 105 "compiler.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

