From: Edward Cree <ecree@solarflare.com>
Subject: [PATCH v2] Allow casting to a restricted type if !restricted_value
Date: Tue, 21 Feb 2017 12:22:18 +0000
Message-ID: <05504e5f-16ab-276b-b53e-77f71102a154@solarflare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nbfkord-smmo03.seg.att.com ([209.65.160.84]:11166 "EHLO
        nbfkord-smmo03.seg.att.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752117AbdBUMW3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 21 Feb 2017 07:22:29 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, luc Van Oostenryck <luc.vanoostenryck@gmail.com>

If the operand of a cast to a restricted type is an unrestricted value,
 the cast should not produce a warning, since an equivalent implied cast
 (e.g. in an initialiser) would not do so.

Also adds a test case (bitwise-cast.c) testing implicit and explicit
 conversions of zero and nonzero integers to bitwise type.

Signed-off-by: Edward Cree <ecree@solarflare.com>
---
v2: combined change and test case into one patch;
    removed RFC tags.

 evaluate.c                |  2 +-
 validation/bitwise-cast.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100644 validation/bitwise-cast.c

diff --git a/evaluate.c b/evaluate.c
index e350c0c..8e855b1 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2771,7 +2771,7 @@ static struct symbol *evaluate_cast(struct expression *expr)
 		t2 = unfoul(t2);
 
 	if (t1 != t2) {
-		if (class1 & TYPE_RESTRICT)
+		if ((class1 & TYPE_RESTRICT) && restricted_value(target, t1))
 			warning(expr->pos, "cast to %s",
 				show_typename(t1));
 		if (class2 & TYPE_RESTRICT)
diff --git a/validation/bitwise-cast.c b/validation/bitwise-cast.c
new file mode 100644
index 0000000..baeca29
--- /dev/null
+++ b/validation/bitwise-cast.c
@@ -0,0 +1,44 @@
+typedef unsigned int u32;
+typedef u32 __attribute__((bitwise)) __be32;
+
+/* Implicit casts of 0, legal */
+static __be32 foo(void)
+{
+	__be32 x = 0;
+
+	return 0;
+}
+
+/* Explicit cast of 0, legal */
+static __be32 bar(void)
+{
+	return (__be32)0;
+}
+
+/* Implicit casts of nonzero, bad */
+static __be32 baz(void)
+{
+	__be32 x = 0x2a;
+
+	return 99;
+}
+
+/* Explicit cast of nonzero, bad */
+static __be32 quux(void)
+{
+	return (__be32)1729;
+}
+
+/*
+ * check-name: conversions to bitwise types
+ * check-command: sparse -Wbitwise $file
+ * check-error-start
+bitwise-cast.c:21:20: warning: incorrect type in initializer (different base types)
+bitwise-cast.c:21:20:    expected restricted __be32 [usertype] x
+bitwise-cast.c:21:20:    got int
+bitwise-cast.c:23:16: warning: incorrect type in return expression (different base types)
+bitwise-cast.c:23:16:    expected restricted __be32
+bitwise-cast.c:23:16:    got int
+bitwise-cast.c:29:17: warning: cast to restricted __be32
+ * check-error-end
+ */
