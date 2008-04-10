From: Philipp Reisner <philipp.reisner@linbit.com>
Subject: Re: [PATCH 1/3] make sparse keep its promise about context tracking
Date: Thu, 10 Apr 2008 17:46:13 +0200
Message-ID: <200804101746.14457.philipp.reisner@linbit.com>
References: <20080410132519.049821000@sipsolutions.net> <200804101724.27382.philipp.reisner@linbit.com> <1207841454.13354.7.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from aug.linbit.com ([212.69.162.22]:40869 "EHLO mail.linbit.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756004AbYDJPqS (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 10 Apr 2008 11:46:18 -0400
In-Reply-To: <1207841454.13354.7.camel@johannes.berg>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org

Am Donnerstag, 10. April 2008 17:30:54 schrieb Johannes Berg:
> Hi Philip,
>
> > I just have implemented nearly the same here. Hopefully Josh will
> > decide for one of these patches soon.
> >
> >
> > +int ident_equal(struct ident *ident1, struct ident *ident2)
> >
> > +int expressions_equal(struct expression *expr1, struct expression
> > *expr2)
>
> That code looks pretty nice, I guess I should look at getting that into
> my version instead of just printing the identifier to a string.
>
> As far as I can see your version doesn't actually implement
> __attribute__((context(x,1,1))) as the man-page envisioned it for
> checking that a function is run under the lock context it wants, which
> was one of the more important goals to me. Doing separate locks sort of
> fell out.
>

Hi Johannes,

I also worked on that part, although I have to admitt that I did not
got that part of the manpage. Instead I invented the require_context
attribute.

Here is the second patch. It applies on top of the first one...

I hope that we get the good ideas of our two works combined and
accepted into sparse...

-Phil

diff --git a/allocate.c b/allocate.c
index 5cc52a9..198297b 100644
--- a/allocate.c
+++ b/allocate.c
@@ -114,6 +114,7 @@ void show_allocations(struct allocator_struct *x)
 ALLOCATOR(ident, "identifiers");
 ALLOCATOR(token, "tokens");
 ALLOCATOR(context, "contexts");
+ALLOCATOR(context_requirement, "context requirements");
 ALLOCATOR(symbol, "symbols");
 ALLOCATOR(expression, "expressions");
 ALLOCATOR(statement, "statements");
diff --git a/allocate.h b/allocate.h
index 9f1dc8c..8fa3efd 100644
--- a/allocate.h
+++ b/allocate.h
@@ -65,6 +65,7 @@ extern void show_allocations(struct allocator_struct *);
 DECLARE_ALLOCATOR(ident);
 DECLARE_ALLOCATOR(token);
 DECLARE_ALLOCATOR(context);
+DECLARE_ALLOCATOR(context_requirement);
 DECLARE_ALLOCATOR(symbol);
 DECLARE_ALLOCATOR(expression);
 DECLARE_ALLOCATOR(statement);
diff --git a/linearize.c b/linearize.c
index 5aae3d6..e47f862 100644
--- a/linearize.c
+++ b/linearize.c
@@ -240,6 +240,7 @@ static const char *opcodes[] = {
 
 	/* Sparse tagging (line numbers, context, whatever) */
 	[OP_CONTEXT] = "context",
+	[OP_CONTEXT_REQ] = "context req",
 	[OP_RANGE] = "range-check",
 
 	[OP_COPY] = "copy",
@@ -442,6 +443,9 @@ const char *show_instruction(struct instruction *insn)
 	case OP_CONTEXT:
 		buf += sprintf(buf, "%s%d", insn->check ? "check: " : "", insn->increment);
 		break;
+	case OP_CONTEXT_REQ:
+		buf += sprintf(buf, "%d to %d, type %d", insn->ctx_req->min, insn->ctx_req->max, insn->access_type);
+		break;
 	case OP_RANGE:
 		buf += sprintf(buf, "%s between %s..%s", show_pseudo(insn->src1), show_pseudo(insn->src2), show_pseudo(insn->src3));
 		break;
@@ -839,6 +843,7 @@ struct access_data {
 	unsigned int offset, alignment;	// byte offset
 	unsigned int bit_size, bit_offset; // which bits
 	struct position pos;
+	struct ctx_req_list *ctx_reqs;    // required contexts
 };
 
 static void finish_address_gen(struct entrypoint *ep, struct access_data *ad)
@@ -887,6 +892,8 @@ static int linearize_address_gen(struct entrypoint *ep,
 
 	if (!ctype)
 		return 0;
+
+	ad->ctx_reqs = ctype->ctype.ctx_reqs;
 	ad->pos = expr->pos;
 	ad->result_type = ctype;
 	ad->source_type = base_type(ctype);
@@ -938,6 +945,7 @@ static pseudo_t linearize_store_gen(struct entrypoint *ep,
 		struct access_data *ad)
 {
 	pseudo_t store = value;
+	struct context_requirement *ctx_req;
 
 	if (type_size(ad->source_type) != type_size(ad->result_type)) {
 		pseudo_t orig = add_load(ep, ad);
@@ -951,6 +959,19 @@ static pseudo_t linearize_store_gen(struct entrypoint *ep,
 		orig = add_binary_op(ep, ad->source_type, OP_AND, orig, value_pseudo(~mask));
 		store = add_binary_op(ep, ad->source_type, OP_OR, orig, store);
 	}
+	if (ad->ctx_reqs) {
+		struct instruction *insn;
+		FOR_EACH_PTR(ad->ctx_reqs, ctx_req) {
+			if (ctx_req->access_type == WRITE ||
+			    ctx_req->access_type == RDWR) {
+				insn = alloc_instruction(OP_CONTEXT_REQ, 0);
+				insn->ctx_req = ctx_req;
+				insn->access_type = WRITE;
+				add_one_insn(ep, insn);
+			}
+		} END_FOR_EACH_PTR(ctx_req);
+
+	}
 	add_store(ep, ad, store);
 	return value;
 }
@@ -989,14 +1010,30 @@ static pseudo_t add_symbol_address(struct entrypoint *ep, struct symbol *sym)
 
 static pseudo_t linearize_load_gen(struct entrypoint *ep, struct access_data *ad)
 {
-	pseudo_t new = add_load(ep, ad);
+	pseudo_t new;
+	struct context_requirement *ctx_req;
+
+	if (ad->ctx_reqs) {
+		struct instruction *insn;
+		FOR_EACH_PTR(ad->ctx_reqs, ctx_req) {
+			if (ctx_req->access_type == READ ||
+			    ctx_req->access_type == RDWR) {
+				insn = alloc_instruction(OP_CONTEXT_REQ, 0);
+				insn->ctx_req = ctx_req;
+				insn->access_type = READ;
+				add_one_insn(ep, insn);
+			}
+		} END_FOR_EACH_PTR(ctx_req);
+
+	}
+	new = add_load(ep, ad);
 
 	if (ad->bit_offset) {
 		pseudo_t shift = value_pseudo(ad->bit_offset);
 		pseudo_t newval = add_binary_op(ep, ad->source_type, OP_LSR, new, shift);
 		new = newval;
 	}
-		
+
 	return new;
 }
 
@@ -1195,6 +1232,7 @@ static pseudo_t linearize_call_expression(struct entrypoint *ep, struct expressi
 	pseudo_t retval, call;
 	struct ctype *ctype = NULL;
 	struct context *context;
+	struct context_requirement *ctx_req;
 
 	if (!expr->ctype) {
 		warning(expr->pos, "call with no type!");
@@ -1211,6 +1249,17 @@ static pseudo_t linearize_call_expression(struct entrypoint *ep, struct expressi
 	if (fn->ctype)
 		ctype = &fn->ctype->ctype;
 
+	if (ctype) {
+		FOR_EACH_PTR(ctype->ctx_reqs, ctx_req) {
+			struct instruction *cinsn;
+
+			cinsn = alloc_instruction(OP_CONTEXT_REQ, 0);
+			cinsn->ctx_req = ctx_req;
+			cinsn->access_type = CALL;
+			add_one_insn(ep, cinsn);
+		} END_FOR_EACH_PTR(ctx_req);
+	}
+
 	if (fn->type == EXPR_PREOP) {
 		if (fn->unop->type == EXPR_SYMBOL) {
 			struct symbol *sym = fn->unop->symbol;
@@ -1236,6 +1285,7 @@ static pseudo_t linearize_call_expression(struct entrypoint *ep, struct expressi
 			int out = context->out;
 			int check = 0;
 			int context_diff;
+
 			if (in < 0) {
 				check = 1;
 				in = 0;
diff --git a/linearize.h b/linearize.h
index a71f9aa..8901a82 100644
--- a/linearize.h
+++ b/linearize.h
@@ -124,6 +124,11 @@ struct instruction {
 			const char *string;
 			struct asm_rules *asm_rules;
 		};
+		struct /* context_req */ {
+			int access_type;
+			struct context_requirement* ctx_req;
+		};
+
 	};
 };
 
@@ -212,6 +217,7 @@ enum opcode {
 
 	/* Sparse tagging (line numbers, context, whatever) */
 	OP_CONTEXT,
+	OP_CONTEXT_REQ,
 	OP_RANGE,
 
 	/* Needed to translate SSA back to normal form */
diff --git a/parse.c b/parse.c
index 6255737..6a8e1ac 100644
--- a/parse.c
+++ b/parse.c
@@ -66,6 +66,7 @@ static struct token *attribute_address_space(struct token *token, struct symbol
 static struct token *attribute_aligned(struct token *token, struct symbol *attr, struct ctype *ctype);
 static struct token *attribute_mode(struct token *token, struct symbol *attr, struct ctype *ctype);
 static struct token *attribute_context(struct token *token, struct symbol *attr, struct ctype *ctype);
+static struct token *attribute_require_context(struct token *token, struct symbol *attr, struct ctype *ctype);
 static struct token *attribute_transparent_union(struct token *token, struct symbol *attr, struct ctype *ctype);
 static struct token *ignore_attribute(struct token *token, struct symbol *attr, struct ctype *ctype);
 
@@ -184,6 +185,10 @@ static struct symbol_op context_op = {
 	.attribute = attribute_context,
 };
 
+static struct symbol_op require_context_op = {
+	.attribute = attribute_require_context,
+};
+
 static struct symbol_op transparent_union_op = {
 	.attribute = attribute_transparent_union,
 };
@@ -265,6 +270,7 @@ static struct init_keyword {
 	{ "address_space",NS_KEYWORD,	.op = &address_space_op },
 	{ "mode",	NS_KEYWORD,	.op = &mode_op },
 	{ "context",	NS_KEYWORD,	.op = &context_op },
+	{ "require_context",	NS_KEYWORD,	.op = &require_context_op },
 	{ "__transparent_union__",	NS_KEYWORD,	.op = &transparent_union_op },
 
 	{ "__mode__",	NS_KEYWORD,	.op = &mode_op },
@@ -907,6 +913,72 @@ static struct token *attribute_context(struct token *token, struct symbol *attr,
 	return token;
 }
 
+static int token_to_accesstype(struct token *token)
+{
+	static const char *at_text[] = {
+		[READ]  = "\"read\"",
+		[WRITE] = "\"write\"",
+		[RDWR]  = "\"rdwr\"",
+		[CALL]  = "\"call\""
+	};
+	const char *ats;
+	int i;
+
+	if (token_type(token) != TOKEN_STRING)
+		goto err;
+
+	ats = show_token(token);
+	for (i = 0; i < sizeof at_text/sizeof at_text[0]; i++) {
+		if (!strcmp(ats,at_text[i]))
+			return i;
+	}
+
+err:
+	sparse_error(token->pos, "Expected \"read\", \"write\", \"rdwr\" or \"call\""
+		     " as 4th argument of require_context");
+
+	return RDWR;
+}
+
+static struct token *attribute_require_context(struct token *token, struct symbol *attr, struct ctype *ctype)
+{
+	struct context_requirement *ctx_req = alloc_context_requirement();
+	struct expression *args[3];
+	int argc = 0;
+
+	token = expect(token, '(', "after require_context attribute");
+	while (!match_op(token, ')')) {
+		struct expression *expr = NULL;
+		if (argc < 3) {
+			token = conditional_expression(token, &expr);
+			if (!expr)
+				break;
+		} else {
+			ctx_req->access_type = token_to_accesstype(token);
+			token = token->next;
+			argc++;
+		}
+
+		if (argc < 3)
+			args[argc++] = expr;
+		if (!match_op(token, ','))
+			break;
+		token = token->next;
+	}
+
+	if (argc == 4) {
+		ctx_req->context = args[0];
+		ctx_req->min = get_expression_value(args[1]);
+		ctx_req->max = get_expression_value(args[2]);
+		add_ptr_list(&ctype->ctx_reqs, ctx_req);
+	} else
+		sparse_error(token->pos, "expected context name, min, max and type values");
+
+	token = expect(token, ')', "after context attribute");
+	return token;
+}
+
+
 static struct token *attribute_transparent_union(struct token *token, struct symbol *attr, struct ctype *ctype)
 {
 	if (Wtransparent_union)
@@ -1039,6 +1111,8 @@ static void apply_ctype(struct position pos, struct ctype *thistype, struct ctyp
 	/* Context */
 	concat_ptr_list((struct ptr_list *)thistype->contexts,
 	                (struct ptr_list **)&ctype->contexts);
+	concat_ptr_list((struct ptr_list *)thistype->ctx_reqs,
+	                (struct ptr_list **)&ctype->ctx_reqs);
 
 	/* Alignment */
 	if (thistype->alignment & (thistype->alignment-1)) {
@@ -1246,6 +1320,8 @@ static struct token *pointer(struct token *token, struct ctype *ctype)
 		ptr->ctype.as = ctype->as;
 		concat_ptr_list((struct ptr_list *)ctype->contexts,
 				(struct ptr_list **)&ptr->ctype.contexts);
+		concat_ptr_list((struct ptr_list *)ctype->ctx_reqs,
+				(struct ptr_list **)&ptr->ctype.ctx_reqs);
 		ptr->ctype.base_type = base_type;
 
 		base_type = ptr;
@@ -1253,6 +1329,7 @@ static struct token *pointer(struct token *token, struct ctype *ctype)
 		ctype->base_type = base_type;
 		ctype->as = 0;
 		free_ptr_list(&ctype->contexts);
+		free_ptr_list(&ctype->ctx_reqs);
 
 		token = declaration_specifiers(token->next, ctype, 1);
 		modifiers = ctype->modifiers;
diff --git a/sparse.c b/sparse.c
index 50c5e51..45a1394 100644
--- a/sparse.c
+++ b/sparse.c
@@ -24,13 +24,11 @@
 #include "expression.h"
 #include "linearize.h"
 
-
 int ident_str(struct ident *ident, char *buffer, int length)
 {
 	return snprintf(buffer, length, "%.*s", ident->len, ident->name);
 }
 
-
 int expression_str(struct expression *expr, char *buffer, int length)
 {
 	int n;
@@ -127,6 +125,22 @@ char *expression_sstr(struct expression *expr)
 	return expression_str(expr, expr_string+5, 32) ? expr_string : empty;
 }
 
+static void out_of_context_access(struct basic_block *bb, struct expression *expr,
+				  struct instruction *insn, const char *why)
+{
+	static const char *at_text[] = {
+		[READ] =  "read access",
+		[WRITE] = "write access",
+		[CALL]  = "call"
+	};
+
+	if (Wcontext) {
+		warning(insn->pos, "out of context %s in '%s' - context too %s%s",
+			at_text[insn->access_type], show_ident(bb->ep->name->ident), why,
+			expression_sstr(expr));
+	}
+}
+
 static int context_increase(struct basic_block *bb, struct expression *expr, int entry)
 {
 	int sum = 0;
@@ -134,22 +148,33 @@ static int context_increase(struct basic_block *bb, struct expression *expr, int
 
 	FOR_EACH_PTR(bb->insns, insn) {
 		int val;
-		if (insn->opcode != OP_CONTEXT)
-			continue;
-		if (!expressions_equal(expr, insn->context_expr))
-			continue;
-		val = insn->increment;
-		if (insn->check) {
-			int current = sum + entry;
-			if (!val) {
-				if (!current)
+
+		switch (insn->opcode) {
+		case OP_CONTEXT:
+			if (!expressions_equal(expr, insn->context_expr))
+				continue;
+			val = insn->increment;
+			if (insn->check) {
+				int current = sum + entry;
+				if (!val) {
+					if (!current)
+						continue;
+				} else if (current >= val)
 					continue;
-			} else if (current >= val)
+				warning(insn->pos, "context check failure");
 				continue;
-			warning(insn->pos, "context check failure");
-			continue;
+			}
+			sum += val;
+			break;
+		case OP_CONTEXT_REQ:
+			if (!expressions_equal(expr, insn->ctx_req->context))
+				continue;
+			if (sum+entry < insn->ctx_req->min)
+				out_of_context_access(bb, expr, insn, "small");
+			if (sum+entry > insn->ctx_req->max)
+				out_of_context_access(bb, expr, insn, "high");
+			break;
 		}
-		sum += val;
 	} END_FOR_EACH_PTR(insn);
 	return sum;
 }
@@ -345,6 +370,8 @@ static void check_one_instruction(struct instruction *insn, struct expression_li
 	case OP_CONTEXT:
 		add_expression_once(expr_list, insn->context_expr);
 		break;
+	case OP_CONTEXT_REQ:
+		add_expression_once(expr_list, insn->ctx_req->context);
 	default:
 		break;
 	}
diff --git a/symbol.c b/symbol.c
index 7539817..4564843 100644
--- a/symbol.c
+++ b/symbol.c
@@ -57,6 +57,11 @@ struct context *alloc_context(void)
 	return __alloc_context(0);
 }
 
+struct context_requirement *alloc_context_requirement(void)
+{
+	return __alloc_context_requirement(0);
+}
+
 struct symbol *alloc_symbol(struct position pos, int type)
 {
 	struct symbol *sym = __alloc_symbol(0);
@@ -201,6 +206,8 @@ static struct symbol *examine_base_type(struct symbol *sym)
 	sym->ctype.modifiers |= base_type->ctype.modifiers & MOD_PTRINHERIT;
 	concat_ptr_list((struct ptr_list *)base_type->ctype.contexts,
 			(struct ptr_list **)&sym->ctype.contexts);
+	concat_ptr_list((struct ptr_list *)base_type->ctype.ctx_reqs,
+			(struct ptr_list **)&sym->ctype.ctx_reqs);
 	if (base_type->type == SYM_NODE) {
 		base_type = base_type->ctype.base_type;
 		sym->ctype.base_type = base_type;
@@ -257,6 +264,8 @@ void merge_type(struct symbol *sym, struct symbol *base_type)
 	sym->ctype.modifiers |= (base_type->ctype.modifiers & ~MOD_STORAGE);
 	concat_ptr_list((struct ptr_list *)base_type->ctype.contexts,
 	                (struct ptr_list **)&sym->ctype.contexts);
+	concat_ptr_list((struct ptr_list *)base_type->ctype.ctx_reqs,
+			(struct ptr_list **)&sym->ctype.ctx_reqs);
 	sym->ctype.base_type = base_type->ctype.base_type;
 	if (sym->ctype.base_type->type == SYM_NODE)
 		merge_type(sym, sym->ctype.base_type);
diff --git a/symbol.h b/symbol.h
index 4362f9a..cdb2452 100644
--- a/symbol.h
+++ b/symbol.h
@@ -74,14 +74,23 @@ struct context {
 	unsigned int in, out;
 };
 
+struct context_requirement {
+	struct expression *context;
+	unsigned int min, max;
+	enum { READ, WRITE, RDWR, CALL } access_type;
+};
+
 extern struct context *alloc_context(void);
+extern struct context_requirement *alloc_context_requirement(void);
 
 DECLARE_PTR_LIST(context_list, struct context);
+DECLARE_PTR_LIST(ctx_req_list, struct context_requirement);
 
 struct ctype {
 	unsigned long modifiers;
 	unsigned long alignment;
 	struct context_list *contexts;
+	struct ctx_req_list *ctx_reqs;
 	unsigned int as;
 	struct symbol *base_type;
 };
diff --git a/validation/context_requirement.c b/validation/context_requirement.c
new file mode 100644
index 0000000..24fe598
--- /dev/null
+++ b/validation/context_requirement.c
@@ -0,0 +1,185 @@
+#ifdef __CHECKER__
+# define __acquires(x)	__attribute__((context(x,0,1)))
+# define __releases(x)	__attribute__((context(x,1,0)))
+# define __acquire(x)	__context__(x,1)
+# define __release(x)	__context__(x,-1)
+# define __cond_lock(x,c)	((c) ? ({ __acquire(x); 1; }) : 0)
+# define __protected_by(x)       __attribute__((require_context(x,1,1,"rdwr")))
+# define __protected_read_by(x)  __attribute__((require_context(x,1,1,"read")))
+# define __protected_write_by(x) __attribute__((require_context(x,1,1,"write")))
+# define __must_hold(x)       __attribute__((context(x,1,1), require_context(x,1,1,"call")))
+#else
+# define __acquires(x)
+# define __releases(x)
+# define __acquire(x) (void)0
+# define __release(x) (void)0
+# define __cond_lock(x,c) (c)
+# define __protected_by(x)
+# define __protected_read_by(x)
+# define __protected_write_by(x)
+# define __must_hold(x)
+#endif
+
+
+#include <stdio.h>
+#include <stdlib.h>
+
+static int to_protect __protected_by(local);
+
+static int local_cnt=0;
+
+static void inc_local(void) __acquires(local)
+{
+	__acquire(local);
+	local_cnt++;
+}
+
+
+#define try_inc_local() __cond_lock(local, _try_inc_local())
+static int _try_inc_local(void)
+{
+	if (random() > RAND_MAX/2) {
+		local_cnt++;
+		return 1;
+	}
+	return 0;
+}
+
+#define dec_local(void) do { __release(local); _dec_local(); } while(0)
+static void _dec_local(void)
+{
+	local_cnt--;
+}
+
+static int valid1(void)
+{
+	inc_local();
+	to_protect = 1;
+	dec_local();
+}
+
+static int valid2(void)
+{
+	inc_local();
+	inc_local();
+	dec_local();
+	dec_local();
+}
+
+static int valid3(void)
+{
+	if (try_inc_local()) {
+		dec_local();
+	}
+}
+
+static int valid4(void)
+{
+	if ((random() > RAND_MAX/2) && try_inc_local()) {
+		dec_local();
+	}
+}
+
+static int helper(void) __must_hold(local)
+{
+	to_protect = 1;
+}
+
+static int valid5(void)
+{
+	inc_local();
+	helper();
+	dec_local();
+}
+
+static int invalid0(void) __releases(local)
+{
+	if (random() > RAND_MAX/2)
+		dec_local();
+}
+
+static int invalid1(void)
+{
+	inc_local();
+}
+
+static int invalid2(void)
+{
+	dec_local();
+}
+
+static int invalid3(void)
+{
+	if (try_inc_local()) {
+	}
+	dec_local();
+}
+
+static int invalid4(void)
+{
+	while (random() > RAND_MAX/2)
+		inc_local();
+
+	dec_local();
+}
+
+static int invalid5(void)
+{
+	try_inc_local();
+	dec_local();
+}
+
+static int invalid6(void)
+{
+	to_protect = 1;
+	inc_local();
+	dec_local();
+}
+
+static int invalid7(void)
+{
+	inc_local();
+	dec_local();
+	to_protect = 1;
+}
+
+static int invalid8(void)
+{
+	inc_local();
+	inc_local();
+	to_protect = 2;
+	dec_local();
+	dec_local();
+}
+
+static int invalid9(void)
+{
+	int lv;
+
+	lv = to_protect;
+	inc_local();
+	dec_local();
+}
+
+static int invalid10(void)
+{
+	helper();
+}
+
+/*
+ * check-name: Check -Wcontext
+ *
+ * check-error-start
+context_requirement.c:97:2: warning: context imbalance in 'invalid0' - different lock contexts for basic block
+context_requirement.c:101:12: warning: context imbalance in 'invalid1' - wrong count at exit
+context_requirement.c:106:12: warning: context imbalance in 'invalid2' - unexpected unlock
+context_requirement.c:113:6: warning: context imbalance in 'invalid3' - different lock contexts for basic block
+context_requirement.c:120:2: warning: context imbalance in 'invalid4' - different lock contexts for basic block
+context_requirement.c:129:2: warning: context imbalance in 'invalid5' - different lock contexts for basic block
+context_requirement.c:134:15: warning: out of context write access in 'invalid6' - context too small
+context_requirement.c:143:15: warning: out of context write access in 'invalid7' - context too small
+context_requirement.c:150:15: warning: out of context write access in 'invalid8' - context too high
+context_requirement.c:159:7: warning: out of context read access in 'invalid9' - context too small
+context_requirement.c:166:8: warning: out of context call in 'invalid10' - context too small
+ * check-error-end
+ */


-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
