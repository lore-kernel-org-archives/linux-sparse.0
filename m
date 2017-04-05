From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/3] add real support for __BASE_FILE__
Date: Wed,  5 Apr 2017 03:14:55 +0200
Message-ID: <20170405011455.60222-4-luc.vanoostenryck@gmail.com>
References: <20170405011455.60222-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35495 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754758AbdDEBRG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 4 Apr 2017 21:17:06 -0400
Received: by mail-wm0-f67.google.com with SMTP id z133so185780wmb.2
        for <linux-sparse@vger.kernel.org>; Tue, 04 Apr 2017 18:17:06 -0700 (PDT)
In-Reply-To: <20170405011455.60222-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

There was some support of it but it was probably just
for sparse to not complain as it was a define that
expanded to the fixed name "base_file.c".

Fix this by letting it expand to the basename of the input
file.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ident-list.h                            |  1 +
 lib.c                                   |  3 ---
 pre-process.c                           |  4 ++++
 validation/preprocessor/__BASE_FILE__.c | 11 +++++++++++
 4 files changed, 16 insertions(+), 3 deletions(-)
 create mode 100644 validation/preprocessor/__BASE_FILE__.c

diff --git a/ident-list.h b/ident-list.h
index 8cc66a50c..21564bc5b 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -104,6 +104,7 @@ __IDENT(pragma_ident, "__pragma__", 0);
 __IDENT(__VA_ARGS___ident, "__VA_ARGS__", 0);
 __IDENT(__LINE___ident, "__LINE__", 0);
 __IDENT(__FILE___ident, "__FILE__", 0);
+__IDENT(__BASE_FILE___ident, "__BASE_FILE__", 0);
 __IDENT(__DATE___ident, "__DATE__", 0);
 __IDENT(__TIME___ident, "__TIME__", 0);
 __IDENT(__func___ident, "__func__", 0);
diff --git a/lib.c b/lib.c
index 272d2c88a..0b4564f5a 100644
--- a/lib.c
+++ b/lib.c
@@ -1038,9 +1038,6 @@ void create_builtin_stream(void)
 	add_pre_buffer("#define __builtin_ms_va_end(arg)\n");
 	add_pre_buffer("#define __builtin_va_arg_pack()\n");
 
-	/* FIXME! We need to do these as special magic macros at expansion time! */
-	add_pre_buffer("#define __BASE_FILE__ \"base_file.c\"\n");
-
 	if (optimize)
 		add_pre_buffer("#define __OPTIMIZE__ 1\n");
 	if (optimize_size)
diff --git a/pre-process.c b/pre-process.c
index 7c57ba1cd..dd698c5bc 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -172,6 +172,10 @@ static int expand_one_symbol(struct token **list)
 		replace_with_integer(token, token->pos.line);
 	} else if (token->ident == &__FILE___ident) {
 		replace_with_string(token, stream_name(token->pos.stream));
+	} else if (token->ident == &__BASE_FILE___ident) {
+		const char *base = stream_name(token->pos.stream);
+		base = sparse_basename(base);
+		replace_with_string(token, base);
 	} else if (token->ident == &__DATE___ident) {
 		if (!t)
 			time(&t);
diff --git a/validation/preprocessor/__BASE_FILE__.c b/validation/preprocessor/__BASE_FILE__.c
new file mode 100644
index 000000000..d1cce9633
--- /dev/null
+++ b/validation/preprocessor/__BASE_FILE__.c
@@ -0,0 +1,11 @@
+__BASE_FILE__
+
+/*
+ * check-name: __BASE_FILE__
+ * check-command: sparse -E $file
+ *
+ * check-output-start
+
+"__BASE_FILE__.c"
+ * check-output-end
+ */
-- 
2.12.0

