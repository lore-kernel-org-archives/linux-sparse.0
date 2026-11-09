Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256442;
	b=nZkRKR/3zFYrpda8M+7YLfpKz3jkxNBjUPYYj2Wg31zLGbPLHD1DXT43IZz3f1dn1Wko
	 Mf7elLwG5E152k++sTsYSUzDh4TIDou4vFMU+RrCVK8RMt+ekcJ9MYA2AcLqAHVSWoyLZ
	 5d8MLAoksz8WGCHa8gvnLxAsLkltd34SfhmPFcF6esnxo2cXeY+pIInDTEyMI6zUXuo+6
	 o/VEKxuAOQ0vBE2L8NOZ0sTdpBCBBiqp6pXm/+x/DicjI62dwB4iUM9jNewmSTqm16S3/
	 yMCYeSgQFi6oijSvZcsWPHKWqY2Lds9VDoD2RU4Rwb/GLwTZiqo0maqKzrx5ASo+OyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256442;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=qnC43Z5ekLdUSPHXPBh4PoB2mN3DlyRgxGPkEtnanYY=;
	b=2/0CLOPrGCnD9+ZlGiKqvrW3NHp7dp/STJiM/1x5lSikH7w87XnlOy1qs+/2qI9hYWiV
	 8+uufbLyORWmrI/5t+nA0ti0/V1kb8b5bSsBAwIJtYzarWToPX/hjARGEauMFid7mT3q6
	 HjUYi2Oc0mRDa4hADL6Ign1J/K23YzHHC6U8RRZiM/FxsOvWaRNACLD5nrXLzh7T5QOpL
	 ZwJ1KuqTbRq88n3nKSzdfkdEAPdHrwBY+WTK8WsWEHjWeUd4wAwlzlQPZIJpmLpNE0V0P
	 14gBl5Yof4amWB16OuiSUy19jWZbJjwU0SR+zSM6oUOxaDRPeIS6zOfMnr4YUdDfDNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=P8saDP4T;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F343606A326
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F343606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=P8saDP4T
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhMV6H5Vz1XM4Tn;
	Mon,  9 Nov 2026 20:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256419; x=1796848420; bh=qnC43
	Z5ekLdUSPHXPBh4PoB2mN3DlyRgxGPkEtnanYY=; b=P8saDP4TwZ1sPewF3mrhL
	LTd9YUjsFnHgb+oDUMXDgz6x9RCph03hlZFjghz/TQLegK+fpIo7lveeK88s52ez
	NZ+N5odec8eLBnTHECcPt0K8G8nxVvs2bh79pbX1NalLjeG2pfIqNBKNurRdA6LB
	7XEakUnxKZCLnsoNxsBweYl/OsUEfKPnIdE/YomcbiphCTZPU4tkuoSNqTtsf/MF
	hc3G9EDOLz4f8UaxiJER8IVAvNRZX9KqIxwj7rDRX0nMmocwOgC16k/zex526IsQ
	zR4/G6jm3D+NghsiORXAUeHu+hQjErJhGAkwuyfchPRE0QzUVLiOx6eup1wBeNV2
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id KmOLPE4VHKfD; Mon,  9 Nov 2026 20:33:39 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM72xZTz1XMfrk;
	Mon,  9 Nov 2026 20:33:39 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 68/73] cleanup: Support __attribute__((cleanup(...))) in linearize and -Wcontext
Date: Mon,  9 Nov 2026 12:32:54 -0800
Message-ID: <20261109203259.362845-69-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109203259.362845-1-bvanassche@acm.org>
References: <20261109203259.362845-1-bvanassche@acm.org>
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Post: <mailto:linux-sparse@vger.kernel.org>
List-Help: <mailto:linux-sparse+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sparse+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Implement evaluation and linearization for __attribute__((cleanup(...)))
so that scope-based resource management in the Linux kernel (such as
guard(mutex)(&lock), scoped_guard, and __free(...) in
include/linux/cleanup.h) is modeled accurately by -Wcontext:
- Validate in parse.c and evaluate.c that the cleanup attribute names a
  function, applies only to local automatic variables, and type-checks
  calls to fn(&var).
- Maintain a lexical cleanup_scope tree in linearize.c across compound
  statements, declarations, iterators, and switches, and record cleanup
  variables as their declarations are linearized.
- Emit cleanup calls in reverse declaration order (LIFO) on block exit,
  loop/switch break and continue, goto, and return after evaluating the
  return expression.
- Copy expanded cleanup expressions correctly in inline.c: handle
  statement expressions that expand_compound() collapsed into a single
  non-compound statement and preserve the constraint flags of asm
  operands since cleanup expressions are not re-evaluated after copying.

Add validation tests in validation/cleanup-context.c,
validation/cleanup-errors.c, validation/cleanup-inline-loop.c,
validation/linear/cleanup-control-flow.c, and
validation/linear/cleanup-stmt-expr-asm.c.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 evaluate.c                                |  38 ++
 expand.c                                  |   8 +-
 inline.c                                  | 218 +++++++++-
 linearize.c                               | 478 +++++++++++++++++++++-
 linearize.h                               |   4 +
 parse.c                                   |  22 +-
 parse.h                                   |   4 +
 symbol.h                                  |   1 +
 validation/cleanup-context.c              | 161 ++++++++
 validation/cleanup-errors.c               |  77 ++++
 validation/cleanup-inline-loop.c          |  31 ++
 validation/linear/cleanup-control-flow.c  |  62 +++
 validation/linear/cleanup-stmt-expr-asm.c |  48 +++
 13 files changed, 1129 insertions(+), 23 deletions(-)
 create mode 100644 validation/cleanup-context.c
 create mode 100644 validation/cleanup-errors.c
 create mode 100644 validation/cleanup-inline-loop.c
 create mode 100644 validation/linear/cleanup-control-flow.c
 create mode 100644 validation/linear/cleanup-stmt-expr-asm.c

diff --git a/evaluate.c b/evaluate.c
index 27bfe1c0fe88..6e1be32f929f 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -4236,6 +4236,41 @@ static bool has_invalid_constexpr_qualifiers(struc=
t symbol *type)
 	return false;
 }
