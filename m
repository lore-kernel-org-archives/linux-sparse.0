From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 7/7] handle fouled-bitwise
Date: Sun, 01 Oct 2006 14:58:11 +0100
Message-ID: <E1GU1pb-00070U-Tt@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:34732 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932224AbWJAN6J
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 1 Oct 2006 09:58:09 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1GU1pb-00070U-Tt
	for linux-sparse@vger.kernel.org; Sun, 01 Oct 2006 14:58:11 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


This stuff comes from handling smaller-than-int bitwise types (e.g. __le16).
The problem is in handling things like
	__be16 x, y;
	...
	if (x == (x & ~y))
The code is bitwise-clean, but current sparse can't deduce that.  Operations
allowed on bitwise types have the following property: (type)(x <op> y) can
be substituted for x <op> y in any expression other than sizeof.  That allows
us to ignore usual arithmetical conversions for those types and treat e.g.
| as __be16 x __be16 -> __be16, despite the promotion rules; resulting
semantics will be the same.  However, ~ on smaller-than-int does not have
such property; indeed, ~y is guaranteed to _not_ fit into range of __be16
in the example above.

That causes a lot of unpleasant problems when dealing with e.g. networking
code - IP checksums are 16bit and ~ is often used in their (re)calculations.
The way to deal with that is based on the observation that even though we do
get junk in upper bits, it normally ends up being discarded and sparse can
be taught to prove that.  To do that we need "fouled" conterparts for short
bitwise types.  They will be assigned to (sub)expressions that might carry
junk in upper bits, but trimming those bits would result in the value we'd
get if all operations had been done within the bitwise type.  E.g. in the
example above y would be __be16, ~y - fouled __be16, x & ~y - __be16 again
and x == (x & ~y) - boolean.

Basically, we delay reporting an error on ~<short bitwise> for as long as
possible in hope that taint will be cleansed later.  Exact rules follow:

        * ~short_bitwise => corresponding fouled
        * any arithmetics that would be banned for bitwise => same warning
as if we would have bitwise
        * if t1 is bitwise type and t2 - its fouled analog, then
t1 & t2 => t1, t1 | t2 => t2, t1 ^ t2 => t2.
        * conversion of t2 to t1 is silent (be it passing as argument
or assignment).  Other conversions are banned.
        * x ? t1 : t2 => t2
        * ~t2 => t2 (_not_ t1; something like ~(x ? y : ~y) is still fouled)
        * x ? t2 : t2 => t2, t2 {&,|,^} t2 => t2 (yes, even ^ - same as before).
        * x ? t2 : constant_valid_for_t1 => t2
        * !t2 => warning, ditto for comparisons involving t2 in any way.
        * wrt casts t2 acts exactly as t1 would.
        * for sizeof, typeof and alignof t2 acts as promoted t1.  Note that
fouled can never be an lvalue or have types derived from it - can't happen.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 evaluate.c                |   77 ++++++++++++++++++++++++++++++++++++---------
 parse.c                   |    1 +
 show-parse.c              |    8 +++++
 symbol.c                  |   38 ++++++++++++++++++++++
 symbol.h                  |    5 +++
 validation/foul-bitwise.c |   20 ++++++++++++
 6 files changed, 134 insertions(+), 15 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 71c46d1..0ebbfc7 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -344,6 +344,7 @@ enum {
 	TYPE_FLOAT = 8,
 	TYPE_PTR = 16,
 	TYPE_COMPOUND = 32,
+	TYPE_FOULED = 64,
 };
 
 static inline int classify_type(struct symbol *type, struct symbol **base)
@@ -356,6 +357,7 @@ static inline int classify_type(struct s
 		[SYM_UNION] = TYPE_COMPOUND,
 		[SYM_BITFIELD] = TYPE_NUM | TYPE_BITFIELD,
 		[SYM_RESTRICT] = TYPE_NUM | TYPE_RESTRICT,
+		[SYM_FOULED] = TYPE_NUM | TYPE_RESTRICT | TYPE_FOULED,
 	};
 	if (type->type == SYM_NODE)
 		type = type->ctype.base_type;
