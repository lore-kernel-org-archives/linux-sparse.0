From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] avoid multiple warnings when inlining undeclared calls
Date: Thu, 25 Jun 2020 21:03:49 +0200
Message-ID: <20200625190349.3665-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403781AbgFYTD6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 25 Jun 2020 15:03:58 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C94C08C5C1
        for <linux-sparse@vger.kernel.org>; Thu, 25 Jun 2020 12:03:57 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id t21so5042884edr.12
        for <linux-sparse@vger.kernel.org>; Thu, 25 Jun 2020 12:03:57 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

When inlining multiple times a function which contains an undeclared
function call, multiple error messages are issued. More annoyingly,
only the first one is meaningful, the other ones doesn't even show
the incriminated identifier:
	error: undefined identifier '...'
	error: not a function <noident>

Part of the problem is that the first message is displayed with
expression_error() which also sets the expression to &bad_ctype.
This change the way how the expression is handled when re-evaluated.

Current fix is to avoid the evaluation of function call if already
set to bad_ctype: it's known that an error message have already been
issued for them and that nothing good can done with them.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                         |  4 ++++
 validation/eval/undecl-no-indent.c | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 validation/eval/undecl-no-indent.c

diff --git a/evaluate.c b/evaluate.c
index 461c2547285f..3b9aec3c13c0 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3130,6 +3130,10 @@ static struct symbol *evaluate_call(struct expression *expr)
 
 	if (ctype->type != SYM_FN) {
 		struct expression *arg;
+
+		if (fn->ctype == &bad_ctype)
+			return NULL;
+
 		expression_error(expr, "not a function %s",
 			     show_ident(sym->ident));
 		/* do typechecking in arguments */
diff --git a/validation/eval/undecl-no-indent.c b/validation/eval/undecl-no-indent.c
new file mode 100644
index 000000000000..4aadf3d99235
--- /dev/null
+++ b/validation/eval/undecl-no-indent.c
@@ -0,0 +1,19 @@
+inline void fun(void)
+{
+	undecl();
+}
+
+void foo(void);
+void foo(void)
+{
+	fun();
+	fun();
+}
+
+/*
+ * check-name: undecl-no-indent
+ *
+ * check-error-start
+eval/undecl-no-indent.c:3:9: error: undefined identifier 'undecl'
+ * check-error-end
+ */
-- 
2.27.0
