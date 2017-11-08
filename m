From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 7/7] add support for C11's _Atomic as type qualifier
Date: Wed,  8 Nov 2017 22:06:13 +0100
Message-ID: <20171108210613.14252-8-luc.vanoostenryck@gmail.com>
References: <20171108210613.14252-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51420 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752939AbdKHVIb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Nov 2017 16:08:31 -0500
Received: by mail-wm0-f65.google.com with SMTP id b9so13637638wmh.0
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 13:08:31 -0800 (PST)
In-Reply-To: <20171108210613.14252-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This only add the parsing and checks as a type qualifier;
there is no operational semantic associated with it.

Note: this only support _Atomic as *type qualifier*, not
      as a *type specifier* (partly because there an
      ambiguity on how to parse '_Atomic' when followed
      by an open parenthesis (can be valid as qualifier
      and as specifier)).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 gdbhelpers               |  3 ++
 ident-list.h             |  2 +-
 parse.c                  | 13 +++++++
 show-parse.c             |  1 +
 symbol.h                 |  3 +-
 validation/c11-atomic.c  | 93 ++++++++++++++++++++++++++++++++++++++++++++++++
 validation/typeof-mods.c | 14 ++++++++
 7 files changed, 127 insertions(+), 2 deletions(-)
 create mode 100644 validation/c11-atomic.c

diff --git a/gdbhelpers b/gdbhelpers
index f6399d3bc..2fe9336dd 100644
--- a/gdbhelpers
+++ b/gdbhelpers
@@ -110,6 +110,9 @@ define gdb_show_ctype
 	if ($arg0->modifiers & MOD_RESTRICT)
 		printf "MOD_RESTRICT "
 	end
+	if ($arg0->modifiers & MOD_ATOMIC)
+		printf "MOD_ATOMIC "
+	end
 	if ($arg0->modifiers & MOD_SIGNED)
 		printf "MOD_SIGNED "
 	end
diff --git a/ident-list.h b/ident-list.h
index 130875741..2f1fecb48 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -37,7 +37,7 @@ IDENT_RESERVED(_Imaginary);
 /* C11 keywords */
 IDENT(_Alignas);
 IDENT_RESERVED(_Alignof);
-IDENT_RESERVED(_Atomic);
+IDENT(_Atomic);
 IDENT_RESERVED(_Generic);
 IDENT(_Noreturn);
 IDENT_RESERVED(_Static_assert);
diff --git a/parse.c b/parse.c
index e6b40fc3f..ab2e17daf 100644
--- a/parse.c
+++ b/parse.c
@@ -59,6 +59,7 @@ static declarator_t
 	register_specifier, static_specifier, extern_specifier,
 	thread_specifier, const_qualifier, volatile_qualifier;
 static declarator_t restrict_qualifier;
+static declarator_t atomic_qualifier;
 
 static struct token *parse_if_statement(struct token *token, struct statement *stmt);
 static struct token *parse_return_statement(struct token *token, struct statement *stmt);
@@ -178,6 +179,11 @@ static struct symbol_op restrict_op = {
 	.declarator = restrict_qualifier,
 };
 
