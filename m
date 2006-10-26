From: Matthew Wilcox <matthew@wil.cx>
Subject: [PATCH] Add __builtin_popcountl
Date: Thu, 26 Oct 2006 11:47:30 -0600
Message-ID: <20061026174730.GE5591@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:23263 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1161366AbWJZRrb (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 26 Oct 2006 13:47:31 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


IA-64 uses __builtin_popcountl() which wasn't a function sparse knew
about.  This patch adds it.  I've never looked at sparse before, so this
is a hack-and-run job.  Please feel free to rewrite it if it doesn't suit.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

diff --git a/symbol.c b/symbol.c
index 6c91112..388e19d 100644
--- a/symbol.c
+++ b/symbol.c
@@ -592,6 +592,29 @@ static int evaluate_choose(struct expres
 	return 1;
 }
 
+static int arguments_popcountl(struct expression *expr)
+{
+	struct expression_list *arglist = expr->args;
+	struct expression *arg;
+	int i = 0;
+
+	FOR_EACH_PTR (arglist, arg) {
+		if (!evaluate_expression(arg))
+			return 0;
+		i++;
+	} END_FOR_EACH_PTR(arg);
+	if (i < 1) {
+		sparse_error(expr->pos,
+			     "not enough arguments for __builtin_popcountl");
+		return 0;
+	} if (i > 1) {
+		sparse_error(expr->pos,
+			     "too many arguments for __builtin_popcountl");
+		return 0;
+	}
+	return 1;
+}
+
 static int expand_expect(struct expression *expr, int cost)
 {
 	struct expression *arg = first_ptr_list((struct ptr_list *) expr->args);
@@ -744,6 +767,11 @@ static struct symbol_op choose_op = {
 	.args = arguments_choose,
 };
 
+static struct symbol_op popcountl_op = {
+	.evaluate = evaluate_to_integer,
+	.args = arguments_popcountl,
+};
+
 /*
  * Builtin functions
  */
@@ -754,6 +782,7 @@ static struct sym_init eval_init_table[]
 	{ "__builtin_warning", &builtin_fn_type, MOD_TOPLEVEL, &warning_op },
 	{ "__builtin_expect", &builtin_fn_type, MOD_TOPLEVEL, &expect_op },
 	{ "__builtin_choose_expr", &builtin_fn_type, MOD_TOPLEVEL, &choose_op },
+	{ "__builtin_popcountl", &builtin_fn_type, MOD_TOPLEVEL, &popcountl_op },
 	{ NULL,		NULL,		0 }
 };
 
