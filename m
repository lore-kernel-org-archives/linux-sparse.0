From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 13/18] Rewrite and fix specifiers handling
Date: Mon, 09 Mar 2009 07:12:18 +0000
Message-ID: <E1LgZes-0000xr-2I@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:43803 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366AbZCIHMU (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Mar 2009 03:12:20 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LgZes-0000xr-2I
	for linux-sparse@vger.kernel.org; Mon, 09 Mar 2009 07:12:18 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Make sure that we accept the right set; kill ad-hackery around checks
for banned combinations.  Instead of that we keep a bitmap describing
what we'd already seen (with several extra bits for 'long long' and
for keeping track of can't-combine-with-anything stuff), check and
update it using the values in ..._op and keep track of size modifiers
more or less explicitly.

Testcases added.  A _lot_ of that used to be done wrong.

Note that __attribute__((mode(...))) got more broken by this one;
the next several changesets will take care of that.

One more thing: we are -><- close to getting rid of MOD_SPECIFIER bits
for good.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 ident-list.h             |    1 +
 parse.c                  |  365 ++++++++++++++++++++++++++--------------------
 parse.h                  |    1 -
 symbol.h                 |   12 +-
 validation/specifiers1.c |  101 +++++++++++++
 validation/specifiers2.c |  152 +++++++++++++++++++
 6 files changed, 467 insertions(+), 165 deletions(-)
 create mode 100644 validation/specifiers1.c
 create mode 100644 validation/specifiers2.c

diff --git a/ident-list.h b/ident-list.h
index 6104826..e22084e 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -23,6 +23,7 @@ IDENT(union);
 IDENT(enum);
 IDENT(__attribute); IDENT(__attribute__);
 IDENT(volatile); IDENT(__volatile); IDENT(__volatile__);
+IDENT(double);
 
 /* Extended gcc identifiers */
 IDENT(asm); IDENT_RESERVED(__asm); IDENT_RESERVED(__asm__);
diff --git a/parse.c b/parse.c
index 04a4227..73b4cac 100644
--- a/parse.c
+++ b/parse.c
@@ -67,6 +67,24 @@ static struct token *attribute_context(struct token *token, struct symbol *attr,
 static struct token *attribute_transparent_union(struct token *token, struct symbol *attr, struct ctype *ctype);
 static struct token *ignore_attribute(struct token *token, struct symbol *attr, struct ctype *ctype);
 
+enum {
+	Set_T = 1,
+	Set_S = 2,
+	Set_Char = 4,
+	Set_Int = 8,
+	Set_Double = 16,
+	Set_Float = 32,
+	Set_Signed = 64,
+	Set_Unsigned = 128,
+	Set_Short = 256,
+	Set_Long = 512,
+	Set_Vlong = 1024,
+	Set_Any = Set_T | Set_Short | Set_Long | Set_Signed | Set_Unsigned
+};
+
+enum {
+	CInt = 0, CSInt, CUInt, CReal, CChar, CSChar, CUChar
+};
 
 static struct symbol_op modifier_op = {
 	.type = KW_MODIFIER,
@@ -77,8 +95,10 @@ static struct symbol_op qualifier_op = {
 };
 
 static struct symbol_op typeof_op = {
-	.type = KW_TYPEOF,
+	.type = KW_SPECIFIER,
 	.declarator = typeof_specifier,
+	.test = Set_Any,
+	.set = Set_S|Set_T,
 };
 
 static struct symbol_op attribute_op = {
@@ -89,20 +109,81 @@ static struct symbol_op attribute_op = {
 static struct symbol_op struct_op = {
 	.type = KW_SPECIFIER,
 	.declarator = struct_specifier,
+	.test = Set_Any,
+	.set = Set_S|Set_T,
 };
 
 static struct symbol_op union_op = {
 	.type = KW_SPECIFIER,
 	.declarator = union_specifier,
+	.test = Set_Any,
+	.set = Set_S|Set_T,
 };
 
 static struct symbol_op enum_op = {
 	.type = KW_SPECIFIER,
 	.declarator = enum_specifier,
+	.test = Set_Any,
+	.set = Set_S|Set_T,
 };
 
 static struct symbol_op spec_op = {
-	.type = KW_SPEC,
+	.type = KW_SPECIFIER,
+	.test = Set_Any,
+	.set = Set_S|Set_T,
+};
+
+static struct symbol_op char_op = {
+	.type = KW_SPECIFIER,
+	.test = Set_T|Set_Long|Set_Short,
+	.set = Set_T|Set_Char,
+	.class = CChar,
+};
+
+static struct symbol_op int_op = {
+	.type = KW_SPECIFIER,
+	.test = Set_T,
+	.set = Set_T|Set_Int,
+};
+
+static struct symbol_op double_op = {
+	.type = KW_SPECIFIER,
+	.test = Set_T|Set_Signed|Set_Unsigned|Set_Short|Set_Vlong,
+	.set = Set_T|Set_Double,
+	.class = CReal,
+};
+
+static struct symbol_op float_op = {
+	.type = KW_SPECIFIER | KW_SHORT,
+	.test = Set_T|Set_Signed|Set_Unsigned|Set_Short|Set_Long,
+	.set = Set_T|Set_Float,
+	.class = CReal,
+};
+
+static struct symbol_op short_op = {
+	.type = KW_SPECIFIER | KW_SHORT,
+	.test = Set_S|Set_Char|Set_Float|Set_Double|Set_Long|Set_Short,
+	.set = Set_Short,
+};
+
+static struct symbol_op signed_op = {
+	.type = KW_SPECIFIER,
+	.test = Set_S|Set_Float|Set_Double|Set_Signed|Set_Unsigned,
+	.set = Set_Signed,
+	.class = CSInt,
+};
+
+static struct symbol_op unsigned_op = {
+	.type = KW_SPECIFIER,
+	.test = Set_S|Set_Float|Set_Double|Set_Signed|Set_Unsigned,
+	.set = Set_Unsigned,
+	.class = CUInt,
+};
+
+static struct symbol_op long_op = {
+	.type = KW_SPECIFIER | KW_LONG,
+	.test = Set_S|Set_Char|Set_Float|Set_Short|Set_Vlong,
+	.set = Set_Long,
 };
 
 static struct symbol_op if_op = {
@@ -216,22 +297,21 @@ static struct init_keyword {
 
 	/* Type specifiers */
 	{ "void",	NS_TYPEDEF, .type = &void_ctype, .op = &spec_op},
-	{ "char",	NS_TYPEDEF, MOD_CHAR, .op = &spec_op },
-	{ "short",	NS_TYPEDEF, MOD_SHORT, .op = &spec_op },
-	{ "int",	NS_TYPEDEF, .type = &int_type, .op = &spec_op },
-	{ "long",	NS_TYPEDEF, MOD_LONG, .op = &spec_op },
-	{ "float",	NS_TYPEDEF, .type = &fp_type, .op = &spec_op },
-	{ "double",	NS_TYPEDEF, MOD_LONG, .type = &fp_type, .op = &spec_op },
-	{ "signed",	NS_TYPEDEF, MOD_SIGNED | MOD_EXPLICITLY_SIGNED, .op = &spec_op },
-	{ "__signed",	NS_TYPEDEF, MOD_SIGNED | MOD_EXPLICITLY_SIGNED, .op = &spec_op },
-	{ "__signed__",	NS_TYPEDEF, MOD_SIGNED | MOD_EXPLICITLY_SIGNED, .op = &spec_op },
-	{ "unsigned",	NS_TYPEDEF, MOD_UNSIGNED, .op = &spec_op },
-	{ "__label__",	NS_TYPEDEF, MOD_LABEL | MOD_UNSIGNED,
-		.type =&label_ctype, .op = &spec_op },
-	{ "_Bool",	NS_TYPEDEF, MOD_UNSIGNED, .type = &bool_ctype,
-		.op = &spec_op },
+	{ "char",	NS_TYPEDEF, .op = &char_op },
+	{ "short",	NS_TYPEDEF, .op = &short_op },
+	{ "int",	NS_TYPEDEF, .op = &int_op },
+	{ "long",	NS_TYPEDEF, .op = &long_op },
+	{ "float",	NS_TYPEDEF, .op = &float_op },
+	{ "double",	NS_TYPEDEF, .op = &double_op },
+	{ "signed",	NS_TYPEDEF, .op = &signed_op },
+	{ "__signed",	NS_TYPEDEF, .op = &signed_op },
+	{ "__signed__",	NS_TYPEDEF, .op = &signed_op },
+	{ "unsigned",	NS_TYPEDEF, .op = &unsigned_op },
+	{ "_Bool",	NS_TYPEDEF, .type = &bool_ctype, .op = &spec_op },
 
 	/* Predeclared types */
+	{ "__label__",	NS_TYPEDEF, MOD_LABEL,
+		.type =&label_ctype, .op = &spec_op },
 	{ "__builtin_va_list", NS_TYPEDEF, .type = &ptr_ctype, .op = &spec_op },
 
 	/* Extended types */
@@ -428,45 +508,7 @@ static struct token *struct_declaration_list(struct token *token, struct symbol_
 
 static int apply_modifiers(struct position pos, struct ctype *ctype)
 {
-	struct symbol *base;
-
-	while ((base = ctype->base_type)) {
-		switch (base->type) {
-		case SYM_FN:
-		case SYM_ENUM:
-		case SYM_ARRAY:
-		case SYM_BITFIELD:
-		case SYM_PTR:
-			ctype = &base->ctype;
-			continue;
-		}
-		break;
-	}
-
-	/* Turn the "virtual types" into real types with real sizes etc */
-	if (ctype->base_type == &int_type) {
-		ctype->base_type = ctype_integer(ctype->modifiers);
-		ctype->modifiers &= ~MOD_SPECIFIER;
-	} else if (ctype->base_type == &fp_type) {
-		ctype->base_type = ctype_fp(ctype->modifiers);
-		ctype->modifiers &= ~MOD_SPECIFIER;
-	}
-
-	if (ctype->modifiers & MOD_BITWISE) {
-		struct symbol *type;
-		ctype->modifiers &= ~(MOD_BITWISE | MOD_SPECIFIER);
-		if (!is_int_type(ctype->base_type)) {
-			sparse_error(pos, "invalid modifier");
-			return 1;
-		}
-		type = alloc_symbol(pos, SYM_BASETYPE);
-		*type = *ctype->base_type;
-		type->ctype.base_type = ctype->base_type;
-		type->type = SYM_RESTRICT;
-		type->ctype.modifiers &= ~MOD_SPECIFIER;
-		ctype->base_type = type;
-		create_fouled(type);
-	}
+	/* not removing it; application of delayed attributes will be here */
 	return 0;
 }
 
@@ -990,82 +1032,26 @@ static struct token *attribute_specifier(struct token *token, struct ctype *ctyp
 	return token;
 }
 
-struct symbol * ctype_integer(unsigned long spec)
-{
-	static struct symbol *const integer_ctypes[][3] = {
-		{ &llong_ctype, &sllong_ctype, &ullong_ctype },
-		{ &long_ctype,  &slong_ctype,  &ulong_ctype  },
-		{ &short_ctype, &sshort_ctype, &ushort_ctype },
-		{ &char_ctype,  &schar_ctype,  &uchar_ctype  },
-		{ &int_ctype,   &sint_ctype,   &uint_ctype   },
-	};
-	struct symbol *const (*ctype)[3];
-	int sub;
-
-	ctype = integer_ctypes;
-	if (!(spec & MOD_LONGLONG)) {
-		ctype++;
-		if (!(spec & MOD_LONG)) {
-			ctype++;
-			if (!(spec & MOD_SHORT)) {
-				ctype++;
-				if (!(spec & MOD_CHAR))
-					ctype++;
-			}
-		}
-	}
-
-	sub = ((spec & MOD_UNSIGNED)
-	       ? 2
-	       : ((spec & MOD_EXPLICITLY_SIGNED)
-		  ? 1
-		  : 0));
-
-	return ctype[0][sub];
-}
-
-struct symbol * ctype_fp(unsigned long spec)
-{
-	if (spec & MOD_LONGLONG)
-		return &ldouble_ctype;
-	if (spec & MOD_LONG)
-		return &double_ctype;
-	return &float_ctype;
-}
-
 static void apply_ctype(struct position pos, struct ctype *thistype, struct ctype *ctype)
 {
 	unsigned long mod = thistype->modifiers;
 
 	if (mod) {
 		unsigned long old = ctype->modifiers;
-		unsigned long extra = 0, dup, conflict;
+		unsigned long dup, conflict;
 
-		if (mod & old & MOD_LONG) {
-			extra = MOD_LONGLONG | MOD_LONG;
-			mod &= ~MOD_LONG;
-			old &= ~MOD_LONG;
-		}
-		dup = (mod & old) | (extra & old) | (extra & mod);
+		dup = mod & old;
 		if (dup)
 			sparse_error(pos, "Just how %sdo you want this type to be?",
 				modifier_string(dup));
 
-		conflict = !(~mod & ~old & (MOD_LONG | MOD_SHORT));
-		if (conflict)
-			sparse_error(pos, "You cannot have both long and short modifiers.");
-
-		conflict = !(~mod & ~old & (MOD_SIGNED | MOD_UNSIGNED));
-		if (conflict)
-			sparse_error(pos, "You cannot have both signed and unsigned modifiers.");
-
 		// Only one storage modifier allowed, except that "inline" doesn't count.
 		conflict = (mod | old) & (MOD_STORAGE & ~MOD_INLINE);
 		conflict &= (conflict - 1);
 		if (conflict)
 			sparse_error(pos, "multiple storage classes");
 
-		ctype->modifiers = old | mod | extra;
+		ctype->modifiers = old | mod;
 	}
 
 	/* Context */
@@ -1085,41 +1071,76 @@ static void apply_ctype(struct position pos, struct ctype *thistype, struct ctyp
 		ctype->as = thistype->as;
 }
 
-static void check_modifiers(struct position *pos, struct symbol *s, unsigned long mod)
-{
-	unsigned long banned, wrong;
-	const unsigned long BANNED_SIZE = MOD_LONG | MOD_LONGLONG | MOD_SHORT;
-	const unsigned long BANNED_SIGN = MOD_SIGNED | MOD_UNSIGNED;
-
-	if (!(s->op->type & KW_SPEC))
-		banned = s->op->type == KW_SPECIFIER ? (BANNED_SIZE | BANNED_SIGN) : 0;
-	else if (s->ctype.base_type == &fp_type)
-		banned = BANNED_SIGN;
-	else if (s->ctype.base_type == &int_type || !s->ctype.base_type || is_int_type (s))
-		banned = 0;
-	else {
-		// label_type
-		// void_type
-		// bad_type
-		// vector_type <-- whatever that is
-		banned = BANNED_SIZE | BANNED_SIGN;
-	}
+static void specifier_conflict(struct position pos, int what, struct ident *new)
+{
+	const char *old;
+	if (what & (Set_S | Set_T))
+		goto Catch_all;
+	if (what & Set_Char)
+		old = "char";
+	else if (what & Set_Double)
+		old = "double";
+	else if (what & Set_Float)
+		old = "float";
+	else if (what & Set_Signed)
+		old = "signed";
+	else if (what & Set_Unsigned)
+		old = "unsigned";
+	else if (what & Set_Short)
+		old = "short";
+	else if (what & Set_Long)
+		old = "long";
+	else
+		old = "long long";
+	sparse_error(pos, "impossible combination of type specifiers: %s %s",
+			old, show_ident(new));
+	return;
+
+Catch_all:
+	sparse_error(pos, "two or more data types in declaration specifiers");
+}
+
+static struct symbol * const int_types[] =
+	{&short_ctype, &int_ctype, &long_ctype, &llong_ctype};
+static struct symbol * const signed_types[] =
+	{&sshort_ctype, &sint_ctype, &slong_ctype, &sllong_ctype};
+static struct symbol * const unsigned_types[] =
+	{&ushort_ctype, &uint_ctype, &ulong_ctype, &ullong_ctype};
+static struct symbol * const real_types[] =
+	{&float_ctype, &double_ctype, &ldouble_ctype};
+static struct symbol * const char_types[] =
+	{&char_ctype, &schar_ctype, &uchar_ctype};
+static struct symbol * const * const types[] = {
+	int_types + 1, signed_types + 1, unsigned_types + 1,
+	real_types + 1, char_types, char_types + 1, char_types + 2
+};
+
+struct symbol *ctype_integer(unsigned long spec)
+{
+	int size;
+
+	if (spec & MOD_LONGLONG)
+		size = 2;
+	else if (spec & MOD_LONG)
+		size = 1;
+	else
+		size = 0;
 
-	wrong = mod & banned;
-	if (wrong)
-		sparse_error(*pos, "modifier %sis invalid in this context",
-		     modifier_string (wrong));
+	return types[spec & MOD_UNSIGNED ? CUInt : CInt][size];
 }
 
 static struct token *declaration_specifiers(struct token *next, struct decl_state *ctx, int qual)
 {
+
 	struct token *token;
+	int seen = 0;
+	int class = CInt;
+	int size = 0;
 
 	while ( (token = next) != NULL ) {
 		struct ctype thistype;
 		struct ident *ident;
 		struct symbol *s, *type;
-		unsigned long mod;
 
 		next = token->next;
 		if (token_type(token) != TOKEN_IDENT)
@@ -1136,43 +1157,69 @@ static struct token *declaration_specifiers(struct token *next, struct decl_stat
 				break;
 		}
 		if (s->ctype.modifiers & MOD_USERTYPE) {
-			if (ctx->ctype.base_type)
-				break;
-			if (ctx->ctype.modifiers & MOD_SPECIFIER)
+			if (seen & Set_Any)
 				break;
+			seen |= Set_S | Set_T;
 			ctx->ctype.base_type = s->ctype.base_type;
 			apply_ctype(token->pos, &s->ctype, &ctx->ctype);
 			continue;
 		}
+		if (s->type != SYM_KEYWORD)
+			break;
+		if (s->op->type & KW_SPECIFIER) {
+			if (seen & s->op->test) {
+				specifier_conflict(token->pos,
+						   seen & s->op->test,
+						   ident);
+				break;
+			}
+			seen |= s->op->set;
+			class += s->op->class;
+			if (s->op->type & KW_SHORT) {
+				size = -1;
+			} else if (s->op->type & KW_LONG && size++) {
+				if (class == CReal) {
+					specifier_conflict(token->pos,
+							   Set_Vlong,
+							   &double_ident);
+					break;
+				}
+				seen |= Set_Vlong;
+			}
+		}
 		thistype = s->ctype;
-		mod = thistype.modifiers;
-		if (s->type == SYM_KEYWORD && s->op->declarator) {
+		if (s->op->declarator)
 			next = s->op->declarator(next, &thistype);
-			mod = thistype.modifiers;
-		}
 		type = thistype.base_type;
-		if (type) {
-			if (ctx->ctype.base_type)
-				break;
+		if (type)
 			ctx->ctype.base_type = type;
-		}
-
-		check_modifiers(&token->pos, s, ctx->ctype.modifiers);
 		apply_ctype(token->pos, &thistype, &ctx->ctype);
 	}
+	if (qual)
+		return token;
 
-	if (!ctx->ctype.base_type) {
+	if (!(seen & Set_S)) {	/* not set explicitly? */
 		struct symbol *base = &incomplete_ctype;
-
-		/*
-		 * If we have modifiers, we'll default to an integer
-		 * type, and "ctype_integer()" will turn this into
-		 * a specific one.
-		 */
-		if (ctx->ctype.modifiers & MOD_SPECIFIER)
-			base = &int_type;
+		if (seen & Set_Any)
+			base = types[class][size];
 		ctx->ctype.base_type = base;
 	}
+
+	if (ctx->ctype.modifiers & MOD_BITWISE) {
+		struct symbol *type;
+		ctx->ctype.modifiers &= ~MOD_BITWISE;
+		if (!is_int_type(ctx->ctype.base_type)) {
+			sparse_error(token->pos, "invalid modifier");
+			return token;
+		}
+		type = alloc_symbol(token->pos, SYM_BASETYPE);
+		*type = *ctx->ctype.base_type;
+		type->ctype.modifiers &= ~MOD_SPECIFIER;
+		type->ctype.base_type = ctx->ctype.base_type;
+		type->type = SYM_RESTRICT;
+		ctx->ctype.base_type = type;
+		create_fouled(type);
+	}
 	return token;
 }
 
diff --git a/parse.h b/parse.h
index 609910f..26dc624 100644
--- a/parse.h
+++ b/parse.h
@@ -128,7 +128,6 @@ extern int show_expression(struct expression *);
 extern struct token *external_declaration(struct token *token, struct symbol_list **list);
 
 extern struct symbol *ctype_integer(unsigned long spec);
-extern struct symbol *ctype_fp(unsigned long spec);
 
 extern void copy_statement(struct statement *src, struct statement *dst);
 extern int inline_function(struct expression *expr, struct symbol *sym);
diff --git a/symbol.h b/symbol.h
index 229057c..f82f51d 100644
--- a/symbol.h
+++ b/symbol.h
@@ -64,11 +64,11 @@ enum keyword {
 	KW_MODIFIER	= 1 << 1,
 	KW_QUALIFIER	= 1 << 2,
 	KW_ATTRIBUTE	= 1 << 3,
-	KW_TYPEOF	= 1 << 4,
-	KW_STATEMENT	= 1 << 5,
-	KW_ASM		= 1 << 6,
-	KW_MODE		= 1 << 7,
-	KW_SPEC		= 1 << 8,
+	KW_STATEMENT	= 1 << 4,
+	KW_ASM		= 1 << 5,
+	KW_MODE		= 1 << 6,
+	KW_SHORT	= 1 << 7,
+	KW_LONG		= 1 << 8,
 };
 
 struct context {
@@ -105,6 +105,8 @@ struct symbol_op {
 	struct token *(*statement)(struct token *token, struct statement *stmt);
 	struct token *(*toplevel)(struct token *token, struct symbol_list **list);
 	struct token *(*attribute)(struct token *token, struct symbol *attr, struct ctype *ctype);
+
+	int test, set, class;
 };
 
 extern int expand_safe_p(struct expression *expr, int cost);
diff --git a/validation/specifiers1.c b/validation/specifiers1.c
new file mode 100644
index 0000000..86db45d
--- /dev/null
+++ b/validation/specifiers1.c
@@ -0,0 +1,101 @@
+static void OK(void)
+{
+#define TEST(x) { T a; x *b = &a; }
+#define TEST2(x, y) TEST(x y) TEST(y x)
+#define TEST3(x, y, z) TEST(x y z) TEST(x z y) TEST(y x z) \
+		       TEST(y z x) TEST(z x y) TEST(z y x)
+#define TEST4(x, y, z, w) TEST2(x y, z w) TEST2(x y, w z) \
+			  TEST2(y x, z w) TEST2(y x, w z) \
+			  TEST2(x z, y w) TEST2(x z, w y) \
+			  TEST2(z x, y w) TEST2(z x, w y) \
+			  TEST2(x w, y z) TEST2(x w, z y) \
+			  TEST2(w x, y z) TEST2(w x, z y)
+
+
+#define T char
+TEST(char)
+#undef T
+
+#define T signed char
+TEST2(char, signed)
+#undef T
+
+#define T unsigned char
+TEST2(char, unsigned)
+#undef T
+
+#define T short
+TEST(short)
+TEST2(int, short)
+#undef T
+
+#define T int
+TEST(int)
+#undef T
+
+#define T long
+TEST(long)
+TEST2(int, long)
+#undef T
+
+#define T long long
+TEST2(long, long)
+TEST3(int, long, long)
+#undef T
+
+#define T signed short
+TEST2(short, signed)
+TEST3(int, short, signed)
+#undef T
+
+#define T signed
+TEST(signed)
+TEST2(int, signed)
+#undef T
+
+#define T signed long
+TEST2(long, signed)
+TEST3(int, long, signed)
+#undef T
+
+#define T signed long long
+TEST3(long, long, signed)
+TEST4(int, long, long, signed)
+#undef T
+
+#define T unsigned short
+TEST2(short, unsigned)
+TEST3(int, short, unsigned)
+#undef T
+
+#define T unsigned
+TEST(unsigned)
+TEST2(int, unsigned)
+#undef T
+
+#define T unsigned long
+TEST2(long, unsigned)
+TEST3(int, long, unsigned)
+#undef T
+
+#define T unsigned long long
+TEST3(long, long, unsigned)
+TEST4(int, long, long, unsigned)
+#undef T
+
+#define T float
+TEST(float)
+#undef T
+
+#define T double
+TEST(double)
+#undef T
+
+#define T long double
+TEST2(double, long)
+#undef T
+}
+/*
+ * check-name: valid specifier combinations
+ * check-command: sparse -Wall $file
+ */
diff --git a/validation/specifiers2.c b/validation/specifiers2.c
new file mode 100644
index 0000000..d5be118
--- /dev/null
+++ b/validation/specifiers2.c
@@ -0,0 +1,152 @@
+typedef int T;
+void BAD(
+char char,
+char int,
+char double,
+char float,
+char long,
+char short,
+int char,
+int int,
+int double,
+int float,
+double char,
+double int,
+double double,
+double float,
+double short,
+double signed,
+double unsigned,
+float char,
+float int,
+float double,
+float float,
+float short,
+float long,
+float signed,
+float unsigned,
+short char,
+short double,
+short float,
+short short,
+short long,
+long char,
+long float,
+long short,
+signed double,
+signed float,
+signed signed,
+signed unsigned,
+unsigned double,
+unsigned float,
+unsigned signed,
+unsigned unsigned,
+unsigned signed,
+long long long,
+long double long,
+long long double,
+double long long,
+T char,
+T int,
+T double,
+T float,
+T short,
+T long,
+T signed,
+T unsigned,
+T void,
+void char,
+void int,
+void double,
+void float,
+void short,
+void long,
+void signed,
+void unsigned,
+char void,
+int void,
+double void,
+float void,
+short void,
+long void,
+signed void,
+unsigned void,
+void void
+);
+/*
+ * check-name: invalid specifier combinations
+ * check-error-start
+specifiers2.c:3:6: error: two or more data types in declaration specifiers
+specifiers2.c:4:6: error: two or more data types in declaration specifiers
+specifiers2.c:5:6: error: two or more data types in declaration specifiers
+specifiers2.c:6:6: error: two or more data types in declaration specifiers
+specifiers2.c:7:6: error: impossible combination of type specifiers: char long
+specifiers2.c:8:6: error: impossible combination of type specifiers: char short
+specifiers2.c:9:5: error: two or more data types in declaration specifiers
+specifiers2.c:10:5: error: two or more data types in declaration specifiers
+specifiers2.c:11:5: error: two or more data types in declaration specifiers
+specifiers2.c:12:5: error: two or more data types in declaration specifiers
+specifiers2.c:13:8: error: two or more data types in declaration specifiers
+specifiers2.c:14:8: error: two or more data types in declaration specifiers
+specifiers2.c:15:8: error: two or more data types in declaration specifiers
+specifiers2.c:16:8: error: two or more data types in declaration specifiers
+specifiers2.c:17:8: error: impossible combination of type specifiers: double short
+specifiers2.c:18:8: error: impossible combination of type specifiers: double signed
+specifiers2.c:19:8: error: impossible combination of type specifiers: double unsigned
+specifiers2.c:20:7: error: two or more data types in declaration specifiers
+specifiers2.c:21:7: error: two or more data types in declaration specifiers
+specifiers2.c:22:7: error: two or more data types in declaration specifiers
+specifiers2.c:23:7: error: two or more data types in declaration specifiers
+specifiers2.c:24:7: error: impossible combination of type specifiers: float short
+specifiers2.c:25:7: error: impossible combination of type specifiers: float long
+specifiers2.c:26:7: error: impossible combination of type specifiers: float signed
+specifiers2.c:27:7: error: impossible combination of type specifiers: float unsigned
+specifiers2.c:28:7: error: impossible combination of type specifiers: short char
+specifiers2.c:29:7: error: impossible combination of type specifiers: short double
+specifiers2.c:30:7: error: impossible combination of type specifiers: short float
+specifiers2.c:31:7: error: impossible combination of type specifiers: short short
+specifiers2.c:32:7: error: impossible combination of type specifiers: short long
+specifiers2.c:33:6: error: impossible combination of type specifiers: long char
+specifiers2.c:34:6: error: impossible combination of type specifiers: long float
+specifiers2.c:35:6: error: impossible combination of type specifiers: long short
+specifiers2.c:36:8: error: impossible combination of type specifiers: signed double
+specifiers2.c:37:8: error: impossible combination of type specifiers: signed float
+specifiers2.c:38:8: error: impossible combination of type specifiers: signed signed
+specifiers2.c:39:8: error: impossible combination of type specifiers: signed unsigned
+specifiers2.c:40:10: error: impossible combination of type specifiers: unsigned double
+specifiers2.c:41:10: error: impossible combination of type specifiers: unsigned float
+specifiers2.c:42:10: error: impossible combination of type specifiers: unsigned signed
+specifiers2.c:43:10: error: impossible combination of type specifiers: unsigned unsigned
+specifiers2.c:44:10: error: impossible combination of type specifiers: unsigned signed
+specifiers2.c:45:11: error: impossible combination of type specifiers: long long long
+specifiers2.c:46:13: error: impossible combination of type specifiers: long long double
+specifiers2.c:47:11: error: impossible combination of type specifiers: long long double
+specifiers2.c:48:13: error: impossible combination of type specifiers: long long double
+specifiers2.c:49:3: error: two or more data types in declaration specifiers
+specifiers2.c:50:3: error: two or more data types in declaration specifiers
+specifiers2.c:51:3: error: two or more data types in declaration specifiers
+specifiers2.c:52:3: error: two or more data types in declaration specifiers
+specifiers2.c:53:3: error: two or more data types in declaration specifiers
+specifiers2.c:54:3: error: two or more data types in declaration specifiers
+specifiers2.c:55:3: error: two or more data types in declaration specifiers
+specifiers2.c:56:3: error: two or more data types in declaration specifiers
+specifiers2.c:57:3: error: two or more data types in declaration specifiers
+specifiers2.c:58:6: error: two or more data types in declaration specifiers
+specifiers2.c:59:6: error: two or more data types in declaration specifiers
+specifiers2.c:60:6: error: two or more data types in declaration specifiers
+specifiers2.c:61:6: error: two or more data types in declaration specifiers
+specifiers2.c:62:6: error: two or more data types in declaration specifiers
+specifiers2.c:63:6: error: two or more data types in declaration specifiers
+specifiers2.c:64:6: error: two or more data types in declaration specifiers
+specifiers2.c:65:6: error: two or more data types in declaration specifiers
+specifiers2.c:66:6: error: two or more data types in declaration specifiers
+specifiers2.c:67:5: error: two or more data types in declaration specifiers
+specifiers2.c:68:8: error: two or more data types in declaration specifiers
+specifiers2.c:69:7: error: two or more data types in declaration specifiers
+specifiers2.c:70:7: error: impossible combination of type specifiers: short void
+specifiers2.c:71:6: error: impossible combination of type specifiers: long void
+specifiers2.c:72:8: error: impossible combination of type specifiers: signed void
+specifiers2.c:73:10: error: impossible combination of type specifiers: unsigned void
+specifiers2.c:74:6: error: two or more data types in declaration specifiers
+ * check-error-end
+ */
-- 
1.5.6.5