=20
+static void evaluate_cleanup(struct symbol *sym)
+{
+	struct expression *var_expr, *addr_expr, *fn_expr, *call;
+
+	if (!sym->cleanup || sym->cleanup->type !=3D EXPR_SYMBOL)
+		return;
+
+	if (sym->ctype.modifiers & (MOD_TOPLEVEL | MOD_STATIC | MOD_EXTERN)) {
+		sparse_error(sym->pos, "cleanup attribute may only be applied to local=
 variables");
+		sym->cleanup =3D NULL;
+		return;
+	}
+
+	var_expr =3D alloc_expression(sym->pos, EXPR_SYMBOL);
+	var_expr->symbol =3D sym;
+	var_expr->symbol_name =3D sym->ident;
+	evaluate_expression(var_expr);
+
+	addr_expr =3D alloc_expression(sym->pos, EXPR_PREOP);
+	addr_expr->op =3D '&';
+	addr_expr->unop =3D var_expr;
+	evaluate_expression(addr_expr);
+
+	fn_expr =3D alloc_expression(sym->cleanup->pos, EXPR_SYMBOL);
+	fn_expr->symbol =3D sym->cleanup->symbol;
+	fn_expr->symbol_name =3D sym->cleanup->symbol_name;
+
+	call =3D alloc_expression(sym->pos, EXPR_CALL);
+	call->fn =3D fn_expr;
+	add_expression(&call->args, addr_expr);
+	evaluate_call(call);
+
+	sym->cleanup =3D call;
+}
+
 static struct symbol *evaluate_symbol(struct symbol *sym)
 {
 	struct symbol *base_type;
@@ -4276,6 +4311,9 @@ static struct symbol *evaluate_symbol(struct symbol=
 *sym)
 			sym->underspecified =3D 0;
 	}
=20
+	if (sym->cleanup)
+		evaluate_cleanup(sym);
+
 	/* And finally, evaluate the body of the symbol too */
 	if (base_type->type =3D=3D SYM_FN) {
 		struct symbol *curr =3D current_fn;
diff --git a/expand.c b/expand.c
index 696662ad11ea..5c3777ff3a23 100644
--- a/expand.c
+++ b/expand.c
@@ -1736,6 +1736,7 @@ int expand_symbol(struct symbol *sym)
 		return 0;
=20
 	retval =3D expand_expression(sym->initializer);
+	expand_expression(sym->cleanup);
 	/* expand the body of the symbol */
 	if (base_type->type =3D=3D SYM_FN) {
 		if (base_type->stmt)
@@ -1856,13 +1857,18 @@ static int expand_statement(struct statement *stm=
t)
 	case STMT_IF:
 		return expand_if_statement(stmt);
=20
-	case STMT_ITERATOR:
+	case STMT_ITERATOR: {
+		struct symbol *sym;
+		FOR_EACH_PTR(stmt->iterator_syms, sym) {
+			expand_symbol(sym);
+		} END_FOR_EACH_PTR(sym);
 		expand_expression(stmt->iterator_pre_condition);
 		expand_expression(stmt->iterator_post_condition);
 		expand_statement(stmt->iterator_pre_statement);
 		expand_statement(stmt->iterator_statement);
 		expand_statement(stmt->iterator_post_statement);
 		return SIDE_EFFECTS;
+	}
=20
 	case STMT_SWITCH:
 		expand_expression(stmt->switch_expression);
diff --git a/inline.c b/inline.c
index c857cd953702..4fa087098160 100644
--- a/inline.c
+++ b/inline.c
@@ -35,7 +35,9 @@
 #include "evaluate.h"
=20
 static void copy_statement(struct statement *src, struct statement *dst)=
;
+static struct statement *copy_one_statement(struct statement *stmt);
 static struct expression *copy_expression(struct expression *expr);
+static bool copy_allow_unreplaced;
=20
 static struct expression * dup_expression(struct expression *expr)
 {
@@ -48,6 +50,7 @@ static struct statement * dup_statement(struct statemen=
t *stmt)
 {
 	struct statement *dup =3D alloc_statement(stmt->pos, stmt->type);
 	*dup =3D *stmt;
+	dup->cleanup_scope =3D NULL;
 	return dup;
 }
=20
@@ -58,7 +61,8 @@ static struct symbol *copy_symbol(struct position pos, =
struct symbol *sym)
 	if (sym->ctype.modifiers & (MOD_STATIC | MOD_EXTERN | MOD_TOPLEVEL | MO=
D_INLINE))
 		return sym;
 	if (!sym->replace) {
-		warning(pos, "unreplaced symbol '%s'", show_ident(sym->ident));
+		if (!copy_allow_unreplaced)
+			warning(pos, "unreplaced symbol '%s'", show_ident(sym->ident));
 		return sym;
 	}
 	return sym->replace;
@@ -77,7 +81,7 @@ static struct symbol *copy_type(struct symbol *type)
 		n =3D alloc_symbol(type->pos, SYM_NODE);
 		*n =3D *type;
 		n->ctype.base_type =3D base;
-		if (base && base->bit_size < 0)
+		if (!copy_allow_unreplaced && base && base->bit_size < 0)
 			n->examined =3D 0;
 		return n;
 	}
@@ -91,7 +95,8 @@ static struct symbol *copy_type(struct symbol *type)
 		*arr =3D *type;
 		arr->ctype.base_type =3D elem;
 		arr->array_size =3D size;
-		if (type->array_size || elem !=3D type->ctype.base_type)
+		if (!copy_allow_unreplaced &&
+		    (type->array_size || elem !=3D type->ctype.base_type))
 			arr->examined =3D 0;
 		return arr;
 	}
@@ -114,7 +119,8 @@ static struct symbol *copy_type(struct symbol *type)
 		t =3D alloc_symbol(type->pos, type->type);
 		*t =3D *type;
 		t->initializer =3D init;
-		t->examined =3D 0;
+		if (!copy_allow_unreplaced)
+			t->examined =3D 0;
 		return t;
 	}
 	default:
@@ -265,8 +271,20 @@ static struct expression * copy_expression(struct ex=
pression *expr)
=20
 	/* Statement expression */
 	case EXPR_STATEMENT: {
-		struct statement *stmt =3D alloc_statement(expr->pos, STMT_COMPOUND);
-		copy_statement(expr->statement, stmt);
+		struct statement *stmt;
+
+		/*
+		 * expand_compound() collapses a compound statement that
+		 * contains a single statement into that statement. Hence,
+		 * after expansion, the statement of a statement expression
+		 * is not necessarily a compound statement.
+		 */
+		if (expr->statement->type =3D=3D STMT_COMPOUND) {
+			stmt =3D alloc_statement(expr->pos, STMT_COMPOUND);
+			copy_statement(expr->statement, stmt);
+		} else {
+			stmt =3D copy_one_statement(expr->statement);
+		}
 		expr =3D dup_expression(expr);
 		expr->statement =3D stmt;
 		break;
@@ -382,7 +400,11 @@ static struct asm_operand_list *copy_asm_operands(st=
ruct asm_operand_list *in)
=20
 	FOR_EACH_PTR(in, old) {
 		struct asm_operand *new =3D __alloc_asm_operand(0);
-		new->name =3D old->name;
+		/*
+		 * Copy the constraint flags too since cleanup expressions
+		 * are copied after evaluation and are not re-evaluated.
+		 */
+		*new =3D *old;
 		new->constraint =3D copy_expression(old->constraint);
 		new->expr =3D copy_expression(old->expr);
 		add_ptr_list(&out, new);
@@ -431,6 +453,7 @@ static struct statement *copy_one_statement(struct st=
atement *stmt)
 			if (newsym !=3D sym) {
 				newsym->ctype.base_type =3D copy_type(newsym->ctype.base_type);
 				newsym->initializer =3D copy_expression(sym->initializer);
+				newsym->cleanup =3D copy_expression(sym->cleanup);
 			}
 			add_symbol(&newstmt->declaration, newsym);
 		} END_FOR_EACH_PTR(sym);
@@ -522,6 +545,7 @@ static struct statement *copy_one_statement(struct st=
atement *stmt)
 			if (newsym !=3D sym) {
 				newsym->ctype.base_type =3D copy_type(newsym->ctype.base_type);
 				newsym->initializer =3D copy_expression(sym->initializer);
+				newsym->cleanup =3D copy_expression(sym->cleanup);
 			}
 			add_symbol(&stmt->iterator_syms, newsym);
 		} END_FOR_EACH_PTR(sym);
@@ -591,6 +615,7 @@ static struct symbol *create_copy_symbol(struct symbo=
l *orig)
 		*sym =3D *orig;
 		sym->bb_target =3D NULL;
 		sym->pseudo =3D NULL;
+		sym->cleanup_scope =3D NULL;
 		set_replace(orig, sym);
 		orig =3D sym;
 	}
@@ -609,6 +634,184 @@ static struct symbol_list *create_symbol_list(struc=
t symbol_list *src)
 	return dst;
 }
