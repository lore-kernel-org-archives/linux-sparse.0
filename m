From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix cast to pointer to floating-point
Date: Sat, 11 Mar 2017 15:16:59 +0100
Message-ID: <20170311141659.36768-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35666 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755674AbdCKOTH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 09:19:07 -0500
Received: by mail-wm0-f67.google.com with SMTP id z63so3126292wmg.2
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 06:19:06 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

By mistake, a cast to floating-pointer pointer was
created as OP_FPCAST instead of OP_PTRCAST.

Fix this by adding the missing 'else'.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c                |  3 +--
 validation/fp-vs-ptrcast.c | 13 +++++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)
 create mode 100644 validation/fp-vs-ptrcast.c

diff --git a/linearize.c b/linearize.c
index 255231c60..6397f68a7 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1119,8 +1119,7 @@ static struct instruction *alloc_cast_instruction(struct symbol *src, struct sym
 		base = base->ctype.base_type;
 		if (base != &void_ctype)
 			opcode = OP_PTRCAST;
-	}
-	if (base->ctype.base_type == &fp_type)
+	} else if (base->ctype.base_type == &fp_type)
 		opcode = OP_FPCAST;
 	return alloc_typed_instruction(opcode, ctype);
 }
diff --git a/validation/fp-vs-ptrcast.c b/validation/fp-vs-ptrcast.c
new file mode 100644
index 000000000..817aee5c9
--- /dev/null
+++ b/validation/fp-vs-ptrcast.c
@@ -0,0 +1,13 @@
+float *f01(void* p)
+{
+	return p;
+}
+
+/*
+ * check-name: fp-vs-ptrcast
+ * check-command: test-linearize -Wno-decl $file
+ * check-output-ignore
+ *
+ * check-output-excludes: fpcast
+ * check-output-contains: ptrcast
+ */
-- 
2.11.1

