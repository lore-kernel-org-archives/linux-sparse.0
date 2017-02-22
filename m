From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/5] use option: '-Woverride-init'
Date: Wed, 22 Feb 2017 16:30:02 +0100
Message-ID: <20170222153006.3035-2-luc.vanoostenryck@gmail.com>
References: <20170221110355.GD300@arm.com>
 <20170222153006.3035-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36219 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754190AbdBVP5x (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Feb 2017 10:57:53 -0500
Received: by mail-wm0-f67.google.com with SMTP id r18so1150964wmd.3
        for <linux-sparse@vger.kernel.org>; Wed, 22 Feb 2017 07:57:47 -0800 (PST)
In-Reply-To: <20170222153006.3035-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Boyd <stephen.boyd@linaro.org>, Will Deacon <will.deacon@arm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Sparse warns unconditionally about overlapping initilalizers.

Introduces a warning flag to control this, use the same name
as GCC's and enabled it by default.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 expand.c                        |  3 +++
 lib.c                           |  2 ++
 lib.h                           |  1 +
 validation/Woverride-init-def.c | 14 ++++++++++++++
 validation/Woverride-init-no.c  | 12 ++++++++++++
 validation/Woverride-init-yes.c | 14 ++++++++++++++
 6 files changed, 46 insertions(+)
 create mode 100644 validation/Woverride-init-def.c
 create mode 100644 validation/Woverride-init-no.c
 create mode 100644 validation/Woverride-init-yes.c

diff --git a/expand.c b/expand.c
index 7af12707e..7457c94dd 100644
--- a/expand.c
+++ b/expand.c
@@ -916,6 +916,9 @@ static void verify_nonoverlapping(struct expression_list **list)
 	struct expression *a = NULL;
 	struct expression *b;
 
+	if (!Woverride_init)
+		return;
+
 	FOR_EACH_PTR(*list, b) {
 		if (!b->ctype || !b->ctype->bit_size)
 			continue;
diff --git a/lib.c b/lib.c
index d47325243..a20f68aa2 100644
--- a/lib.c
+++ b/lib.c
@@ -231,6 +231,7 @@ int Wsparse_error = 0;
 int Wnon_pointer_null = 1;
 int Wold_initializer = 1;
 int Wone_bit_signed_bitfield = 1;
+int Woverride_init = 1;
 int Wparen_string = 0;
 int Wptr_subtraction_blows = 0;
 int Wreturn_void = 0;
@@ -480,6 +481,7 @@ static const struct warning {
 	{ "non-pointer-null", &Wnon_pointer_null },
 	{ "old-initializer", &Wold_initializer },
 	{ "one-bit-signed-bitfield", &Wone_bit_signed_bitfield },
+	{ "override-init", &Woverride_init },
 	{ "paren-string", &Wparen_string },
 	{ "ptr-subtraction-blows", &Wptr_subtraction_blows },
 	{ "return-void", &Wreturn_void },
diff --git a/lib.h b/lib.h
index 095b1f517..35edd3217 100644
--- a/lib.h
+++ b/lib.h
@@ -117,6 +117,7 @@ extern int Winit_cstring;
 extern int Wnon_pointer_null;
 extern int Wold_initializer;
 extern int Wone_bit_signed_bitfield;
+extern int Woverride_init;
 extern int Wparen_string;
 extern int Wptr_subtraction_blows;
 extern int Wreturn_void;
diff --git a/validation/Woverride-init-def.c b/validation/Woverride-init-def.c
new file mode 100644
index 000000000..95ecf33be
--- /dev/null
+++ b/validation/Woverride-init-def.c
@@ -0,0 +1,14 @@
+static int array[] = {
+	[1] = 3,
+	[1] = 1,		/* check-should-warn */
+};
+
+/*
+ * check-name: Woverride-init-def
+ * check-command: sparse $file
+ *
+ * check-error-start
+Woverride-init-def.c:2:10: warning: Initializer entry defined twice
+Woverride-init-def.c:3:10:   also defined here
+ * check-error-end
+ */
diff --git a/validation/Woverride-init-no.c b/validation/Woverride-init-no.c
new file mode 100644
index 000000000..ba4d82b9f
--- /dev/null
+++ b/validation/Woverride-init-no.c
@@ -0,0 +1,12 @@
+static int array[] = {
+	[1] = 3,
+	[1] = 1,		/* check-should-warn */
+};
+
+/*
+ * check-name: Woverride-init-no
+ * check-command: sparse -Wno-override-init $file
+ *
+ * check-error-start
+ * check-error-end
+ */
diff --git a/validation/Woverride-init-yes.c b/validation/Woverride-init-yes.c
new file mode 100644
index 000000000..c04a836be
--- /dev/null
+++ b/validation/Woverride-init-yes.c
@@ -0,0 +1,14 @@
+static int array[] = {
+	[1] = 3,
+	[1] = 1,		/* check-should-warn */
+};
+
+/*
+ * check-name: Woverride-init-yes
+ * check-command: sparse -Woverride-init $file
+ *
+ * check-error-start
+Woverride-init-yes.c:2:10: warning: Initializer entry defined twice
+Woverride-init-yes.c:3:10:   also defined here
+ * check-error-end
+ */
-- 
2.11.1