=20
+static void collect_stmt_local_symbols(struct statement *stmt, struct sy=
mbol_list **list);
+
+static void register_local_sym(struct symbol *sym, struct symbol_list **=
list)
+{
+	if (!sym || sym->replace)
+		return;
+	if (sym->ctype.modifiers & (MOD_STATIC | MOD_EXTERN | MOD_TOPLEVEL | MO=
D_INLINE))
+		return;
+	add_symbol(list, create_copy_symbol(sym));
+}
+
+static void collect_expr_local_symbols(struct expression *expr, struct s=
ymbol_list **list)
+{
+	if (!expr)
+		return;
+	switch (expr->type) {
+	case EXPR_STATEMENT:
+		collect_stmt_local_symbols(expr->statement, list);
+		break;
+	case EXPR_PREOP:
+	case EXPR_POSTOP:
+		collect_expr_local_symbols(expr->unop, list);
+		break;
+	case EXPR_SLICE:
+		collect_expr_local_symbols(expr->base, list);
+		break;
+	case EXPR_BINOP:
+	case EXPR_COMMA:
+	case EXPR_COMPARE:
+	case EXPR_LOGICAL:
+	case EXPR_ASSIGNMENT:
+		collect_expr_local_symbols(expr->left, list);
+		collect_expr_local_symbols(expr->right, list);
+		break;
+	case EXPR_DEREF:
+		collect_expr_local_symbols(expr->deref, list);
+		break;
+	case EXPR_CAST:
+	case EXPR_FORCE_CAST:
+	case EXPR_IMPLIED_CAST:
+	case EXPR_SIZEOF:
+	case EXPR_PTRSIZEOF:
+	case EXPR_ALIGNOF:
+		collect_expr_local_symbols(expr->cast_expression, list);
+		break;
+	case EXPR_SELECT:
+	case EXPR_CONDITIONAL:
+		collect_expr_local_symbols(expr->conditional, list);
+		collect_expr_local_symbols(expr->cond_true, list);
+		collect_expr_local_symbols(expr->cond_false, list);
+		break;
+	case EXPR_CALL: {
+		struct expression *arg;
+		collect_expr_local_symbols(expr->fn, list);
+		FOR_EACH_PTR(expr->args, arg) {
+			collect_expr_local_symbols(arg, list);
+		} END_FOR_EACH_PTR(arg);
+		break;
+	}
+	case EXPR_INITIALIZER: {
+		struct expression *entry;
+		FOR_EACH_PTR(expr->expr_list, entry) {
+			collect_expr_local_symbols(entry, list);
+		} END_FOR_EACH_PTR(entry);
+		break;
+	}
+	case EXPR_INDEX:
+		collect_expr_local_symbols(expr->idx_expression, list);
+		break;
+	case EXPR_IDENTIFIER:
+		collect_expr_local_symbols(expr->ident_expression, list);
+		break;
+	case EXPR_POS:
+		collect_expr_local_symbols(expr->init_expr, list);
+		break;
+	default:
+		break;
+	}
+}
+
+static void collect_stmt_local_symbols(struct statement *stmt, struct sy=
mbol_list **list)
+{
+	struct symbol *sym;
+
+	if (!stmt)
+		return;
+	switch (stmt->type) {
+	case STMT_COMPOUND: {
+		struct statement *s;
+		register_local_sym(stmt->ret, list);
+		collect_stmt_local_symbols(stmt->args, list);
+		FOR_EACH_PTR(stmt->stmts, s) {
+			collect_stmt_local_symbols(s, list);
+		} END_FOR_EACH_PTR(s);
+		break;
+	}
+	case STMT_DECLARATION:
+		FOR_EACH_PTR(stmt->declaration, sym) {
+			register_local_sym(sym, list);
+			collect_expr_local_symbols(sym->initializer, list);
+			collect_expr_local_symbols(sym->cleanup, list);
+		} END_FOR_EACH_PTR(sym);
+		break;
+	case STMT_ITERATOR:
+		register_local_sym(stmt->iterator_break, list);
+		register_local_sym(stmt->iterator_continue, list);
+		FOR_EACH_PTR(stmt->iterator_syms, sym) {
+			register_local_sym(sym, list);
+			collect_expr_local_symbols(sym->initializer, list);
+			collect_expr_local_symbols(sym->cleanup, list);
+		} END_FOR_EACH_PTR(sym);
+		collect_stmt_local_symbols(stmt->iterator_pre_statement, list);
+		collect_expr_local_symbols(stmt->iterator_pre_condition, list);
+		collect_stmt_local_symbols(stmt->iterator_statement, list);
+		collect_stmt_local_symbols(stmt->iterator_post_statement, list);
+		collect_expr_local_symbols(stmt->iterator_post_condition, list);
+		break;
+	case STMT_SWITCH:
+		register_local_sym(stmt->switch_break, list);
+		register_local_sym(stmt->switch_case, list);
+		collect_expr_local_symbols(stmt->switch_expression, list);
+		collect_stmt_local_symbols(stmt->switch_statement, list);
+		break;
+	case STMT_CASE:
+		register_local_sym(stmt->case_label, list);
+		collect_stmt_local_symbols(stmt->case_statement, list);
+		break;
+	case STMT_LABEL:
+		register_local_sym(stmt->label_identifier, list);
+		collect_stmt_local_symbols(stmt->label_statement, list);
+		break;
+	case STMT_IF:
+		collect_expr_local_symbols(stmt->if_conditional, list);
+		collect_stmt_local_symbols(stmt->if_true, list);
+		collect_stmt_local_symbols(stmt->if_false, list);
+		break;
+	case STMT_EXPRESSION:
+	case STMT_CONTEXT:
+		collect_expr_local_symbols(stmt->expression, list);
+		break;
+	case STMT_RETURN:
+		collect_expr_local_symbols(stmt->ret_value, list);
+		break;
+	case STMT_GOTO:
+		collect_expr_local_symbols(stmt->goto_expression, list);
+		break;
+	case STMT_ASM: {
+		struct asm_operand *op;
+		FOR_EACH_PTR(stmt->asm_inputs, op) {
+			collect_expr_local_symbols(op->expr, list);
+		} END_FOR_EACH_PTR(op);
+		FOR_EACH_PTR(stmt->asm_outputs, op) {
+			collect_expr_local_symbols(op->expr, list);
+		} END_FOR_EACH_PTR(op);
+		break;
+	}
+	default:
+		break;
+	}
+}
+
+struct expression *copy_cleanup_expression(struct expression *expr)
+{
+	struct symbol_list *syms =3D NULL;
+	struct expression *dup;
+
+	if (!expr || expr->type !=3D EXPR_STATEMENT)
+		return expr;
+
+	collect_expr_local_symbols(expr, &syms);
+	copy_allow_unreplaced =3D true;
+	dup =3D copy_expression(expr);
+	copy_allow_unreplaced =3D false;
+	unset_replace_list(syms);
+	free_ptr_list(&syms);
+	return dup;
+}
+
 int inline_function(struct expression *expr, struct symbol *sym)
 {
 	struct symbol_list * fn_symbol_list;
@@ -641,6 +844,7 @@ int inline_function(struct expression *expr, struct s=
ymbol *sym)
 			*a =3D *name;
 			a->bb_target =3D NULL;
 			a->pseudo =3D NULL;
+			a->cleanup_scope =3D NULL;
 			set_replace(name, a);
 			add_symbol(&fn_symbol_list, a);
 			a->initializer =3D arg;
diff --git a/linearize.c b/linearize.c
index f43502577649..9d36415551d6 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2039,16 +2039,383 @@ static pseudo_t linearize_one_symbol(struct entr=
ypoint *ep, struct symbol *sym)
 	return value;
 }
=20
+struct cleanup_scope {
+	struct cleanup_scope *parent;
+	struct statement *stmt;
+	struct symbol_list *cleanups;
+	int depth;
+};
+
+ALLOCATOR(cleanup_scope, "cleanup scope");
+
+static inline struct cleanup_scope *alloc_cleanup_scope(struct cleanup_s=
cope *parent, struct statement *stmt)
+{
+	struct cleanup_scope *scope =3D __alloc_cleanup_scope(0);
+	scope->parent =3D parent;
+	scope->stmt =3D stmt;
+	scope->cleanups =3D NULL;
+	scope->depth =3D parent ? parent->depth + 1 : 0;
+	return scope;
+}
+
+static struct cleanup_scope *cleanup_scope_lca(struct cleanup_scope *s1,=
 struct cleanup_scope *s2)
