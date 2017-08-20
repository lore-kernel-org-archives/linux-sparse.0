From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix expansion of constant bitfield dereference
Date: Mon, 21 Aug 2017 00:16:02 +0200
Message-ID: <20170820221602.27852-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34761 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753334AbdHTWQQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 20 Aug 2017 18:16:16 -0400
Received: by mail-wr0-f195.google.com with SMTP id p14so9528032wrg.1
        for <linux-sparse@vger.kernel.org>; Sun, 20 Aug 2017 15:16:15 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

During the expansion of a dereference, it's if the initializer
which corrrespond to the offset we're interested is a constant.
In which case this dereference can be avoided and the value
given in the initializer can be used instead.

However, it's not enough to check for the offset since for bitfields
several are placed at the same offset.
Currently, the first initializer matching the offset is selected.

Fix this by refusing such expansion if the constant value correspond
to a bitfield.

Reported-by: Dibyendu Majumdar <mobile@majumdar.org.uk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 expand.c                           |  2 ++
 validation/bitfield-expand-deref.c | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 validation/bitfield-expand-deref.c

diff --git a/expand.c b/expand.c
index f436b5b50..d44cfac73 100644
--- a/expand.c
+++ b/expand.c
@@ -644,6 +644,8 @@ static int expand_dereference(struct expression *expr)
 		if (value) {
 			/* FIXME! We should check that the size is right! */
 			if (value->type == EXPR_VALUE) {
+				if (is_bitfield_type(value->ctype))
+					return UNSAFE;
 				expr->type = EXPR_VALUE;
 				expr->value = value->value;
 				expr->taint = 0;
diff --git a/validation/bitfield-expand-deref.c b/validation/bitfield-expand-deref.c
new file mode 100644
index 000000000..58d1fe176
--- /dev/null
+++ b/validation/bitfield-expand-deref.c
@@ -0,0 +1,27 @@
+struct s {
+	int a:8;
+	int b:8;
+};
+
+int foo(void)
+{
+	struct s x = { .a = 12, .b = 34, };
+
+	return x.b;
+}
+
+int bar(int a)
+{
+	struct s x = { .a = 12, .b = a, };
+
+	return x.b;
+}
+
+/*
+ * check-name: bitfield expand deref
+ * check-command: test-linearize -Wno-decl $file
+
+ * check-output-ignore
+ * check-output-excludes: ret\..*\$12
+ * check-output-contains: ret\..*\$34
+ */
-- 
2.14.0

