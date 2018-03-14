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
     tCONST = 262,
     tINTEGER = 263,
     tRETURN = 264,
     tPRINTF = 265,
     tACOLGAU = 266,
     tACOLDROI = 267,
     tSEMICOLON = 268,
     tCOMMA = 269,
     tPLUS = 270,
     tMINUS = 271,
     tSLASH = 272,
     tMUL = 273,
     tEQUAL = 274,
     tPARGAU = 275,
     tPARDROI = 276,
     tEOF = 277,
     tTAB = 278,
     tSPACE = 279,
     tINT = 280,
     tVARIABLE = 281,
     tEXP = 282
   };
#endif
/* Tokens.  */
#define tIF 258
#define tWHILE 259
#define tELSE 260
#define tMAIN 261
#define tCONST 262
#define tINTEGER 263
#define tRETURN 264
#define tPRINTF 265
#define tACOLGAU 266
#define tACOLDROI 267
#define tSEMICOLON 268
#define tCOMMA 269
#define tPLUS 270
#define tMINUS 271
#define tSLASH 272
#define tMUL 273
#define tEQUAL 274
#define tPARGAU 275
#define tPARDROI 276
#define tEOF 277
#define tTAB 278
#define tSPACE 279
#define tINT 280
#define tVARIABLE 281
#define tEXP 282




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 6 "compiler.y"
{ char* str; int nb; }
/* Line 1529 of yacc.c.  */
#line 105 "compiler.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

