From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/4] builtin: extract eval_args() from arguments_choose()
Date: Sat, 17 Feb 2018 15:56:31 +0100
Message-ID: <20180217145634.53616-2-luc.vanoostenryck@gmail.com>
References: <20180217145634.53616-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38363 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751005AbeBQO4n (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 17 Feb 2018 09:56:43 -0500
Received: by mail-wm0-f65.google.com with SMTP id z9so2592958wmb.3
        for <linux-sparse@vger.kernel.org>; Sat, 17 Feb 2018 06:56:42 -0800 (PST)
In-Reply-To: <20180217145634.53616-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Almost the same code is needed for others builtins, only
with another function name a arguments number.

So, extract this into a generic helper.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c | 49 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/builtin.c b/builtin.c
index f5ea06ab9..9aa109d15 100644
--- a/builtin.c
+++ b/builtin.c
@@ -51,6 +51,35 @@ static int evaluate_pure_unop(struct expression *expr)
 	return 1;
 }
 
+/*
+ * eval_args - check the number of arguments and evaluate them.
+ */
+static int eval_args(struct expression *expr, int n)
+{
+	struct expression *arg;
+	struct symbol *sym;
+	const char *msg;
+	int rc = 1;
+
+	FOR_EACH_PTR(expr->args, arg) {
+		if (n-- == 0) {
+			msg = "too many arguments";
+			goto error;
+		}
+		if (!evaluate_expression(arg))
+			rc = 0;
+	} END_FOR_EACH_PTR(arg);
+	if (n > 0) {
+		msg = "not enough arguments";
+		goto error;
+	}
+	return rc;
+
+error:
+	sym = expr->fn->ctype;
+	expression_error(expr, "%s for %s", msg, show_ident(sym->ident));
+	return 0;
+}
 
 static int evaluate_expect(struct expression *expr)
 {
@@ -61,25 +90,7 @@ static int evaluate_expect(struct expression *expr)
 
 static int arguments_choose(struct expression *expr)
 {
-	struct expression_list *arglist = expr->args;
-	struct expression *arg;
-	int i = 0;