@@ -411,26 +413,30 @@ static int restricted_binop(int op, stru
 {
 	switch (op) {
 		case '&':
+		case '=':
+		case SPECIAL_AND_ASSIGN:
+		case SPECIAL_OR_ASSIGN:
+		case SPECIAL_XOR_ASSIGN:
+			return 1;	/* unfoul */
 		case '|':
 		case '^':
 		case '?':
-		case '=':
+			return 2;	/* keep fouled */
 		case SPECIAL_EQUAL:
 		case SPECIAL_NOTEQUAL:
-		case SPECIAL_AND_ASSIGN:
-		case SPECIAL_OR_ASSIGN:
-		case SPECIAL_XOR_ASSIGN:
-			return 0;
+			return 3;	/* warn if fouled */
 		default:
-			return 1;
+			return 0;	/* warn */
 	}
 }
 
-static int restricted_unop(int op, struct symbol *type)
+static int restricted_unop(int op, struct symbol **type)
 {
-	if (op == '~' && type->bit_size >= bits_in_int)
+	if (op == '~') {
+		if ((*type)->bit_size < bits_in_int)
+			*type = befoul(*type);
 		return 0;
-	if (op == '+')
+	} if (op == '+')
 		return 0;
 	return 1;
 }
@@ -445,8 +451,15 @@ static struct symbol *restricted_binop_t
 	struct symbol *ctype = NULL;
 	if (lclass & TYPE_RESTRICT) {
 		if (rclass & TYPE_RESTRICT) {
-			if (ltype == rtype)
+			if (ltype == rtype) {
 				ctype = ltype;
+			} else if (lclass & TYPE_FOULED) {
+				if (ltype->ctype.base_type == rtype)
+					ctype = ltype;
+			} else if (rclass & TYPE_FOULED) {
+				if (rtype->ctype.base_type == ltype)
+					ctype = rtype;
+			}
 		} else {
 			if (!restricted_value(right, ltype))
 				ctype = ltype;
@@ -454,8 +467,22 @@ static struct symbol *restricted_binop_t
 	} else if (!restricted_value(left, rtype))
 		ctype = rtype;
 
-	if (ctype && restricted_binop(op, ctype))
-		ctype = NULL;
+	if (ctype) {
+		switch (restricted_binop(op, ctype)) {
+		case 1:
+			if ((lclass ^ rclass) & TYPE_FOULED)
+				ctype = ctype->ctype.base_type;
+			break;
+		case 3:
+			if (!(lclass & rclass & TYPE_FOULED))
+				break;
+		case 0:
+			ctype = NULL;
+		default:
+			break;
+		}
+	}
+
 	return ctype;
 }
 
@@ -503,10 +530,14 @@ Restr:
 	if (lclass & TYPE_RESTRICT) {
 		warning((*left)->pos, "restricted degrades to integer");
 		ltype = ltype->ctype.base_type;
+		if (is_restricted_type(ltype)) /* was fouled */
+			ltype = ltype->ctype.base_type;
 	}
 	if (rclass & TYPE_RESTRICT) {
 		warning((*right)->pos, "restricted degrades to integer");
 		rtype = rtype->ctype.base_type;
+		if (is_restricted_type(rtype)) /* was fouled */
+			rtype = rtype->ctype.base_type;
 	}
 	goto Normal;
 }