+{
+	if (!s1 || !s2)
+		return NULL;
+	while (s1->depth > s2->depth)
+		s1 =3D s1->parent;
+	while (s2->depth > s1->depth)
+		s2 =3D s2->parent;
+	while (s1 && s2 && s1 !=3D s2) {
+		s1 =3D s1->parent;
+		s2 =3D s2->parent;
+	}
+	return s1;
+}
+
+static struct symbol *first_cleanup_decl(struct symbol_list *list)
+{
+	struct symbol *sym;
+
+	FOR_EACH_PTR(list, sym) {
+		if (sym->cleanup)
+			return sym;
+	} END_FOR_EACH_PTR(sym);
+	return NULL;
+}
+
+static bool has_cleanup_decl(struct symbol_list *list)
+{
+	return first_cleanup_decl(list) !=3D NULL;
+}
+
+static struct symbol *bypasses_cleanup_decl(struct cleanup_scope *from, =
struct cleanup_scope *to)
+{
+	struct cleanup_scope *lca =3D cleanup_scope_lca(from, to);
+	struct cleanup_scope *s;
+
+	for (s =3D to; s && s !=3D lca; s =3D s->parent) {
+		if (!s->stmt)
+			continue;
+		if (s->stmt->type =3D=3D STMT_DECLARATION) {
+			struct symbol *sym =3D first_cleanup_decl(s->stmt->declaration);
+			if (sym)
+				return sym;
+		} else if (s->stmt->type =3D=3D STMT_ITERATOR) {
+			struct symbol *sym =3D first_cleanup_decl(s->stmt->iterator_syms);
+			if (sym)
+				return sym;
+		}
+	}
+	return NULL;
+}
+
+static int count_cleanups_to(struct cleanup_scope *from, struct cleanup_=
scope *to)
+{
+	struct cleanup_scope *s;
+	int count =3D 0;
+
+	for (s =3D from; s && s !=3D to; s =3D s->parent)
+		count +=3D symbol_list_size(s->cleanups);
+	return count;
+}
+
+static void prepare_expr_cleanup_scopes(struct expression *expr, struct =
cleanup_scope *parent);
+
+static void prepare_cleanup_scopes(struct statement *stmt, struct cleanu=
p_scope *parent)
+{
+	if (!stmt)
+		return;
+
+	switch (stmt->type) {
+	case STMT_COMPOUND: {
+		struct cleanup_scope *scope =3D stmt->cleanup_scope;
+		struct cleanup_scope *cur;
+		struct statement *s;
+		if (!scope) {
+			scope =3D alloc_cleanup_scope(parent, stmt);
+			stmt->cleanup_scope =3D scope;
+		} else {
+			scope->parent =3D parent;
+			scope->depth =3D parent ? parent->depth + 1 : 0;
+			scope->cleanups =3D NULL;
+		}
+		if (stmt->ret) {
+			stmt->ret->cleanup_scope =3D parent;
+			stmt->ret->bb_target =3D NULL;
+		}
+		if (stmt->args)
+			prepare_cleanup_scopes(stmt->args, scope);
+		cur =3D scope;
+		FOR_EACH_PTR(stmt->stmts, s) {
+			struct statement *inner =3D s;
+			prepare_cleanup_scopes(s, cur);
+			while (inner && (inner->type =3D=3D STMT_LABEL || inner->type =3D=3D =
STMT_CASE))
+				inner =3D (inner->type =3D=3D STMT_LABEL) ? inner->label_statement :=
 inner->case_statement;
+			if (inner && inner->type =3D=3D STMT_DECLARATION && inner->cleanup_sc=
ope)
+				cur =3D inner->cleanup_scope;
+		} END_FOR_EACH_PTR(s);
+		break;
+	}
+	case STMT_DECLARATION: {
+		struct cleanup_scope *scope =3D NULL;
+		struct symbol *sym;
+
+		if (has_cleanup_decl(stmt->declaration)) {
+			scope =3D stmt->cleanup_scope;
+			if (!scope) {
+				scope =3D alloc_cleanup_scope(parent, stmt);
+				stmt->cleanup_scope =3D scope;
+			} else {
+				scope->parent =3D parent;
+				scope->depth =3D parent ? parent->depth + 1 : 0;
+				scope->cleanups =3D NULL;
+			}
+		}
+		FOR_EACH_PTR(stmt->declaration, sym) {
+			sym->initialized =3D 0;
+			prepare_expr_cleanup_scopes(sym->initializer,
+						    scope ? scope : parent);
+		} END_FOR_EACH_PTR(sym);
+		break;
+	}
+	case STMT_SWITCH: {
+		struct cleanup_scope *scope =3D stmt->cleanup_scope;
+		if (!scope) {
+			scope =3D alloc_cleanup_scope(parent, stmt);
+			stmt->cleanup_scope =3D scope;
+		} else {
+			scope->parent =3D parent;
+			scope->depth =3D parent ? parent->depth + 1 : 0;
+			scope->cleanups =3D NULL;
+		}
+		if (stmt->switch_break) {
+			stmt->switch_break->cleanup_scope =3D parent;
+			stmt->switch_break->bb_target =3D NULL;
+		}
+		if (stmt->switch_case) {
+			struct symbol *sym;
+			FOR_EACH_PTR(stmt->switch_case->symbol_list, sym) {
+				sym->bb_target =3D NULL;
+			} END_FOR_EACH_PTR(sym);
+		}
+		prepare_expr_cleanup_scopes(stmt->switch_expression, parent);
+		prepare_cleanup_scopes(stmt->switch_statement, scope);
+		break;
+	}
+	case STMT_ITERATOR: {
+		struct cleanup_scope *scope =3D stmt->cleanup_scope;
+		struct symbol *sym;
+		if (!scope) {
+			scope =3D alloc_cleanup_scope(parent, stmt);
+			stmt->cleanup_scope =3D scope;
+		} else {
+			scope->parent =3D parent;
+			scope->depth =3D parent ? parent->depth + 1 : 0;
+			scope->cleanups =3D NULL;
+		}
+		if (stmt->iterator_break) {
+			stmt->iterator_break->cleanup_scope =3D scope;
+			stmt->iterator_break->bb_target =3D NULL;
+		}
+		if (stmt->iterator_continue) {
+			stmt->iterator_continue->cleanup_scope =3D scope;
+			stmt->iterator_continue->bb_target =3D NULL;
+		}
+		FOR_EACH_PTR(stmt->iterator_syms, sym) {
+			sym->initialized =3D 0;
+			prepare_expr_cleanup_scopes(sym->initializer, scope);
+		} END_FOR_EACH_PTR(sym);
+		prepare_cleanup_scopes(stmt->iterator_pre_statement, scope);
+		prepare_expr_cleanup_scopes(stmt->iterator_pre_condition, scope);
+		prepare_cleanup_scopes(stmt->iterator_statement, scope);
+		prepare_cleanup_scopes(stmt->iterator_post_statement, scope);
+		prepare_expr_cleanup_scopes(stmt->iterator_post_condition, scope);
+		break;
+	}
+	case STMT_LABEL: {
+		struct symbol *label =3D stmt->label_identifier;
+		if (label) {
+			label->cleanup_scope =3D parent;
+			label->bb_target =3D NULL;
+		}
+		prepare_cleanup_scopes(stmt->label_statement, parent);
+		break;
+	}
+	case STMT_CASE:
+		if (stmt->case_label) {
+			stmt->case_label->cleanup_scope =3D parent;
+			stmt->case_label->bb_target =3D NULL;
+		}
+		prepare_expr_cleanup_scopes(stmt->case_expression, parent);
+		prepare_expr_cleanup_scopes(stmt->case_to, parent);
+		prepare_cleanup_scopes(stmt->case_statement, parent);
+		break;
+	case STMT_IF:
+		prepare_expr_cleanup_scopes(stmt->if_conditional, parent);
+		prepare_cleanup_scopes(stmt->if_true, parent);
+		prepare_cleanup_scopes(stmt->if_false, parent);
+		break;
+	case STMT_EXPRESSION:
+		prepare_expr_cleanup_scopes(stmt->expression, parent);
+		break;
+	case STMT_RETURN:
+		prepare_expr_cleanup_scopes(stmt->ret_value, parent);
+		break;
+	case STMT_CONTEXT:
+		prepare_expr_cleanup_scopes(stmt->expression, parent);
+		prepare_expr_cleanup_scopes(stmt->context, parent);
+		break;
+	case STMT_RANGE:
+		prepare_expr_cleanup_scopes(stmt->range_expression, parent);
+		prepare_expr_cleanup_scopes(stmt->range_low, parent);
+		prepare_expr_cleanup_scopes(stmt->range_high, parent);
+		break;
+	case STMT_GOTO:
+		prepare_expr_cleanup_scopes(stmt->goto_expression, parent);
+		break;
+	case STMT_ASM: {
+		struct asm_operand *op;
+		FOR_EACH_PTR(stmt->asm_inputs, op) {
+			prepare_expr_cleanup_scopes(op->expr, parent);
+		} END_FOR_EACH_PTR(op);
+		FOR_EACH_PTR(stmt->asm_outputs, op) {
+			prepare_expr_cleanup_scopes(op->expr, parent);
+		} END_FOR_EACH_PTR(op);
+		break;
+	}
+	default:
+		break;
+	}
+}
+
+static void prepare_expr_cleanup_scopes(struct expression *expr, struct =
cleanup_scope *parent)
+{
+	if (!expr)
+		return;
+	switch (expr->type) {
+	case EXPR_STATEMENT:
+		prepare_cleanup_scopes(expr->statement, parent);
+		break;
+	case EXPR_BINOP:
+	case EXPR_COMMA:
+	case EXPR_COMPARE:
+	case EXPR_LOGICAL:
+	case EXPR_ASSIGNMENT:
+		prepare_expr_cleanup_scopes(expr->left, parent);
+		prepare_expr_cleanup_scopes(expr->right, parent);
+		break;
+	case EXPR_PREOP:
+	case EXPR_POSTOP:
+		prepare_expr_cleanup_scopes(expr->unop, parent);
+		break;
+	case EXPR_CONDITIONAL:
+	case EXPR_SELECT:
+		prepare_expr_cleanup_scopes(expr->conditional, parent);
+		prepare_expr_cleanup_scopes(expr->cond_true, parent);
+		prepare_expr_cleanup_scopes(expr->cond_false, parent);
+		break;
+	case EXPR_CALL: {
+		struct expression *arg;
+		prepare_expr_cleanup_scopes(expr->fn, parent);
+		FOR_EACH_PTR(expr->args, arg) {
+			prepare_expr_cleanup_scopes(arg, parent);
+		} END_FOR_EACH_PTR(arg);
+		break;
+	}
+	case EXPR_CAST:
+	case EXPR_FORCE_CAST:
+	case EXPR_IMPLIED_CAST:
+	case EXPR_SIZEOF:
+	case EXPR_PTRSIZEOF:
+	case EXPR_ALIGNOF:
+		prepare_expr_cleanup_scopes(expr->cast_expression, parent);
+		break;
+	case EXPR_SLICE:
+		prepare_expr_cleanup_scopes(expr->base, parent);
+		break;
+	case EXPR_DEREF:
+		prepare_expr_cleanup_scopes(expr->deref, parent);
+		break;
+	case EXPR_INITIALIZER: {
+		struct expression *entry;
+		FOR_EACH_PTR(expr->expr_list, entry) {
+			prepare_expr_cleanup_scopes(entry, parent);
+		} END_FOR_EACH_PTR(entry);
+		break;
+	}
+	case EXPR_POS:
+		prepare_expr_cleanup_scopes(expr->init_expr, parent);
+		break;
+	case EXPR_INDEX:
+		prepare_expr_cleanup_scopes(expr->idx_expression, parent);
+		break;
+	case EXPR_IDENTIFIER:
+		prepare_expr_cleanup_scopes(expr->ident_expression, parent);
+		break;
+	case EXPR_GENERIC: {
+		struct type_expression *map;
+		prepare_expr_cleanup_scopes(expr->control, parent);
+		prepare_expr_cleanup_scopes(expr->def, parent);
+		for (map =3D expr->map; map; map =3D map->next)
+			prepare_expr_cleanup_scopes(map->expr, parent);
+		break;
+	}
+	case EXPR_OFFSETOF:
+		prepare_expr_cleanup_scopes(expr->down, parent);
+		if (expr->op !=3D '.')
+			prepare_expr_cleanup_scopes(expr->index, parent);
+		break;
+	case EXPR_HAS_ATTRIBUTE:
+		prepare_expr_cleanup_scopes(expr->has_attr_expr, parent);
+		break;
+	default:
+		break;
+	}
+}
+
+static void emit_cleanups_to(struct entrypoint *ep, struct cleanup_scope=
 *target_scope)
