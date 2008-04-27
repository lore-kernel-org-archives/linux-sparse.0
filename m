From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 2/5] allow context() attribute on variables
Date: Sun, 27 Apr 2008 13:31:30 +0200
Message-ID: <20080427113349.512685000@sipsolutions.net>
References: <20080427113128.237957000@sipsolutions.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:46142 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758504AbYD0Ly1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 27 Apr 2008 07:54:27 -0400
Content-Disposition: inline; filename=003-context-on-vars.patch
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>

This patch makes it possible to add the context attribute on
variables, to warn for example in this case:

    struct something {
        int x __attribute__((context(L,1,1)));
    };

    extern struct something *s;

    static void warn_access13(void)
    {
        s->x = 7;
    }

This is achieved by translating the context attribute on
variables that are loaded from/stored to into a context
expression internally. A number of tests are included,
including tests for a struct member (as above) and array
accesses.

To distinguish between reads and writes (the default is to
check both) use the fourth parameter to the context attribute:
	__attribute__((context(L,1,1,read)))
or
	__attribute__((context(L,1,1,write)))

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
The exact_context() attribute is also allowed so we have the
same max/no-max semantics as functions.

 linearize.c                    |   92 ++++++++++++++++-
 linearize.h                    |    1 
 parse.c                        |   25 ++++
 sparse.1                       |    7 +
 sparse.c                       |   18 ++-
 symbol.h                       |    7 +
 validation/context-exact.c     |    2 
 validation/context-on-vars.c   |  219 +++++++++++++++++++++++++++++++++++++++++
 validation/context-statement.c |    6 -
 9 files changed, 365 insertions(+), 12 deletions(-)

--- sparse.orig/sparse.c	2008-04-26 23:09:05.000000000 +0200
+++ sparse/sparse.c	2008-04-26 23:09:27.000000000 +0200
@@ -114,6 +114,7 @@ static struct context_check_list *checke
 }
 
 #define IMBALANCE_IN "context imbalance in '%s': "
+#define CONTEXT_PROB "context problem in '%s': "
 #define DEFAULT_CONTEXT_DESCR "   default context: "
 
 static void get_context_string(char **buf, const char **name)