@@ -1104,10 +1135,13 @@ static int compatible_assignment_types(s
 			return 0;
 		}
 		if (tclass & TYPE_RESTRICT) {
-			if (restricted_binop(op, target)) {
+			if (!restricted_binop(op, target)) {
 				sparse_error(expr->pos, "bad restricted assignment");
 				return 0;
 			}
+			/* allowed assignments unfoul */
+			if (sclass & TYPE_FOULED && s->ctype.base_type == t)
+				goto Cast;
 			if (!restricted_value(*rp, target))
 				return 1;
 		} else if (!(sclass & TYPE_RESTRICT))
@@ -1482,7 +1516,10 @@ static struct symbol *evaluate_postop(st
 		sparse_error(expr->pos, "need lvalue expression for ++/--");
 		return NULL;
 	}
-	if (is_restricted_type(ctype) && restricted_unop(expr->op, ctype)) {
+	if (is_restricted_type(ctype) && restricted_unop(expr->op, &ctype)) {
+		sparse_error(expr->pos, "bad operation on restricted");
+		return NULL;
+	} else if (is_fouled_type(ctype) && restricted_unop(expr->op, &ctype)) {
 		sparse_error(expr->pos, "bad operation on restricted");
 		return NULL;
 	}
@@ -1506,7 +1543,9 @@ static struct symbol *evaluate_sign(stru
 		ctype = rtype;
 	} else if (is_float_type(ctype) && expr->op != '~') {
 		/* no conversions needed */
-	} else if (is_restricted_type(ctype) && !restricted_unop(expr->op, ctype)) {
+	} else if (is_restricted_type(ctype) && !restricted_unop(expr->op, &ctype)) {
+		/* no conversions needed */
+	} else if (is_fouled_type(ctype) && !restricted_unop(expr->op, &ctype)) {
 		/* no conversions needed */
 	} else {
 		return bad_expr_type(expr);
@@ -1556,6 +1595,8 @@ static struct symbol *evaluate_preop(str
 			expr->right = alloc_expression(expr->pos, EXPR_FVALUE);
 			expr->right->ctype = ctype;
 			expr->right->fvalue = 0;
+		} else if (is_fouled_type(ctype)) {
+			warning(expr->pos, "restricted degrades to integer");
 		}
 		ctype = &bool_ctype;
 		break;
@@ -1755,6 +1796,8 @@ static struct symbol *evaluate_type_info
 		if (is_restricted_type(sym)) {
 			if (sym->bit_size < bits_in_int && is_promoted(expr))
 				sym = &int_ctype;
+		} else if (is_fouled_type(sym)) {
+			sym = &int_ctype;
 		}
 	}
 	examine_symbol_type(sym);
@@ -2210,6 +2253,10 @@ static struct symbol *evaluate_cast(stru
 	if (class2 & TYPE_COMPOUND)
 		warning(expr->pos, "cast from non-scalar");
 
+	/* allowed cast unfouls */
+	if (class2 & TYPE_FOULED)
+		t2 = t2->ctype.base_type;
+
 	if (!(ctype->ctype.modifiers & MOD_FORCE) && t1 != t2) {
 		if (class1 & TYPE_RESTRICT)
 			warning(expr->pos, "cast to restricted type");
diff --git a/parse.c b/parse.c
index bdd6e29..5c78ac0 100644
--- a/parse.c
+++ b/parse.c
@@ -809,6 +809,7 @@ static struct token *declaration_specifi
 		type->type = SYM_RESTRICT;
 		type->ctype.modifiers &= ~MOD_SPECIFIER;
 		ctype->base_type = type;
+		create_fouled(type);
 	}
 	return token;
 }
diff --git a/show-parse.c b/show-parse.c
index 5437a62..2701d17 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -48,6 +48,7 @@ static void do_debug_symbol(struct symbo
 		[SYM_BITFIELD] = "bitf",
 		[SYM_LABEL] = "labl",
 		[SYM_RESTRICT] = "rstr",
+		[SYM_FOULED] = "foul",
 		[SYM_BAD] = "bad.",
 	};
 	struct context *context;
@@ -257,6 +258,9 @@ static void do_show_type(struct symbol *
 	case SYM_RESTRICT:
 		break;
 
+	case SYM_FOULED:
+		break;
+
 	default:
 		prepend(name, "unknown type %d", sym->type);
 		return;
@@ -289,6 +293,10 @@ static void do_show_type(struct symbol *
 		prepend(name, "restricted ");
 		return;
 
+	case SYM_FOULED:
+		prepend(name, "fouled ");
+		return;
+
 	default:
 		break;
 	}
diff --git a/symbol.c b/symbol.c
index 7d64f7f..6c91112 100644
--- a/symbol.c
+++ b/symbol.c
@@ -423,6 +423,9 @@ struct symbol *examine_symbol_type(struc
 	case SYM_RESTRICT:
 		examine_base_type(sym);
 		return sym;
+	case SYM_FOULED:
+		examine_base_type(sym);
+		return sym;
 	default:
 		sparse_error(sym->pos, "Examining unknown symbol type %d", sym->type);
 		break;
@@ -430,6 +433,41 @@ struct symbol *examine_symbol_type(struc
 	return sym;
 }
 
+static struct symbol_list *restr, *fouled;
+
+void create_fouled(struct symbol *type)
+{
+	if (type->bit_size < bits_in_int) {
+		struct symbol *new = alloc_symbol(type->pos, type->type);
+		*new = *type;
+		new->bit_size = bits_in_int;
+		new->type = SYM_FOULED;
+		new->ctype.base_type = type;
+		add_symbol(&restr, type);
+		add_symbol(&fouled, new);
+	}
+}
+
+struct symbol *befoul(struct symbol *type)
+{
+	struct symbol *t1, *t2;
+	while (type->type == SYM_NODE)
+		type = type->ctype.base_type;
+	PREPARE_PTR_LIST(restr, t1);
+	PREPARE_PTR_LIST(fouled, t2);
+	for (;;) {
+		if (t1 == type)
+			return t2;
+		if (!t1)
+			break;
+		NEXT_PTR_LIST(t1);
+		NEXT_PTR_LIST(t2);
+	}
+	FINISH_PTR_LIST(t2);
+	FINISH_PTR_LIST(t1);
+	return NULL;
+}
+
 void check_declaration(struct symbol *sym)
 {
 	int warned = 0;
diff --git a/symbol.h b/symbol.h
index f1ed4c1..367c0f5 100644
--- a/symbol.h
+++ b/symbol.h
@@ -52,6 +52,7 @@ enum type {
 	SYM_BITFIELD,
 	SYM_LABEL,
 	SYM_RESTRICT,
+	SYM_FOULED,
 	SYM_BAD,
 };
 
@@ -270,7 +271,11 @@ static inline int get_sym_type(struct sy
 }
 
 #define is_restricted_type(type) (get_sym_type(type) == SYM_RESTRICT)
+#define is_fouled_type(type) (get_sym_type(type) == SYM_FOULED)
 #define is_bitfield_type(type)   (get_sym_type(type) == SYM_BITFIELD)
 extern int is_ptr_type(struct symbol *);
 
+void create_fouled(struct symbol *type);
+struct symbol *befoul(struct symbol *type);
+
 #endif /* SEMANTIC_H */
diff --git a/validation/foul-bitwise.c b/validation/foul-bitwise.c
new file mode 100644
index 0000000..576790d
--- /dev/null
+++ b/validation/foul-bitwise.c
@@ -0,0 +1,20 @@
+typedef unsigned short __attribute__((bitwise))__le16;
+__le16 foo(__le16 a)
+{
+	return a |= ~a;
+}
+
+int baz(__le16 a)
+{
+	return ~a == ~a;
+}
+
+int barf(__le16 a)
+{
+	return a == (a & ~a);
+}
+
+__le16 bar(__le16 a)
+{
+	return -a;
+}
-- 
1.4.2.GIT
