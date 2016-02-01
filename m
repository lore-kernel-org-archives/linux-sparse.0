From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH v3 11/21] evaluate: recognize address constants created through casts
Date: Mon, 01 Feb 2016 03:39:09 +0100
Message-ID: <87a8nli27m.fsf@gmail.com>
References: <87lh75jh9l.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34775 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbcBACjM (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 31 Jan 2016 21:39:12 -0500
Received: by mail-wm0-f66.google.com with SMTP id p63so7029245wmp.1
        for <linux-sparse@vger.kernel.org>; Sun, 31 Jan 2016 18:39:11 -0800 (PST)
In-Reply-To: <87lh75jh9l.fsf@gmail.com> (Nicolai Stange's message of "Mon, 01
	Feb 2016 03:28:38 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nicolai Stange <nicstange@gmail.com>

According to 6.6(9), an address constant may get created by casting
an integer constant to pointer type.

Make evaluate_cast() handle this case, that is tag a cast expression
as being an address constant if the target is a integer constant and
the destination is of pointer type.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 evaluate.c                          | 10 +++++++++-
 validation/constexpr-pointer-cast.c | 13 +++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)
 create mode 100644 validation/constexpr-pointer-cast.c

diff --git a/evaluate.c b/evaluate.c
index 91f89f4..a740474 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2767,7 +2767,15 @@ static struct symbol *evaluate_cast(struct expression *expr)
 
 	class1 = classify_type(ctype, &t1);
 
-	if (class1 & TYPE_NUM) {
+	if (!(class1 & TYPE_NUM)) {
+		/*
+		 * Casts of integer literals to pointer type yield
+		 * address constants [6.6(9)].
+		 */
+		if (class1 & TYPE_PTR &&
+			(target->constexpr_flags & CONSTEXPR_FLAG_INT_CONST))
+			expr->constexpr_flags = CONSTEXPR_FLAG_ADDR_CONST;
+	} else {
 		/*
 		 * Casts to numeric types never result in address
 		 * constants [6.6(9)].
diff --git a/validation/constexpr-pointer-cast.c b/validation/constexpr-pointer-cast.c
new file mode 100644
index 0000000..d19c108
--- /dev/null
+++ b/validation/constexpr-pointer-cast.c
@@ -0,0 +1,13 @@
+static int *a = (int*)0;	// OK
+static int b = 0;
+static int *c = (int*)b;	// KO
+
+
+/*
+ * check-name: integer literal cast to pointer type constness verification.
+ * check-command: sparse -Wconstexpr-not-const $file
+ *
+ * check-error-start
+constexpr-pointer-cast.c:3:18: warning: non-constant initializer for static object
+ * check-error-end
+ */
-- 
2.7.0