+static struct symbol_op atomic_op = {
+	.type = KW_QUALIFIER,
+	.declarator = atomic_qualifier,
+};
+
 static struct symbol_op typeof_op = {
 	.type = KW_SPECIFIER,
 	.declarator = typeof_specifier,
@@ -427,6 +433,7 @@ static struct init_keyword {
 	{ "restrict",	NS_TYPEDEF, .op = &restrict_op},
 	{ "__restrict",	NS_TYPEDEF, .op = &restrict_op},
 	{ "__restrict__",	NS_TYPEDEF, .op = &restrict_op},
+	{ "_Atomic",	NS_TYPEDEF, .op = &atomic_op},
 
 	/* Typedef.. */
 	{ "typedef",	NS_TYPEDEF, .op = &typedef_op },
@@ -1473,6 +1480,12 @@ static struct token *restrict_qualifier(struct token *next, struct decl_state *c
 	return next;
 }
 
+static struct token *atomic_qualifier(struct token *next, struct decl_state *ctx)
+{
+	apply_qualifier(&next->pos, &ctx->ctype, MOD_ATOMIC);
+	return next;
+}
+
 static void apply_ctype(struct position pos, struct ctype *thistype, struct ctype *ctype)
 {
 	unsigned long mod = thistype->modifiers;
diff --git a/show-parse.c b/show-parse.c
index 825db6921..a4ce6f68d 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -126,6 +126,7 @@ const char *modifier_string(unsigned long mod)
 		{MOD_CONST,		"const"},
 		{MOD_VOLATILE,		"volatile"},
 		{MOD_RESTRICT,		"restrict"},
+		{MOD_ATOMIC,		"[atomic]"},
 		{MOD_SIGNED,		"[signed]"},
 		{MOD_UNSIGNED,		"[unsigned]"},
 		{MOD_CHAR,		"[char]"},
diff --git a/symbol.h b/symbol.h
index 1e7eefd74..bf69d44c6 100644
--- a/symbol.h
+++ b/symbol.h
@@ -214,6 +214,7 @@ struct symbol {
 #define MOD_CONST		0x00000200
 #define MOD_VOLATILE		0x00000400
 #define MOD_RESTRICT		0x00000800
+#define MOD_ATOMIC		0x00001000
 
 #define MOD_SIGNED		0x00002000
 #define MOD_UNSIGNED		0x00004000
@@ -243,7 +244,7 @@ struct symbol {
 #define MOD_SIZE	(MOD_CHAR | MOD_SHORT | MOD_LONG_ALL)
 #define MOD_IGNORE	(MOD_STORAGE | MOD_ADDRESSABLE |	\
 	MOD_ASSIGNED | MOD_USERTYPE | MOD_EXPLICITLY_SIGNED)
-#define	MOD_QUALIFIER	(MOD_CONST | MOD_VOLATILE | MOD_RESTRICT)
+#define	MOD_QUALIFIER	(MOD_CONST | MOD_VOLATILE | MOD_RESTRICT | MOD_ATOMIC)
 #define MOD_PTRINHERIT	(MOD_QUALIFIER | MOD_NODEREF | MOD_NORETURN | MOD_NOCAST)
 /* modifiers preserved by typeof() operator */
 #define MOD_TYPEOF	(MOD_QUALIFIER | MOD_NOCAST | MOD_SPECIFIER)
diff --git a/validation/c11-atomic.c b/validation/c11-atomic.c
new file mode 100644
index 000000000..bea3dab8f
--- /dev/null
+++ b/validation/c11-atomic.c
@@ -0,0 +1,93 @@
+void f00(int _Atomic  dst);
+void f01(int _Atomic *dst);
+void f02(int _Atomic *dst);
+void f03(int _Atomic *dst);
+
+int _Atomic qo;
+int         uo;
+
+void f00(int dst)	  { }	/* check-should-pass */
+void f01(typeof(&qo) dst) { }	/* check-should-pass */
+void f02(int *dst)	  { }	/* check-should-fail */
+void f03(typeof(&uo) dst) { }	/* check-should-fail */
+
+void foo(void)
+{
+	qo = uo;		/* check-should-pass */
+	uo = qo;		/* check-should-pass */
+}
+
+void ref(void)
+{
+	const int qo;
+	int uo;
+	extern const int *pqo;
+	extern       int *puo;
+
+	pqo = &qo;		/* check-should-pass */
+	pqo = &uo;		/* check-should-pass */
+	pqo = puo;
+
+	puo = &uo;		/* check-should-pass */
+
+	puo = &qo;		/* check-should-fail */
+	puo = pqo;		/* check-should-fail */
+}
+
+void bar(void)
+{
+	extern int _Atomic *pqo;
+	extern int         *puo;
+
+	pqo = &qo;		/* check-should-pass */
+	pqo = &uo;		/* check-should-pass */
+	pqo = puo;
+
+	puo = &uo;		/* check-should-pass */
+
+	puo = &qo;		/* check-should-fail */
+	puo = pqo;		/* check-should-fail */
+}
+
+void baz(void)
+{
+	extern typeof(&qo) pqo;
+	extern typeof(&uo) puo;
+
+	pqo = &qo;		/* check-should-pass */
+	pqo = &uo;		/* check-should-pass */
+	pqo = puo;
+
+	puo = &uo;		/* check-should-pass */
+
+	puo = &qo;		/* check-should-fail */
+	puo = pqo;		/* check-should-fail */
+}
+
+/*
+ * check-name: C11 _Atomic type qualifier
+ * check-command: sparse -Wno-decl $file;
+ *
+ * check-error-start
+c11-atomic.c:11:6: error: symbol 'f02' redeclared with different type (originally declared at c11-atomic.c:3) - incompatible argument 1 (different modifiers)
+c11-atomic.c:12:6: error: symbol 'f03' redeclared with different type (originally declared at c11-atomic.c:4) - incompatible argument 1 (different modifiers)
+c11-atomic.c:33:13: warning: incorrect type in assignment (different modifiers)
+c11-atomic.c:33:13:    expected int *extern [assigned] puo
+c11-atomic.c:33:13:    got int const *<noident>
+c11-atomic.c:34:13: warning: incorrect type in assignment (different modifiers)
+c11-atomic.c:34:13:    expected int *extern [assigned] puo
+c11-atomic.c:34:13:    got int const *extern [assigned] pqo
+c11-atomic.c:48:13: warning: incorrect type in assignment (different modifiers)
+c11-atomic.c:48:13:    expected int *extern [assigned] puo
+c11-atomic.c:48:13:    got int [atomic] *<noident>
+c11-atomic.c:49:13: warning: incorrect type in assignment (different modifiers)
+c11-atomic.c:49:13:    expected int *extern [assigned] puo
+c11-atomic.c:49:13:    got int [atomic] *extern [assigned] pqo
+c11-atomic.c:63:13: warning: incorrect type in assignment (different modifiers)
+c11-atomic.c:63:13:    expected int *extern [assigned] puo
+c11-atomic.c:63:13:    got int [atomic] *<noident>
+c11-atomic.c:64:13: warning: incorrect type in assignment (different modifiers)
+c11-atomic.c:64:13:    expected int *extern [assigned] puo
+c11-atomic.c:64:13:    got int [atomic] *extern [assigned] pqo
+ * check-error-end
+ */
diff --git a/validation/typeof-mods.c b/validation/typeof-mods.c
index 878a111a2..aa880f373 100644
--- a/validation/typeof-mods.c
+++ b/validation/typeof-mods.c
@@ -57,6 +57,20 @@ static void test_restrict(void)
 	obj = *ptr;
 }
 
+static void test_atomic(void)
+{
+	int _Atomic obj, *ptr;
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

