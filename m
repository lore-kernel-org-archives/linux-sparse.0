From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] add support for __int128
Date: Sat, 10 Dec 2016 00:03:11 +0100
Message-ID: <20161209230311.36024-3-luc.vanoostenryck@gmail.com>
References: <20161209230311.36024-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35329 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753857AbcLIXD3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 9 Dec 2016 18:03:29 -0500
Received: by mail-wm0-f67.google.com with SMTP id a20so66918wme.2
        for <linux-sparse@vger.kernel.org>; Fri, 09 Dec 2016 15:03:28 -0800 (PST)
In-Reply-To: <20161209230311.36024-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

There is already support for __int128_t & __uint128_t but not yet
for GCC's __int128.

This patch add support for it and a couple of test cases.

Note: it's slightly more tricky that it look because contrary to
'__int128_t', '__int128' is not an exact type (it can still receive
the 'unsigned' or 'signed' specifier).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c             | 10 +++++++++
 validation/int128.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)
 create mode 100644 validation/int128.c

diff --git a/parse.c b/parse.c
index 808a078a..fa46758a 100644
--- a/parse.c
+++ b/parse.c
@@ -101,6 +101,7 @@ enum {
 	Set_Short = 256,
 	Set_Long = 512,
 	Set_Vlong = 1024,
+	Set_Int128 = 2048,
 	Set_Any = Set_T | Set_Short | Set_Long | Set_Signed | Set_Unsigned
 };
 
@@ -253,6 +254,12 @@ static struct symbol_op long_op = {
 	.set = Set_Long,
 };
 
+static struct symbol_op int128_op = {
+	.type = KW_SPECIFIER | KW_LONG,
+	.test = Set_S|Set_T|Set_Char|Set_Short|Set_Int|Set_Float|Set_Double|Set_Long|Set_Vlong|Set_Int128,
+	.set =  Set_T|Set_Int128,
+};
+
 static struct symbol_op if_op = {
 	.statement = parse_if_statement,
 };
@@ -408,6 +415,7 @@ static struct init_keyword {
 	{ "__signed",	NS_TYPEDEF, .op = &signed_op },
 	{ "__signed__",	NS_TYPEDEF, .op = &signed_op },
 	{ "unsigned",	NS_TYPEDEF, .op = &unsigned_op },
+	{ "__int128",	NS_TYPEDEF, .op = &int128_op },
 	{ "_Bool",	NS_TYPEDEF, .type = &bool_ctype, .op = &spec_op },
 
 	/* Predeclared types */
@@ -1496,6 +1504,8 @@ static struct token *declaration_specifiers(struct token *token, struct decl_sta
 			}
 			seen |= s->op->set;
 			class += s->op->class;
+			if (s->op->set & Set_Int128)
+				size = 2;
 			if (s->op->type & KW_SHORT) {
 				size = -1;
 			} else if (s->op->type & KW_LONG && size++) {
diff --git a/validation/int128.c b/validation/int128.c
new file mode 100644
index 00000000..53d678e2
--- /dev/null
+++ b/validation/int128.c
@@ -0,0 +1,58 @@
+typedef		 __int128	 int128_t;
+typedef   signed __int128	sint128_t;
+typedef unsigned __int128	uint128_t;
+
+typedef	__int128 int	badxi;
+typedef int __int128	badix;
+typedef unsigned unsigned __int128 baduu;
+typedef double __int128 baddx;
+typedef __int128 double badxd;
+
+int sizeof_int128(void)
+{
+	return sizeof(__int128);
+}
+
+typedef unsigned long long u64;
+typedef unsigned long      u32;
+
+u64 foo(u64 a, u64 b, u64 c, u32 s)
+{
+       unsigned __int128 tmp;
+
+       tmp = (((uint128_t)a) * b) + c;
+       return (u64) (tmp >> s);
+}
+
+/*
+ * check-name: int128
+ * check-command: test-linearize $file
+ * check-output-ignore
+ *
+ * check-output-contains: ret\\..*\\$16
+ * check-output-contains: mulu\\.128
+ * check-output-contains: add\\.128
+ *
+ * check-error-start
+int128.c:5:18: error: two or more data types in declaration specifiers
+int128.c:5:18: error: Trying to use reserved word 'int' as identifier
+int128.c:5:25: error: Expected ; at end of declaration
+int128.c:5:25: error: got badxi
+int128.c:6:13: error: two or more data types in declaration specifiers
+int128.c:6:13: error: Trying to use reserved word '__int128' as identifier
+int128.c:6:25: error: Expected ; at end of declaration
+int128.c:6:25: error: got badix
+int128.c:7:18: error: impossible combination of type specifiers: unsigned unsigned
+int128.c:7:18: error: Trying to use reserved word 'unsigned' as identifier
+int128.c:7:27: error: Expected ; at end of declaration
+int128.c:7:27: error: got __int128
+int128.c:8:16: error: two or more data types in declaration specifiers
+int128.c:8:16: error: Trying to use reserved word '__int128' as identifier
+int128.c:8:25: error: Expected ; at end of declaration
+int128.c:8:25: error: got baddx
+int128.c:9:18: error: two or more data types in declaration specifiers
+int128.c:9:18: error: Trying to use reserved word 'double' as identifier
+int128.c:9:25: error: Expected ; at end of declaration
+int128.c:9:25: error: got badxd
+ * check-error-end
+ */
-- 
2.10.2

