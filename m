From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 5] Add annotation for inline function call.
Date: Fri, 9 Feb 2007 16:19:12 -0800
Message-ID: <20070210001912.GD20644@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from [204.127.225.96] ([204.127.225.96]:64022 "EHLO
	alnrmhc16.comcast.net" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1946811AbXBJAr4 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 9 Feb 2007 19:47:56 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@freedesktop.org>


Sparse inline function body at evaluation. It very hard
to find out the original function call. This change try
to preserved the original call is preserved as annotation.

Index: sparse/parse.h
===================================================================
--- sparse.orig/parse.h	2007-02-01 00:55:07.000000000 -0800
+++ sparse/parse.h	2007-02-02 01:24:11.000000000 -0800
@@ -55,6 +55,8 @@ struct statement {
 		struct /* compound_struct */ {
 			struct statement_list *stmts;
 			struct symbol *ret;
+			struct symbol *inline_fn;
+			struct statement *args;
 		};
 		struct /* labeled_struct */ {
 			struct symbol *label_identifier;
Index: sparse/expression.h
===================================================================
Index: sparse/evaluate.c
===================================================================
--- sparse.orig/evaluate.c	2007-02-01 00:55:07.000000000 -0800
+++ sparse/evaluate.c	2007-02-02 01:24:11.000000000 -0800
@@ -2791,7 +2791,7 @@ struct symbol *evaluate_statement(struct
 		 * Then, evaluate each statement, making the type of the
 		 * compound statement be the type of the last statement
 		 */
-		type = NULL;
+		type = evaluate_statement(stmt->args);
 		FOR_EACH_PTR(stmt->stmts, s) {
 			type = evaluate_statement(s);
 		} END_FOR_EACH_PTR(s);
Index: sparse/inline.c
===================================================================
--- sparse.orig/inline.c	2007-02-01 00:55:07.000000000 -0800
+++ sparse/inline.c	2007-02-02 01:24:11.000000000 -0800
@@ -443,8 +443,9 @@ void copy_statement(struct statement *sr
 	FOR_EACH_PTR(src->stmts, stmt) {
 		add_statement(&dst->stmts, copy_one_statement(stmt));
 	} END_FOR_EACH_PTR(stmt);
-
+	dst->args = copy_one_statement(src->args);
 	dst->ret = copy_symbol(src->pos, src->ret);
+	dst->inline_fn = src->inline_fn;
 }
 
 static struct symbol *create_copy_symbol(struct symbol *orig)
@@ -489,6 +490,7 @@ int inline_function(struct expression *e
 	}
 	if (fn->expanding)
 		return 0;
+
 	fn->expanding = 1;
 
 	name_list = fn->arguments;
@@ -517,13 +519,14 @@ int inline_function(struct expression *e
 	} END_FOR_EACH_PTR(arg);
 	FINISH_PTR_LIST(name);
 
+	copy_statement(fn->inline_stmt, stmt);
+
 	if (arg_decl) {
 		struct statement *decl = alloc_statement(expr->pos, STMT_DECLARATION);
 		decl->declaration = arg_decl;
-		add_statement(&stmt->stmts, decl);
+		stmt->args = decl;
 	}
-
-	copy_statement(fn->inline_stmt, stmt);
+	stmt->inline_fn = sym;
 
 	unset_replace_list(fn_symbol_list);
 
Index: sparse/expand.c
===================================================================
--- sparse.orig/expand.c	2007-02-01 00:55:07.000000000 -0800
+++ sparse/expand.c	2007-02-02 01:24:11.000000000 -0800
@@ -1053,9 +1053,9 @@ static int expand_compound(struct statem
 	if (stmt->ret)
 		expand_symbol(stmt->ret);
 
-	cost = 0;
-	last = NULL;
-	statements = 0;
+	last = stmt->args;
+	cost = expand_statement(last);
+	statements = last != NULL;
 	FOR_EACH_PTR(stmt->stmts, s) {
 		statements++;
 		last = s;
Index: sparse/show-parse.c
===================================================================
--- sparse.orig/show-parse.c	2007-02-01 00:55:07.000000000 -0800
+++ sparse/show-parse.c	2007-02-02 01:24:11.000000000 -0800
@@ -485,6 +485,10 @@ int show_statement(struct statement *stm
 		struct statement *s;
 		int last = 0;
 
+		if (stmt->inline_fn) {
+			show_statement(stmt->args);
+			printf("\tbegin_inline \t%s\n", show_ident(stmt->inline_fn->ident));
+		}
 		FOR_EACH_PTR(stmt->stmts, s) {
 			last = show_statement(s);
 		} END_FOR_EACH_PTR(s);
@@ -496,6 +500,8 @@ int show_statement(struct statement *stm
 			last = new_pseudo();
 			printf("\tld.%d\t\tv%d,[v%d]\n", bits, last, addr);
 		}
+		if (stmt->inline_fn)
+			printf("\tend_inlined\t%s\n", show_ident(stmt->inline_fn->ident));
 		return last;
 	}
 
Index: sparse/linearize.h
===================================================================
--- sparse.orig/linearize.h	2007-02-01 00:55:07.000000000 -0800
+++ sparse/linearize.h	2007-02-02 01:24:11.000000000 -0800
@@ -196,6 +196,7 @@ enum opcode {
 	OP_SCAST,
 	OP_FPCAST,
 	OP_PTRCAST,
+	OP_INLINED_CALL,
 	OP_CALL,
 	OP_VANEXT,
 	OP_VAARG,
Index: sparse/linearize.c
===================================================================
--- sparse.orig/linearize.c	2007-02-02 01:23:59.000000000 -0800
+++ sparse/linearize.c	2007-02-02 01:24:11.000000000 -0800
@@ -27,11 +27,11 @@ pseudo_t linearize_expression(struct ent
 
 static pseudo_t add_binary_op(struct entrypoint *ep, struct symbol *ctype, int op, pseudo_t left, pseudo_t right);
 static pseudo_t add_setval(struct entrypoint *ep, struct symbol *ctype, struct expression *val);
-static void linearize_one_symbol(struct entrypoint *ep, struct symbol *sym);
+static pseudo_t linearize_one_symbol(struct entrypoint *ep, struct symbol *sym);
 
 struct access_data;
 static pseudo_t add_load(struct entrypoint *ep, struct access_data *);
-pseudo_t linearize_initializer(struct entrypoint *ep, struct expression *initializer, struct access_data *);
+static pseudo_t linearize_initializer(struct entrypoint *ep, struct expression *initializer, struct access_data *);
 
 struct pseudo void_pseudo = {};
 
@@ -226,6 +226,7 @@ static const char *opcodes[] = {
 	[OP_SCAST] = "scast",
 	[OP_FPCAST] = "fpcast",
 	[OP_PTRCAST] = "ptrcast",
+	[OP_INLINED_CALL] = "# call",
 	[OP_CALL] = "call",
 	[OP_VANEXT] = "va_next",
 	[OP_VAARG] = "va_arg",
@@ -399,6 +400,7 @@ const char *show_instruction(struct inst
 	case OP_STORE: case OP_SNOP:
 		buf += sprintf(buf, "%s -> %d[%s]", show_pseudo(insn->target), insn->offset, show_pseudo(insn->src));
 		break;
+	case OP_INLINED_CALL:
 	case OP_CALL: {
 		struct pseudo *arg;
 		if (insn->target && insn->target != VOID)
@@ -1487,7 +1489,7 @@ static pseudo_t linearize_position(struc
 	return linearize_initializer(ep, init_expr, ad);
 }
 
-pseudo_t linearize_initializer(struct entrypoint *ep, struct expression *initializer, struct access_data *ad)
+static pseudo_t linearize_initializer(struct entrypoint *ep, struct expression *initializer, struct access_data *ad)
 {
 	switch (initializer->type) {
 	case EXPR_INITIALIZER: {
@@ -1505,6 +1507,7 @@ pseudo_t linearize_initializer(struct en
 		ad->source_type = base_type(initializer->ctype);
 		ad->result_type = initializer->ctype;
 		linearize_store_gen(ep, value, ad);
+		return value;
 	}
 	}
 
@@ -1595,21 +1598,23 @@ pseudo_t linearize_expression(struct ent
 	return VOID;
 }
 
-static void linearize_one_symbol(struct entrypoint *ep, struct symbol *sym)
+static pseudo_t linearize_one_symbol(struct entrypoint *ep, struct symbol *sym)
 {
 	struct access_data ad = { NULL, };
+	pseudo_t value;
 
 	if (!sym || !sym->initializer || sym->initialized)
-		return;
+		return VOID;
 
 	/* We need to output these puppies some day too.. */
 	if (sym->ctype.modifiers & (MOD_STATIC | MOD_TOPLEVEL))
-		return;
+		return VOID;
 
 	sym->initialized = 1;
 	ad.address = symbol_pseudo(ep, sym);
-	linearize_initializer(ep, sym->initializer, &ad);
+	value = linearize_initializer(ep, sym->initializer, &ad);
 	finish_address_gen(ep, &ad);
+	return value;
 }
 
 static pseudo_t linearize_compound_statement(struct entrypoint *ep, struct statement *stmt)
@@ -1637,6 +1642,29 @@ static pseudo_t linearize_compound_state
 		}
 		return phi_node->target;
 	}
+
+	return pseudo;
+}
+
+static pseudo_t linearize_inlined_call(struct entrypoint *ep, struct statement *stmt)
+{
+	struct instruction *insn = alloc_instruction(OP_INLINED_CALL, 0);
+	struct statement *args = stmt->args;
+	pseudo_t pseudo;
+
+	if (args) {
+		struct symbol *sym;
+
+		concat_symbol_list(args->declaration, &ep->syms);
+		FOR_EACH_PTR(args->declaration, sym) {
+			pseudo_t value = linearize_one_symbol(ep, sym);
+			use_pseudo(insn, value, add_pseudo(&insn->arguments, value));
+		} END_FOR_EACH_PTR(sym);
+	}
+
+	insn->target = pseudo = linearize_compound_statement(ep, stmt);
+	use_pseudo(insn, symbol_pseudo(ep, stmt->inline_fn), &insn->func);
+	add_one_insn(ep, insn);
 	return pseudo;
 }
 
@@ -1920,6 +1948,8 @@ pseudo_t linearize_statement(struct entr
 	}
 
 	case STMT_COMPOUND:
+		if (stmt->inline_fn)
+			return linearize_inlined_call(ep, stmt);
 		return linearize_compound_statement(ep, stmt);
 
 	/*
