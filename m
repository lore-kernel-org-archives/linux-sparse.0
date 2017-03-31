From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 15/25] constexpr: recognize members of static compound objects as address constants
Date: Fri, 31 Mar 2017 03:44:49 +0200
Message-ID: <20170331014459.9351-16-luc.vanoostenryck@gmail.com>
References: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35202 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935019AbdCaBqo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Mar 2017 21:46:44 -0400
Received: by mail-wr0-f194.google.com with SMTP id p52so16621606wrc.2
        for <linux-sparse@vger.kernel.org>; Thu, 30 Mar 2017 18:46:43 -0700 (PDT)
In-Reply-To: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Nicolai Stange <nicstange@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

From: Nicolai Stange <nicstange@gmail.com>

According to 6.6(9), the member access operators "." and "->" may be used
in the creation of address constants.

Uses of both operators amount to the creation of EXPR_DEREF expressions
which are eventually fed into evaluate_offset() at evaluation.

Make evaluate_offset() propagate any address constant flag of the object
containing the referenced member to the newly created pointer addition
expression.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                                   |  6 ++++++
 validation/constexpr-addr-of-static-member.c | 26 ++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 validation/constexpr-addr-of-static-member.c

diff --git a/evaluate.c b/evaluate.c
index e58d9c373..9a7d432b8 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1962,6 +1962,12 @@ static struct expression *evaluate_offset(struct expression *expr, unsigned long
 	 * we ever take the address of this member dereference..
 	 */
 	add->ctype = &lazy_ptr_ctype;
+	/*
+	 * The resulting address of a member access through an address
+	 * constant is an address constant again [6.6(9)].
+	 */
+	add->flags = expr->flags;
+
 	return add;
 }
 
diff --git a/validation/constexpr-addr-of-static-member.c b/validation/constexpr-addr-of-static-member.c
new file mode 100644
index 000000000..f944f213e
--- /dev/null
+++ b/validation/constexpr-addr-of-static-member.c
@@ -0,0 +1,26 @@
+struct A {
+	int a;
+	int b[2];
+};
+
+struct B {
+	int c;
+	struct A d;
+};
+
+static struct B a= {1, {1, {1, 1}}};
+
+static int *b = &a.d.a;	// OK
+static int *c = &(&a.d)->a;	// OK
+static int *d = a.d.b;		// OK
+static int *e = (&a.d)->b;	// OK
+static int *f = &a.d.b[1];	// OK
+static int *g = &(&a.d)->b[1];	// OK
+
+/*
+ * check-name: address of static object's member constness verification.
+ * check-command: sparse -Wconstexpr-not-const $file
+ *
+ * check-error-start
+ * check-error-end
+ */
-- 
2.12.0

