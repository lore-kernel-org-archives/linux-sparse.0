From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] add support for '-f[no-][un]signed-char'
Date: Fri, 29 Dec 2017 22:46:25 +0100
Message-ID: <20171229214625.41368-3-luc.vanoostenryck@gmail.com>
References: <20171229214625.41368-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36130 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbdL2Vqf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 29 Dec 2017 16:46:35 -0500
Received: by mail-wm0-f65.google.com with SMTP id b76so50002867wmg.1
        for <linux-sparse@vger.kernel.org>; Fri, 29 Dec 2017 13:46:34 -0800 (PST)
In-Reply-To: <20171229214625.41368-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Till now, sparse's plain chars where signed with no possibility
to change it. This is a problem when using sparse on code
for architectures like ARM where chars are by default unsigned
or simply for code compiled with GCC's '-f[no-][un]signed-char'.

Change this by parsing these options and adjusting the type
of plain chars accordingly.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c                      |  3 +++
 lib.h                      |  1 +
 sparse.1                   |  5 +++++
 symbol.c                   |  6 ++++++
 validation/char-signed.c   |  9 +++++++++
 validation/char-unsigned.c | 11 +++++++++++
 6 files changed, 35 insertions(+)
 create mode 100644 validation/char-signed.c
 create mode 100644 validation/char-unsigned.c

diff --git a/lib.c b/lib.c
index b018eb972..fb11738ca 100644
--- a/lib.c
+++ b/lib.c
@@ -263,6 +263,7 @@ unsigned long fdump_ir;
 int fmem_report = 0;
 unsigned long long fmemcpy_max_count = 100000;
 unsigned long fpasses = ~0UL;
+int funsigned_char = 0;
 
 int preprocess_only;
 
@@ -878,6 +879,8 @@ static struct flag fflags[] = {
 	{ "tabstop=",		NULL,	handle_ftabstop },
 	{ "mem2reg",		NULL,	handle_fpasses,	PASS_MEM2REG },
 	{ "optim",		NULL,	handle_fpasses,	PASS_OPTIM },
+	{ "signed-char",	&funsigned_char, NULL,	OPT_INVERSE },
+	{ "unsigned-char",	&funsigned_char, NULL, },
 	{ },
 };
 
diff --git a/lib.h b/lib.h
index b0f342658..37d486727 100644
--- a/lib.h
+++ b/lib.h
@@ -171,6 +171,7 @@ extern int fmem_report;
 extern unsigned long fdump_ir;
 extern unsigned long long fmemcpy_max_count;
 extern unsigned long fpasses;
+extern int funsigned_char;
 
 extern int arch_m64;
 extern int arch_msize_long;
diff --git a/sparse.1 b/sparse.1
index 5b2bcd9c2..efb012933 100644
--- a/sparse.1
+++ b/sparse.1
@@ -381,6 +381,11 @@ Set the distance between tab stops.  This helps sparse report correct
 column numbers in warnings or errors.  If the value is less than 1 or
 greater than 100, the option is ignored.  The default is 8.
 .
+.TP
+.B \-f[no-]unsigned-char, \-f[no-]signed-char
+Let plain 'char' be unsigned or signed.
+By default chars are signed.
+.
 .SH SEE ALSO
 .BR cgcc (1)
 .
diff --git a/symbol.c b/symbol.c
index 2f4afd515..773060ec1 100644
--- a/symbol.c
+++ b/symbol.c
@@ -767,4 +767,10 @@ void init_ctype(void)
 		sym->ctype.base_type = ctype->base_type;
 		sym->ctype.modifiers = ctype->modifiers;
 	}
+
+	// and now some adjustments
+	if (funsigned_char) {
+		char_ctype.ctype.modifiers |= MOD_UNSIGNED;
+		char_ctype.ctype.modifiers &= ~MOD_SIGNED;
+	}
 }
diff --git a/validation/char-signed.c b/validation/char-signed.c
new file mode 100644
index 000000000..7f657dacb
--- /dev/null
+++ b/validation/char-signed.c
@@ -0,0 +1,9 @@
+void foo(void)
+{
+	_Static_assert((char) -1 == -1, "plain char is not signed");
+}
+
+/*
+ * check-name: fsigned-char
+ * check-command: sparse -fsigned-char -Wno-decl $file
+ */
diff --git a/validation/char-unsigned.c b/validation/char-unsigned.c
new file mode 100644
index 000000000..19cadbda3
--- /dev/null
+++ b/validation/char-unsigned.c
@@ -0,0 +1,11 @@
+#define	MASK ((1 << __CHAR_BIT__) - 1)
+
+void foo(void)
+{
+	_Static_assert((char) -1 == (-1 & MASK), "plain char is not unsigned");
+}
+
+/*
+ * check-name: fsigned-char
+ * check-command: sparse -funsigned-char -Wno-decl $file
+ */
-- 
2.15.0

