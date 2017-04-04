From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/6] let -dD report macro defintions
Date: Tue,  4 Apr 2017 23:49:53 +0200
Message-ID: <20170404214955.47926-5-luc.vanoostenryck@gmail.com>
References: <20170404214955.47926-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33732 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753855AbdDDVuO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 4 Apr 2017 17:50:14 -0400
Received: by mail-wm0-f68.google.com with SMTP id o81so7985367wmb.0
        for <linux-sparse@vger.kernel.org>; Tue, 04 Apr 2017 14:50:13 -0700 (PDT)
In-Reply-To: <20170404214955.47926-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c                                       |  5 +++++
 validation/empty-file                       |  0
 validation/preprocessor/dump-macros-empty.c |  7 +++++++
 validation/preprocessor/dump-macros-multi.c |  7 +++++++
 validation/preprocessor/dump-macros.c       | 18 ++++++++++++++++++
 5 files changed, 37 insertions(+)
 create mode 100644 validation/empty-file
 create mode 100644 validation/preprocessor/dump-macros-empty.c
 create mode 100644 validation/preprocessor/dump-macros-multi.c
 create mode 100644 validation/preprocessor/dump-macros.c

diff --git a/lib.c b/lib.c
index 991ead9bd..700681c01 100644
--- a/lib.c
+++ b/lib.c
@@ -1075,9 +1075,14 @@ void create_builtin_stream(void)
 
 static struct symbol_list *sparse_tokenstream(struct token *token)
 {
+	int builtin = token && !token->pos.stream;
+
 	// Preprocess the stream
 	token = preprocess(token);
 
+	if (dump_macro_defs && !builtin)
+		dump_macro_definitions();
+
 	if (preprocess_only) {
 		while (!eof_token(token)) {
 			int prec = 1;
diff --git a/validation/empty-file b/validation/empty-file
new file mode 100644
index 000000000..e69de29bb
diff --git a/validation/preprocessor/dump-macros-empty.c b/validation/preprocessor/dump-macros-empty.c
new file mode 100644
index 000000000..672c66c71
--- /dev/null
+++ b/validation/preprocessor/dump-macros-empty.c
@@ -0,0 +1,7 @@
+/*
+ * check-name: dump-macros with empty file
+ * check-command: sparse -E -dD empty-file
+ *
+ * check-output-ignore
+check-output-pattern-1-times: #define __CHECKER__ 1
+ */
diff --git a/validation/preprocessor/dump-macros-multi.c b/validation/preprocessor/dump-macros-multi.c
new file mode 100644
index 000000000..2f6e8d04f
--- /dev/null
+++ b/validation/preprocessor/dump-macros-multi.c
@@ -0,0 +1,7 @@
+/*
+ * check-name: dump-macros with multiple files
+ * check-command: sparse -E -dD empty-file $file
+ *
+ * check-output-ignore
+check-output-pattern-2-times: #define __CHECKER__ 1
+ */
diff --git a/validation/preprocessor/dump-macros.c b/validation/preprocessor/dump-macros.c
new file mode 100644
index 000000000..79f3de6a2
--- /dev/null
+++ b/validation/preprocessor/dump-macros.c
@@ -0,0 +1,18 @@
+#define ABC abc
+#undef ABC
+
+#define	DEF def
+#undef DEF
+#define DEF xyz
+
+#define NYDEF ydef
+/*
+ * check-name: dump-macros
+ * check-command: sparse -E -dD -DIJK=ijk -UNDEF -UNYDEF $file
+ *
+ * check-output-ignore
+check-output-pattern-1-times: #define __CHECKER__ 1
+check-output-contains: #define IJK ijk
+check-output-contains: #define DEF xyz
+check-output-contains: #define NYDEF ydef
+ */
-- 
2.12.0

