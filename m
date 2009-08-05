From: Blue Swirl <blauwirbel@gmail.com>
Subject: [PATCH 1/2] Add support for TImode type (__int128_t)
Date: Wed, 5 Aug 2009 21:51:45 +0300
Message-ID: <f43fc5580908051151i4876db5dn95ccafa8da3f7f84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:8631 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666AbZHESwG (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 5 Aug 2009 14:52:06 -0400
Received: by fg-out-1718.google.com with SMTP id e21so86267fga.17
        for <linux-sparse@vger.kernel.org>; Wed, 05 Aug 2009 11:52:06 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

GCC provides a 128 bit type called internally as TImode (__int128_t)on 64 bit
platforms (at least x86_64 and Sparc64). These types are used by OpenBIOS.

Add support for types "long long long", __mode__(TI) and __(u)int128_t.

Signed-off-by: Blue Swirl <blauwirbel@gmail.com>
---
 cgcc         |    7 ++++---
 evaluate.c   |    8 +++++---
 expand.c     |    3 ++-
 gdbhelpers   |    3 +++
 parse.c      |   25 ++++++++++++++++++++++---
 show-parse.c |    3 +++
 symbol.c     |    6 ++++++
 symbol.h     |    8 +++++---
 target.c     |    1 +
 target.h     |    1 +
 10 files changed, 52 insertions(+), 13 deletions(-)

diff --git a/cgcc b/cgcc
index fdda6d1..59de967 100755
--- a/cgcc
+++ b/cgcc
@@ -128,8 +128,9 @@ sub integer_types {
 	 16 => '32767',
 	 32 => '2147483647',
 	 64 => '9223372036854775807',
+	 128 => '170141183460469231731687303715884105728',
 	 );
-    my @types = (['SCHAR',''], ['SHRT',''], ['INT',''], ['LONG','L'],
['LONG_LONG','LL']);
+    my @types = (['SCHAR',''], ['SHRT',''], ['INT',''], ['LONG','L'],
['LONG_LONG','LL'], ['LONG_LONG_LONG','LLL']);

     my $result = " -D__CHAR_BIT__=$char";
     while (@types) {
@@ -260,12 +261,12 @@ sub add_specs {
 		&define_size_t ($m64 ? "long unsigned int" : "unsigned int"));
     } elsif ($spec eq 'sparc64') {
 	return (' -Dsparc=1 -D__sparc=1 -D__sparc__=1 -D__sparcv9__=1
-D__sparc64__=1 -D__arch64__=1 -D__LP64__=1' .
-		&integer_types (8, 16, 32, 64, 64) .
+		&integer_types (8, 16, 32, 64, 64, 128) .
 		&float_types (1, 1, 33, [24,8], [53,11], [113,15]) .
 		&define_size_t ("long unsigned int"));
     } elsif ($spec eq 'x86_64') {
 	return (' -Dx86_64=1 -D__x86_64=1 -D__x86_64__=1' .
-		&integer_types (8, 16, 32, $m32 ? 32 : 64, 64) .
+		&integer_types (8, 16, 32, $m32 ? 32 : 64, 64, 128) .
 		&float_types (1, 1, 33, [24,8], [53,11], [113,15]) .
 		&define_size_t ($m32 ? "unsigned int" : "long unsigned int"));
     } elsif ($spec eq 'ppc') {
diff --git a/evaluate.c b/evaluate.c
index 1ab5ae8..fedb5c5 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -165,7 +165,8 @@ static struct symbol *bigger_int_type(struct
symbol *left, struct symbol *right)
 	if ((lmod ^ rmod) & MOD_UNSIGNED) {
 		if (lmod & MOD_UNSIGNED)
 			goto left;
-	} else if ((lmod & ~rmod) & (MOD_LONG | MOD_LONGLONG))
+	} else if ((lmod & ~rmod) & (MOD_LONG | MOD_LONGLONG | \
+				     MOD_LONGLONGLONG))
 		goto left;
 right:
 	left = right;
@@ -512,7 +513,7 @@ Normal:
 	} else if (rclass & TYPE_FLOAT) {
 		unsigned long lmod = ltype->ctype.modifiers;
 		unsigned long rmod = rtype->ctype.modifiers;
-		if (rmod & ~lmod & (MOD_LONG | MOD_LONGLONG))
+		if (rmod & ~lmod & (MOD_LONG | MOD_LONGLONG | MOD_LONGLONGLONG))
 			return rtype;
 		else
 			return ltype;
@@ -2114,7 +2115,8 @@ static int evaluate_arguments(struct symbol *f,
struct symbol *fn, struct expres
 				*p = cast_to(expr, integer_promotion(type));
 			} else if (class & TYPE_FLOAT) {
 				unsigned long mod = type->ctype.modifiers;
-				if (!(mod & (MOD_LONG|MOD_LONGLONG)))
+				if (!(mod & (MOD_LONG | MOD_LONGLONG | \
+					     MOD_LONGLONGLONG)))
 					*p = cast_to(expr, &double_ctype);
 			} else if (class & TYPE_PTR) {
 				if (expr->ctype == &null_ctype)
diff --git a/expand.c b/expand.c
index 82fd62a..b965dc3 100644
--- a/expand.c
+++ b/expand.c
@@ -128,7 +128,8 @@ Float:
 	else
 		expr->fvalue = old->fvalue;

-	if (!(newtype->ctype.modifiers & MOD_LONGLONG)) {
+	if (!(newtype->ctype.modifiers & MOD_LONGLONG) && \
+	    !(newtype->ctype.modifiers & MOD_LONGLONGLONG)) {
 		if ((newtype->ctype.modifiers & MOD_LONG))
 			expr->fvalue = (double)expr->fvalue;
 		else
diff --git a/gdbhelpers b/gdbhelpers
index db78d6c..8634786 100644
--- a/gdbhelpers
+++ b/gdbhelpers
@@ -125,6 +125,9 @@ define gdb_show_ctype
 	if ($arg0->modifiers & MOD_LONGLONG)
 		printf "MOD_LONGLONG "
 	end
+	if ($arg0->modifiers & MOD_LONGLONGLONG)
+		printf "MOD_LONGLONGLONG "
+	end
 	if ($arg0->modifiers & MOD_TYPEDEF)
 		printf "MOD_TYPEDEF "
 	end
diff --git a/parse.c b/parse.c
index 613f439..5e75242 100644
--- a/parse.c
+++ b/parse.c
@@ -70,7 +70,7 @@ static attr_t
 typedef struct symbol *to_mode_t(struct symbol *);

 static to_mode_t
-	to_QI_mode, to_HI_mode, to_SI_mode, to_DI_mode, to_word_mode;
+	to_QI_mode, to_HI_mode, to_SI_mode, to_DI_mode, to_TI_mode, to_word_mode;

 enum {
 	Set_T = 1,
@@ -347,6 +347,11 @@ static struct symbol_op mode_DI_op = {
 	.to_mode = to_DI_mode
 };

+static struct symbol_op mode_TI_op = {
+	.type = KW_MODE,
+	.to_mode = to_TI_mode
+};
+
 static struct symbol_op mode_word_op = {
 	.type = KW_MODE,
 	.to_mode = to_word_mode
@@ -386,6 +391,8 @@ static struct init_keyword {

 	/* Predeclared types */
 	{ "__builtin_va_list", NS_TYPEDEF, .type = &ptr_ctype, .op = &spec_op },
+	{ "__int128_t",	NS_TYPEDEF, .type = &lllong_ctype, .op = &spec_op },
+	{ "__uint128_t",NS_TYPEDEF, .type = &ulllong_ctype, .op = &spec_op },

 	/* Extended types */
 	{ "typeof", 	NS_TYPEDEF, .op = &typeof_op },
@@ -457,6 +464,8 @@ static struct init_keyword {
 	{ "__SI__",	NS_KEYWORD,			.op = &mode_SI_op },
 	{ "DI",		NS_KEYWORD,	MOD_LONGLONG,	.op = &mode_DI_op },
 	{ "__DI__",	NS_KEYWORD,	MOD_LONGLONG,	.op = &mode_DI_op },
+	{ "TI",		NS_KEYWORD,	MOD_LONGLONGLONG,	.op = &mode_TI_op },
+	{ "__TI__",	NS_KEYWORD,	MOD_LONGLONGLONG,	.op = &mode_TI_op },
 	{ "word",	NS_KEYWORD,	MOD_LONG,	.op = &mode_word_op },
 	{ "__word__",	NS_KEYWORD,	MOD_LONG,	.op = &mode_word_op },

@@ -1042,6 +1051,14 @@ static struct symbol *to_DI_mode(struct symbol *ctype)
 						     : &sllong_ctype;
 }

+static struct symbol *to_TI_mode(struct symbol *ctype)
+{
+	if (ctype->ctype.base_type != &int_type)
+		return NULL;
+	return ctype->ctype.modifiers & MOD_UNSIGNED ? &ulllong_ctype
+						     : &slllong_ctype;
+}
+
 static struct symbol *to_word_mode(struct symbol *ctype)
 {
 	if (ctype->ctype.base_type != &int_type)
@@ -1322,9 +1339,11 @@ Catch_all:
 static struct symbol * const int_types[] =
 	{&short_ctype, &int_ctype, &long_ctype, &llong_ctype};
 static struct symbol * const signed_types[] =
-	{&sshort_ctype, &sint_ctype, &slong_ctype, &sllong_ctype};
+	{&sshort_ctype, &sint_ctype, &slong_ctype, &sllong_ctype,
+	 &slllong_ctype};
 static struct symbol * const unsigned_types[] =
-	{&ushort_ctype, &uint_ctype, &ulong_ctype, &ullong_ctype};
+	{&ushort_ctype, &uint_ctype, &ulong_ctype, &ullong_ctype,
+	 &ulllong_ctype};
 static struct symbol * const real_types[] =
 	{&float_ctype, &double_ctype, &ldouble_ctype};
 static struct symbol * const char_types[] =
diff --git a/show-parse.c b/show-parse.c
index 99795e8..f249f4b 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -191,6 +191,9 @@ static struct ctype_name {
 	{ & llong_ctype, "long long" },
 	{ &sllong_ctype, "signed long long" },
 	{ &ullong_ctype, "unsigned long long" },
+	{ & lllong_ctype, "long long long" },
+	{ &slllong_ctype, "signed long long long" },
+	{ &ulllong_ctype, "unsigned long long long" },

 	{ &void_ctype,   "void" },
 	{ &bool_ctype,   "bool" },
diff --git a/symbol.c b/symbol.c
index cda6bd0..96dfbfa 100644
--- a/symbol.c
+++ b/symbol.c
@@ -751,6 +751,7 @@ struct symbol	bool_ctype, void_ctype, type_ctype,
 		int_ctype, sint_ctype, uint_ctype,
 		long_ctype, slong_ctype, ulong_ctype,
 		llong_ctype, sllong_ctype, ullong_ctype,
+		lllong_ctype, slllong_ctype, ulllong_ctype,
 		float_ctype, double_ctype, ldouble_ctype,
 		string_ctype, ptr_ctype, lazy_ptr_ctype,
 		incomplete_ctype, label_ctype, bad_ctype,
@@ -787,6 +788,7 @@ void init_symbols(void)

 #define MOD_ESIGNED (MOD_SIGNED | MOD_EXPLICITLY_SIGNED)
 #define MOD_LL (MOD_LONG | MOD_LONGLONG)
+#define MOD_LLL MOD_LONGLONGLONG
 static const struct ctype_declare {
 	struct symbol *ptr;
 	enum type type;
@@ -816,6 +818,9 @@ static const struct ctype_declare {
 	{ &llong_ctype,	    SYM_BASETYPE, MOD_SIGNED | MOD_LL,	
&bits_in_longlong,       &max_int_alignment, &int_type },
 	{ &sllong_ctype,    SYM_BASETYPE, MOD_ESIGNED | MOD_LL,	
&bits_in_longlong,       &max_int_alignment, &int_type },
 	{ &ullong_ctype,    SYM_BASETYPE, MOD_UNSIGNED | MOD_LL,
&bits_in_longlong,       &max_int_alignment, &int_type },
+	{ &lllong_ctype,    SYM_BASETYPE, MOD_SIGNED | MOD_LLL,	
&bits_in_longlonglong,   &max_int_alignment, &int_type },
+	{ &slllong_ctype,   SYM_BASETYPE, MOD_ESIGNED | MOD_LLL,
&bits_in_longlonglong,   &max_int_alignment, &int_type },
+	{ &ulllong_ctype,   SYM_BASETYPE, MOD_UNSIGNED | MOD_LLL,
&bits_in_longlonglong,   &max_int_alignment, &int_type },

 	{ &float_ctype,	    SYM_BASETYPE,  0,			    &bits_in_float,
&max_fp_alignment,  &fp_type },
 	{ &double_ctype,    SYM_BASETYPE, MOD_LONG,		    &bits_in_double,
     &max_fp_alignment,  &fp_type },
@@ -828,6 +833,7 @@ static const struct ctype_declare {
 	{ &lazy_ptr_ctype,  SYM_PTR,	  0,			    &bits_in_pointer,
&pointer_alignment, &void_ctype },
 	{ NULL, }
 };
+#undef MOD_LLL
 #undef MOD_LL
 #undef MOD_ESIGNED

diff --git a/symbol.h b/symbol.h
index 42d69d6..1b6be1d 100644
--- a/symbol.h
+++ b/symbol.h
@@ -196,8 +196,9 @@ struct symbol {
 #define MOD_SHORT	0x0200
 #define MOD_LONG	0x0400
 #define MOD_LONGLONG	0x0800
+#define MOD_LONGLONGLONG	0x1000

-#define MOD_TYPEDEF	0x1000
+#define MOD_TYPEDEF	0x10000

 #define MOD_TLS		0x20000
 #define MOD_INLINE	0x40000
@@ -219,8 +220,8 @@ struct symbol {
 #define MOD_NONLOCAL	(MOD_EXTERN | MOD_TOPLEVEL)
 #define MOD_STORAGE	(MOD_AUTO | MOD_REGISTER | MOD_STATIC |
MOD_EXTERN | MOD_INLINE | MOD_TOPLEVEL)
 #define MOD_SIGNEDNESS	(MOD_SIGNED | MOD_UNSIGNED | MOD_EXPLICITLY_SIGNED)
-#define MOD_SPECIFIER	(MOD_CHAR | MOD_SHORT | MOD_LONG | MOD_LONGLONG
| MOD_SIGNEDNESS)
-#define MOD_SIZE	(MOD_CHAR | MOD_SHORT | MOD_LONG | MOD_LONGLONG)
+#define MOD_SPECIFIER	(MOD_CHAR | MOD_SHORT | MOD_LONG | MOD_LONGLONG
| MOD_LONGLONGLONG | MOD_SIGNEDNESS)
+#define MOD_SIZE	(MOD_CHAR | MOD_SHORT | MOD_LONG | MOD_LONGLONG |
MOD_LONGLONGLONG)
 #define MOD_IGNORE (MOD_TOPLEVEL | MOD_STORAGE | MOD_ADDRESSABLE |	\
 	MOD_ASSIGNED | MOD_USERTYPE | MOD_ACCESSED | MOD_EXPLICITLY_SIGNED)
 #define MOD_PTRINHERIT (MOD_VOLATILE | MOD_CONST | MOD_NODEREF | MOD_STORAGE)
@@ -240,6 +241,7 @@ extern struct symbol	bool_ctype, void_ctype, type_ctype,
 			int_ctype, sint_ctype, uint_ctype,
 			long_ctype, slong_ctype, ulong_ctype,
 			llong_ctype, sllong_ctype, ullong_ctype,
+			lllong_ctype, slllong_ctype, ulllong_ctype,
 			float_ctype, double_ctype, ldouble_ctype,
 			string_ctype, ptr_ctype, lazy_ptr_ctype,
 			incomplete_ctype, label_ctype, bad_ctype,
diff --git a/target.c b/target.c
index bf1bb8f..17b228a 100644
--- a/target.c
+++ b/target.c
@@ -20,6 +20,7 @@ int bits_in_short = 16;
 int bits_in_int = 32;
 int bits_in_long = 32;
 int bits_in_longlong = 64;
+int bits_in_longlonglong = 128;

 int max_int_alignment = 4;

diff --git a/target.h b/target.h
index 7f0fd27..1030c7c 100644
--- a/target.h
+++ b/target.h
@@ -18,6 +18,7 @@ extern int bits_in_short;
 extern int bits_in_int;
 extern int bits_in_long;
 extern int bits_in_longlong;
+extern int bits_in_longlonglong;

 extern int max_int_alignment;

-- 
1.6.2.4
