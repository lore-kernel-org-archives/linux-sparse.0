From: Tomas Klacko <tomas.klacko@gmail.com>
Subject: Re: including sparse headers in C++ code
Date: Tue, 12 Oct 2010 00:33:32 +0200
Message-ID: <AANLkTi=8EkK+_9pOA8fbDgYGfz-bPGj6XhLUnfSkdGeV@mail.gmail.com>
References: <AANLkTinGSRQYqR2h+V0nAB+vn4xWCGxgbmGHuMm-xHyB@mail.gmail.com>
	<20101009205930.GA4684@feather>
	<AANLkTinaDZZmyeaK+rAvLCdZ-90n17WhABRsZGUBBcSH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41281 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756672Ab0JKWdd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 11 Oct 2010 18:33:33 -0400
Received: by iwn36 with SMTP id 36so26713iwn.19
        for <linux-sparse@vger.kernel.org>; Mon, 11 Oct 2010 15:33:32 -0700 (PDT)
In-Reply-To: <AANLkTinaDZZmyeaK+rAvLCdZ-90n17WhABRsZGUBBcSH@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org

Hi,

On Sat, Oct 9, 2010 at 11:46 PM, Christopher Li <sparse@chrisli.org> wr=
ote:
> On Sat, Oct 9, 2010 at 1:59 PM, Josh Triplett <josh@joshtriplett.org>=
 wrote:
>> It seems reasonable to avoid the use of C++ keywords in Sparse *head=
ers*
>> (though unnecessary in *source*). =A0Looks like this will primarily =
cause
>> pain due to "enum namespace" and the various places using it. =A0See=
ms
>> easy enough to change those all to "ns". =A0"new" mostly seems to ge=
t used
>> as a parameter name or local variable name; for the former we could =
omit
>> it, and for the latter we could trivially call it something more
>> specific like "newlist" or "newptr".
>>
>> So, I'd tend to guess "patches welcome" (again, for headers only, pl=
us
>> minimal corresponding source changes when required). =A0I wouldn't
>> anticipate other Sparse developers objecting strongly, but if they d=
o
>> your mail seems like the right way to find out. =A0The various reaso=
ns
>> given for *not* making the Linux kernel headers compatible don't see=
m to
>> apply here, though.
>
> Well said. I don't expect sparse to compile in the C++ mode. Making
> sparse header usable in C++ seems reasonable to me.

Great. I am posting my current status (as a patch) so that you can comm=
ent on it
and that I can refine it further.


This is the patch:
=46rom 2a7094f02181b06afbe593daab6992d7539b618a Mon Sep 17 00:00:00 200=
1
=46rom: Tomas Klacko <tomas.klacko@gmail.com>
Date: Mon, 11 Oct 2010 09:50:14 +0200
Subject: [PATCH] Make headers usable in C++ code.

---
 c2xml.c        |    6 ++--
 compile-i386.c |   10 ++++----
 ctags.c        |    6 ++--
 evaluate.c     |   68 ++++++++++++++++++++++++++++--------------------=
--------
 expression.c   |   12 +++++-----
 expression.h   |    7 +++--
 graph.c        |    2 +-
 lib.h          |   38 ++++++++++++++++++++++---------
 linearize.h    |    4 +-
 parse.c        |   50 ++++++++++++++++++++--------------------
 parse.h        |    5 +++-
 pre-process.c  |   10 ++++----
 ptrlist.h      |   16 ++++++++++--
 show-parse.c   |    8 +++---
 symbol.c       |   14 +++++-----
 symbol.h       |   14 +++++-----
 token.h        |    5 ++-
 tokenize.c     |   12 +++++-----
 18 files changed, 159 insertions(+), 128 deletions(-)

diff --git a/c2xml.c b/c2xml.c
index 37f29cf..e5b64a0 100644
--- a/c2xml.c
+++ b/c2xml.c
@@ -128,7 +128,7 @@ static void examine_modifiers(struct symbol *sym,
xmlNodePtr node)

 	int i;

-	if (sym->namespace !=3D NS_SYMBOL)
+	if (sym->Namespace !=3D NS_SYMBOL)
 		return;

 	/*iterate over the 32 bit bitfield*/
@@ -236,7 +236,7 @@ static void examine_namespace(struct symbol *sym)
 	if (sym->ident && sym->ident->reserved)
 		return;

-	switch(sym->namespace) {
+	switch(sym->Namespace) {
 	case NS_MACRO:
 		examine_macro(sym, root_node);
 		break;
@@ -253,7 +253,7 @@ static void examine_namespace(struct symbol *sym)
 	case NS_KEYWORD:
 		break;
 	default:
-		die("Unrecognised namespace type %d",sym->namespace);
+		die("Unrecognised namespace type %d",sym->Namespace);
 	}

 }
diff --git a/compile-i386.c b/compile-i386.c
index abe9313..0a08e86 100644
--- a/compile-i386.c
+++ b/compile-i386.c
@@ -332,9 +332,9 @@ busy:
 	return 1;
 }

-static struct storage *get_reg(struct regclass *class)
+static struct storage *get_reg(struct regclass *Class)
 {
-	const unsigned char *regs =3D class->regs;
+	const unsigned char *regs =3D Class->regs;
 	int regno;

 	while ((regno =3D *regs) !=3D NOREG) {
@@ -343,11 +343,11 @@ static struct storage *get_reg(struct regclass *c=
lass)
 			continue;
 		return get_hardreg(hardreg_storage_table + regno, 1);
 	}
-	fprintf(stderr, "Ran out of %s registers\n", class->name);
+	fprintf(stderr, "Ran out of %s registers\n", Class->name);
 	exit(1);
 }

