From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/3] validate expression's type in conditionals
Date: Sun, 29 Jan 2017 12:34:09 +0100
Message-ID: <20170129113409.9834-4-luc.vanoostenryck@gmail.com>
References: <20170129113409.9834-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36368 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750803AbdA2Mkv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 29 Jan 2017 07:40:51 -0500
Received: by mail-wm0-f65.google.com with SMTP id r126so70530734wmr.3
        for <linux-sparse@vger.kernel.org>; Sun, 29 Jan 2017 04:39:32 -0800 (PST)
In-Reply-To: <20170129113409.9834-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This wasn't done yet, in particular void values was accepted
inside if statements, which lead to strange situations after
linearization.

Implement this simply by calling the newly created is_scalar_type()
in evaluate_conditional() and issuing an appropriate diagnostic
when the check fail.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                    |  5 +++
 validation/conditional-type.c | 99 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)
 create mode 100644 validation/conditional-type.c

diff --git a/evaluate.c b/evaluate.c
index e350c0c08..f3616e450 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -865,6 +865,11 @@ static struct symbol *evaluate_conditional(struct expression *expr, int iterator
 	if (ctype) {
 		if (is_safe_type(ctype))
 			warning(expr->pos, "testing a 'safe expression'");
+		if (!is_scalar_type(ctype)) {
+			sparse_error(expr->pos, "incorrect type in conditional");
+			info(expr->pos, "   got %s", show_typename(ctype));
+			ctype = NULL;
+		}
 	}
 
 	return ctype;
diff --git a/validation/conditional-type.c b/validation/conditional-type.c
new file mode 100644
index 000000000..a14c05ec1
--- /dev/null
+++ b/validation/conditional-type.c
@@ -0,0 +1,99 @@
+extern void afun(void);
+extern void vcond(void);
+static int array[3];
+
+struct state {
+	int nr:2;
+};
+
+enum number {
+	zero,
+	one,
+	two,
+	many,
+};
+
+static int bad_if(struct state s)
+{
+	if (vcond()) return 1;
+	if (s) return 1;
+	return 0;
+}
+static void bad_if2(int *a, int *b)
+{
+	if (vcond()) *a = 1;
+	*b = 0;
+}
+static int bad_sel(struct state s)
+{
+	return vcond() ? 1 : 0;
+	return s ? 1 : 0;
+}
+static int bad_loop_void(void)
+{
+	while (vcond())
+		;
+	for (;vcond();)
+		;
+	do
+		;
+	while (vcond());
+	return 0;
+}
+
+
+static int good_if_int(int a, _Bool b, long c, unsigned char d)
+{
+	if (a) return 1;
+	if (b) return 1;
+	if (c) return 1;
+	if (d) return 1;
+	return 0;
+}
+static int good_if_float(float a, double b)
+{
+	if (a) return 1;
+	if (b) return 1;
+	return 0;
+}
+static int good_if_enum(void)
+{
+	if (many) return 1;
+	return 0;
+}
+static int good_if_bitfield(struct state s, struct state *p)
+{
+	if (s.nr) return 1;
+	if (p->nr) return 1;
+	return 0;
+}
+static int good_if_ptr(void *ptr)
+{
+	if (ptr) return 1;
+	if (array) return 1;
+	if (afun) return 1;
+	return 0;
+}
+
+/*
+ * check-name: conditional-type
+ *
+ * check-error-start
+conditional-type.c:18:18: error: incorrect type in conditional
+conditional-type.c:18:18:    got void
+conditional-type.c:19:13: error: incorrect type in conditional
+conditional-type.c:19:13:    got struct state s
+conditional-type.c:24:18: error: incorrect type in conditional
+conditional-type.c:24:18:    got void
+conditional-type.c:29:21: error: incorrect type in conditional
+conditional-type.c:29:21:    got void
+conditional-type.c:30:16: error: incorrect type in conditional
+conditional-type.c:30:16:    got struct state s
+conditional-type.c:34:21: error: incorrect type in conditional
+conditional-type.c:34:21:    got void
+conditional-type.c:36:20: error: incorrect type in conditional
+conditional-type.c:36:20:    got void
+conditional-type.c:40:21: error: incorrect type in conditional
+conditional-type.c:40:21:    got void
+ * check-error-end
+ */
-- 
2.11.0

