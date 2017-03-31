From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 25/25] constexpr: flag __builtin_bswap() as constexpr
Date: Fri, 31 Mar 2017 03:44:59 +0200
Message-ID: <20170331014459.9351-26-luc.vanoostenryck@gmail.com>
References: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33396 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934742AbdCaBqx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Mar 2017 21:46:53 -0400
Received: by mail-wr0-f193.google.com with SMTP id u18so16611990wrc.0
        for <linux-sparse@vger.kernel.org>; Thu, 30 Mar 2017 18:46:52 -0700 (PDT)
In-Reply-To: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Nicolai Stange <nicstange@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c                           | 17 +++++++++++++++++
 validation/constexpr-pure-builtin.c | 23 +++++++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 validation/constexpr-pure-builtin.c

diff --git a/builtin.c b/builtin.c
index a427b45ee..139448988 100644
--- a/builtin.c
+++ b/builtin.c
@@ -34,6 +34,22 @@ static int evaluate_to_int_const_expr(struct expression *expr)
 	return 1;
 }
 
+static int evaluate_pure_unop(struct expression *expr)
+{
+	struct expression *arg = first_expression(expr->args);
+	int flags = arg->flags;
+
+	/*
+	 * Allow such functions with a constant integer expression
+	 * argument to be treated as a *constant* integer.
+	 * This allow us to use them in switch() { case ...:
+	 */
+	flags |= (flags & CEF_ICE) ? CEF_SET_INT : 0;
+	expr->flags = flags;
+	return 1;
+}
+
+
 static int evaluate_expect(struct expression *expr)
 {
 	/* Should we evaluate it to return the type of the first argument? */
@@ -201,6 +217,7 @@ static int expand_bswap(struct expression *expr, int cost)
 }
 
 static struct symbol_op bswap_op = {
+	.evaluate = evaluate_pure_unop,
 	.expand = expand_bswap,
 };
 
diff --git a/validation/constexpr-pure-builtin.c b/validation/constexpr-pure-builtin.c
new file mode 100644
index 000000000..f4cd67eda
--- /dev/null
+++ b/validation/constexpr-pure-builtin.c
@@ -0,0 +1,23 @@
+// requires constant integer expressions
+static int bar[] = {
+	[__builtin_bswap16(0x1234)] = 0,		// OK
+	[__builtin_bswap32(0x1234)] = 0,		// OK
+	[__builtin_bswap64(0x1234)] = 0,		// OK
+};
+
+// requires constant integers
+static int foo(unsigned long long a)
+{
+	switch (a) {
+	case __builtin_bswap16(1   <<  8):
+	case __builtin_bswap32(2L  << 24):
+	case __builtin_bswap64(3LL << 56):
+		return 0;
+	default:
+		return 1;
+	}
+}
+
+/*
+ * check-name: constness of pure/const builtins
+ */
-- 
2.12.0

