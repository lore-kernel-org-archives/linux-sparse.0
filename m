From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH v2 01/10] Add the __restrict__ keyword
Date: Thu, 07 Aug 2014 21:11:02 +0100
Message-ID: <53E3DD56.1030706@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta004.mxout.tch.inty.net ([91.221.169.45]:57716 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750874AbaHGULF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 7 Aug 2014 16:11:05 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Chris,

I added a separate test file (alternate-keywords.c) which includes
test cases for restrict, __restrict and __restrict__. I also included
some additional tests for other alternative keywords (hence the name
of the file), namely inline, typeof and their variants.

I have tested this only on 32-bit Linux so far. (I will do the other
platforms tomorrow, but I don't expect to find any problems) I wanted
to get this to you tonight.

ATB,
Ramsay Jones

 ident-list.h                    |  2 +-
 parse.c                         |  3 ++-
 validation/alternate-keywords.c | 46 +++++++++++++++++++++++++++++++++++++++++
 validation/reserved.c           |  1 +
 4 files changed, 50 insertions(+), 2 deletions(-)
 create mode 100644 validation/alternate-keywords.c

diff --git a/ident-list.h b/ident-list.h
index c0fc18f..d5a145f 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -86,7 +86,7 @@ IDENT(stdcall); IDENT(__stdcall__);
 IDENT(fastcall); IDENT(__fastcall__);
 IDENT(dllimport); IDENT(__dllimport__);
 IDENT(dllexport); IDENT(__dllexport__);
-IDENT(restrict); IDENT(__restrict);
+IDENT(restrict); IDENT(__restrict); IDENT(__restrict__);
 IDENT(artificial); IDENT(__artificial__);
 IDENT(leaf); IDENT(__leaf__);
 IDENT(vector_size); IDENT(__vector_size__);
diff --git a/parse.c b/parse.c
index eaa1883..ec835ef 100644
--- a/parse.c
+++ b/parse.c
@@ -435,6 +435,7 @@ static struct init_keyword {
 	/* Ignored for now.. */
 	{ "restrict",	NS_TYPEDEF, .op = &restrict_op},
 	{ "__restrict",	NS_TYPEDEF, .op = &restrict_op},
+	{ "__restrict__",	NS_TYPEDEF, .op = &restrict_op},
 
 	/* Storage class */
 	{ "auto",	NS_TYPEDEF, .op = &auto_op },
@@ -1553,7 +1554,7 @@ static struct token *abstract_array_declarator(struct token *token, struct symbo
 
 	token = abstract_array_static_declarator(token, &has_static);
 
-	if (match_idents(token, &restrict_ident, &__restrict_ident, NULL))
+	if (match_idents(token, &restrict_ident, &__restrict_ident, &__restrict___ident, NULL))
 		token = abstract_array_static_declarator(token->next, &has_static);
 	token = parse_expression(token, &expr);
 	sym->array_size = expr;
diff --git a/validation/alternate-keywords.c b/validation/alternate-keywords.c
new file mode 100644
index 0000000..2e91a35
--- /dev/null
+++ b/validation/alternate-keywords.c
@@ -0,0 +1,46 @@
+
+extern float strtof(const char *__restrict__ ptr, char **__restrict__ endptr);
+extern double strtod(const char *__restrict ptr, char **__restrict endptr);
+/* restrict: -std=c99 or -std=gnu99 or -std=c11 */
+extern long double strtold(const char *restrict ptr, char **restrict endptr);
+
+extern int (*funcs[])(void);
+
+/* typeof: no -std or -std=gnu90 or -std=gnu99 or -std=gnu11 */
+extern typeof (funcs[0]) f0;
+extern __typeof (funcs[1]) f1;
+extern __typeof__(funcs[2]) f2;
+
+typedef unsigned short uint16_t;
+typedef unsigned int uint32_t;
+typedef unsigned long long uint64_t;
+
+static __inline__ uint16_t swap16(uint16_t val)
+{
+	return ((((uint16_t)(val) & (uint16_t)0x00ffU) << 8) |
+		(((uint16_t)(val) & (uint16_t)0xff00U) >> 8));
+}
+
+static __inline uint32_t swap32(uint32_t val)
+{
+	return ((((uint32_t)(val) & (uint32_t)0x000000ffUL) << 24) |
+		(((uint32_t)(val) & (uint32_t)0x0000ff00UL) <<  8) |
+		(((uint32_t)(val) & (uint32_t)0x00ff0000UL) >>  8) |
+		(((uint32_t)(val) & (uint32_t)0xff000000UL) >> 24));
+}
+
+/* inline: no -std or -std=gnu90 or -std=c99 or -std=c11 */
+static inline uint64_t swap64(uint64_t val)
+{
+	return ((((uint64_t)(val) & (uint64_t)0x00000000000000ffULL) << 56) |
+		(((uint64_t)(val) & (uint64_t)0x000000000000ff00ULL) << 40) |
+		(((uint64_t)(val) & (uint64_t)0x0000000000ff0000ULL) << 24) |
+		(((uint64_t)(val) & (uint64_t)0x00000000ff000000ULL) <<  8) |
+		(((uint64_t)(val) & (uint64_t)0x000000ff00000000ULL) >>  8) |
+		(((uint64_t)(val) & (uint64_t)0x0000ff0000000000ULL) >> 24) |
+		(((uint64_t)(val) & (uint64_t)0x00ff000000000000ULL) >> 40) |
+		(((uint64_t)(val) & (uint64_t)0xff00000000000000ULL) >> 56));
+}
+/*
+ * check-name: alternate keywords
+ */
diff --git a/validation/reserved.c b/validation/reserved.c
index caacd21..e5d7af8 100644
--- a/validation/reserved.c
+++ b/validation/reserved.c
@@ -30,6 +30,7 @@ reserved.c:8:12: error: Trying to use reserved word '__const' as identifier
 reserved.c:9:12: error: Trying to use reserved word '__const__' as identifier
 reserved.c:10:12: error: Trying to use reserved word 'restrict' as identifier
 reserved.c:11:12: error: Trying to use reserved word '__restrict' as identifier
+reserved.c:12:12: error: Trying to use reserved word '__restrict__' as identifier
 reserved.c:13:12: error: Trying to use reserved word 'typedef' as identifier
 reserved.c:14:12: error: Trying to use reserved word '__typeof' as identifier
 reserved.c:15:12: error: Trying to use reserved word '__typeof__' as identifier
-- 
2.0.0