-static struct storage *get_reg_value(struct storage *value, struct
regclass *class)
+static struct storage *get_reg_value(struct storage *value, struct
regclass *Class)
 {
 	struct reg_info *info;
 	struct storage *reg;
@@ -359,7 +359,7 @@ static struct storage *get_reg_value(struct
storage *value, struct regclass *cla
 		return get_hardreg(hardreg_storage_table + info->own_regno, 0);
 	}

-	reg =3D get_reg(class);
+	reg =3D get_reg(Class);
 	emit_move(value, reg, value->ctype, "reload register");
 	info =3D reg->reg;
 	info->contains =3D value;
diff --git a/ctags.c b/ctags.c
index 7e129a6..cd4e508 100644
--- a/ctags.c
+++ b/ctags.c
@@ -145,7 +145,7 @@ static void examine_symbol(struct symbol *sym)

 	default:
 		die("unknown symbol %s namespace:%d type:%d\n", show_ident(sym->iden=
t),
-		    sym->namespace, sym->type);
+		    sym->Namespace, sym->type);
 	}
 	if (!sym->kind)
 		sym->kind =3D 'v';
@@ -159,7 +159,7 @@ static void examine_namespace(struct symbol *sym)
 	if (sym->ident && sym->ident->reserved)
 		return;

