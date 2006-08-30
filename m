From: Josh Triplett <josht@us.ibm.com>
Subject: [PATCH RESEND] Parse and track multiple contexts by expression
Date: Wed, 30 Aug 2006 10:14:53 -0700
Message-ID: <1156958093.3418.1.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:64985 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751171AbWH3ROs
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 30 Aug 2006 13:14:48 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k7UHEltu010167
	for <linux-sparse@vger.kernel.org>; Wed, 30 Aug 2006 13:14:47 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k7UHEkCE237430
	for <linux-sparse@vger.kernel.org>; Wed, 30 Aug 2006 11:14:46 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k7UHEksG014005
	for <linux-sparse@vger.kernel.org>; Wed, 30 Aug 2006 11:14:46 -0600
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>

sparse currently only tracks one global context for __context__ and
__attribute__((context)).  Add support for parsing an additional argument to
each of these which gives a context expression.  For __attribute__((context)),
store each context attribute as a separate context structure containing the
expression, the entry context, and the exit context, and keep a list of these
structures in the ctype.  For __context__, store the context expression in the
context instruction.  Modify the various frontends to adapt to this change,
without changing functionality.

This change should not affect parsing of programs which worked with previous
versions of sparse, unless those programs use comma expressions as arguments
to __context__ or __attribute__((context)), which seems highly dubious and
unlikely.  sparse with -Wcontext generates identical output with or without
this change on Linux 2.6.18-rc4.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 allocate.c   |    1 +
 allocate.h   |    1 +
 check.c      |    8 +++++++-
 linearize.c  |   49 ++++++++++++++++++++++++++++---------------------
 linearize.h  |    1 +
 parse.c      |   36 +++++++++++++++++++++++++-----------
 parse.h      |    5 ++++-
 show-parse.c |   17 +++++++++++++----
 symbol.c     |    9 +++++++--
 symbol.h     |   12 +++++++++++-
 10 files changed, 98 insertions(+), 41 deletions(-)

