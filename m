From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH v3 13/21] evaluate: recognize members of static compound objects as address constants
Date: Mon, 01 Feb 2016 03:40:42 +0100
Message-ID: <871t8xi251.fsf@gmail.com>
References: <87lh75jh9l.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33505 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451AbcBACkp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 31 Jan 2016 21:40:45 -0500
Received: by mail-wm0-f67.google.com with SMTP id r129so7041445wmr.0
        for <linux-sparse@vger.kernel.org>; Sun, 31 Jan 2016 18:40:44 -0800 (PST)
In-Reply-To: <87lh75jh9l.fsf@gmail.com> (Nicolai Stange's message of "Mon, 01
	Feb 2016 03:28:38 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nicolai Stange <nicstange@gmail.com>

According to 6.6(9), the member access operators "." and "->" may be used
in the creation of address constants.

Uses of both operators amount to the creation of EXPR_DEREF expressions
which are eventually fed into evaluate_offset() at evaluation.

Make evaluate_offset() propagate any address constant flag of the object
containing the referenced member to the newly created pointer addition
expression.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 evaluate.c                                   |  6 ++++++
 validation/constexpr-addr-of-static-member.c | 26 ++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 validation/constexpr-addr-of-static-member.c

diff --git a/evaluate.c b/evaluate.c
index 16b4ce0..f31ba9c 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1957,6 +1957,12 @@ static struct expression *evaluate_offset(struct expression *expr, unsigned long
 	 * we ever take the address of this member dereference..
 	 */
 	add->ctype = &lazy_ptr_ctype;
+	/*
+	 * The resulting address of a member access through an address
+	 * constant is an address constant again [6.6(9)].
+	 */
+	add->constexpr_flags = expr->constexpr_flags;
+
 	return add;
 }
 
diff --git a/validation/constexpr-addr-of-static-member.c b/validation/constexpr-addr-of-static-member.c
new file mode 100644
index 0000000..f944f21
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
2.7.0