@@ -267,10 +268,19 @@ static int handle_context(struct entrypo
 	if (!ok && Wcontext) {
 		get_context_string(&buf, &name);
 
-		warning(insn->pos,
-			IMBALANCE_IN
-			"__context__ statement expected different context",
-			show_ident(ep->name->ident));
+		if (insn->access_var) {
+			char *symname = strdup(show_ident(insn->access_var->ident));
+			warning(insn->pos,
+				CONTEXT_PROB
+				"access to '%s' requires different context",
+				show_ident(ep->name->ident), symname);
+			free(symname);
+		} else {
+			warning(insn->pos,
+				CONTEXT_PROB
+				"__context__ statement expected different context",
+				show_ident(ep->name->ident));
+		}
 
 		info(insn->pos, "%swanted %s%d, got %d",
 		     name, cmp, insn->required, val);
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ sparse/validation/context-on-vars.c	2008-04-26 23:37:36.000000000 +0200
@@ -0,0 +1,219 @@
+static void a(void) __attribute__((context(L,0,1)))
+{
+	__context__(L,1);
+}
+
+static void r(void) __attribute__((context(L,1,0)))
+{
+	__context__(L,-1);
+}
+
+static int nl_int __attribute__((context(L,1,1)));
+static int nl_array[100] __attribute__((context(L,1,1)));
+extern int condition;
+
+static void warn_access1(void)
+{
+    nl_int = 7;
+}
+
+static void warn_access2(void)
+{
+    nl_int++;
+}
+
+static void warn_access3(void)
+{
+    if (condition)
+        nl_int++;
+}
+
+static void warn_access4(void)
+{
+    condition -= nl_int;
+}
+
+static void warn_access5(void)
+{
+    int x = condition ? nl_int : 0;
+}
+
+static void warn_access6(void)
+{
+    if (!nl_int) {
+        condition = 1;
+    }
+}
+
+static void warn_access7(void)
+{
+    if (nl_int) {
+        condition = 1;
+    }
+}
+
+static int *warn_access8(void)
+{
+    return &nl_int;
+}
+
+static void warn_access9(void)
+{
+    (void*)nl_int;
+}
+
+static void warn_access10(void)
+{
+    nl_array[7]++;
+}
+
+static void good_access1(void)
+{
+    a();
+    nl_int = 7;
+    r();
+}
+
+static void good_access1(void)
+{
+    if (condition) {
+        a();
+        nl_int = 7;
+        r();
+    }
+}
+
+static void good_access3(void)
+{
+    /* tests more our ability to optimise things out ... */
+    int x = 0 ? nl_int : 0;
+}
+
+static int *good_access4(void)
+{
+    return &nl_int;
+}
+
+struct something {
+    int a;
+    int b;
+};
+
+extern struct something *s __attribute__((context(L,1,1)));
+
+static void warn_access11(void)
+{
+    s->b = 7;
+}
+
+struct something2 {
+    int a;
+    int b __attribute__((context(L,1,1)));
+};
+
+extern struct something2 *s2;
+extern int lx __attribute__((context(L,1,1)));
+
+static void warn_access12(void)
+{
+    s2->b = lx;
+}
+
+static void warn_access13(void)
+{
+    s2->b = 7;
+}
+
+static void good_1(void)
+{
+    a();
+    s2->b = 7;
+    r();
+}
+
+static void good_2(void)
+{
+    a();
+    a();
+    s2->b = 8;
+    r();
+    r();
+}
+
+struct something3 {
+    int a;
+    int b __attribute__((exact_context(L,1,1)));
+};
+
+extern struct something3 *s3;
+
+static void warn_exact1(void)
+{
+    a();
+    a();
+    s3->b = 8;
+    r();
+    r();
+}
+
+extern int x __attribute__((context(L,1,1,read)));
+extern int y __attribute__((context(L,1,1,write)));
+
+static void good_3(void)
+{
+  a();
+  y = x;
+  r();
+}
+
+static void good_4(void)
+{
+  x = y;
+}
+
+static void warn_access14(void)
+{
+  x;
+}
+
+static void warn_access15(void)
+{
+  y = 7;
+}
+
+/*
+ * check-name: Check -Wcontext for variables
+ *
+ * check-error-start
+context-on-vars.c:17:14: warning: context problem in 'warn_access1': access to 'nl_int' requires different context
+context-on-vars.c:17:14:    context 'L': wanted >= 1, got 0
+context-on-vars.c:22:11: warning: context problem in 'warn_access2': access to 'nl_int' requires different context
+context-on-vars.c:22:11:    context 'L': wanted >= 1, got 0
+context-on-vars.c:28:15: warning: context problem in 'warn_access3': access to 'nl_int' requires different context
+context-on-vars.c:28:15:    context 'L': wanted >= 1, got 0
+context-on-vars.c:33:18: warning: context problem in 'warn_access4': access to 'nl_int' requires different context
+context-on-vars.c:33:18:    context 'L': wanted >= 1, got 0
+context-on-vars.c:38:25: warning: context problem in 'warn_access5': access to 'nl_int' requires different context
+context-on-vars.c:38:25:    context 'L': wanted >= 1, got 0
+context-on-vars.c:43:10: warning: context problem in 'warn_access6': access to 'nl_int' requires different context
+context-on-vars.c:43:10:    context 'L': wanted >= 1, got 0
+context-on-vars.c:50:9: warning: context problem in 'warn_access7': access to 'nl_int' requires different context
+context-on-vars.c:50:9:    context 'L': wanted >= 1, got 0
+context-on-vars.c:62:12: warning: context problem in 'warn_access9': access to 'nl_int' requires different context
+context-on-vars.c:62:12:    context 'L': wanted >= 1, got 0
+context-on-vars.c:67:16: warning: context problem in 'warn_access10': access to 'nl_array' requires different context
+context-on-vars.c:67:16:    context 'L': wanted >= 1, got 0
+context-on-vars.c:106:5: warning: context problem in 'warn_access11': access to 's' requires different context
+context-on-vars.c:106:5:    context 'L': wanted >= 1, got 0
+context-on-vars.c:119:13: warning: context problem in 'warn_access12': access to 'lx' requires different context
+context-on-vars.c:119:13:    context 'L': wanted >= 1, got 0
+context-on-vars.c:124:5: warning: context problem in 'warn_access13': access to 'b' requires different context
+context-on-vars.c:124:5:    context 'L': wanted >= 1, got 0
+context-on-vars.c:154:5: warning: context problem in 'warn_exact1': access to 'b' requires different context
+context-on-vars.c:154:5:    context 'L': wanted 1, got 2
+context-on-vars.c:176:3: warning: context problem in 'warn_access14': access to 'x' requires different context
+context-on-vars.c:176:3:    context 'L': wanted >= 1, got 0
+context-on-vars.c:181:7: warning: context problem in 'warn_access15': access to 'y' requires different context
+context-on-vars.c:181:7:    context 'L': wanted >= 1, got 0
+ * check-error-end
+ */
--- sparse.orig/linearize.c	2008-04-26 23:09:05.000000000 +0200
+++ sparse/linearize.c	2008-04-26 23:37:56.000000000 +0200
@@ -30,7 +30,6 @@ static pseudo_t add_setval(struct entryp
 static pseudo_t linearize_one_symbol(struct entrypoint *ep, struct symbol *sym);
 
 struct access_data;
-static pseudo_t add_load(struct entrypoint *ep, struct access_data *);
 static pseudo_t linearize_initializer(struct entrypoint *ep, struct expression *initializer, struct access_data *);
 
 struct pseudo void_pseudo = {};
@@ -935,6 +934,8 @@ static pseudo_t linearize_store_gen(stru
 		pseudo_t value,
 		struct access_data *ad)
 {
+	struct context *context;
+	struct instruction *insn;
 	pseudo_t store = value;
 
 	if (type_size(ad->source_type) != type_size(ad->result_type)) {
@@ -950,6 +951,49 @@ static pseudo_t linearize_store_gen(stru
 		store = add_binary_op(ep, ad->source_type, OP_OR, orig, store);
 	}
 	add_store(ep, ad, store);
+
+	FOR_EACH_PTR(ad->source_type->ctype.contexts, context) {
+		if (context->rws != CTX_RWS_BOTH &&
+		    context->rws != CTX_RWS_WRITE)
+			continue;
+		insn = alloc_instruction(OP_CONTEXT, 0);
+		insn->required = context->in;
+		insn->increment = insn->inc_false = context->out - context->in;
+		insn->context_expr = context->context;
+		insn->access_var = ad->source_type;
+		insn->exact = context->exact;
+		add_one_insn(ep, insn);
+	} END_FOR_EACH_PTR(context);
+
+	FOR_EACH_PTR(ad->result_type->ctype.contexts, context) {
+		if (context->rws != CTX_RWS_BOTH &&
+		    context->rws != CTX_RWS_WRITE)
+			continue;
+		insn = alloc_instruction(OP_CONTEXT, 0);
+		insn->required = context->in;
+		insn->increment = insn->inc_false = context->out - context->in;
+		insn->context_expr = context->context;
+		insn->access_var = ad->result_type;
+		insn->exact = context->exact;
+		add_one_insn(ep, insn);
+	} END_FOR_EACH_PTR(context);
+
+	if (ad->address->type == PSEUDO_SYM &&
+	    ad->address->sym->namespace & NS_SYMBOL) {
+		FOR_EACH_PTR(ad->address->sym->ctype.contexts, context) {
+			if (context->rws != CTX_RWS_BOTH &&
+			    context->rws != CTX_RWS_WRITE)
+				continue;
+			insn = alloc_instruction(OP_CONTEXT, 0);
+			insn->required = context->in;
+			insn->increment = insn->inc_false = context->out - context->in;
+			insn->context_expr = context->context;
+			insn->access_var = ad->address->sym;
+			insn->exact = context->exact;
+			add_one_insn(ep, insn);
+		} END_FOR_EACH_PTR(context);
+	}
+
 	return value;
 }
 
@@ -987,6 +1031,8 @@ static pseudo_t add_symbol_address(struc
 
 static pseudo_t linearize_load_gen(struct entrypoint *ep, struct access_data *ad)
 {
+	struct context *context;
+	struct instruction *insn;
 	pseudo_t new = add_load(ep, ad);
 
 	if (ad->bit_offset) {
@@ -994,7 +1040,49 @@ static pseudo_t linearize_load_gen(struc
 		pseudo_t newval = add_binary_op(ep, ad->source_type, OP_LSR, new, shift);
 		new = newval;
 	}
-		
+
+	FOR_EACH_PTR(ad->source_type->ctype.contexts, context) {
+		if (context->rws != CTX_RWS_BOTH &&
+		    context->rws != CTX_RWS_READ)
+			continue;
+		insn = alloc_instruction(OP_CONTEXT, 0);
+		insn->required = context->in;
+		insn->increment = insn->inc_false = context->out - context->in;
+		insn->context_expr = context->context;
+		insn->access_var = ad->source_type;
+		insn->exact = context->exact;
+		add_one_insn(ep, insn);
+	} END_FOR_EACH_PTR(context);
+
+	FOR_EACH_PTR(ad->result_type->ctype.contexts, context) {
+		if (context->rws != CTX_RWS_BOTH &&
+		    context->rws != CTX_RWS_READ)
+			continue;
+		insn = alloc_instruction(OP_CONTEXT, 0);
+		insn->required = context->in;
+		insn->increment = insn->inc_false = context->out - context->in;
+		insn->context_expr = context->context;
+		insn->access_var = ad->result_type;
+		insn->exact = context->exact;
+		add_one_insn(ep, insn);
+	} END_FOR_EACH_PTR(context);
+
+	if (ad->address->type == PSEUDO_SYM &&
+	    ad->address->sym->namespace & NS_SYMBOL) {
+		FOR_EACH_PTR(ad->address->sym->ctype.contexts, context) {
+			if (context->rws != CTX_RWS_BOTH &&
+			    context->rws != CTX_RWS_READ)
+				continue;
+			insn = alloc_instruction(OP_CONTEXT, 0);
+			insn->required = context->in;
+			insn->increment = insn->inc_false = context->out - context->in;
+			insn->context_expr = context->context;
+			insn->access_var = ad->address->sym;
+			insn->exact = context->exact;
+			add_one_insn(ep, insn);
+		} END_FOR_EACH_PTR(context);
+	}
+
 	return new;
 }
 
--- sparse.orig/linearize.h	2008-04-26 23:09:05.000000000 +0200
+++ sparse/linearize.h	2008-04-26 23:09:27.000000000 +0200
@@ -118,6 +118,7 @@ struct instruction {
 		struct /* context */ {
 			int increment, required, inc_false, exact;
 			struct expression *context_expr;
+			struct symbol *access_var;
 		};
 		struct /* asm */ {
 			const char *string;
--- sparse.orig/validation/context-statement.c	2008-04-26 23:08:59.000000000 +0200
+++ sparse/validation/context-statement.c	2008-04-26 23:09:06.000000000 +0200
@@ -59,11 +59,11 @@ static void bad_macro3(void)
  * check-error-start
 context-statement.c:16:8: warning: context imbalance in 'bad_arr': unexpected unlock
 context-statement.c:16:8:    context 'LOCK': wanted 0, got -1
-context-statement.c:38:5: warning: context imbalance in 'bad_macro1': __context__ statement expected different context
+context-statement.c:38:5: warning: context problem in 'bad_macro1': __context__ statement expected different context
 context-statement.c:38:5:    context 'LOCK': wanted >= 1, got 0
-context-statement.c:47:5: warning: context imbalance in 'bad_macro2': __context__ statement expected different context
+context-statement.c:47:5: warning: context problem in 'bad_macro2': __context__ statement expected different context
 context-statement.c:47:5:    context 'LOCK': wanted >= 1, got 0
-context-statement.c:53:5: warning: context imbalance in 'bad_macro3': __context__ statement expected different context
+context-statement.c:53:5: warning: context problem in 'bad_macro3': __context__ statement expected different context
 context-statement.c:53:5:    context 'LOCK': wanted >= 0, got -1
  * check-error-end
  */
--- sparse.orig/sparse.1	2008-04-26 23:09:05.000000000 +0200
+++ sparse/sparse.1	2008-04-26 23:42:50.000000000 +0200
@@ -94,6 +94,13 @@ There is also the corresponding
 .BI __exact_context__( [expression , ]adjust_value[ , required] )
 statement.
 
+Both these can also be added to variable accesses but it is not recommended
+to make variable accesses modify the context. For variables, it is possible
+to distinguish between reads and writes (the regular context attribute will
+be required on both reads and writes) by using either the token "read" or
+the token "write" for an optional fourth argument:
+.BI __attribute__((context( expression , in_context , out_context , read|write )).
+
 To indicate that a certain function acquires a context depending on its
 return value, use
 .BI __attribute__((conditional_context( [expression ,] in_context , out_success , out_failure ))
--- sparse.orig/validation/context-exact.c	2008-04-26 23:09:05.000000000 +0200
+++ sparse/validation/context-exact.c	2008-04-26 23:09:06.000000000 +0200
@@ -61,7 +61,7 @@ static void good_5(void)
  * check-name: Check __exact_context__ statement with required context
  *
  * check-error-start
-context-exact.c:46:2: warning: context imbalance in 'warn_1': __context__ statement expected different context
+context-exact.c:46:2: warning: context problem in 'warn_1': __context__ statement expected different context
 context-exact.c:46:2:    context 'TEST': wanted 1, got 2
  * check-error-end
  */
--- sparse.orig/parse.c	2008-04-26 23:37:51.000000000 +0200
+++ sparse/parse.c	2008-04-26 23:39:10.000000000 +0200
@@ -883,16 +883,18 @@ static struct token *attribute_mode(stru
 static struct token *_attribute_context(struct token *token, struct symbol *attr, struct ctype *ctype, int exact)
 {
 	struct context *context = alloc_context();
-	struct expression *args[3];
+	struct expression *args[4];
 	int argc = 0;
+	struct token *last = NULL;
 
 	token = expect(token, '(', "after context attribute");
 	while (!match_op(token, ')')) {
 		struct expression *expr = NULL;
+		last = token;
 		token = conditional_expression(token, &expr);
 		if (!expr)
 			break;
-		if (argc < 3)
+		if (argc < 4)
 			args[argc++] = expr;
 		else
 			argc++;
@@ -917,6 +919,25 @@ static struct token *_attribute_context(
 		context->in = get_expression_value(args[1]);
 		context->out = get_expression_value(args[2]);
 		break;
+	case 4: {
+		const char *rw;
+		context->context = args[0];
+		context->in = get_expression_value(args[1]);
+		context->out = get_expression_value(args[2]);
+
+		if (last && token_type(last) == TOKEN_IDENT)
+			rw = show_token(last);
+		else
+			rw = NULL;
+
+		if (rw && strcmp(rw, "read") == 0)
+			context->rws = CTX_RWS_READ;
+		else if (rw && strcmp(rw, "write") == 0)
+			context->rws = CTX_RWS_WRITE;
+		else
+			sparse_error(last->pos, "invalid read/write specifier");
+		break;
+	}
 	default:
 		sparse_error(token->pos, "too many arguments to context attribute");
 		break;
--- sparse.orig/symbol.h	2008-04-26 23:37:51.000000000 +0200
+++ sparse/symbol.h	2008-04-26 23:37:56.000000000 +0200
@@ -69,10 +69,17 @@ enum keyword {
 	KW_MODE		= 1 << 7,
 };
 
+enum context_read_write_specifier {
+	CTX_RWS_BOTH = 0,
+	CTX_RWS_READ,
+	CTX_RWS_WRITE,
+};
+
 struct context {
 	struct expression *context;
 	unsigned int in, out, out_false;
 	int exact;
+	enum context_read_write_specifier rws;
 };
 
 extern struct context *alloc_context(void);

-- 

