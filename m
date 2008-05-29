From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 2/9] add __exact_context__
Date: Thu, 29 May 2008 10:54:04 +0200
Message-ID: <20080529085514.035665000@sipsolutions.net>
References: <20080529085402.814224000@sipsolutions.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:45659 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756031AbYE2I5u (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 29 May 2008 04:57:50 -0400
Content-Disposition: inline; filename=003-exact-context.patch
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-sparse@vger.kernel.org

We also need a statement to indicate that an exact context is
required, most notably the next patch will require it so that
it can translate attributes on variables into statements.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 ident-list.h               |    1 
 linearize.c                |    1 
 linearize.h                |    2 -
 parse.c                    |   20 ++++++++++++-
 parse.h                    |    1 
 sparse.1                   |    2 -
 sparse.c                   |   14 ++++++---
 validation/context-exact.c |   67 +++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 101 insertions(+), 7 deletions(-)

--- sparse.orig/ident-list.h	2008-04-26 23:09:00.000000000 +0200
+++ sparse/ident-list.h	2008-04-26 23:09:05.000000000 +0200
@@ -96,6 +96,7 @@ __IDENT(__PRETTY_FUNCTION___ident, "__PR
 
 /* Sparse commands */
 IDENT_RESERVED(__context__);
+IDENT_RESERVED(__exact_context__);
 IDENT_RESERVED(__range__);
 
 /* Magic function names we recognize */
--- sparse.orig/linearize.c	2008-04-26 23:09:00.000000000 +0200
+++ sparse/linearize.c	2008-04-26 23:09:05.000000000 +0200
@@ -1681,6 +1681,7 @@ static pseudo_t linearize_context(struct
 		value = expr->value;
 
 	insn->required = value;
+	insn->exact = stmt->exact;
 
 	insn->context_expr = stmt->context;
 	add_one_insn(ep, insn);
--- sparse.orig/parse.c	2008-04-26 23:09:04.000000000 +0200
+++ sparse/parse.c	2008-04-26 23:09:05.000000000 +0200
@@ -52,6 +52,7 @@ static struct token *parse_while_stateme
 static struct token *parse_do_statement(struct token *token, struct statement *stmt);
 static struct token *parse_goto_statement(struct token *token, struct statement *stmt);
 static struct token *parse_context_statement(struct token *token, struct statement *stmt);
+static struct token *parse_exact_context_statement(struct token *token, struct statement *stmt);
 static struct token *parse_range_statement(struct token *token, struct statement *stmt);
 static struct token *parse_asm_statement(struct token *token, struct statement *stmt);
 static struct token *toplevel_asm_declaration(struct token *token, struct symbol_list **list);
@@ -149,6 +150,10 @@ static struct symbol_op __context___op =
 	.statement = parse_context_statement,
 };
 
+static struct symbol_op __exact_context___op = {
+	.statement = parse_exact_context_statement,
+};
+
 static struct symbol_op range_op = {
 	.statement = parse_range_statement,
 };
@@ -254,6 +259,7 @@ static struct init_keyword {
 	{ "do",		NS_KEYWORD, .op = &do_op },
 	{ "goto",	NS_KEYWORD, .op = &goto_op },
 	{ "__context__",NS_KEYWORD, .op = &__context___op },
+	{ "__exact_context__",NS_KEYWORD, .op = &__exact_context___op },
 	{ "__range__",	NS_KEYWORD, .op = &range_op },
 	{ "asm",	NS_KEYWORD, .op = &asm_op },
 	{ "__asm",	NS_KEYWORD, .op = &asm_op },
@@ -1810,7 +1816,7 @@ static struct token *parse_goto_statemen
 	return expect(token, ';', "at end of statement");
 }
 
-static struct token *parse_context_statement(struct token *token, struct statement *stmt)
+static struct token *_parse_context_statement(struct token *token, struct statement *stmt, int exact)
 {
 	struct expression *args[3];
 	int argc = 0;
@@ -1835,6 +1841,8 @@ static struct token *parse_context_state
 	stmt->expression = args[0];
 	stmt->context = NULL;
 
+	stmt->exact = exact;
+
 	switch (argc) {
 	case 0:
 		sparse_error(token->pos, "__context__ statement needs argument(s)");
@@ -1864,6 +1872,16 @@ static struct token *parse_context_state
 	return expect(token, ')', "at end of __context__");
 }
 
+static struct token *parse_context_statement(struct token *token, struct statement *stmt)
+{
+	return _parse_context_statement(token, stmt, 0);
+}
+
+static struct token *parse_exact_context_statement(struct token *token, struct statement *stmt)
+{
+	return _parse_context_statement(token, stmt, 1);
+}
+
 static struct token *parse_range_statement(struct token *token, struct statement *stmt)
 {
 	stmt->type = STMT_RANGE;
--- sparse.orig/sparse.1	2008-04-26 23:09:00.000000000 +0200
+++ sparse/sparse.1	2008-04-26 23:09:05.000000000 +0200
@@ -90,7 +90,7 @@ To indicate that a function requires
 .BI exactly
 a certain lock context (not "at least" as above), use the form
 .BI __attribute__((exact_context( [expression ,] in_context , out_context ))
-There currently is no corresponding
+There is also the corresponding
 .BI __exact_context__( [expression , ]adjust_value[ , required] )
 statement.
 
--- sparse.orig/sparse.c	2008-04-26 23:09:00.000000000 +0200
+++ sparse/sparse.c	2008-04-26 23:09:05.000000000 +0200
@@ -239,7 +239,7 @@ static int handle_context(struct entrypo
 			  struct context_check_list **combined)
 {
 	struct context_check *c;
-	const char *name;
+	const char *name, *cmp;
 	char *buf;
 	int val, ok;
 
@@ -256,7 +256,13 @@ static int handle_context(struct entrypo
 		}
 	} END_FOR_EACH_PTR(c);
 
-	ok = insn->required <= val;
+	if (insn->exact) {
+		ok = insn->required == val;
+		cmp = "";
+	} else {
+		ok = insn->required <= val;
+		cmp = ">= ";
+	}
 
 	if (!ok && Wcontext) {
 		get_context_string(&buf, &name);
@@ -266,8 +272,8 @@ static int handle_context(struct entrypo
 			"__context__ statement expected different context",
 			show_ident(ep->name->ident));
 
-		info(insn->pos, "%swanted >= %d, got %d",
-		     name, insn->required, val);
+		info(insn->pos, "%swanted %s%d, got %d",
+		     name, cmp, insn->required, val);
 
 		free(buf);
 		return -1;
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ sparse/validation/context-exact.c	2008-04-26 23:09:05.000000000 +0200
@@ -0,0 +1,67 @@
+static void a(void) __attribute__((context(TEST,0,1)))
+{
+	__context__(TEST,1);
+}
+
+static void r(void) __attribute__((context(TEST,1,0)))
+{
+	__context__(TEST,-1,1);
+}
+
+static void good_1(void)
+{
+	a();
+	r();
+}
+
+static void good_2(void)
+{
+	a();
+	r();
+	a();
+	r();
+}
+
+static void good_3(void)
+{
+	a();
+	a();
+	r();
+	r();
+}
+
+static void good_4(void)
+{
+	a();
+	a();
+	__context__(TEST,0,1);
+	r();
+	r();
+}
+
+static void warn_1(void)
+{
+	a();
+	a();
+	__exact_context__(TEST,0,1);
+	r();
+	r();
+}
+
+static void good_5(void)
+{
+	a();
+	a();
+	__exact_context__(TEST,0,2);
+	r();
+	r();
+}
+
+/*
+ * check-name: Check __exact_context__ statement with required context
+ *
+ * check-error-start
+context-exact.c:46:2: warning: context imbalance in 'warn_1': __context__ statement expected different context
+context-exact.c:46:2:    context 'TEST': wanted 1, got 2
+ * check-error-end
+ */
--- sparse.orig/linearize.h	2008-04-26 23:09:00.000000000 +0200
+++ sparse/linearize.h	2008-04-26 23:09:05.000000000 +0200
@@ -116,7 +116,7 @@ struct instruction {
 			struct pseudo_list *arguments;
 		};
 		struct /* context */ {
-			int increment, required, inc_false;
+			int increment, required, inc_false, exact;
 			struct expression *context_expr;
 		};
 		struct /* asm */ {
--- sparse.orig/parse.h	2008-04-26 23:09:00.000000000 +0200
+++ sparse/parse.h	2008-04-26 23:09:05.000000000 +0200
@@ -43,6 +43,7 @@ struct statement {
 			struct expression *expression;
 			struct expression *context;
 			struct expression *required;
+			int exact;
 		};
 		struct /* return_statement */ {
 			struct expression *ret_value;

-- 