+{
+	struct cleanup_scope *saved_scope =3D ep->cleanup_scope;
+	struct cleanup_scope *scope;
+
+	if (!ep->active || !bb_reachable(ep->active))
+		return;
+
+	for (scope =3D saved_scope; scope && scope !=3D target_scope; scope =3D=
 scope->parent) {
+		struct symbol *sym;
+		ep->cleanup_scope =3D scope;
+		FOR_EACH_PTR_REVERSE(scope->cleanups, sym) {
+			if (sym->cleanup && sym->cleanup->ctype) {
+				struct expression *cleanup =3D copy_cleanup_expression(sym->cleanup)=
;
+				prepare_expr_cleanup_scopes(cleanup, scope);
+				linearize_expression(ep, cleanup);
+			}
+		} END_FOR_EACH_PTR_REVERSE(sym);
+	}
+	ep->cleanup_scope =3D saved_scope;
+}
+
 static pseudo_t linearize_compound_statement(struct entrypoint *ep, stru=
ct statement *stmt)
 {
+	struct cleanup_scope *scope =3D stmt->cleanup_scope;
 	pseudo_t pseudo;
 	struct statement *s;
=20
+	if (!scope) {
+		prepare_cleanup_scopes(stmt, ep->cleanup_scope);
+		scope =3D stmt->cleanup_scope;
+	}
+
+	ep->cleanup_scope =3D scope;
 	pseudo =3D VOID;
 	FOR_EACH_PTR(stmt->stmts, s) {
 		pseudo =3D linearize_statement(ep, s);
 	} END_FOR_EACH_PTR(s);
=20
+	emit_cleanups_to(ep, scope->parent);
+	ep->cleanup_scope =3D scope->parent;
+
 	return pseudo;
 }
=20
@@ -2266,8 +2633,14 @@ static pseudo_t linearize_declaration(struct entry=
point *ep, struct statement *s
=20
 	concat_symbol_list(stmt->declaration, &ep->syms);
=20
+	if (stmt->cleanup_scope) {
+		stmt->cleanup_scope->cleanups =3D NULL;
+		ep->cleanup_scope =3D stmt->cleanup_scope;
+	}
 	FOR_EACH_PTR(stmt->declaration, sym) {
 		linearize_one_symbol(ep, sym);
+		if (sym->cleanup && ep->cleanup_scope)
+			add_symbol(&ep->cleanup_scope->cleanups, sym);
 	} END_FOR_EACH_PTR(sym);
 	return VOID;
 }
@@ -2277,10 +2650,10 @@ static pseudo_t linearize_return(struct entrypoin=
t *ep, struct statement *stmt)
 	struct expression *expr =3D stmt->expression;
 	struct symbol *ret =3D stmt->ret_target;
 	struct basic_block *bb_return =3D get_bound_block(ep, ret);
-	struct basic_block *active;
 	pseudo_t src =3D linearize_expression(ep, expr);
