From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: Format-string sanity checks
Date: Thu, 11 Oct 2007 00:57:21 -0700
Message-ID: <70318cbf0710110057ya8ba529o7379425628e68be1@mail.gmail.com>
References: <1192048821.26648.13.camel@grianne>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:30345 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224AbXJKH5V (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 11 Oct 2007 03:57:21 -0400
Received: by rv-out-0910.google.com with SMTP id k20so426798rvb
        for <linux-sparse@vger.kernel.org>; Thu, 11 Oct 2007 00:57:21 -0700 (PDT)
In-Reply-To: <1192048821.26648.13.camel@grianne>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Vegard Nossum <vegard.nossum@gmail.com>
Cc: linux-sparse@vger.kernel.org

If you use linearized code instead of the symbol tree. That will
save you a lot of trouble. The best example is sparse.c. Please take
a look at check_call_instruction() and check_memset().

You can add your printk check in similar ways.

Chris

On 10/10/07, Vegard Nossum <vegard.nossum@gmail.com> wrote:
> Hey,
>
> As part of my project to make printk() in the kernel a bit safer, I've
> written this program using sparse to detect unsafe/unwise uses of
> printk.
>
> Basically, I want all format strings of printk() to be literal strings.
>
> This is a very early version. It can probably be written a bit nicer,
> for instance by including it in evaluate_call(), dropping a few of the
> checks (I am not so familiar with sparse, and wanted to be on the safe
> side), and also check all functions marked with the gcc printf attribute
> instead of just "printk". But it works for my purposes.
>
> This code is under the same license as sparse itself.
>
> Kind regards,
> Vegard
>
>
>
> /* Copyright (C) 2007  Vegard Nossum <vegard.nossum@gmail.com> */
>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
>
> #include "lib.h"
> #include "allocate.h"
> #include "token.h"
> #include "parse.h"
> #include "symbol.h"
> #include "expression.h"
> #include "linearize.h"
>
> static void check_stmt(struct statement *stmt);
> static void check_stmts(struct statement_list *stmts);
> static void check_sym(struct symbol *sym);
> static void check_syms(struct symbol_list *syms);
> static void check_expr(struct expression *expr);
> static void check_exprs(struct expression_list *exprs);
>
> static void
> check_printk(struct position pos, struct expression *expr)
> {
>         struct expression_list *args = expr->args;
>         struct expression *format;
>         struct symbol *symbol;
>         struct symbol *base;
>         struct expression *initializer;
>         struct string *string;
>         unsigned int i;
>
>         format = first_ptr_list(args);
>         if(!format) {
>                 warning(pos, "function call has no arguments");
>                 return;
>         }
>
>         if(format->type != EXPR_SYMBOL) {
>                 warning(pos, "format string has wrong type");
>                 return;
>         }
>
>         if(format->symbol_name) {
>                 warning(pos, "format string is a named symbol");
>                 return;
>         }
>
>         symbol = format->symbol;
>         if(symbol->namespace == NS_SYMBOL) {
>                 warning(pos, "format string is not a string literal");
>                 return;
>         }
>
>         if(!symbol->string) {
>                 warning(pos, "format string is not a string");
>                 return;
>         }
>
>         base = symbol->ctype.base_type;
>         if(base->type != SYM_ARRAY) {
>                 warning(pos, "format string is not an array");
>                 return;
>         }
>
>         initializer = symbol->initializer;
>         if(!initializer) {
>                 warning(pos, "format string does not have an initializer");
>                 return;
>         }
>
>         if(initializer->type != EXPR_STRING) {
>                 warning(pos, "format string is not a string literal");
>                 return;
>         }
>
>         string = initializer->string;
>         for(i = 0; i < string->length; ++i) {
>                 if(string->data[i] == '\n'
>                         && i != string->length - 2)
>                 {
>                         warning(pos, "format string contains newline");
>                         return;
>                 }
>         }
> }
>
> static void
> check_expr(struct expression *expr)
> {
>         if(!expr)
>                 return;
>
>         /* XXX: This needs some work... Maybe use evaluate? */
>         switch(expr->type) {
>         case EXPR_VALUE:
>         case EXPR_FVALUE:
>         case EXPR_STRING:
>                 break;
>         case EXPR_SYMBOL:
>         case EXPR_TYPE:
>                 //check_sym(expr->symbol);
>                 break;
>         case EXPR_BINOP:
>         case EXPR_ASSIGNMENT:
>         case EXPR_LOGICAL:
>         case EXPR_COMMA:
>         case EXPR_COMPARE:
>                 check_expr(expr->left);
>                 check_expr(expr->right);
>                 break;
>         case EXPR_DEREF:
>                 check_expr(expr->deref);
>                 break;
>         case EXPR_PREOP:
>         case EXPR_POSTOP:
>                 check_expr(expr->unop);
>                 break;
>         case EXPR_CAST:
>         case EXPR_FORCE_CAST:
>         case EXPR_IMPLIED_CAST:
>                 /* XXX: Hmm? */
>                 check_expr(expr->cast_expression);
>                 break;
>         case EXPR_SIZEOF:
>                 break;
>         case EXPR_ALIGNOF:
>                 break;
>         case EXPR_PTRSIZEOF:
>                 break;
>         case EXPR_CONDITIONAL:
>         case EXPR_SELECT:
>                 check_expr(expr->conditional);
>                 check_expr(expr->cond_true);
>                 check_expr(expr->cond_false);
>                 break;
>         case EXPR_STATEMENT:
>                 check_stmt(expr->statement);
>                 break;
>         case EXPR_CALL:
>                 check_expr(expr->fn);
>                 check_exprs(expr->args);
>                 break;
>         case EXPR_LABEL:
>                 //check_sym(expr->label_symbol);
>                 break;
>         case EXPR_INITIALIZER:
>                 check_exprs(expr->expr_list);
>                 break;
>         case EXPR_IDENTIFIER:
>                 check_expr(expr->ident_expression);
>                 break;
>         case EXPR_INDEX:
>                 check_expr(expr->idx_expression);
>                 break;
>         case EXPR_POS:
>                 check_expr(expr->init_expr);
>                 break;
>         case EXPR_SLICE:
>                 check_expr(expr->base);
>                 break;
>         case EXPR_OFFSETOF:
>                 check_expr(expr->down);
>                 break;
>         }
>
>         if(expr->type == EXPR_CALL) {
>                 struct expression *fn = expr->fn;
>
>                 if(fn->type == EXPR_PREOP)
>                         fn = fn->unop;
>
>                 if(fn->type == EXPR_SYMBOL) {
>                         if(!strcmp(fn->symbol_name->name, "printk"))
>                                 check_printk(fn->pos, expr);
>                 } else {
> #if 0
>                         printf("%d: Function in call expression has "
>                                 "unhandled type %d\n",
>                                 fn->pos.line,
>                                 fn->type);
> #endif
>                 }
>         }
> }
>
> static void
> check_exprs(struct expression_list *exprs)
> {
>         struct expression *expr;
>
>         if(!exprs)
>                 return;
>
>         FOR_EACH_PTR(exprs, expr) {
>                 check_expr(expr);
>         } END_FOR_EACH_PTR(expr);
> }
>
> static void
> check_stmt(struct statement *stmt)
> {
>         if(!stmt)
>                 return;
>
>         switch(stmt->type) {
>         case STMT_NONE:
>                 break;
>         case STMT_DECLARATION:
>                 break;
>         case STMT_EXPRESSION:
>                 check_expr(stmt->expression);
>                 break;
>         case STMT_COMPOUND:
>                 check_stmts(stmt->stmts);
>                 break;
>         case STMT_IF:
>                 check_expr(stmt->if_conditional);
>                 check_stmt(stmt->if_true);
>                 check_stmt(stmt->if_false);
>                 break;
>         case STMT_RETURN:
>                 check_expr(stmt->ret_value);
>                 break;
>         case STMT_CASE:
>                 check_expr(stmt->case_expression);
>                 break;
>         case STMT_SWITCH:
>                 check_expr(stmt->switch_expression);
>                 check_stmt(stmt->switch_statement);
>                 break;
>         case STMT_ITERATOR:
>                 check_stmt(stmt->iterator_pre_statement);
>                 check_expr(stmt->iterator_pre_condition);
>                 check_stmt(stmt->iterator_statement);
>                 check_stmt(stmt->iterator_post_statement);
>                 check_expr(stmt->iterator_post_condition);
>                 break;
>         case STMT_LABEL:
>                 break;
>         case STMT_GOTO:
>                 check_expr(stmt->goto_expression);
>                 break;
>         case STMT_ASM:
>                 check_expr(stmt->asm_string);
>                 check_exprs(stmt->asm_outputs);
>                 check_exprs(stmt->asm_inputs);
>                 check_exprs(stmt->asm_clobbers);
>                 break;
>         case STMT_CONTEXT:
>                 break;
>         case STMT_RANGE:
>                 check_expr(stmt->range_expression);
>                 check_expr(stmt->range_low);
>                 check_expr(stmt->range_high);
>                 break;
>         }
> }
>
> static void
> check_stmts(struct statement_list *stmts)
> {
>         struct statement *stmt;
>
>         if(!stmts)
>                 return;
>
>         FOR_EACH_PTR(stmts, stmt) {
>                 check_stmt(stmt);
>         } END_FOR_EACH_PTR(stmt);
> }
>
> static void
> check_sym(struct symbol *sym)
> {
>         if(sym->ctype.base_type)
>                 sym = sym->ctype.base_type;
>
>         if(sym->type == SYM_FN)
>                 check_stmt(sym->stmt);
> }
>
> static void
> check_syms(struct symbol_list *syms)
> {
>         struct symbol *sym;
>
>         FOR_EACH_PTR_NOTAG(syms, sym) {
>                 check_sym(sym);
>         } END_FOR_EACH_PTR_NOTAG(sym);
> }
>
> int
> main(int argc, char *argv[])
> {
>         struct string_list *files = NULL;
>         char *file;
>
>         sparse_initialize(argc, argv, &files);
>
>         FOR_EACH_PTR_NOTAG(files, file) {
>                 check_syms(sparse(file));
>         } END_FOR_EACH_PTR_NOTAG(file);
>
>         return 0;
> }
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
