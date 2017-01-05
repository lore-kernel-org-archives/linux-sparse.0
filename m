From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/5] C11: teach sparse about '_Noreturn'
Date: Thu,  5 Jan 2017 04:22:17 +0100
Message-ID: <20170105032220.7339-3-luc.vanoostenryck@gmail.com>
References: <20170105032220.7339-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34719 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967369AbdAEDXE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 4 Jan 2017 22:23:04 -0500
Received: by mail-wm0-f65.google.com with SMTP id c85so56100922wmi.1
        for <linux-sparse@vger.kernel.org>; Wed, 04 Jan 2017 19:22:29 -0800 (PST)
In-Reply-To: <20170105032220.7339-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This is mainly a new name for GCC's 'noreturn' attribute but defined
as a new function specifier.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c                   | 14 ++++++++++++++
 validation/c11-noreturn.c |  9 +++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 validation/c11-noreturn.c

diff --git a/parse.c b/parse.c
index 7fc145db..f131d0e6 100644
--- a/parse.c
+++ b/parse.c
@@ -122,6 +122,12 @@ static struct symbol_op inline_op = {
 	.declarator = inline_specifier,
 };
 
+static declarator_t noreturn_specifier;
+static struct symbol_op noreturn_op = {
+	.type = KW_MODIFIER,
+	.declarator = noreturn_specifier,
+};
+
 static struct symbol_op auto_op = {
 	.type = KW_MODIFIER,
 	.declarator = auto_specifier,
@@ -432,6 +438,8 @@ static struct init_keyword {
 	{ "__inline",	NS_TYPEDEF, .op = &inline_op },
 	{ "__inline__",	NS_TYPEDEF, .op = &inline_op },
 
+	{ "_Noreturn",	NS_TYPEDEF, .op = &noreturn_op },
+
 	/* Ignored for now.. */
 	{ "restrict",	NS_TYPEDEF, .op = &restrict_op},
 	{ "__restrict",	NS_TYPEDEF, .op = &restrict_op},
@@ -1368,6 +1376,12 @@ static struct token *inline_specifier(struct token *next, struct decl_state *ctx
 	return next;
 }
 
+static struct token *noreturn_specifier(struct token *next, struct decl_state *ctx)
+{
+	apply_qualifier(&next->pos, &ctx->ctype, MOD_NORETURN);
+	return next;
+}
+
 static struct token *const_qualifier(struct token *next, struct decl_state *ctx)
 {
 	apply_qualifier(&next->pos, &ctx->ctype, MOD_CONST);
diff --git a/validation/c11-noreturn.c b/validation/c11-noreturn.c
new file mode 100644
index 00000000..bc20de82
--- /dev/null
+++ b/validation/c11-noreturn.c
@@ -0,0 +1,9 @@
+static _Noreturn void foo(void) { while (1) ; }
+
+/*
+ * check-name: c11-noreturn
+ * check-command: test-parsing -std=c11 $file
+ *
+ * check-output-ignore
+ * check-output-contains: \[noreturn\]
+ */
-- 
2.11.0

