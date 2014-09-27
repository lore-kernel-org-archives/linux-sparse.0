From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH v3 01/10] Add the __restrict__ keyword
Date: Sat, 27 Sep 2014 13:52:35 +0100
Message-ID: <5426B313.7050109@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:35940 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753129AbaI0M6Y (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Sep 2014 08:58:24 -0400
Received: from smtp.demon.co.uk (unknown [127.0.0.1])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id AE3BE6F90A8
	for <linux-sparse@vger.kernel.org>; Sat, 27 Sep 2014 13:51:49 +0100 (BST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Chris,

As promised, this adds tests for __restrict__ and restrict
keywords to validation/restrict-array.c.

[Note: I had intended to include a comment, just as for the
new test file, reminding gcc users to use -std=c99 etc., in
the case of the 'restrict' keyword (I always compile tests
with gcc), but I forgot. :( ]

ATB,
Ramsay Jones


 ident-list.h                    |  2 +-
 parse.c                         |  3 ++-
 validation/alternate-keywords.c | 46 +++++++++++++++++++++++++++++++++++++++++
 validation/reserved.c           |  1 +
 validation/restrict-array.c     | 25 ++++++++++++++++++++++
 5 files changed, 75 insertions(+), 2 deletions(-)
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
diff --git a/validation/restrict-array.c b/validation/restrict-array.c
index 3facebf..04bfdad 100644
--- a/validation/restrict-array.c
+++ b/validation/restrict-array.c
@@ -7,6 +7,31 @@ extern int lio_listio64 (int __mode,
 			 struct aiocb64 *__const __list[__restrict_arr],
 			 int __nent, struct sigevent *__restrict __sig);
 
+#undef __restrict_arr
+#define __restrict_arr __restrict__
+
+struct gaicb;
+
+extern int getaddrinfo_a (int __mode, struct gaicb *__list[__restrict_arr],
+			  int __ent, struct sigevent *__restrict __sig);
+
+#undef __restrict_arr
+#define __restrict_arr restrict
+
+typedef struct re_pattern_buffer regex_t;
+typedef int regoff_t;
+typedef struct
+{
+  regoff_t rm_so;  /* Byte offset from string's start to substring's start.  */
+  regoff_t rm_eo;  /* Byte offset from string's start to substring's end.  */
+} regmatch_t;
+typedef unsigned long int size_t;
+
+extern int regexec (const regex_t *__restrict __preg,
+		    const char *__restrict __string, size_t __nmatch,
+		    regmatch_t __pmatch[__restrict_arr],
+		    int __eflags);
+
 /*
  * check-name: restrict array attribute
  */
-- 
2.1.0
