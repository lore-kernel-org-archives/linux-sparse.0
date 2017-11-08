From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 6/7] associate MOD_RESTRICT with restrict-qualified variables
Date: Wed,  8 Nov 2017 22:06:12 +0100
Message-ID: <20171108210613.14252-7-luc.vanoostenryck@gmail.com>
References: <20171108210613.14252-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:48878 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752595AbdKHVIa (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Nov 2017 16:08:30 -0500
Received: by mail-wm0-f67.google.com with SMTP id p75so13145126wmg.3
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 13:08:29 -0800 (PST)
In-Reply-To: <20171108210613.14252-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Note: there is still no semantic associated with 'restrict'
      but this is a preparatory step.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 gdbhelpers                   |  3 ++
 parse.c                      | 16 +++++---
 show-parse.c                 |  1 +
 symbol.h                     |  3 +-
 validation/optim/restrict.c  | 73 ++++++++++++++++++++++++++++++++++
 validation/reload-aliasing.c | 41 +++++++++++++++++++
 validation/restrict.c        | 93 ++++++++++++++++++++++++++++++++++++++++++++
 validation/typeof-mods.c     | 14 +++++++
 8 files changed, 238 insertions(+), 6 deletions(-)
 create mode 100644 validation/optim/restrict.c
 create mode 100644 validation/reload-aliasing.c
 create mode 100644 validation/restrict.c

diff --git a/gdbhelpers b/gdbhelpers
index 3d1148a87..f6399d3bc 100644
--- a/gdbhelpers
+++ b/gdbhelpers
@@ -107,6 +107,9 @@ define gdb_show_ctype
 	if ($arg0->modifiers & MOD_VOLATILE)
 		printf "MOD_VOLATILE "
 	end
+	if ($arg0->modifiers & MOD_RESTRICT)
+		printf "MOD_RESTRICT "
+	end
 	if ($arg0->modifiers & MOD_SIGNED)
 		printf "MOD_SIGNED "
 	end
diff --git a/parse.c b/parse.c
index c6dccfbd8..e6b40fc3f 100644
--- a/parse.c
+++ b/parse.c
@@ -58,6 +58,7 @@ static declarator_t
 	typedef_specifier, inline_specifier, auto_specifier,
 	register_specifier, static_specifier, extern_specifier,
 	thread_specifier, const_qualifier, volatile_qualifier;
+static declarator_t restrict_qualifier;
 
 static struct token *parse_if_statement(struct token *token, struct statement *stmt);
 static struct token *parse_return_statement(struct token *token, struct statement *stmt);
@@ -174,6 +175,7 @@ static struct symbol_op volatile_op = {
 
 static struct symbol_op restrict_op = {
 	.type = KW_QUALIFIER,
+	.declarator = restrict_qualifier,
 };
 
 static struct symbol_op typeof_op = {
@@ -422,6 +424,9 @@ static struct init_keyword {
 	{ "volatile",	NS_TYPEDEF, .op = &volatile_op },
 	{ "__volatile",		NS_TYPEDEF, .op = &volatile_op },
 	{ "__volatile__", 	NS_TYPEDEF, .op = &volatile_op },
+	{ "restrict",	NS_TYPEDEF, .op = &restrict_op},
+	{ "__restrict",	NS_TYPEDEF, .op = &restrict_op},
+	{ "__restrict__",	NS_TYPEDEF, .op = &restrict_op},
 
 	/* Typedef.. */
 	{ "typedef",	NS_TYPEDEF, .op = &typedef_op },
@@ -467,11 +472,6 @@ static struct init_keyword {
 
 	{ "_Alignas",	NS_TYPEDEF, .op = &alignas_op },
 
-	/* Ignored for now.. */
-	{ "restrict",	NS_TYPEDEF, .op = &restrict_op},
-	{ "__restrict",	NS_TYPEDEF, .op = &restrict_op},
-	{ "__restrict__",	NS_TYPEDEF, .op = &restrict_op},
-
 	/* Static assertion */
 	{ "_Static_assert", NS_KEYWORD, .op = &static_assert_op },
 
@@ -1467,6 +1467,12 @@ static struct token *volatile_qualifier(struct token *next, struct decl_state *c
 	return next;
 }
 
+static struct token *restrict_qualifier(struct token *next, struct decl_state *ctx)
+{
+	apply_qualifier(&next->pos, &ctx->ctype, MOD_RESTRICT);
+	return next;
+}
+
 static void apply_ctype(struct position pos, struct ctype *thistype, struct ctype *ctype)
 {
 	unsigned long mod = thistype->modifiers;
diff --git a/show-parse.c b/show-parse.c
index 3364aec5e..825db6921 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -125,6 +125,7 @@ const char *modifier_string(unsigned long mod)
 		{MOD_EXTERN,		"extern"},
 		{MOD_CONST,		"const"},
 		{MOD_VOLATILE,		"volatile"},
+		{MOD_RESTRICT,		"restrict"},
 		{MOD_SIGNED,		"[signed]"},
 		{MOD_UNSIGNED,		"[unsigned]"},
 		{MOD_CHAR,		"[char]"},
diff --git a/symbol.h b/symbol.h
index 994a11a7f..1e7eefd74 100644
--- a/symbol.h
+++ b/symbol.h
@@ -213,6 +213,7 @@ struct symbol {
 
 #define MOD_CONST		0x00000200
 #define MOD_VOLATILE		0x00000400
+#define MOD_RESTRICT		0x00000800
 
 #define MOD_SIGNED		0x00002000
 #define MOD_UNSIGNED		0x00004000
@@ -242,7 +243,7 @@ struct symbol {
 #define MOD_SIZE	(MOD_CHAR | MOD_SHORT | MOD_LONG_ALL)
 #define MOD_IGNORE	(MOD_STORAGE | MOD_ADDRESSABLE |	\
 	MOD_ASSIGNED | MOD_USERTYPE | MOD_EXPLICITLY_SIGNED)
-#define MOD_QUALIFIER	(MOD_CONST | MOD_VOLATILE)
+#define	MOD_QUALIFIER	(MOD_CONST | MOD_VOLATILE | MOD_RESTRICT)
 #define MOD_PTRINHERIT	(MOD_QUALIFIER | MOD_NODEREF | MOD_NORETURN | MOD_NOCAST)
 /* modifiers preserved by typeof() operator */
 #define MOD_TYPEOF	(MOD_QUALIFIER | MOD_NOCAST | MOD_SPECIFIER)
diff --git a/validation/optim/restrict.c b/validation/optim/restrict.c
new file mode 100644
index 000000000..de6289e2b
--- /dev/null
+++ b/validation/optim/restrict.c
@@ -0,0 +1,73 @@
+extern int g, h;
+
+void f00u(int *s)
+{
+	g = *s;
+	h = *s;
+}
+
+void f00r(int *restrict s)
+{
+	g = *s;
+	h = *s;
+}
+
+
+void f01u(int *a, int *b, int *s)
+{
+	*a = *s;
+	*b = *s;
+}
+
+void f01r(int *restrict a, int *restrict b, int *restrict s)
+{
+	*a = *s;
+	*b = *s;
+}
+
+/*
+ * check-name: optim/restrict
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-start
+f00u:
+.L0:
+	<entry-point>
+	load.32     %r2 <- 0[%arg1]
+	store.32    %r2 -> 0[g]
+	load.32     %r4 <- 0[%arg1]
+	store.32    %r4 -> 0[h]
+	ret
+
+
+f00r:
+.L2:
+	<entry-point>
+	load.32     %r6 <- 0[%arg1]
+	store.32    %r6 -> 0[g]
+	store.32    %r6 -> 0[h]
+	ret
+
+
+f01u:
+.L4:
+	<entry-point>
+	load.32     %r10 <- 0[%arg3]
+	store.32    %r10 -> 0[%arg1]
+	load.32     %r13 <- 0[%arg3]
+	store.32    %r13 -> 0[%arg2]
+	ret
+
+
+f01r:
+.L6:
+	<entry-point>
+	load.32     %r16 <- 0[%arg3]
+	store.32    %r16 -> 0[%arg1]
+	store.32    %r16 -> 0[%arg2]
+	ret
+
+
+ * check-output-end
+ */
diff --git a/validation/reload-aliasing.c b/validation/reload-aliasing.c
new file mode 100644
index 000000000..3aad317bd
--- /dev/null
+++ b/validation/reload-aliasing.c
@@ -0,0 +1,41 @@
+extern int g, h;
+
+void f00(int *s)
+{
+	g = *s;
+	h = *s;
+}
+
+void f01(int *a, int *b, int *s)
+{
+	*a = *s;
+	*b = *s;
+}
+
+/*
+ * check-name: reload-aliasing.c
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-start
+f00:
+.L0:
+	<entry-point>
+	load.32     %r2 <- 0[%arg1]
+	store.32    %r2 -> 0[g]
+	load.32     %r4 <- 0[%arg1]
+	store.32    %r4 -> 0[h]
+	ret
+
+
+f01:
+.L2:
+	<entry-point>
+	load.32     %r6 <- 0[%arg3]
+	store.32    %r6 -> 0[%arg1]
+	load.32     %r9 <- 0[%arg3]
+	store.32    %r9 -> 0[%arg2]
+	ret
+
+
+ * check-output-end
+ */
diff --git a/validation/restrict.c b/validation/restrict.c
new file mode 100644
index 000000000..f431f6d0f
--- /dev/null
+++ b/validation/restrict.c
@@ -0,0 +1,93 @@
+void f00(void *restrict  dst);
+void f01(void *restrict *dst);
+void f02(void *restrict *dst);
+void f03(void *restrict *dst);
+
+void *restrict rp;
+void * up;
+
+void f00(void *dst)	  { }	/* check-should-pass */
+void f01(typeof(&rp) dst) { }	/* check-should-pass */
+void f02(void **dst)	  { }	/* check-should-fail */
+void f03(typeof(&up) dst) { }	/* check-should-fail */
+
+void foo(void)
+{
+	rp = up;		/* check-should-pass */
+	up = rp;		/* check-should-pass */
+}
+
+void ref(void)
+{
+	void *const qp;
+	void * up;
+	extern void *const *pqp;
+	extern void **pup;
+
+	pqp = &qp;		/* check-should-pass */
+	pqp = &up;		/* check-should-pass */
+	pqp = pup;
+
+	pup = &up;		/* check-should-pass */
+
+	pup = &qp;		/* check-should-fail */
+	pup = pqp;		/* check-should-fail */
+}
+
+void bar(void)
+{
+	extern void *restrict *prp;
+	extern void **pup;
+
+	prp = &rp;		/* check-should-pass */
+	prp = &up;		/* check-should-pass */
+	prp = pup;
+
+	pup = &up;		/* check-should-pass */
+
+	pup = &rp;		/* check-should-fail */
+	pup = prp;		/* check-should-fail */
+}
+
+void baz(void)
+{
+	extern typeof(&rp) prp;
+	extern typeof(&up) pup;
+
+	prp = &rp;		/* check-should-pass */
+	prp = &up;		/* check-should-pass */
+	prp = pup;
+
+	pup = &up;		/* check-should-pass */
+
+	pup = &rp;		/* check-should-fail */
+	pup = prp;		/* check-should-fail */
+}
+
+/*
+ * check-name: restrict qualifier
+ * check-command: sparse -Wno-decl $file;
+ *
+ * check-error-start
+restrict.c:11:6: error: symbol 'f02' redeclared with different type (originally declared at restrict.c:3) - incompatible argument 1 (different modifiers)
+restrict.c:12:6: error: symbol 'f03' redeclared with different type (originally declared at restrict.c:4) - incompatible argument 1 (different modifiers)
+restrict.c:33:13: warning: incorrect type in assignment (different modifiers)
+restrict.c:33:13:    expected void **extern [assigned] pup
+restrict.c:33:13:    got void *const *<noident>
+restrict.c:34:13: warning: incorrect type in assignment (different modifiers)
+restrict.c:34:13:    expected void **extern [assigned] pup
+restrict.c:34:13:    got void *const *extern [assigned] pqp
+restrict.c:48:13: warning: incorrect type in assignment (different modifiers)
+restrict.c:48:13:    expected void **extern [assigned] pup
+restrict.c:48:13:    got void *restrict *<noident>
+restrict.c:49:13: warning: incorrect type in assignment (different modifiers)
+restrict.c:49:13:    expected void **extern [assigned] pup
+restrict.c:49:13:    got void *restrict *extern [assigned] prp
+restrict.c:63:13: warning: incorrect type in assignment (different modifiers)
+restrict.c:63:13:    expected void **extern [assigned] pup
+restrict.c:63:13:    got void *restrict *<noident>
+restrict.c:64:13: warning: incorrect type in assignment (different modifiers)
+restrict.c:64:13:    expected void **extern [assigned] pup
+restrict.c:64:13:    got void *restrict *extern [assigned] prp
+ * check-error-end
+ */
diff --git a/validation/typeof-mods.c b/validation/typeof-mods.c
index 9822e96f6..878a111a2 100644
--- a/validation/typeof-mods.c
+++ b/validation/typeof-mods.c
@@ -43,6 +43,20 @@ static void test_volatile(void)
 	obj = *ptr;
 }
 
+static void test_restrict(void)
+{
+	int *restrict obj, *restrict *ptr;
+	typeof(obj) var = obj;
+	typeof(ptr) ptr2 = ptr;
+	typeof(*ptr) var2 = obj;
+	typeof(*ptr) *ptr3 = ptr;
+	typeof(obj) *ptr4 = ptr;
+	obj = obj;
+	ptr = ptr;
+	ptr = &obj;
+	obj = *ptr;
+}
+
 static void test_bitwise(void)
 {
 	typedef int __bitwise type_t;
-- 
2.14.0