diff --git a/allocate.c b/allocate.c
index 4894e59..f3d29a6 100644
--- a/allocate.c
+++ b/allocate.c
@@ -113,6 +113,7 @@ void show_allocations(struct allocator_s
 
 ALLOCATOR(ident, "identifiers");
 ALLOCATOR(token, "tokens");
+ALLOCATOR(context, "contexts");
 ALLOCATOR(symbol, "symbols");
 ALLOCATOR(expression, "expressions");
 ALLOCATOR(statement, "statements");
diff --git a/allocate.h b/allocate.h
index ab6bd0a..33703fe 100644
--- a/allocate.h
+++ b/allocate.h
@@ -61,6 +61,7 @@ #define ALLOCATOR(x, n) __ALLOCATOR(stru
 
 DECLARE_ALLOCATOR(ident);
 DECLARE_ALLOCATOR(token);
+DECLARE_ALLOCATOR(context);
 DECLARE_ALLOCATOR(symbol);
 DECLARE_ALLOCATOR(expression);
 DECLARE_ALLOCATOR(statement);
diff --git a/check.c b/check.c
index bbfac44..d327c3b 100644
--- a/check.c
+++ b/check.c
@@ -234,6 +234,8 @@ static void check_instructions(struct en
 static void check_context(struct entrypoint *ep)
 {
 	struct symbol *sym = ep->name;
+	struct context *context;
+	unsigned int in_context = 0, out_context = 0;
 
 	if (verbose && ep->entry->bb->needs) {
 		pseudo_t pseudo;
@@ -246,7 +248,11 @@ static void check_context(struct entrypo
 
 	check_instructions(ep);
 
-	check_bb_context(ep, ep->entry->bb, sym->ctype.in_context, sym->ctype.out_context);
+	FOR_EACH_PTR(sym->ctype.contexts, context) {
+		in_context += context->in;
+		out_context += context->out;
+	} END_FOR_EACH_PTR(context);
+	check_bb_context(ep, ep->entry->bb, in_context, out_context);
 }
 
 static void check_symbols(struct symbol_list *list)
diff --git a/linearize.c b/linearize.c
index f47bad9..8a8a2d3 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1183,7 +1183,8 @@ static pseudo_t linearize_call_expressio
 	struct expression *arg, *fn;
 	struct instruction *insn = alloc_typed_instruction(OP_CALL, expr->ctype);
 	pseudo_t retval, call;
-	int context_diff, check;
+	struct ctype *ctype = NULL;
+	struct context *context;
 
 	if (!expr->ctype) {
 		warning(expr->pos, "call with no type!");
@@ -1197,21 +1198,8 @@ static pseudo_t linearize_call_expressio
 
 	fn = expr->fn;
 
-	check = 0;
-	context_diff = 0;
-	if (fn->ctype) {
-		int in = fn->ctype->ctype.in_context;
-		int out = fn->ctype->ctype.out_context;
-		if (in < 0) {
-			check = 1;
-			in = 0;
-		}
-		if (out < 0) {
-			check = 0;
-			out = 0;
-		}
-		context_diff = out - in;
-	}
+	if (fn->ctype)
+		ctype = &fn->ctype->ctype;
 
 	if (fn->type == EXPR_PREOP) {
 		if (fn->unop->type == EXPR_SYMBOL) {
@@ -1232,11 +1220,29 @@ static pseudo_t linearize_call_expressio
 	insn->target = retval;
 	add_one_insn(ep, insn);
 
-	if (check || context_diff) {
-		insn = alloc_instruction(OP_CONTEXT, 0);
-		insn->increment = context_diff;
-		insn->check = check;
-		add_one_insn(ep, insn);
+	if (ctype) {
+		FOR_EACH_PTR(ctype->contexts, context) {
+			int in = context->in;
+			int out = context->out;
+			int check = 0;
+			int context_diff;
+			if (in < 0) {
+				check = 1;
+				in = 0;
+			}
+			if (out < 0) {
+				check = 0;
+				out = 0;
+			}
+			context_diff = out - in;
+			if (check || context_diff) {
+				insn = alloc_instruction(OP_CONTEXT, 0);
+				insn->increment = context_diff;
+				insn->check = check;
+				insn->context_expr = context->context;
+				add_one_insn(ep, insn);
+			}
+		} END_FOR_EACH_PTR(context);
 	}
 
 	return retval;
@@ -1637,6 +1643,7 @@ static pseudo_t linearize_context(struct
 		value = expr->value;
 
 	insn->increment = value;
+	insn->context_expr = stmt->context;
 	add_one_insn(ep, insn);
 	return VOID;
 }
diff --git a/linearize.h b/linearize.h
index 66a76dc..ac946f3 100644
--- a/linearize.h
+++ b/linearize.h
@@ -105,6 +105,7 @@ struct instruction {
 		struct /* context */ {
 			int increment;
 			int check;
+			struct expression *context_expr;
 		};
 		struct /* asm */ {
 			const char *string;
diff --git a/parse.c b/parse.c
index c536ec2..bdd6e29 100644
--- a/parse.c
+++ b/parse.c
@@ -434,10 +434,17 @@ static const char * handle_attribute(str
 	}
 	if (attribute == &context_ident) {
 		if (expr && expr->type == EXPR_COMMA) {
-			int input = get_expression_value(expr->left);
-			int output = get_expression_value(expr->right);
-			ctype->in_context = input;
-			ctype->out_context = output;
+			struct context *context = alloc_context();
+			if(expr->left->type == EXPR_COMMA) {
+				context->context = expr->left->left;
+				context->in = get_expression_value(
+					expr->left->right);
+			} else {
+				context->context = NULL;
+				context->in = get_expression_value(expr->left);
+			}
+			context->out = get_expression_value(expr->right);
+			add_ptr_list(&ctype->contexts, context);
 			return NULL;
 		}
 		return "expected context input/output values";
@@ -669,9 +676,9 @@ static void apply_ctype(struct position 
 		ctype->modifiers = old | mod | extra;
 	}
 
-	/* Context mask and value */
-	ctype->in_context += thistype->in_context;
-	ctype->out_context += thistype->out_context;
+	/* Context */
+	concat_ptr_list((struct ptr_list *)thistype->contexts,
+	                (struct ptr_list **)&ctype->contexts);
 
 	/* Alignment */
 	if (thistype->alignment & (thistype->alignment-1)) {
@@ -908,16 +915,15 @@ static struct token *pointer(struct toke
 		struct symbol *ptr = alloc_symbol(token->pos, SYM_PTR);
 		ptr->ctype.modifiers = modifiers & ~MOD_STORAGE;
 		ptr->ctype.as = ctype->as;
-		ptr->ctype.in_context += ctype->in_context;
-		ptr->ctype.out_context += ctype->out_context;
+		concat_ptr_list((struct ptr_list *)ctype->contexts,
+				(struct ptr_list **)&ptr->ctype.contexts);
 		ptr->ctype.base_type = base_type;
 
 		base_type = ptr;
 		ctype->modifiers = modifiers & MOD_STORAGE;
 		ctype->base_type = base_type;
 		ctype->as = 0;
-		ctype->in_context = 0;
-		ctype->out_context = 0;
+		free_ptr_list(&ctype->contexts);
 
 		token = declaration_specifiers(token->next, ctype, 1);
 		modifiers = ctype->modifiers;
@@ -1384,6 +1390,14 @@ default_statement:
 		if (token->ident == &__context___ident) {
 			stmt->type = STMT_CONTEXT;
 			token = parse_expression(token->next, &stmt->expression);
+			if(stmt->expression->type == EXPR_PREOP
+			   && stmt->expression->op == '('
+			   && stmt->expression->unop->type == EXPR_COMMA) {
+				struct expression *expr;
+				expr = stmt->expression->unop;
+				stmt->context = expr->left;
+				stmt->expression = expr->right;
+			}
 			return expect(token, ';', "at end of statement");
 		}
 		if (token->ident == &__range___ident) {
diff --git a/parse.h b/parse.h
index 2f3a3fe..f43d431 100644
--- a/parse.h
+++ b/parse.h
@@ -39,7 +39,10 @@ struct statement {
 			struct symbol *label;
 			struct statement *label_statement;
 		};
-		struct expression *expression;
+		struct {
+			struct expression *expression;
+			struct expression *context;
+		};
 		struct /* return_statement */ {
 			struct expression *ret_value;
 			struct symbol *ret_target;
diff --git a/show-parse.c b/show-parse.c
index 70a5b08..5437a62 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -50,18 +50,27 @@ static void do_debug_symbol(struct symbo
 		[SYM_RESTRICT] = "rstr",
 		[SYM_BAD] = "bad.",
 	};
+	struct context *context;
+	int i;
 
 	if (!sym)
 		return;
-	fprintf(stderr, "%.*s%s%3d:%lu %lx %s (as: %d, context: %x:%x) %p (%s:%d:%d)\n",
+	fprintf(stderr, "%.*s%s%3d:%lu %lx %s (as: %d) %p (%s:%d:%d)\n",
 		indent, indent_string, typestr[sym->type],
 		sym->bit_size, sym->ctype.alignment,
-		sym->ctype.modifiers, show_ident(sym->ident),
-		sym->ctype.as, sym->ctype.in_context, sym->ctype.out_context,
+		sym->ctype.modifiers, show_ident(sym->ident), sym->ctype.as,
 		sym, stream_name(sym->pos.stream), sym->pos.line, sym->pos.pos);
+	i = 0;
+	FOR_EACH_PTR(sym->ctype.contexts, context) {
+		/* FIXME: should print context expression */
+		fprintf(stderr, "< context%d: in=%d, out=%d\n",
+			i, context->in, context->out);
+		fprintf(stderr, "  end context%d >\n", i);
+		i++;
+	} END_FOR_EACH_PTR(context);
 	if (sym->type == SYM_FN) {
-		int i = 1;
 		struct symbol *arg;
+		i = 0;
 		FOR_EACH_PTR(sym->arguments, arg) {
 			fprintf(stderr, "< arg%d:\n", i);
 			do_debug_symbol(arg, 0);
diff --git a/symbol.c b/symbol.c
index 4856349..1ebfd56 100644
--- a/symbol.c
+++ b/symbol.c
@@ -53,6 +53,11 @@ struct symbol *lookup_symbol(struct iden
 	return sym;
 }
 
+struct context *alloc_context(void)
+{
+	return __alloc_context(0);
+}
+
 struct symbol *alloc_symbol(struct position pos, int type)
 {
 	struct symbol *sym = __alloc_symbol(0);
@@ -247,8 +252,8 @@ void merge_type(struct symbol *sym, stru
 {
 	sym->ctype.as |= base_type->ctype.as;
 	sym->ctype.modifiers |= (base_type->ctype.modifiers & ~MOD_STORAGE);
-	sym->ctype.in_context += base_type->ctype.in_context;
-	sym->ctype.out_context += base_type->ctype.out_context;
+	concat_ptr_list((struct ptr_list *)base_type->ctype.contexts,
+	                (struct ptr_list **)&sym->ctype.contexts);
 	sym->ctype.base_type = base_type->ctype.base_type;
 }
 
diff --git a/symbol.h b/symbol.h
index a773a0a..9d939cf 100644
--- a/symbol.h
+++ b/symbol.h
@@ -55,10 +55,20 @@ enum type {
 	SYM_BAD,
 };
 
+struct context {
+	struct expression *context;
+	unsigned int in, out;
+};
+
+extern struct context *alloc_context(void);
+
+DECLARE_PTR_LIST(context_list, struct context);
+
 struct ctype {
 	unsigned long modifiers;
 	unsigned long alignment;
-	unsigned int in_context, out_context, as;
+	struct context_list *contexts;
+	unsigned int as;
 	struct symbol *base_type;
 };
 
-- 
1.4.1.1
