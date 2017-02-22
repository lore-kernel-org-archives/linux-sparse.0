From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/5] add test case for warnings about overlapping initializers
Date: Wed, 22 Feb 2017 16:30:03 +0100
Message-ID: <20170222153006.3035-3-luc.vanoostenryck@gmail.com>
References: <20170221110355.GD300@arm.com>
 <20170222153006.3035-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36454 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932354AbdBVP5Y (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Feb 2017 10:57:24 -0500
Received: by mail-wm0-f65.google.com with SMTP id r18so1143819wmd.3
        for <linux-sparse@vger.kernel.org>; Wed, 22 Feb 2017 07:56:12 -0800 (PST)
In-Reply-To: <20170222153006.3035-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Boyd <stephen.boyd@linaro.org>, Will Deacon <will.deacon@arm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/field-override.c | 88 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 validation/field-override.c

diff --git a/validation/field-override.c b/validation/field-override.c
new file mode 100644
index 000000000..d5d00dfa8
--- /dev/null
+++ b/validation/field-override.c
@@ -0,0 +1,88 @@
+static int ref[] = {
+	[1] = 3,
+	[2] = 3,
+	[3] = 3,
+	[2] = 2,		/* check-should-warn */
+	[1] = 1,		/* check-should-warn */
+};
+
+static int foo[] = {
+	[1 ... 3] = 3,
+};
+
+static int foz[4] = {
+	[0 ... 3] = 3,
+	[0] = 0,
+	[1] = 0,
+	[2 ... 3] = 1,
+	[2] = 3,		/* check-should-warn */
+	[3] = 3,		/* check-should-warn */
+};
+
+static int bar[] = {
+	[1 ... 3] = 3,
+	[1]       = 1,		/* check-should-warn */
+	[2]       = 2,		/* check-should-warn */
+	[2 ... 4] = 2,		/* check-should-warn */
+	[2 ... 3] = 2,		/* check-should-warn */
+	[4] = 4,		/* check-should-warn */
+	[0] = 0,
+	[5] = 5,
+};
+
+static int baz[3][3] = {
+	[0 ... 2][0 ... 2] = 0,
+	[0] = { 0, 0, 0, },	/* check-should-warn */
+	[0][0] = 1,		/* check-should-warn */
+	[1] = { 0, 0, 0, },	/* check-should-warn */
+	[1][0] = 1,		/* check-should-warn */
+	[1][1] = 1,		/* check-should-warn */
+	[1 ... 2][1 ... 2] = 2,
+};
+
+
+struct s {
+	int i;
+	int a[2];
+};
+
+static struct s s = {
+	.a[0] = 0,
+	.a[1] = 1,
+};
+
+static struct s a[2] = {
+	[0].i = 0,
+	[1].i = 1,
+	[0].a[0] = 2,
+	[0].a[1] = 3,
+};
+
+static struct s b[2] = {
+	[0 ... 1] = { 0, { 1, 2 }, },
+	[0].i = 0,
+	[1].i = 1,
+	[0].a[0] = 2,
+	[0].a[1] = 3,
+};
+
+/*
+ * check-name: field-override
+ * check-command: sparse -Woverride-init $file
+ * check-known-to-fail
+ *
+ * check-error-start
+field-override.c:2:10: warning: Initializer entry defined twice
+field-override.c:6:10:   also defined here
+field-override.c:14:10: warning: Initializer entry defined twice
+field-override.c:15:10:   also defined here
+field-override.c:23:10: warning: Initializer entry defined twice
+field-override.c:24:10:   also defined here
+field-override.c:23:10: warning: Initializer entry defined twice
+field-override.c:25:10:   also defined here
+field-override.c:34:10: warning: Initializer entry defined twice
+field-override.c:35:10:   also defined here
+field-override.c:62:10: warning: Initializer entry defined twice
+field-override.c:63:10:   also defined here
+ * check-error-end
+ */
-- 
2.11.1