-	switch(sym->namespace) {
+	switch(sym->Namespace) {
 	case NS_KEYWORD:
 	case NS_PREPROCESSOR:
 		return;
@@ -177,7 +177,7 @@ static void examine_namespace(struct symbol *sym)
 		examine_symbol(sym);
 		break;
 	default:
-		die("unknown namespace %d symbol:%s type:%d\n", sym->namespace,
+		die("unknown namespace %d symbol:%s type:%d\n", sym->Namespace,
 		    show_ident(sym->ident), sym->type);
 	}
 	add_tag(sym);
diff --git a/evaluate.c b/evaluate.c
index f8343c2..0baf92b 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -357,7 +357,7 @@ static inline int classify_type(struct symbol
*type, struct symbol **base)
 	return type_class[type->type];
 }

-#define is_int(class) ((class & (TYPE_NUM | TYPE_FLOAT)) =3D=3D TYPE_N=
UM)
+#define is_int(Class) ((Class & (TYPE_NUM | TYPE_FLOAT)) =3D=3D TYPE_N=
UM)

 static inline int is_string_type(struct symbol *type)
 {
@@ -480,10 +480,10 @@ static struct symbol *restricted_binop_type(int o=
p,
 }

 static inline void unrestrict(struct expression *expr,
-			      int class, struct symbol **ctype)
+			      int Class, struct symbol **ctype)
 {
-	if (class & TYPE_RESTRICT) {
-		if (class & TYPE_FOULED)
+	if (Class & TYPE_RESTRICT) {
+		if (Class & TYPE_FOULED)
 			*ctype =3D unfoul(*ctype);
 		warning(expr->pos, "%s degrades to integer",
 			show_typename(*ctype));
@@ -1696,7 +1696,7 @@ static struct symbol *evaluate_postop(struct
expression *expr)
 {
 	struct expression *op =3D expr->unop;
 	struct symbol *ctype =3D op->ctype;
-	int class =3D classify_type(op->ctype, &ctype);
+	int Class =3D classify_type(op->ctype, &ctype);
 	int multiply =3D 0;

 	if (!lvalue_expression(expr->unop)) {
@@ -1704,12 +1704,12 @@ static struct symbol *evaluate_postop(struct
expression *expr)
 		return NULL;
 	}

-	if ((class & TYPE_RESTRICT) && restricted_unop(expr->op, &ctype))
+	if ((Class & TYPE_RESTRICT) && restricted_unop(expr->op, &ctype))
 		return bad_expr_type(expr);

-	if (class & TYPE_NUM) {
+	if (Class & TYPE_NUM) {
 		multiply =3D 1;
-	} else if (class =3D=3D TYPE_PTR) {
+	} else if (Class =3D=3D TYPE_PTR) {
 		struct symbol *target =3D examine_pointer_target(ctype);
 		if (!is_function(target))
 			multiply =3D bits_to_bytes(target->bit_size);
@@ -1729,19 +1729,19 @@ static struct symbol *evaluate_postop(struct
expression *expr)
 static struct symbol *evaluate_sign(struct expression *expr)
 {
 	struct symbol *ctype =3D expr->unop->ctype;
-	int class =3D classify_type(ctype, &ctype);
+	int Class =3D classify_type(ctype, &ctype);
 	if (expr->flags && !(expr->unop->flags & Int_const_expr))
 		expr->flags =3D 0;
 	/* should be an arithmetic type */
-	if (!(class & TYPE_NUM))
+	if (!(Class & TYPE_NUM))
 		return bad_expr_type(expr);
-	if (!(class & (TYPE_FLOAT|TYPE_RESTRICT))) {
+	if (!(Class & (TYPE_FLOAT|TYPE_RESTRICT))) {
 		struct symbol *rtype =3D integer_promotion(ctype);
 		expr->unop =3D cast_to(expr->unop, rtype);
 		ctype =3D rtype;
-	} else if ((class & TYPE_FLOAT) && expr->op !=3D '~') {
+	} else if ((Class & TYPE_FLOAT) && expr->op !=3D '~') {
 		/* no conversions needed */
-	} else if ((class & TYPE_RESTRICT) && !restricted_unop(expr->op, &cty=
pe)) {
+	} else if ((Class & TYPE_RESTRICT) && !restricted_unop(expr->op, &cty=
pe)) {
 		/* no conversions needed */
 	} else {
 		return bad_expr_type(expr);
@@ -2111,14 +2111,14 @@ static int evaluate_arguments(struct symbol
*f, struct symbol *fn, struct expres
 		target =3D argtype;
 		if (!target) {
 			struct symbol *type;
-			int class =3D classify_type(ctype, &type);
-			if (is_int(class)) {
+			int Class =3D classify_type(ctype, &type);
+			if (is_int(Class)) {
 				*p =3D cast_to(expr, integer_promotion(type));
-			} else if (class & TYPE_FLOAT) {
+			} else if (Class & TYPE_FLOAT) {
 				unsigned long mod =3D type->ctype.modifiers;
 				if (!(mod & (MOD_LONG_ALL)))
 					*p =3D cast_to(expr, &double_ctype);
-			} else if (class & TYPE_PTR) {
+			} else if (Class & TYPE_PTR) {
 				if (expr->ctype =3D=3D &null_ctype)
 					*p =3D cast_to(expr, &ptr_ctype);
 				else
@@ -2191,7 +2191,7 @@ static void excess(struct expression *e, const ch=
ar *s)
 /*
  * implicit designator for the first element
  */
-static struct expression *first_subobject(struct symbol *ctype, int cl=
ass,
+static struct expression *first_subobject(struct symbol *ctype, int Cl=
ass,
 					  struct expression **v)
 {
 	struct expression *e =3D *v, *new;
@@ -2199,7 +2199,7 @@ static struct expression *first_subobject(struct
symbol *ctype, int class,
 	if (ctype->type =3D=3D SYM_NODE)
 		ctype =3D ctype->ctype.base_type;

-	if (class & TYPE_PTR) { /* array */
+	if (Class & TYPE_PTR) { /* array */
 		if (!ctype->bit_size)
 			return NULL;
 		new =3D alloc_expression(e->pos, EXPR_INDEX);
@@ -2351,13 +2351,13 @@ static struct expression
*next_designators(struct expression *old,
 }

 static int handle_simple_initializer(struct expression **ep, int neste=
d,
-				     int class, struct symbol *ctype);
+				     int Class, struct symbol *ctype);

 /*
  * deal with traversing subobjects [6.7.8(17,18,20)]
  */
 static void handle_list_initializer(struct expression *expr,
-				    int class, struct symbol *ctype)
+				    int Class, struct symbol *ctype)
 {
 	struct expression *e, *last =3D NULL, *top =3D NULL, *next;
 	int jumped =3D 0;
@@ -2371,12 +2371,12 @@ static void handle_list_initializer(struct
expression *expr,
 			struct symbol *struct_sym;
 			if (!top) {
 				top =3D e;
-				last =3D first_subobject(ctype, class, &top);
+				last =3D first_subobject(ctype, Class, &top);
 			} else {
 				last =3D next_designators(last, ctype, e, &top);
 			}
 			if (!last) {
-				excess(e, class & TYPE_PTR ? "array" :
+				excess(e, Class & TYPE_PTR ? "array" :
 							"struct or union");
 				DELETE_CURRENT_PTR(e);
 				continue;
@@ -2508,7 +2508,7 @@ static struct expression *handle_scalar(struct
expression *e, int nested)
  * until we dig into the inner struct.
  */
 static int handle_simple_initializer(struct expression **ep, int neste=
d,
-				     int class, struct symbol *ctype)
+				     int Class, struct symbol *ctype)
 {
 	int is_string =3D is_string_type(ctype);
 	struct expression *e =3D *ep, *p;
@@ -2518,7 +2518,7 @@ static int handle_simple_initializer(struct
expression **ep, int nested,
 		return 0;

 	/* scalar */
-	if (!(class & TYPE_COMPOUND)) {
+	if (!(Class & TYPE_COMPOUND)) {
 		e =3D handle_scalar(e, nested);
 		if (!e)
 			return 0;
@@ -2548,7 +2548,7 @@ static int handle_simple_initializer(struct
expression **ep, int nested,
 				goto String;
 			}
 		}
-		handle_list_initializer(e, class, ctype);
+		handle_list_initializer(e, Class, ctype);
 		return 1;
 	}

@@ -2562,7 +2562,7 @@ static int handle_simple_initializer(struct
expression **ep, int nested,
 		return 0;
 	}
 	/* struct or union can be initialized by compatible */
-	if (class !=3D TYPE_COMPOUND)
+	if (Class !=3D TYPE_COMPOUND)
 		return 0;
 	type =3D evaluate_expression(e);
 	if (!type)
@@ -2591,8 +2591,8 @@ String:
 static void evaluate_initializer(struct symbol *ctype, struct expressi=
on **ep)
 {
 	struct symbol *type;
-	int class =3D classify_type(ctype, &type);
-	if (!handle_simple_initializer(ep, 0, class, ctype))
+	int Class =3D classify_type(ctype, &type);
+	if (!handle_simple_initializer(ep, 0, Class, ctype))
 		expression_error(*ep, "invalid initializer");
 }

@@ -2820,7 +2820,7 @@ static struct symbol *evaluate_offsetof(struct
expression *expr)
 {
 	struct expression *e =3D expr->down;
 	struct symbol *ctype =3D expr->in;
-	int class;
+	int Class;

 	if (expr->op =3D=3D '.') {
 		struct symbol *field;
@@ -2830,8 +2830,8 @@ static struct symbol *evaluate_offsetof(struct
expression *expr)
 			return NULL;
 		}
 		examine_symbol_type(ctype);
-		class =3D classify_type(ctype, &ctype);
-		if (class !=3D TYPE_COMPOUND) {
+		Class =3D classify_type(ctype, &ctype);
+		if (Class !=3D TYPE_COMPOUND) {
 			expression_error(expr, "expected structure or union");
 			return NULL;
 		}
@@ -2853,8 +2853,8 @@ static struct symbol *evaluate_offsetof(struct
expression *expr)
 			return NULL;
 		}
 		examine_symbol_type(ctype);
-		class =3D classify_type(ctype, &ctype);
-		if (class !=3D (TYPE_COMPOUND | TYPE_PTR)) {
+		Class =3D classify_type(ctype, &ctype);
+		if (Class !=3D (TYPE_COMPOUND | TYPE_PTR)) {
 			expression_error(expr, "expected array");
 			return NULL;
 		}
diff --git a/expression.c b/expression.c
index 7e06e60..5f68c77 100644
--- a/expression.c
+++ b/expression.c
@@ -118,7 +118,7 @@ static struct token *parse_type(struct token
*token, struct expression **tree)
 	struct symbol *sym;
 	*tree =3D alloc_expression(token->pos, EXPR_TYPE);
 	(*tree)->flags =3D Int_const_expr; /* sic */
-	token =3D typename(token, &sym, NULL);
+	token =3D Typename(token, &sym, NULL);
 	if (sym->ident)
 		sparse_error(token->pos,
 			     "type expression should not include identifier "
@@ -167,7 +167,7 @@ static struct token *builtin_offsetof_expr(struct
token *token,
 		return expect(token, '(', "after __builtin_offset");

 	token =3D token->next;
-	token =3D typename(token, &sym, NULL);
+	token =3D Typename(token, &sym, NULL);
 	if (sym->ident)
 		sparse_error(token->pos,
 			     "type expression should not include identifier "
@@ -455,7 +455,7 @@ struct token *primary_expression(struct token
*token, struct expression **tree)
 		 *
 		 *	if (typeof(a) =3D=3D int) ..
 		 */
-		if (sym && sym->namespace =3D=3D NS_TYPEDEF) {
+		if (sym && sym->Namespace =3D=3D NS_TYPEDEF) {
 			sparse_error(token->pos, "typename in expression");
 			sym =3D NULL;
 		}
@@ -486,7 +486,7 @@ struct token *primary_expression(struct token
*token, struct expression **tree)
 		if (token->special =3D=3D '[' && lookup_type(token->next)) {
 			expr =3D alloc_expression(token->pos, EXPR_TYPE);
 			expr->flags =3D Int_const_expr; /* sic */
-			token =3D typename(token->next, &expr->symbol, NULL);
+			token =3D Typename(token->next, &expr->symbol, NULL);
 			token =3D expect(token, ']', "in type expression");
 			break;
 		}
@@ -606,7 +606,7 @@ static struct token *type_info_expression(struct
token *token,
 	if (!match_op(token, '(') || !lookup_type(token->next))
 		return unary_expression(token, &expr->cast_expression);
 	p =3D token;
-	token =3D typename(token->next, &expr->cast_type, NULL);
+	token =3D Typename(token->next, &expr->cast_type, NULL);

 	if (!match_op(token, ')')) {
 		static const char * error[] =3D {
@@ -731,7 +731,7 @@ static struct token *cast_expression(struct token
*token, struct expression **tr
 			struct symbol *sym;
 			int is_force;

-			token =3D typename(next, &sym, &is_force);
+			token =3D Typename(next, &sym, &is_force);
 			cast->cast_type =3D sym;
 			token =3D expect(token, ')', "at end of cast operator");
 			if (match_op(token, '{')) {
diff --git a/expression.h b/expression.h
index 9778de8..57617b2 100644
--- a/expression.h
+++ b/expression.h
@@ -196,13 +196,14 @@ static inline struct expression
*alloc_const_expression(struct position pos, int
 }

 /* Type name parsing */
-struct token *typename(struct token *, struct symbol **, int *);
+struct token *Typename(struct token *, struct symbol **, int *);

 static inline int lookup_type(struct token *token)
 {
 	if (token->pos.type =3D=3D TOKEN_IDENT) {
-		struct symbol *sym =3D lookup_symbol(token->ident, NS_SYMBOL | NS_TY=
PEDEF);
-		return sym && (sym->namespace & NS_TYPEDEF);
+		struct symbol *sym =3D lookup_symbol(token->ident,
+                        (enum Namespace)(NS_SYMBOL | NS_TYPEDEF) );
+		return sym && (sym->Namespace & NS_TYPEDEF);
 	}
 	return 0;
 }
diff --git a/graph.c b/graph.c
index 1a77d75..cd55f1c 100644
--- a/graph.c
+++ b/graph.c
@@ -124,7 +124,7 @@ static void graph_calls(struct entrypoint *ep, int =
internal)
 				if (insn->func->type =3D=3D PSEUDO_SYM) {
 					for (sym =3D insn->func->sym->ident->symbols;
 					     sym; sym =3D sym->next_id) {
-						if (sym->namespace & NS_SYMBOL && sym->ep)
+						if (sym->Namespace & NS_SYMBOL && sym->ep)
 							break;
 					}

diff --git a/lib.h b/lib.h
index 2cea252..95c9973 100644
--- a/lib.h
+++ b/lib.h
@@ -120,6 +120,10 @@ extern int Wdeclarationafterstatement;
 extern int dbg_entry;
 extern int dbg_dead;

+#ifdef __cplusplus
+extern "C" {
+#endif
+
 extern void declare_builtin_functions(void);
 extern void create_builtin_stream(void);
 extern struct symbol_list *sparse_initialize(int argc, char **argv,
struct string_list **files);
@@ -127,6 +131,10 @@ extern struct symbol_list *__sparse(char *filename=
);
 extern struct symbol_list *sparse_keep_tokens(char *filename);
 extern struct symbol_list *sparse(char *filename);

+#ifdef __cplusplus
+}
+#endif
+
 static inline int symbol_list_size(struct symbol_list *list)
 {
 	return ptr_list_size((struct ptr_list *)(list));
@@ -162,33 +170,41 @@ static inline void free_instruction_list(struct
instruction_list **head)
 	free_ptr_list((struct ptr_list **)head);
 }

-static inline struct instruction * delete_last_instruction(struct
instruction_list **head)
+static inline struct instruction * delete_last_instruction(
+        struct instruction_list **head)
 {
-	return undo_ptr_list_last((struct ptr_list **)head);
+	return (struct instruction *)undo_ptr_list_last(
+                (struct ptr_list **)head);
 }

-static inline struct basic_block * delete_last_basic_block(struct
basic_block_list **head)
+static inline struct basic_block * delete_last_basic_block(
+        struct basic_block_list **head)
 {
-	return delete_ptr_list_last((struct ptr_list **)head);
+	return (struct basic_block *)delete_ptr_list_last(
+                (struct ptr_list **)head);
 }

-static inline struct basic_block *first_basic_block(struct
basic_block_list *head)
+static inline struct basic_block *first_basic_block(
+        struct basic_block_list *head)
 {
-	return first_ptr_list((struct ptr_list *)head);
+	return (struct basic_block *)first_ptr_list((struct ptr_list *)head);
 }
-static inline struct instruction *last_instruction(struct
instruction_list *head)
+
+static inline struct instruction *last_instruction(
+        struct instruction_list *head)
 {
-	return last_ptr_list((struct ptr_list *)head);
+	return (struct instruction *)last_ptr_list((struct ptr_list *)head);
 }

-static inline struct instruction *first_instruction(struct
instruction_list *head)
+static inline struct instruction *first_instruction(
+        struct instruction_list *head)
 {
-	return first_ptr_list((struct ptr_list *)head);
+	return (struct instruction *)first_ptr_list((struct ptr_list *)head);
 }

 static inline pseudo_t first_pseudo(struct pseudo_list *head)
 {
-	return first_ptr_list((struct ptr_list *)head);
+	return (pseudo_t)first_ptr_list((struct ptr_list *)head);
 }

 static inline void concat_symbol_list(struct symbol_list *from,
struct symbol_list **to)
diff --git a/linearize.h b/linearize.h
index 50b3601..9aeb5e2 100644
--- a/linearize.h
+++ b/linearize.h
@@ -314,9 +314,9 @@ static inline void remove_bb_from_list(struct
basic_block_list **list, struct ba
 }

 static inline void replace_bb_in_list(struct basic_block_list **list,
-	struct basic_block *old, struct basic_block *new, int count)
+	struct basic_block *old, struct basic_block *_new, int count)
 {
-	replace_ptr_list_entry((struct ptr_list **)list, old, new, count);
+	replace_ptr_list_entry((struct ptr_list **)list, old, _new, count);
 }

 struct entrypoint {
diff --git a/parse.c b/parse.c
index 537055f..a885fbd 100644
--- a/parse.c
+++ b/parse.c
@@ -188,7 +188,7 @@ static struct symbol_op char_op =3D {
 	.type =3D KW_SPECIFIER,
 	.test =3D Set_T|Set_Long|Set_Short,
 	.set =3D Set_T|Set_Char,
-	.class =3D CChar,
+	.Class =3D CChar,
 };

 static struct symbol_op int_op =3D {
@@ -201,14 +201,14 @@ static struct symbol_op double_op =3D {
 	.type =3D KW_SPECIFIER,
 	.test =3D Set_T|Set_Signed|Set_Unsigned|Set_Short|Set_Vlong,
 	.set =3D Set_T|Set_Double,
-	.class =3D CReal,
+	.Class =3D CReal,
 };

 static struct symbol_op float_op =3D {
 	.type =3D KW_SPECIFIER | KW_SHORT,
 	.test =3D Set_T|Set_Signed|Set_Unsigned|Set_Short|Set_Long,
 	.set =3D Set_T|Set_Float,
-	.class =3D CReal,
+	.Class =3D CReal,
 };

 static struct symbol_op short_op =3D {
@@ -221,14 +221,14 @@ static struct symbol_op signed_op =3D {
 	.type =3D KW_SPECIFIER,
 	.test =3D Set_S|Set_Float|Set_Double|Set_Signed|Set_Unsigned,
 	.set =3D Set_Signed,
-	.class =3D CSInt,
+	.Class =3D CSInt,
 };

 static struct symbol_op unsigned_op =3D {
 	.type =3D KW_SPECIFIER,
 	.test =3D Set_S|Set_Float|Set_Double|Set_Signed|Set_Unsigned,
 	.set =3D Set_Unsigned,
-	.class =3D CUInt,
+	.Class =3D CUInt,
 };

 static struct symbol_op long_op =3D {
@@ -364,7 +364,7 @@ static struct symbol_op mode_word_op =3D {

 static struct init_keyword {
 	const char *name;
-	enum namespace ns;
+	enum Namespace ns;
 	unsigned long modifiers;
 	struct symbol_op *op;
 	struct symbol *type;
@@ -979,7 +979,7 @@ static struct token *typeof_specifier(struct token
*token, struct decl_state *ct
 		return token;
 	}
 	if (lookup_type(token->next)) {
-		token =3D typename(token->next, &sym, NULL);
+		token =3D Typename(token->next, &sym, NULL);
 		ctx->ctype.base_type =3D sym->ctype.base_type;
 		apply_ctype(token->pos, &sym->ctype, &ctx->ctype);
 	} else {
@@ -1249,21 +1249,21 @@ static unsigned long storage_modifiers(struct
decl_state *ctx)
 		| (ctx->is_tls ? MOD_TLS : 0);
 }

-static void set_storage_class(struct position *pos, struct decl_state
*ctx, int class)
+static void set_storage_class(struct position *pos, struct decl_state
*ctx, int Class)
 {
 	/* __thread can be used alone, or with extern or static */
-	if (ctx->is_tls && (class !=3D SStatic && class !=3D SExtern)) {
+	if (ctx->is_tls && (Class !=3D SStatic && Class !=3D SExtern)) {
 		sparse_error(*pos, "__thread can only be used alone, or with "
 				"extern or static");
 		return;
 	}

 	if (!ctx->storage_class) {
-		ctx->storage_class =3D class;
+		ctx->storage_class =3D Class;
 		return;
 	}
-	if (ctx->storage_class =3D=3D class)
-		sparse_error(*pos, "duplicate %s", storage_class[class]);
+	if (ctx->storage_class =3D=3D Class)
+		sparse_error(*pos, "duplicate %s", storage_class[Class]);
 	else
 		sparse_error(*pos, "multiple storage classes");
 }
@@ -1427,13 +1427,13 @@ static struct token *handle_qualifiers(struct
token *t, struct decl_state *ctx)
 static struct token *declaration_specifiers(struct token *token,
struct decl_state *ctx)
 {
 	int seen =3D 0;
-	int class =3D CInt;
+	int Class =3D CInt;
 	int size =3D 0;

 	while (token_type(token) =3D=3D TOKEN_IDENT) {
 		struct symbol *s =3D lookup_symbol(token->ident,
 						 NS_TYPEDEF | NS_SYMBOL);
-		if (!s || !(s->namespace & NS_TYPEDEF))
+		if (!s || !(s->Namespace & NS_TYPEDEF))
 			break;
 		if (s->type !=3D SYM_KEYWORD) {
 			if (seen & Set_Any)
@@ -1452,11 +1452,11 @@ static struct token
*declaration_specifiers(struct token *token, struct decl_sta
 				break;
 			}
 			seen |=3D s->op->set;
-			class +=3D s->op->class;
+			Class +=3D s->op->Class;
 			if (s->op->type & KW_SHORT) {
 				size =3D -1;
 			} else if (s->op->type & KW_LONG && size++) {
-				if (class =3D=3D CReal) {
+				if (Class =3D=3D CReal) {
 					specifier_conflict(token->pos,
 							   Set_Vlong,
 							   &double_ident);
@@ -1477,7 +1477,7 @@ static struct token
*declaration_specifiers(struct token *token, struct decl_sta
 	if (!(seen & Set_S)) {	/* not set explicitly? */
 		struct symbol *base =3D &incomplete_ctype;
 		if (seen & Set_Any)
-			base =3D types[class][size];
+			base =3D types[Class][size];
 		ctx->ctype.base_type =3D base;
 	}

@@ -1831,10 +1831,10 @@ static struct token
*parameter_declaration(struct token *token, struct symbol *s
 	return token;
 }

-struct token *typename(struct token *token, struct symbol **p, int *fo=
rced)
+struct token *Typename(struct token *token, struct symbol **p, int *fo=
rced)
 {
 	struct decl_state ctx =3D {.prefer_abstract =3D 1};
-	int class;
+	int Class;
 	struct symbol *sym =3D alloc_symbol(token->pos, SYM_NODE);
 	*p =3D sym;
 	token =3D declaration_specifiers(token, &ctx);
@@ -1842,17 +1842,17 @@ struct token *typename(struct token *token,
struct symbol **p, int *forced)
 	apply_modifiers(token->pos, &ctx);
 	sym->ctype =3D ctx.ctype;
 	sym->endpos =3D token->pos;
-	class =3D ctx.storage_class;
+	Class =3D ctx.storage_class;
 	if (forced) {
 		*forced =3D 0;
-		if (class =3D=3D SForced) {
+		if (Class =3D=3D SForced) {
 			*forced =3D 1;
-			class =3D 0;
+			Class =3D 0;
 		}
 	}
-	if (class)
+	if (Class)
 		warning(sym->pos, "storage class in typename (%s %s)",
-			storage_class[class], show_typename(sym));
+			storage_class[Class], show_typename(sym));
 	return token;
 }

@@ -2295,7 +2295,7 @@ static struct token *label_statement(struct token=
 *token)
 		struct symbol *sym =3D alloc_symbol(token->pos, SYM_LABEL);
 		/* it's block-scope, but we want label namespace */
 		bind_symbol(sym, token->ident, NS_SYMBOL);
-		sym->namespace =3D NS_LABEL;
+		sym->Namespace =3D NS_LABEL;
 		fn_local_symbol(sym);
 		token =3D token->next;
 		if (!match_op(token, ','))
diff --git a/parse.h b/parse.h
index 6b21e23..56e23e6 100644
--- a/parse.h
+++ b/parse.h
@@ -28,6 +28,7 @@ enum statement_type {
 	STMT_RANGE,
 };

+
 struct statement {
 	enum statement_type type;
 	struct position pos;
@@ -35,10 +36,12 @@ struct statement {
 		struct /* declaration */ {
 			struct symbol_list *declaration;
 		};
-		struct /* label_arg */ {
+                /*
+		struct / * label_arg * / {
 			struct symbol *label;
 			struct statement *label_statement;
 		};
+                */
 		struct {
 			struct expression *expression;
 			struct expression *context;
diff --git a/pre-process.c b/pre-process.c
index 656acaa..bdd6419 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -109,7 +109,7 @@ static void replace_with_integer(struct token
*token, unsigned int val)
 static struct symbol *lookup_macro(struct ident *ident)
 {
 	struct symbol *sym =3D lookup_symbol(ident, NS_MACRO | NS_UNDEF);
-	if (sym && sym->namespace !=3D NS_MACRO)
+	if (sym && sym->Namespace !=3D NS_MACRO)
 		sym =3D NULL;
 	return sym;
 }
@@ -1146,7 +1146,7 @@ static int do_handle_define(struct stream
*stream, struct token **line, struct t
 		if (attr < sym->attr)
 			goto out;

-		clean =3D (attr =3D=3D sym->attr && sym->namespace =3D=3D NS_MACRO);
+		clean =3D (attr =3D=3D sym->attr && sym->Namespace =3D=3D NS_MACRO);

 		if (token_list_different(sym->expansion, expansion) ||
 		    token_list_different(sym->arglist, arglist)) {
@@ -1173,7 +1173,7 @@ static int do_handle_define(struct stream
*stream, struct token **line, struct t
 		__free_token(token);	/* Free the "define" token, but not the rest
of the line */
 	}

-	sym->namespace =3D NS_MACRO;
+	sym->Namespace =3D NS_MACRO;
 	sym->used_in =3D NULL;
 	sym->attr =3D attr;
 out:
@@ -1209,7 +1209,7 @@ static int do_handle_undef(struct stream
*stream, struct token **line, struct to
 	if (sym) {
 		if (attr < sym->attr)
 			return 1;
-		if (attr =3D=3D sym->attr && sym->namespace =3D=3D NS_UNDEF)
+		if (attr =3D=3D sym->attr && sym->Namespace =3D=3D NS_UNDEF)
 			return 1;
 	} else if (attr <=3D SYM_ATTR_NORMAL)
 		return 1;
@@ -1219,7 +1219,7 @@ static int do_handle_undef(struct stream
*stream, struct token **line, struct to
 		bind_symbol(sym, left->ident, NS_MACRO);
 	}

-	sym->namespace =3D NS_UNDEF;
+	sym->Namespace =3D NS_UNDEF;
 	sym->used_in =3D NULL;
 	sym->attr =3D attr;

diff --git a/ptrlist.h b/ptrlist.h
index fbfc080..5d246b4 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -14,7 +14,8 @@

 /* Silly type-safety check ;) */
 #define DECLARE_PTR_LIST(listname,type)	struct listname { type *list[1=
]; }
-#define CHECK_TYPE(head,ptr)		(void)(&(ptr) =3D=3D &(head)->list[0])
+#define CHECK_TYPE(head,ptr)		(void)((void*)&(ptr) =3D=3D (void*)&(hea=
d)->list[0])
+//#define CHECK_TYPE(head,ptr)		(void)(&(ptr) =3D=3D &(head)->list[0])
 #define TYPEOF(head)			__typeof__(&(head)->list[0])
 #define VRFY_PTR_LIST(head)		(void)(sizeof((head)->list[0]))

@@ -36,10 +37,14 @@ struct ptr_list {

 #define ptr_list_empty(x) ((x) =3D=3D NULL)

+#ifdef __cplusplus
+extern "C" {
+#endif
+
 void * undo_ptr_list_last(struct ptr_list **head);
 void * delete_ptr_list_last(struct ptr_list **head);
 int delete_ptr_list_entry(struct ptr_list **, void *, int);
-int replace_ptr_list_entry(struct ptr_list **, void *old, void *new, i=
nt);
+int replace_ptr_list_entry(struct ptr_list **, void *old, void *_new, =
int);
 extern void sort_list(struct ptr_list **, int (*)(const void *, const =
void *));

 extern void **__add_ptr_list(struct ptr_list **, void *, unsigned long=
);
@@ -48,6 +53,11 @@ extern void __free_ptr_list(struct ptr_list **);
 extern int ptr_list_size(struct ptr_list *);
 extern int linearize_ptr_list(struct ptr_list *, void **, int);

+#ifdef __cplusplus
+}
+#endif
+
+
 /*
  * Hey, who said that you can't do overloading in C?
  *
@@ -270,7 +280,7 @@ extern void pack_ptr_list(struct ptr_list **);

 static inline void update_tag(void *p, unsigned long tag)
 {
-	unsigned long *ptr =3D p;
+	unsigned long *ptr =3D (unsigned long*)p;
 	*ptr =3D tag | (~3UL & *ptr);
 }

diff --git a/show-parse.c b/show-parse.c
index c97debe..7f8938a 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -257,7 +257,7 @@ const char *builtin_ctypename(struct ctype *ctype)

 static void do_show_type(struct symbol *sym, struct type_name *name)
 {
-	const char *typename;
+	const char *Typename;
 	unsigned long mod =3D 0;
 	int as =3D 0;
 	int was_ptr =3D 0;
@@ -284,12 +284,12 @@ deeper:
 	if (!sym)
 		goto out;

-	if ((typename =3D builtin_typename(sym))) {
-		int len =3D strlen(typename);
+	if ((Typename =3D builtin_typename(sym))) {
+		int len =3D strlen(Typename);
 		if (name->start !=3D name->end)
 			*--name->start =3D ' ';
 		name->start -=3D len;
-		memcpy(name->start, typename, len);
+		memcpy(name->start, Typename, len);
 		goto out;
 	}

diff --git a/symbol.c b/symbol.c
index 96dfbfa..845f3ae 100644
--- a/symbol.c
+++ b/symbol.c
@@ -39,12 +39,12 @@ void access_symbol(struct symbol *sym)
 	}
 }

-struct symbol *lookup_symbol(struct ident *ident, enum namespace ns)
+struct symbol *lookup_symbol(struct ident *ident, enum Namespace ns)
 {
 	struct symbol *sym;

 	for (sym =3D ident->symbols; sym; sym =3D sym->next_id) {
-		if (sym->namespace & ns) {
+		if (sym->Namespace & ns) {
 			sym->used =3D 1;
 			return sym;
 		}
@@ -515,7 +515,7 @@ void check_declaration(struct symbol *sym)
 	struct symbol *next =3D sym;

 	while ((next =3D next->next_id) !=3D NULL) {
-		if (next->namespace !=3D sym->namespace)
+		if (next->Namespace !=3D sym->Namespace)
 			continue;
 		if (sym->scope =3D=3D next->scope) {
 			sym->same_symbol =3D next;
@@ -538,7 +538,7 @@ void check_declaration(struct symbol *sym)
 	}
 }

-void bind_symbol(struct symbol *sym, struct ident *ident, enum namespa=
ce ns)
+void bind_symbol(struct symbol *sym, struct ident *ident, enum Namespa=
ce ns)
 {
 	struct scope *scope;
 	if (sym->bound) {
@@ -549,7 +549,7 @@ void bind_symbol(struct symbol *sym, struct ident
*ident, enum namespace ns)
 		sparse_error(sym->pos, "Trying to use reserved word '%s' as
identifier", show_ident(ident));
 		return;
 	}
-	sym->namespace =3D ns;
+	sym->Namespace =3D ns;
 	sym->next_id =3D ident->symbols;
 	ident->symbols =3D sym;
 	if (sym->ident && sym->ident !=3D ident)
@@ -576,12 +576,12 @@ void bind_symbol(struct symbol *sym, struct
ident *ident, enum namespace ns)
 	bind_scope(sym, scope);
 }

-struct symbol *create_symbol(int stream, const char *name, int type,
int namespace)
+struct symbol *create_symbol(int stream, const char *name, int type,
int Namespace)
 {
 	struct token *token =3D built_in_token(stream, name);
 	struct symbol *sym =3D alloc_symbol(token->pos, type);

-	bind_symbol(sym, token->ident, namespace);
+	bind_symbol(sym, token->ident, Namespace);
 	return sym;
 }

diff --git a/symbol.h b/symbol.h
index e567305..6118d00 100644
--- a/symbol.h
+++ b/symbol.h
@@ -24,7 +24,7 @@
  * token contains the information on where the symbol was
  * declared.
  */
-enum namespace {
+enum Namespace {
 	NS_NONE =3D 0,
 	NS_MACRO =3D 1,
 	NS_TYPEDEF =3D 2,
@@ -109,7 +109,7 @@ struct symbol_op {
 	struct token *(*attribute)(struct token *token, struct symbol *attr,
struct decl_state *ctx);
 	struct symbol *(*to_mode)(struct symbol *);

-	int test, set, class;
+	int test, set, Class;
 };

 extern int expand_safe_p(struct expression *expr, int cost);
@@ -121,7 +121,7 @@ extern int expand_constant_p(struct expression
*expr, int cost);

 struct symbol {
 	enum type type:8;
-	enum namespace namespace:9;
+	enum Namespace Namespace:9;
 	unsigned char used:1, attr:2, enum_member:1, bound:1;
 	struct position pos;		/* Where this symbol was declared */
 	struct position endpos;		/* Where this symbol ends*/
@@ -267,8 +267,8 @@ extern void access_symbol(struct symbol *);
 extern const char * type_difference(struct ctype *c1, struct ctype *c2=
,
 	unsigned long mod1, unsigned long mod2);

-extern struct symbol *lookup_symbol(struct ident *, enum namespace);
-extern struct symbol *create_symbol(int stream, const char *name, int
type, int namespace);
+extern struct symbol *lookup_symbol(struct ident *, enum Namespace);
+extern struct symbol *create_symbol(int stream, const char *name, int
type, int Namespace);
 extern void init_symbols(void);
 extern void init_ctype(void);
 extern struct symbol *alloc_symbol(struct position, int type);
@@ -279,7 +279,7 @@ extern int show_symbol_expr_init(struct symbol *sym=
);
 extern void show_type_list(struct symbol *);
 extern void show_symbol_list(struct symbol_list *, const char *);
 extern void add_symbol(struct symbol_list **, struct symbol *);
-extern void bind_symbol(struct symbol *, struct ident *, enum namespac=
e);
+extern void bind_symbol(struct symbol *, struct ident *, enum Namespac=
e);

 extern struct symbol *examine_symbol_type(struct symbol *);
 extern struct symbol *examine_pointer_target(struct symbol *);
@@ -367,7 +367,7 @@ static inline int get_sym_type(struct symbol *type)
 	return type->type;
 }

-static inline struct symbol *lookup_keyword(struct ident *ident, enum
namespace ns)
+static inline struct symbol *lookup_keyword(struct ident *ident, enum
Namespace ns)
 {
 	if (!ident->keyword)
 		return NULL;
diff --git a/token.h b/token.h
index a7ec77e..9dcd525 100644
--- a/token.h
+++ b/token.h
@@ -175,7 +175,7 @@ struct token {
 static inline struct token *containing_token(struct token **p)
 {
 	void *addr =3D (char *)p - ((char *)&((struct token *)0)->next - (cha=
r *)0);
-	return addr;
+	return (struct token *)addr;
 }

 #define token_type(x) ((x)->pos.type)
@@ -205,7 +205,8 @@ extern struct token *preprocess(struct token *);

 static inline int match_op(struct token *token, int op)
 {
-	return token->pos.type =3D=3D TOKEN_SPECIAL && token->special =3D=3D =
op;
+	return token->pos.type =3D=3D TOKEN_SPECIAL &&
+                token->special =3D=3D (unsigned int) op;
 }

 static inline int match_ident(struct token *token, struct ident *id)
diff --git a/tokenize.c b/tokenize.c
index 4c97517..c88a5a2 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -406,13 +406,13 @@ static int get_one_number(int c, int next,
stream_t *stream)

 	*p++ =3D c;
 	for (;;) {
-		long class =3D  cclass[next + 1];
-		if (!(class & (Dot | Digit | Letter)))
+		long Class =3D  cclass[next + 1];
+		if (!(Class & (Dot | Digit | Letter)))
 			break;
 		if (p !=3D buffer_end)
 			*p++ =3D next;
 		next =3D nextchar(stream);
-		if (class & Exp) {
+		if (Class & Exp) {
 			if (next =3D=3D '-' || next =3D=3D '+') {
 				if (p !=3D buffer_end)
 					*p++ =3D next;
@@ -899,10 +899,10 @@ static int get_one_identifier(int c, stream_t *st=
ream)

 static int get_one_token(int c, stream_t *stream)
 {
-	long class =3D cclass[c + 1];
-	if (class & Digit)
+	long Class =3D cclass[c + 1];
+	if (Class & Digit)
 		return get_one_number(c, nextchar(stream), stream);
-	if (class & Letter)
+	if (Class & Letter)
 		return get_one_identifier(c, stream);
 	return get_one_special(c, stream);
 }
--=20
1.5.4.3


=46ew notes from me. In the header files, I made changes to keywords
new, namespace, class, typename, (plus I inserted explicit retyping
where the g++ compiler needed it). As a result, I also made changes
(renaming) in the source code. But now I see, that not all of the class=
->Class
renaming in *.c files is necessary, and I should probably undo it.

Also for consistency, I should probably go through and check the rest
of the headers
(for instance putting extern "C" to all function declarations).
Something I wasn't clearly
thinking about with my first email :-)

So far, this (pseudo) code passes "g++ -Wall -Werror":

// start
#include "lib.h"
#include "allocate.h"
#include "token.h"
#include "parse.h"
#include "symbol.h"
#include "expression.h"
#include "linearize.h"

int main(int argc, *argv[])
{
  sparse_initialize();
  concat_symbol_list();
}
// end


Tomas Klacko
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
