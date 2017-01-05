From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/5] C11: teach sparse about '_Alignof()'
Date: Thu,  5 Jan 2017 04:22:18 +0100
Message-ID: <20170105032220.7339-4-luc.vanoostenryck@gmail.com>
References: <20170105032220.7339-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33955 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937571AbdAED3m (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 4 Jan 2017 22:29:42 -0500
Received: by mail-wm0-f68.google.com with SMTP id c85so56117775wmi.1
        for <linux-sparse@vger.kernel.org>; Wed, 04 Jan 2017 19:29:41 -0800 (PST)
In-Reply-To: <20170105032220.7339-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This is a new name for GCC's '__alignof()' operator which was
already supported.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 expression.c             |  1 +
 ident-list.h             |  1 +
 validation/c11-alignof.c | 12 ++++++++++++
 3 files changed, 14 insertions(+)
 create mode 100644 validation/c11-alignof.c

diff --git a/expression.c b/expression.c
index 7293d472..638639df 100644
--- a/expression.c
+++ b/expression.c
@@ -617,6 +617,7 @@ static struct token *unary_expression(struct token *token, struct expression **t
 				{ &sizeof_ident, EXPR_SIZEOF },
 				{ &__alignof___ident, EXPR_ALIGNOF },
 				{ &__alignof_ident, EXPR_ALIGNOF },
+				{ &_Alignof_ident, EXPR_ALIGNOF },
 				{ &__sizeof_ptr___ident, EXPR_PTRSIZEOF },
 			};
 			int i;
diff --git a/ident-list.h b/ident-list.h
index b65b667d..8cc66a50 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -31,6 +31,7 @@ IDENT(L);
 /* Extended gcc identifiers */
 IDENT(asm); IDENT_RESERVED(__asm); IDENT_RESERVED(__asm__);
 IDENT(alignof); IDENT_RESERVED(__alignof); IDENT_RESERVED(__alignof__); 
+IDENT_RESERVED(_Alignof);
 IDENT_RESERVED(__sizeof_ptr__);
 IDENT_RESERVED(__builtin_types_compatible_p);
 IDENT_RESERVED(__builtin_offsetof);
diff --git a/validation/c11-alignof.c b/validation/c11-alignof.c
new file mode 100644
index 00000000..238ef994
--- /dev/null
+++ b/validation/c11-alignof.c
@@ -0,0 +1,12 @@
+static int foo(void)
+{
+	return _Alignof(short);
+}
+
+/*
+ * check-name: c11-alignof
+ * check-command: test-linearize -std=c11 $file
+ *
+ * check-output-ignore
+ * check-output-contains: ret\\.32 *\$2
+ */
-- 
2.11.0