-	active =3D ep->active;
-	if (active && !is_void_type(ret)) {
+
+	emit_cleanups_to(ep, ret ? ret->cleanup_scope : NULL);
+	if (ep->active && !is_void_type(ret)) {
 		add_return(ep, bb_return, ret, src);
 	}
 	add_goto(ep, bb_return);
@@ -2311,10 +2684,27 @@ static pseudo_t linearize_switch(struct entrypoin=
t *ep, struct statement *stmt)
 	add_one_insn(ep, switch_ins);
 	finish_block(ep);
=20
+	struct cleanup_scope *switch_scope =3D stmt->cleanup_scope;
+	if (!switch_scope) {
+		prepare_cleanup_scopes(stmt, ep->cleanup_scope);
+		switch_scope =3D stmt->cleanup_scope;
+	}
+	ep->cleanup_scope =3D switch_scope;
+	stmt->switch_break->cleanup_scope =3D switch_scope->parent;
+
 	default_case =3D NULL;
 	FOR_EACH_PTR(stmt->switch_case->symbol_list, sym) {
 		struct statement *case_stmt =3D sym->stmt;
-		struct basic_block *bb_case =3D get_bound_block(ep, sym);
+		struct symbol *bypass =3D bypasses_cleanup_decl(switch_scope, sym->cle=
anup_scope);
+		struct basic_block *bb_case;
+
+		if (bypass) {
+			sparse_error(case_stmt->pos,
+				     "jump bypasses initialization of variable '%s' with cleanup att=
ribute",
+				     show_ident(bypass->ident));
+			continue;
+		}
+		bb_case =3D get_bound_block(ep, sym);
=20
 		if (!case_stmt->case_expression) {
 			default_case =3D bb_case;
@@ -2349,6 +2739,7 @@ static pseudo_t linearize_switch(struct entrypoint =
*ep, struct statement *stmt)
=20
 	/* And linearize the actual statement */
 	linearize_statement(ep, stmt->switch_statement);
+	emit_cleanups_to(ep, switch_scope->parent);
 	set_activeblock(ep, switch_end);
=20
 	if (!default_case)
@@ -2360,6 +2751,7 @@ static pseudo_t linearize_switch(struct entrypoint =
*ep, struct statement *stmt)
 	add_bb(&active->children, default_case);
 	sort_switch_cases(switch_ins);
=20
+	ep->cleanup_scope =3D switch_scope->parent;
 	return VOID;
 }
=20
@@ -2372,9 +2764,18 @@ static pseudo_t linearize_iterator(struct entrypoi=
nt *ep, struct statement *stmt
 	struct expression *post_condition =3D stmt->iterator_post_condition;
 	struct basic_block *loop_top, *loop_body, *loop_continue, *loop_end;
 	struct symbol *sym;
+	struct cleanup_scope *iter_scope =3D stmt->cleanup_scope;
+	if (!iter_scope) {
+		prepare_cleanup_scopes(stmt, ep->cleanup_scope);
+		iter_scope =3D stmt->cleanup_scope;
+	}
+
+	ep->cleanup_scope =3D iter_scope;
=20
 	FOR_EACH_PTR(stmt->iterator_syms, sym) {
 		linearize_one_symbol(ep, sym);
+		if (sym->cleanup)
+			add_symbol(&iter_scope->cleanups, sym);
 	} END_FOR_EACH_PTR(sym);
 	concat_symbol_list(stmt->iterator_syms, &ep->syms);
 	linearize_statement(ep, pre_statement);
@@ -2383,6 +2784,9 @@ static pseudo_t linearize_iterator(struct entrypoin=
t *ep, struct statement *stmt
 	loop_continue =3D alloc_basic_block(ep, stmt->pos);
 	loop_end =3D alloc_basic_block(ep, stmt->pos);
=20
+	stmt->iterator_continue->cleanup_scope =3D iter_scope;
+	stmt->iterator_break->cleanup_scope =3D iter_scope;
+
 	/* An empty post-condition means that it's the same as the pre-conditio=
n */
 	if (!post_condition) {
 		loop_top =3D alloc_basic_block(ep, stmt->pos);
@@ -2407,6 +2811,9 @@ static pseudo_t linearize_iterator(struct entrypoin=
t *ep, struct statement *stmt
 		linearize_cond_branch(ep, post_condition, loop_top, loop_end);
 	set_activeblock(ep, loop_end);
=20
+	emit_cleanups_to(ep, iter_scope->parent);
+	ep->cleanup_scope =3D iter_scope->parent;
+
 	return VOID;
 }
=20
@@ -2464,28 +2871,72 @@ static pseudo_t linearize_statement(struct entryp=
oint *ep, struct statement *stm
 		struct expression *expr;
 		struct instruction *goto_ins;
 		struct basic_block *active;
+		struct cleanup_scope *common_lca =3D NULL;
+		int expected_cleanups =3D -1;
 		pseudo_t pseudo;
=20
 		active =3D ep->active;
 		if (!bb_reachable(active))
 			break;
=20
-		if (stmt->goto_label) {
-			add_goto(ep, get_bound_block(ep, stmt->goto_label));
+		sym =3D stmt->goto_label;
+		expr =3D stmt->goto_expression;
+		if (!sym && expr && expr->type =3D=3D EXPR_LABEL)
+			sym =3D expr->label_symbol;
+
+		if (sym) {
+			struct symbol *bypass =3D bypasses_cleanup_decl(ep->cleanup_scope, sy=
m->cleanup_scope);
+			if (bypass) {
+				sparse_error(stmt->pos,
+					     "jump bypasses initialization of variable '%s' with cleanup at=
tribute",
+					     show_ident(bypass->ident));
+				add_unreachable(ep);
+				break;
+			}
+			emit_cleanups_to(ep, cleanup_scope_lca(ep->cleanup_scope, sym->cleanu=
p_scope));
+			add_goto(ep, get_bound_block(ep, sym));
 			break;
 		}
=20
-		expr =3D stmt->goto_expression;
 		if (!expr)
 			break;
=20
-		/* This can happen as part of simplification */
-		if (expr->type =3D=3D EXPR_LABEL) {
-			add_goto(ep, get_bound_block(ep, expr->label_symbol));
+		pseudo =3D linearize_expression(ep, expr);
+		active =3D ep->active;
+		if (!bb_reachable(active))
 			break;
+
+		FOR_EACH_PTR(stmt->target_list, sym) {
+			struct symbol *bypass =3D bypasses_cleanup_decl(ep->cleanup_scope, sy=
m->cleanup_scope);
+			struct cleanup_scope *lca;
+			int n;
+
+			if (bypass) {
+				sparse_error(stmt->pos,
+					     "jump bypasses initialization of variable '%s' with cleanup at=
tribute",
+					     show_ident(bypass->ident));
+				add_unreachable(ep);
+				goto out_goto;
+			}
+			lca =3D cleanup_scope_lca(ep->cleanup_scope, sym->cleanup_scope);
+			n =3D count_cleanups_to(ep->cleanup_scope, lca);
+			if (expected_cleanups < 0) {
+				expected_cleanups =3D n;
+				common_lca =3D lca;
+			} else if (n !=3D expected_cleanups) {
+				sparse_error(stmt->pos, "computed goto crosses cleanup scope");
+				add_unreachable(ep);
+				goto out_goto;
+			}
+		} END_FOR_EACH_PTR(sym);
+
+		if (expected_cleanups > 0) {
+			emit_cleanups_to(ep, common_lca);
+			active =3D ep->active;
+			if (!bb_reachable(active))
+				break;
 		}
=20
-		pseudo =3D linearize_expression(ep, expr);
 		goto_ins =3D alloc_instruction(OP_COMPUTEDGOTO, 0);
 		use_pseudo(goto_ins, pseudo, &goto_ins->src);
 		add_one_insn(ep, goto_ins);
@@ -2494,11 +2945,12 @@ static pseudo_t linearize_statement(struct entryp=
oint *ep, struct statement *stm
 			struct basic_block *bb_computed =3D get_bound_block(ep, sym);
 			struct multijmp *jmp =3D alloc_multijmp(bb_computed, 1, 0);
 			add_multijmp(&goto_ins->multijmp_list, jmp);
-			add_bb(&bb_computed->parents, ep->active);
+			add_bb(&bb_computed->parents, active);
 			add_bb(&active->children, bb_computed);
 		} END_FOR_EACH_PTR(sym);
=20
 		finish_block(ep);
+	out_goto:
 		break;
 	}
=20
@@ -2613,6 +3065,8 @@ static struct entrypoint *linearize_fn(struct symbo=
l *sym, struct symbol *base_t
 	if (!stmt || sym->bogus_linear)
 		return NULL;
=20
+	prepare_cleanup_scopes(stmt, NULL);
+
 	ep =3D alloc_entrypoint();
 	ep->name =3D sym;
 	sym->ep =3D ep;
diff --git a/linearize.h b/linearize.h
index 3412494edbef..7b828859238e 100644
--- a/linearize.h
+++ b/linearize.h
@@ -321,6 +321,9 @@ static inline void replace_bb_in_list(struct basic_bl=
ock_list **list,
 	replace_ptr_list_entry((struct ptr_list **)list, old, new, count);
 }
=20
+struct cleanup_scope;
+DECLARE_ALLOCATOR(cleanup_scope);
+
 struct entrypoint {
 	struct symbol *name;
 	struct symbol_list *syms;
@@ -329,6 +332,7 @@ struct entrypoint {
 	struct basic_block *active;
 	struct instruction *entry;
 	unsigned int dom_levels;	/* max levels in the dom tree */
+	struct cleanup_scope *cleanup_scope;
 };
=20
 extern void insert_select(struct basic_block *bb, struct instruction *br=
, struct instruction *phi, pseudo_t if_true, pseudo_t if_false);
diff --git a/parse.c b/parse.c
index 7010d412fdab..ae799370203a 100644
--- a/parse.c
+++ b/parse.c
@@ -1512,7 +1512,7 @@ static struct token *attribute_cleanup(struct token=
 *token, struct symbol *attr,
 		else if (token_type(token) !=3D TOKEN_IDENT)
 			sparse_error(token->pos, "argument is not an identifier");
 		token =3D primary_expression(token, &expr);
-		if (expr && expr->type =3D=3D EXPR_SYMBOL)
+		if (expr && expr->type =3D=3D EXPR_SYMBOL && match_op(token, ')'))
 			ctx->cleanup =3D expr;
 		return expect(token, ')', "after attribute's argument'");
 	}
@@ -2609,7 +2609,8 @@ static struct token *declaration_list(struct token =
*token, struct symbol_list **
=20
 		decl->ctype =3D ctx.ctype;
 		decl->ctype.modifiers |=3D mod;
-		decl->cleanup =3D ctx.cleanup;
+		if (ctx.cleanup)
+			sparse_error(decl->pos, "cleanup attribute may only be applied to loc=
al variables");
 		decl->packed =3D ctx.packed;
 		decl->explicit_alignment =3D ctx.explicit_alignment;
 		apply_fn_ptr_modifiers(decl, ctx.f_modifiers);
@@ -2681,6 +2682,8 @@ static struct token *parameter_declaration(struct t=
oken *token, struct symbol *s
 	apply_fn_ptr_modifiers(sym, ctx.f_modifiers);
 	sym->endpos =3D token->pos;
 	sym->forced_arg =3D ctx.forced;
+	if (ctx.cleanup)
+		sparse_error(sym->pos, "cleanup attribute may only be applied to local=
 variables");
 	if (ctx.has_auto || ctx.autotype) {
 		sparse_error(sym->pos,
 			     "parameter '%s' cannot be declared %s",
@@ -3845,6 +3848,7 @@ struct token *external_declaration(struct token *to=
ken, struct symbol_list **lis
 	struct symbol *decl;
 	struct decl_state ctx =3D { .ident =3D &ident };
 	struct ctype saved;
+	struct expression *saved_cleanup;
 	struct symbol *base_type;
 	unsigned long mod, saved_f_modifiers;
 	unsigned int saved_explicit_alignment, saved_td_align;
@@ -3889,6 +3893,7 @@ struct token *external_declaration(struct token *to=
ken, struct symbol_list **lis
 	saved_td_align =3D ctx.typedef_alignment;
 	saved_f_modifiers =3D ctx.f_modifiers;
 	saved =3D ctx.ctype;
+	saved_cleanup =3D ctx.cleanup;
 	token =3D declarator(token, &ctx);
 	token =3D handle_asm_name(token, &ctx);
 	token =3D handle_attributes(token, &ctx);
@@ -3945,6 +3950,10 @@ struct token *external_declaration(struct token *t=
oken, struct symbol_list **lis
 			}
 		}
 	} else if (base_type && base_type->type =3D=3D SYM_FN) {
+		if (decl->cleanup) {
+			sparse_error(decl->pos, "cleanup attribute may only be applied to loc=
al variables");
+			decl->cleanup =3D NULL;
+		}
 		if (ctx.is_constexpr) {
 			sparse_error(
 				decl->pos,
@@ -4033,6 +4042,9 @@ struct token *external_declaration(struct token *to=
ken, struct symbol_list **lis
 				add_symbol(list, decl);
 				fn_local_symbol(decl);
 			}
+		} else if (decl->cleanup) {
+			sparse_error(decl->pos, "cleanup attribute may only be applied to loc=
al variables");
+			decl->cleanup =3D NULL;
 		}
 		check_declaration(decl);
 		if (decl->same_symbol) {
@@ -4161,7 +4173,7 @@ struct token *external_declaration(struct token *to=
ken, struct symbol_list **lis
 		ctx.typedef_alignment =3D saved_td_align;
 		ctx.f_modifiers =3D saved_f_modifiers;
 		ctx.ctype =3D saved;
-		ctx.cleanup =3D NULL;
+		ctx.cleanup =3D saved_cleanup;
 		ctx.ident_modifiers =3D 0;
 		token =3D handle_attributes(token, &ctx);
 		token =3D declarator(token, &ctx);
@@ -4195,6 +4207,10 @@ struct token *external_declaration(struct token *t=
oken, struct symbol_list **lis
 		/* Function declarations are automatically extern unless specifically =
static */
 		base_type =3D decl->ctype.base_type;
 		if (!is_typedef && base_type && base_type->type =3D=3D SYM_FN) {
+			if (decl->cleanup) {
+				sparse_error(decl->pos, "cleanup attribute may only be applied to lo=
cal variables");
+				decl->cleanup =3D NULL;
+			}
 			decl->ctype.modifiers |=3D ctx.f_modifiers;
 			if (standard >=3D STANDARD_C23 && base_type->kr_args)
 				sparse_error(decl->pos,
diff --git a/parse.h b/parse.h
index 6a528bc8ca4d..83c39c3cecbc 100644
--- a/parse.h
+++ b/parse.h
@@ -44,9 +44,12 @@ enum statement_type {
 	STMT_RANGE,
 };
=20
+struct cleanup_scope;
+
 struct statement {
 	enum statement_type type;
 	struct position pos;
+	struct cleanup_scope *cleanup_scope;
 	union {
 		struct /* declaration */ {
 			struct symbol_list *declaration;
@@ -138,6 +141,7 @@ extern struct symbol *ctype_integer(int size, int wan=
t_unsigned);
=20
 extern int inline_function(struct expression *expr, struct symbol *sym);
 extern void uninline(struct symbol *sym);
+extern struct expression *copy_cleanup_expression(struct expression *exp=
r);
 extern void init_parser(int);
 extern void init_parser_finalize(void);
=20
diff --git a/symbol.h b/symbol.h
index cd9268703192..721b6c7d05a4 100644
--- a/symbol.h
+++ b/symbol.h
@@ -251,6 +251,7 @@ struct symbol {
 		};
 	};
 	pseudo_t pseudo;
+	struct cleanup_scope *cleanup_scope;
 };
=20
 /* Modifiers */
diff --git a/validation/cleanup-context.c b/validation/cleanup-context.c
new file mode 100644
index 000000000000..d07936359466
--- /dev/null
+++ b/validation/cleanup-context.c
@@ -0,0 +1,161 @@
+#define __cleanup(f) __attribute__((cleanup(f)))
+#define __context_lock(x) __attribute__((context(0, 1)))
+#define __context_unlock(x) __attribute__((context(1, 0)))
+
+static void lock(int *x) __context_lock(x)
+{
+	__context__(1);
+}
+
+static void unlock(int **x) __context_unlock(x)
+{
+	__context__(-1);
+}
+
+static void test_normal_exit(int *m)
+{
+	int *guard __cleanup(unlock) =3D (lock(m), m);
+}
+
+static int test_return(int *m, int cond)
+{
+	int *guard __cleanup(unlock) =3D (lock(m), m);
+	if (cond)
+		return 1;
+	return 0;
+}
+
+static int test_nested_return(int *m1, int *m2, int cond)
+{
+	int *g1 __cleanup(unlock) =3D (lock(m1), m1);
+	{
+		int *g2 __cleanup(unlock) =3D (lock(m2), m2);
+		if (cond)
+			return -1;
+	}
+	return 0;
+}
+
+static void test_loop_break(int *m, int n)
+{
+	for (int i =3D 0; i < n; i++) {
+		int *guard __cleanup(unlock) =3D (lock(m), m);
+		if (i =3D=3D 2)
+			break;
+	}
+}
+
+static void test_loop_continue(int *m, int n)
+{
+	for (int i =3D 0; i < n; i++) {
+		int *guard __cleanup(unlock) =3D (lock(m), m);
+		if (i =3D=3D 2)
+			continue;
+	}
+}
+
+static void test_backward_goto(int *m, int cond)
+{
+again:
+	{
+		int *guard __cleanup(unlock) =3D (lock(m), m);
+		if (cond) {
+			cond =3D 0;
+			goto again;
+		}
+	}
+}
+
+static void test_forward_goto(int *m, int cond)
+{
+	{
+		int *guard __cleanup(unlock) =3D (lock(m), m);
+		if (cond)
+			goto out;
+	}
+out:
+	return;
+}
+
+static void test_loop_header_break(int *m, int n)
+{
+	for (int *guard __cleanup(unlock) =3D (lock(m), m); n > 0; n--) {
+		if (n =3D=3D 2)
+			break;
+	}
+}
+
+static void test_switch_break(int *m, int val)
+{
+	switch (val) {
+	case 1: {
+		int *guard __cleanup(unlock) =3D (lock(m), m);
+		break;
+	}
+	default:
+		break;
+	}
+}
+
+static void test_switch_case_decl(int *m, int val)
+{
+	switch (val) {
+	default:
+		break;
+	case 1: ;
+		int *guard __cleanup(unlock) =3D (lock(m), m);
+		break;
+	}
+}
+
+static void test_computed_goto_const(int *m)
+{
+	{
+		int *guard __cleanup(unlock) =3D (lock(m), m);
+		goto *&&out;
+	}
+out:
+	return;
+}
+
+static void test_computed_goto_dyn(int *m, int cond)
+{
+	void *target =3D cond ? &&out1 : &&out2;
+	{
+		int *guard __cleanup(unlock) =3D (lock(m), m);
+		goto *target;
+	}
+out1:
+	return;
+out2:
+	return;
+}
+
+static void test_multi_declarator(int *m1, int *m2)
+{
+	int __cleanup(unlock) *g1 =3D (lock(m1), m1), *g2 =3D (lock(m2), m2);
+}
+
+static void test_stmt_expr_init_backward_goto(int *m, int cond)
+{
+again:
+	int *guard __cleanup(unlock) =3D ({ int *p =3D (lock(m), m); p; });
+	if (cond) {
+		cond =3D 0;
+		goto again;
+	}
+}
+
+static void test_warn_imbalance(int *m)
+{
+	lock(m);
+}
+
+/*
+ * check-name: cleanup attribute in context analysis
+ * check-command: sparse -Wcontext $file
+ *
+ * check-error-start
+cleanup-context.c:149:13: warning: context imbalance in 'test_warn_imbal=
ance' - wrong count at exit
+ * check-error-end
+ */
diff --git a/validation/cleanup-errors.c b/validation/cleanup-errors.c
new file mode 100644
index 000000000000..0aed01fbbfde
--- /dev/null
+++ b/validation/cleanup-errors.c
@@ -0,0 +1,77 @@
+#define __cleanup(f) __attribute__((cleanup(f)))
+
+static void cl(int *p)
+{
+	(void)p;
+}
+
+static void lock(int *m) __attribute__((context(0, 1)))
+{
+	(void)m;
+	__context__(1);
+}
+
+static void unlock(int **m) __attribute__((context(1, 0)))
+{
+	(void)m;
+	__context__(-1);
+}
+
+static void bad_param(int x __cleanup(cl))
+{
+	(void)x;
+}
+
+struct bad_struct {
+	int member __cleanup(cl);
+};
+
+typedef int bad_typedef __cleanup(cl);
+
+static void bad_fn(void) __cleanup(cl);
+
+static void bad_forward_goto(int *m, int c)
+{
+	if (c)
+		goto inside;
+	int *guard __cleanup(unlock) =3D (lock(m), m);
+inside:
+	return;
+}
+
+static void bad_switch_bypass(int *m, int v)
+{
+	switch (v) {
+	case 1: ;
+		int *guard __cleanup(unlock) =3D (lock(m), m);
+		break;
+	case 2:
+		break;
+	}
+}
+
+static void bad_cgoto_into_scope(void *p)
+{
+	goto *p;
+	{
+		int x __cleanup(cl) =3D 1;
+	inner:
+		(void)&&inner;
+		(void)x;
+	}
+}
+
+/*
+ * check-name: cleanup attribute error diagnostics
+ * check-command: sparse -Wcontext $file
+ *
+ * check-error-start
+cleanup-errors.c:20:23: error: cleanup attribute may only be applied to =
local variables
+cleanup-errors.c:26:13: error: cleanup attribute may only be applied to =
local variables
+cleanup-errors.c:29:13: error: cleanup attribute may only be applied to =
local variables
+cleanup-errors.c:31:13: error: cleanup attribute may only be applied to =
local variables
+cleanup-errors.c:36:17: error: jump bypasses initialization of variable =
'guard' with cleanup attribute
+cleanup-errors.c:48:9: error: jump bypasses initialization of variable '=
guard' with cleanup attribute
+cleanup-errors.c:55:9: error: jump bypasses initialization of variable '=
x' with cleanup attribute
+ * check-error-end
+ */
diff --git a/validation/cleanup-inline-loop.c b/validation/cleanup-inline=
-loop.c
new file mode 100644
index 000000000000..539cb39f8d98
--- /dev/null
+++ b/validation/cleanup-inline-loop.c
@@ -0,0 +1,31 @@
+#define __cleanup(f) __attribute__((cleanup(f)))
+
+static inline void cleanup_fn(int *p)
+{
+	int tmp =3D *p;
+	while (tmp > 0) {
+		tmp--;
+		if (tmp =3D=3D 0)
+			goto done;
+	}
+done:
+	*p =3D tmp;
+}
+
+static int test_multiple_exits(int cond)
+{
+	int x __cleanup(cleanup_fn) =3D 2;
+	if (cond =3D=3D 1)
+		return 1;
+	if (cond =3D=3D 2)
+		return 2;
+	return 0;
+}
+
+/*
+ * check-name: inline cleanup with loop across multiple exits
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-excludes: VOID
+ */
diff --git a/validation/linear/cleanup-control-flow.c b/validation/linear=
/cleanup-control-flow.c
new file mode 100644
index 000000000000..269df60917e4
--- /dev/null
+++ b/validation/linear/cleanup-control-flow.c
@@ -0,0 +1,62 @@
+void cl1(int *p);
+void cl2(int *p);
+void cl3(int *p);
+
+/* 1. break and continue inside loop with cleanup variable */
+void loop_cleanup(int a, int b)
+{
+	while (a > 0) {
+		int x __attribute__((cleanup(cl1))) =3D a;
+		if (b =3D=3D 1)
+			break;
+		if (b =3D=3D 2)
+			continue;
+		a--;
+	}
+}
+
+/* 2. goto out of nested cleanup scopes */
+int goto_nested_cleanup(int c)
+{
+	int outer __attribute__((cleanup(cl1))) =3D 1;
+	{
+		int inner __attribute__((cleanup(cl2))) =3D 2;
+		if (c)
+			goto out;
+	}
+out:
+	return outer;
+}
+
+/* 3. Cleanup declaration inside unbraced switch case runs once, not twi=
ce */
+void switch_case_cleanup(int v)
+{
+	switch (v) {
+	default:
+		break;
+	case 1: ;
+		int s __attribute__((cleanup(cl3))) =3D v;
+		break;
+	}
+}
+
+/* 4. Multi-declarator cleanup and statement-expression initializer + ba=
ckward goto */
+void multi_and_stmt_expr_cleanup(int c)
+{
+again:
+	int __attribute__((cleanup(cl3))) a =3D ({ int t =3D c; t; }), b =3D 2;
+	if (c) {
+		c =3D 0;
+		goto again;
+	}
+}
+
+/*
+ * check-name: cleanup-control-flow
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-pattern(4): call.*cl1
+ * check-output-pattern(2): call.*cl2
+ * check-output-pattern(5): call.*cl3
+ */
diff --git a/validation/linear/cleanup-stmt-expr-asm.c b/validation/linea=
r/cleanup-stmt-expr-asm.c
new file mode 100644
index 000000000000..82c79c3fbee1
--- /dev/null
+++ b/validation/linear/cleanup-stmt-expr-asm.c
@@ -0,0 +1,48 @@
+/*
+ * Cleanup expressions are copied after expansion. expand_compound()
+ * collapses single-statement compound statements, so the statement of
+ * a statement expression is not necessarily a compound statement anymor=
e
+ * when the cleanup expression is copied. Additionally, asm memory
+ * operands have already been converted into addresses and must keep
+ * their constraint flags when copied.
+ */
+struct s {
+	int a;
+	int counter;
+};
+
+static inline void release(struct s **p)
+{
+	struct s *v =3D *p;
+
+	({ asm volatile("inc %0" : "+m" (v->counter)); });
+	({ asm volatile("dec %0" : "=3Dm" (v->a) : "m" (v->a)); });
+}
+
+int f(struct s *v)
+{
+	struct s *__attribute__((cleanup(release))) x =3D v;
+
+	return 0;
+}
+
+/*
+ * check-name: cleanup-stmt-expr-asm
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-start
+f:
+.L0:
+	<entry-point>
+	add.64      %r6 <- %arg1, $4
+	asm         "inc %0"
+		out: "+m" (%r6)
+	asm         "dec %0"
+		out: "=3Dm" (%arg1)
+		in: "m" (%arg1)
+	# call      release, %r2
+	ret.32      $0
+
+
+ * check-output-end
+ */
