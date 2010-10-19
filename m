From: Tomas Klacko <tomas.klacko@gmail.com>
Subject: Re: including sparse headers in C++ code
Date: Tue, 19 Oct 2010 22:03:42 +0200
Message-ID: <AANLkTinuRiaMZExudng5ECeunmF4s2ptnfaE=fYBft=i@mail.gmail.com>
References: <20101009205930.GA4684@feather>
	<AANLkTinaDZZmyeaK+rAvLCdZ-90n17WhABRsZGUBBcSH@mail.gmail.com>
	<AANLkTi=8EkK+_9pOA8fbDgYGfz-bPGj6XhLUnfSkdGeV@mail.gmail.com>
	<20101011224656.GN19804@ZenIV.linux.org.uk>
	<AANLkTinWYFf0CqBt9FJ9QyeGCU6754GotQM06U4vMqRa@mail.gmail.com>
	<AANLkTimdy9TwwSJM=rwTjXdRsnove6A2b0=d4M_dOin0@mail.gmail.com>
	<AANLkTimhh3zj8kgvaSQq9_CS711mLw8skrWL4yUgvJzT@mail.gmail.com>
	<AANLkTimZb1PsnKcMQ_Ka6dkk7fNwXiJb6_U4GcckLsF4@mail.gmail.com>
	<20101016191153.GA19324@feather>
	<AANLkTi=tpKLvWh6VKsizpZaxYMBntaGU1gC5uRu1_bND@mail.gmail.com>
	<20101018053955.GA1628@feather>
	<AANLkTim2ti8+aht_f=Mv=0iLZCvF65CFF6GNP2gHF=Kq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf3040e2e62a5b6b0492fdca09
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49626 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397Ab0JSUDo (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 19 Oct 2010 16:03:44 -0400
Received: by gyg13 with SMTP id 13so88763gyg.19
        for <linux-sparse@vger.kernel.org>; Tue, 19 Oct 2010 13:03:43 -0700 (PDT)
In-Reply-To: <AANLkTim2ti8+aht_f=Mv=0iLZCvF65CFF6GNP2gHF=Kq@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-sparse@vger.kernel.org

--20cf3040e2e62a5b6b0492fdca09
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 18, 2010 at 8:37 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Sun, Oct 17, 2010 at 10:39 PM, Josh Triplett <josh@joshtriplett.org> w=
rote:
>>
>> Based on these two code examples, I think you don't need to change
>> CHECK_TYPE at all. =A0(And the user should always use code like your
>> second example, not your first example.)
>
> Oh good, then we can completely remove the #ifdef __cplusplus.

I have removed the #ifdef __cplusplus and the dead label union.

This is the attached patch:

From 68743b26a471a5f59a0efb2929f2dfc82f7eae1a Mon Sep 17 00:00:00 2001
From: Tomas Klacko <tomas.klacko@gmail.com>
Date: Tue, 19 Oct 2010 18:36:53 +0200
Subject: [PATCH] Make headers usable in Cxx code.

---
 c2xml.c       |    6 +++---
 ctags.c       |    6 +++---
 expression.c  |   12 ++++++------
 expression.h  |    6 +++---
 graph.c       |    2 +-
 lib.h         |   13 +++++++------
 linearize.h   |    4 ++--
 parse.c       |   22 +++++++++++-----------
 parse.h       |    4 ----
 pre-process.c |   10 +++++-----
 ptrlist.h     |    4 ++--
 symbol.c      |   10 +++++-----
 symbol.h      |   15 ++++++++-------
 token.h       |    4 ++--
 14 files changed, 58 insertions(+), 60 deletions(-)

diff --git a/c2xml.c b/c2xml.c
index 37f29cf..749c699 100644
--- a/c2xml.c
+++ b/c2xml.c
@@ -128,7 +128,7 @@ static void examine_modifiers(struct symbol *sym,
xmlNodePtr node)

 	int i;

-	if (sym->namespace !=3D NS_SYMBOL)
+	if (sym->ns !=3D NS_SYMBOL)
 		return;

 	/*iterate over the 32 bit bitfield*/
@@ -236,7 +236,7 @@ static void examine_namespace(struct symbol *sym)
 	if (sym->ident && sym->ident->reserved)
 		return;

-	switch(sym->namespace) {
+	switch(sym->ns) {
 	case NS_MACRO:
 		examine_macro(sym, root_node);
 		break;
@@ -253,7 +253,7 @@ static void examine_namespace(struct symbol *sym)
 	case NS_KEYWORD:
 		break;
 	default:
-		die("Unrecognised namespace type %d",sym->namespace);
+		die("Unrecognised namespace type %d",sym->ns);
 	}

 }
diff --git a/ctags.c b/ctags.c
index 7e129a6..7e09c95 100644
--- a/ctags.c
+++ b/ctags.c
@@ -145,7 +145,7 @@ static void examine_symbol(struct symbol *sym)

 	default:
 		die("unknown symbol %s namespace:%d type:%d\n", show_ident(sym->ident),
-		    sym->namespace, sym->type);
+		    sym->ns, sym->type);
 	}
 	if (!sym->kind)
 		sym->kind =3D 'v';
@@ -159,7 +159,7 @@ static void examine_namespace(struct symbol *sym)
 	if (sym->ident && sym->ident->reserved)
 		return;

-	switch(sym->namespace) {
+	switch(sym->ns) {
 	case NS_KEYWORD:
 	case NS_PREPROCESSOR:
 		return;
@@ -177,7 +177,7 @@ static void examine_namespace(struct symbol *sym)
 		examine_symbol(sym);
 		break;
 	default:
-		die("unknown namespace %d symbol:%s type:%d\n", sym->namespace,
+		die("unknown namespace %d symbol:%s type:%d\n", sym->ns,
 		    show_ident(sym->ident), sym->type);
 	}
 	add_tag(sym);
diff --git a/expression.c b/expression.c
index 7e06e60..e02f5b0 100644
--- a/expression.c
+++ b/expression.c
@@ -118,7 +118,7 @@ static struct token *parse_type(struct token
*token, struct expression **tree)
 	struct symbol *sym;
 	*tree =3D alloc_expression(token->pos, EXPR_TYPE);
 	(*tree)->flags =3D Int_const_expr; /* sic */
-	token =3D typename(token, &sym, NULL);
+	token =3D type_name(token, &sym, NULL);
 	if (sym->ident)
 		sparse_error(token->pos,
 			     "type expression should not include identifier "
@@ -167,7 +167,7 @@ static struct token *builtin_offsetof_expr(struct
token *token,
 		return expect(token, '(', "after __builtin_offset");

 	token =3D token->next;
-	token =3D typename(token, &sym, NULL);
+	token =3D type_name(token, &sym, NULL);
 	if (sym->ident)
 		sparse_error(token->pos,
 			     "type expression should not include identifier "
@@ -455,7 +455,7 @@ struct token *primary_expression(struct token
*token, struct expression **tree)
 		 *
 		 *	if (typeof(a) =3D=3D int) ..
 		 */
-		if (sym && sym->namespace =3D=3D NS_TYPEDEF) {
+		if (sym && sym->ns =3D=3D NS_TYPEDEF) {
 			sparse_error(token->pos, "typename in expression");
 			sym =3D NULL;
 		}
@@ -486,7 +486,7 @@ struct token *primary_expression(struct token
*token, struct expression **tree)
 		if (token->special =3D=3D '[' && lookup_type(token->next)) {
 			expr =3D alloc_expression(token->pos, EXPR_TYPE);
 			expr->flags =3D Int_const_expr; /* sic */
-			token =3D typename(token->next, &expr->symbol, NULL);
+			token =3D type_name(token->next, &expr->symbol, NULL);
 			token =3D expect(token, ']', "in type expression");
 			break;
 		}
@@ -606,7 +606,7 @@ static struct token *type_info_expression(struct
token *token,
 	if (!match_op(token, '(') || !lookup_type(token->next))
 		return unary_expression(token, &expr->cast_expression);
 	p =3D token;
-	token =3D typename(token->next, &expr->cast_type, NULL);
+	token =3D type_name(token->next, &expr->cast_type, NULL);

 	if (!match_op(token, ')')) {
 		static const char * error[] =3D {
@@ -731,7 +731,7 @@ static struct token *cast_expression(struct token
*token, struct expression **tr
 			struct symbol *sym;
 			int is_force;

-			token =3D typename(next, &sym, &is_force);
+			token =3D type_name(next, &sym, &is_force);
 			cast->cast_type =3D sym;
 			token =3D expect(token, ')', "at end of cast operator");
 			if (match_op(token, '{')) {
diff --git a/expression.h b/expression.h
index 9778de8..698c778 100644
--- a/expression.h
+++ b/expression.h
@@ -196,13 +196,13 @@ static inline struct expression
*alloc_const_expression(struct position pos, int
 }

 /* Type name parsing */
-struct token *typename(struct token *, struct symbol **, int *);
+struct token *type_name(struct token *, struct symbol **, int *);

 static inline int lookup_type(struct token *token)
 {
 	if (token->pos.type =3D=3D TOKEN_IDENT) {
-		struct symbol *sym =3D lookup_symbol(token->ident, NS_SYMBOL | NS_TYPEDE=
F);
-		return sym && (sym->namespace & NS_TYPEDEF);
+		struct symbol *sym =3D lookup_symbol(token->ident, NS_SYMBOL_OR_TYPEDEF)=
;
+		return sym && (sym->ns & NS_TYPEDEF);
 	}
 	return 0;
 }
diff --git a/graph.c b/graph.c
index 1a77d75..7e0868f 100644
--- a/graph.c
+++ b/graph.c
@@ -124,7 +124,7 @@ static void graph_calls(struct entrypoint *ep, int inte=
rnal)
 				if (insn->func->type =3D=3D PSEUDO_SYM) {
 					for (sym =3D insn->func->sym->ident->symbols;
 					     sym; sym =3D sym->next_id) {
-						if (sym->namespace & NS_SYMBOL && sym->ep)
+						if (sym->ns & NS_SYMBOL && sym->ep)
 							break;
 					}

diff --git a/lib.h b/lib.h
index 2cea252..6d24fc8 100644
--- a/lib.h
+++ b/lib.h
@@ -164,31 +164,32 @@ static inline void free_instruction_list(struct
instruction_list **head)

 static inline struct instruction * delete_last_instruction(struct
instruction_list **head)
 {
-	return undo_ptr_list_last((struct ptr_list **)head);
+	return (struct instruction *)undo_ptr_list_last((struct ptr_list **)head)=
;
 }

 static inline struct basic_block * delete_last_basic_block(struct
basic_block_list **head)
 {
-	return delete_ptr_list_last((struct ptr_list **)head);
+	return (struct basic_block *)delete_ptr_list_last((struct ptr_list **)hea=
d);
 }

 static inline struct basic_block *first_basic_block(struct
basic_block_list *head)
 {
-	return first_ptr_list((struct ptr_list *)head);
+	return (struct basic_block *)first_ptr_list((struct ptr_list *)head);
 }
+
 static inline struct instruction *last_instruction(struct
instruction_list *head)
 {
-	return last_ptr_list((struct ptr_list *)head);
+	return (struct instruction *)last_ptr_list((struct ptr_list *)head);
 }

 static inline struct instruction *first_instruction(struct
instruction_list *head)
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
index 50b3601..a6d629f 100644
--- a/linearize.h
+++ b/linearize.h
@@ -314,9 +314,9 @@ static inline void remove_bb_from_list(struct
basic_block_list **list, struct ba
 }

 static inline void replace_bb_in_list(struct basic_block_list **list,
-	struct basic_block *old, struct basic_block *new, int count)
+	struct basic_block *old, struct basic_block *newlist, int count)
 {
-	replace_ptr_list_entry((struct ptr_list **)list, old, new, count);
+	replace_ptr_list_entry((struct ptr_list **)list, old, newlist, count);
 }

 struct entrypoint {
diff --git a/parse.c b/parse.c
index 537055f..0f6fc4b 100644
--- a/parse.c
+++ b/parse.c
@@ -188,7 +188,7 @@ static struct symbol_op char_op =3D {
 	.type =3D KW_SPECIFIER,
 	.test =3D Set_T|Set_Long|Set_Short,
 	.set =3D Set_T|Set_Char,
-	.class =3D CChar,
+	.klass =3D CChar,
 };

 static struct symbol_op int_op =3D {
@@ -201,14 +201,14 @@ static struct symbol_op double_op =3D {
 	.type =3D KW_SPECIFIER,
 	.test =3D Set_T|Set_Signed|Set_Unsigned|Set_Short|Set_Vlong,
 	.set =3D Set_T|Set_Double,
-	.class =3D CReal,
+	.klass =3D CReal,
 };

 static struct symbol_op float_op =3D {
 	.type =3D KW_SPECIFIER | KW_SHORT,
 	.test =3D Set_T|Set_Signed|Set_Unsigned|Set_Short|Set_Long,
 	.set =3D Set_T|Set_Float,
-	.class =3D CReal,
+	.klass =3D CReal,
 };

 static struct symbol_op short_op =3D {
@@ -221,14 +221,14 @@ static struct symbol_op signed_op =3D {
 	.type =3D KW_SPECIFIER,
 	.test =3D Set_S|Set_Float|Set_Double|Set_Signed|Set_Unsigned,
 	.set =3D Set_Signed,
-	.class =3D CSInt,
+	.klass =3D CSInt,
 };

 static struct symbol_op unsigned_op =3D {
 	.type =3D KW_SPECIFIER,
 	.test =3D Set_S|Set_Float|Set_Double|Set_Signed|Set_Unsigned,
 	.set =3D Set_Unsigned,
-	.class =3D CUInt,
+	.klass =3D CUInt,
 };

 static struct symbol_op long_op =3D {
@@ -364,7 +364,7 @@ static struct symbol_op mode_word_op =3D {

 static struct init_keyword {
 	const char *name;
-	enum namespace ns;
+	enum name_space ns;
 	unsigned long modifiers;
 	struct symbol_op *op;
 	struct symbol *type;
@@ -979,7 +979,7 @@ static struct token *typeof_specifier(struct token
*token, struct decl_state *ct
 		return token;
 	}
 	if (lookup_type(token->next)) {
-		token =3D typename(token->next, &sym, NULL);
+		token =3D type_name(token->next, &sym, NULL);
 		ctx->ctype.base_type =3D sym->ctype.base_type;
 		apply_ctype(token->pos, &sym->ctype, &ctx->ctype);
 	} else {
@@ -1433,7 +1433,7 @@ static struct token
*declaration_specifiers(struct token *token, struct decl_sta
 	while (token_type(token) =3D=3D TOKEN_IDENT) {
 		struct symbol *s =3D lookup_symbol(token->ident,
 						 NS_TYPEDEF | NS_SYMBOL);
-		if (!s || !(s->namespace & NS_TYPEDEF))
+		if (!s || !(s->ns & NS_TYPEDEF))
 			break;
 		if (s->type !=3D SYM_KEYWORD) {
 			if (seen & Set_Any)
@@ -1452,7 +1452,7 @@ static struct token
*declaration_specifiers(struct token *token, struct decl_sta
 				break;
 			}
 			seen |=3D s->op->set;
-			class +=3D s->op->class;
+			class +=3D s->op->klass;
 			if (s->op->type & KW_SHORT) {
 				size =3D -1;
 			} else if (s->op->type & KW_LONG && size++) {
@@ -1831,7 +1831,7 @@ static struct token
*parameter_declaration(struct token *token, struct symbol *s
 	return token;
 }

-struct token *typename(struct token *token, struct symbol **p, int *forced=
)
+struct token *type_name(struct token *token, struct symbol **p, int *force=
d)
 {
 	struct decl_state ctx =3D {.prefer_abstract =3D 1};
 	int class;
@@ -2295,7 +2295,7 @@ static struct token *label_statement(struct token *to=
ken)
 		struct symbol *sym =3D alloc_symbol(token->pos, SYM_LABEL);
 		/* it's block-scope, but we want label namespace */
 		bind_symbol(sym, token->ident, NS_SYMBOL);
-		sym->namespace =3D NS_LABEL;
+		sym->ns =3D NS_LABEL;
 		fn_local_symbol(sym);
 		token =3D token->next;
 		if (!match_op(token, ','))
diff --git a/parse.h b/parse.h
index 6b21e23..b26bd03 100644
--- a/parse.h
+++ b/parse.h
@@ -35,10 +35,6 @@ struct statement {
 		struct /* declaration */ {
 			struct symbol_list *declaration;
 		};
-		struct /* label_arg */ {
-			struct symbol *label;
-			struct statement *label_statement;
-		};
 		struct {
 			struct expression *expression;
 			struct expression *context;
diff --git a/pre-process.c b/pre-process.c
index 656acaa..b7371f3 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -109,7 +109,7 @@ static void replace_with_integer(struct token
*token, unsigned int val)
 static struct symbol *lookup_macro(struct ident *ident)
 {
 	struct symbol *sym =3D lookup_symbol(ident, NS_MACRO | NS_UNDEF);
-	if (sym && sym->namespace !=3D NS_MACRO)
+	if (sym && sym->ns !=3D NS_MACRO)
 		sym =3D NULL;
 	return sym;
 }
@@ -1146,7 +1146,7 @@ static int do_handle_define(struct stream
*stream, struct token **line, struct t
 		if (attr < sym->attr)
 			goto out;

-		clean =3D (attr =3D=3D sym->attr && sym->namespace =3D=3D NS_MACRO);
+		clean =3D (attr =3D=3D sym->attr && sym->ns =3D=3D NS_MACRO);

 		if (token_list_different(sym->expansion, expansion) ||
 		    token_list_different(sym->arglist, arglist)) {
@@ -1173,7 +1173,7 @@ static int do_handle_define(struct stream
*stream, struct token **line, struct t
 		__free_token(token);	/* Free the "define" token, but not the rest
of the line */
 	}

-	sym->namespace =3D NS_MACRO;
+	sym->ns =3D NS_MACRO;
 	sym->used_in =3D NULL;
 	sym->attr =3D attr;
 out:
@@ -1209,7 +1209,7 @@ static int do_handle_undef(struct stream
*stream, struct token **line, struct to
 	if (sym) {
 		if (attr < sym->attr)
 			return 1;
-		if (attr =3D=3D sym->attr && sym->namespace =3D=3D NS_UNDEF)
+		if (attr =3D=3D sym->attr && sym->ns =3D=3D NS_UNDEF)
 			return 1;
 	} else if (attr <=3D SYM_ATTR_NORMAL)
 		return 1;
@@ -1219,7 +1219,7 @@ static int do_handle_undef(struct stream
*stream, struct token **line, struct to
 		bind_symbol(sym, left->ident, NS_MACRO);
 	}

-	sym->namespace =3D NS_UNDEF;
+	sym->ns =3D NS_UNDEF;
 	sym->used_in =3D NULL;
 	sym->attr =3D attr;

diff --git a/ptrlist.h b/ptrlist.h
index fbfc080..b884e4d 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -39,7 +39,7 @@ struct ptr_list {
 void * undo_ptr_list_last(struct ptr_list **head);
 void * delete_ptr_list_last(struct ptr_list **head);
 int delete_ptr_list_entry(struct ptr_list **, void *, int);
-int replace_ptr_list_entry(struct ptr_list **, void *old, void *new, int);
+int replace_ptr_list_entry(struct ptr_list **, void *old, void *newlist, i=
nt);
 extern void sort_list(struct ptr_list **, int (*)(const void *, const void=
 *));

 extern void **__add_ptr_list(struct ptr_list **, void *, unsigned long);
@@ -270,7 +270,7 @@ extern void pack_ptr_list(struct ptr_list **);

 static inline void update_tag(void *p, unsigned long tag)
 {
-	unsigned long *ptr =3D p;
+	unsigned long *ptr =3D (unsigned long *)p;
 	*ptr =3D tag | (~3UL & *ptr);
 }

diff --git a/symbol.c b/symbol.c
index 96dfbfa..a8cd999 100644
--- a/symbol.c
+++ b/symbol.c
@@ -39,12 +39,12 @@ void access_symbol(struct symbol *sym)
 	}
 }

-struct symbol *lookup_symbol(struct ident *ident, enum namespace ns)
+struct symbol *lookup_symbol(struct ident *ident, enum name_space ns)
 {
 	struct symbol *sym;

 	for (sym =3D ident->symbols; sym; sym =3D sym->next_id) {
-		if (sym->namespace & ns) {
+		if (sym->ns & ns) {
 			sym->used =3D 1;
 			return sym;
 		}
@@ -515,7 +515,7 @@ void check_declaration(struct symbol *sym)
 	struct symbol *next =3D sym;

 	while ((next =3D next->next_id) !=3D NULL) {
-		if (next->namespace !=3D sym->namespace)
+		if (next->ns !=3D sym->ns)
 			continue;
 		if (sym->scope =3D=3D next->scope) {
 			sym->same_symbol =3D next;
@@ -538,7 +538,7 @@ void check_declaration(struct symbol *sym)
 	}
 }

-void bind_symbol(struct symbol *sym, struct ident *ident, enum namespace n=
s)
+void bind_symbol(struct symbol *sym, struct ident *ident, enum name_space =
ns)
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
+	sym->ns =3D ns;
 	sym->next_id =3D ident->symbols;
 	ident->symbols =3D sym;
 	if (sym->ident && sym->ident !=3D ident)
diff --git a/symbol.h b/symbol.h
index e567305..a483096 100644
--- a/symbol.h
+++ b/symbol.h
@@ -24,13 +24,14 @@
  * token contains the information on where the symbol was
  * declared.
  */
-enum namespace {
+enum name_space {
 	NS_NONE =3D 0,
 	NS_MACRO =3D 1,
 	NS_TYPEDEF =3D 2,
 	NS_STRUCT =3D 4,  // Also used for unions and enums.
 	NS_LABEL =3D 8,
 	NS_SYMBOL =3D 16,
+	NS_SYMBOL_OR_TYPEDEF =3D 18,
 	NS_ITERATOR =3D 32,
 	NS_PREPROCESSOR =3D 64,
 	NS_UNDEF =3D 128,
@@ -109,7 +110,7 @@ struct symbol_op {
 	struct token *(*attribute)(struct token *token, struct symbol *attr,
struct decl_state *ctx);
 	struct symbol *(*to_mode)(struct symbol *);

-	int test, set, class;
+	int test, set, klass;
 };

 extern int expand_safe_p(struct expression *expr, int cost);
@@ -121,7 +122,7 @@ extern int expand_constant_p(struct expression
*expr, int cost);

 struct symbol {
 	enum type type:8;
-	enum namespace namespace:9;
+	enum name_space ns:9;
 	unsigned char used:1, attr:2, enum_member:1, bound:1;
 	struct position pos;		/* Where this symbol was declared */
 	struct position endpos;		/* Where this symbol ends*/
@@ -267,8 +268,8 @@ extern void access_symbol(struct symbol *);
 extern const char * type_difference(struct ctype *c1, struct ctype *c2,
 	unsigned long mod1, unsigned long mod2);

-extern struct symbol *lookup_symbol(struct ident *, enum namespace);
-extern struct symbol *create_symbol(int stream, const char *name, int
type, int namespace);
+extern struct symbol *lookup_symbol(struct ident *, enum name_space);
+extern struct symbol *create_symbol(int stream, const char *name, int
type, int name_space);
 extern void init_symbols(void);
 extern void init_ctype(void);
 extern struct symbol *alloc_symbol(struct position, int type);
@@ -279,7 +280,7 @@ extern int show_symbol_expr_init(struct symbol *sym);
 extern void show_type_list(struct symbol *);
 extern void show_symbol_list(struct symbol_list *, const char *);
 extern void add_symbol(struct symbol_list **, struct symbol *);
-extern void bind_symbol(struct symbol *, struct ident *, enum namespace);
+extern void bind_symbol(struct symbol *, struct ident *, enum name_space);

 extern struct symbol *examine_symbol_type(struct symbol *);
 extern struct symbol *examine_pointer_target(struct symbol *);
@@ -367,7 +368,7 @@ static inline int get_sym_type(struct symbol *type)
 	return type->type;
 }

-static inline struct symbol *lookup_keyword(struct ident *ident, enum
namespace ns)
+static inline struct symbol *lookup_keyword(struct ident *ident, enum
name_space ns)
 {
 	if (!ident->keyword)
 		return NULL;
diff --git a/token.h b/token.h
index a7ec77e..fd854a0 100644
--- a/token.h
+++ b/token.h
@@ -175,7 +175,7 @@ struct token {
 static inline struct token *containing_token(struct token **p)
 {
 	void *addr =3D (char *)p - ((char *)&((struct token *)0)->next - (char *)=
0);
-	return addr;
+	return (struct token*)addr;
 }

 #define token_type(x) ((x)->pos.type)
@@ -205,7 +205,7 @@ extern struct token *preprocess(struct token *);

 static inline int match_op(struct token *token, int op)
 {
-	return token->pos.type =3D=3D TOKEN_SPECIAL && token->special =3D=3D op;
+	return token->pos.type =3D=3D TOKEN_SPECIAL && token->special =3D=3D (uns=
igned int)op;
 }

 static inline int match_ident(struct token *token, struct ident *id)
--=20
1.5.4.3

Tomas Klacko

--20cf3040e2e62a5b6b0492fdca09
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-Make-headers-usable-in-Cxx-code.patch"
Content-Disposition: attachment;
	filename="0001-Make-headers-usable-in-Cxx-code.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gfh7a9px0

RnJvbSA2ODc0M2IyNmE0NzFhNWY1OWEwZWZiMjkyOWYyZGZjODJmN2VhZTFhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUb21hcyBLbGFja28gPHRvbWFzLmtsYWNrb0BnbWFpbC5jb20+
CkRhdGU6IFR1ZSwgMTkgT2N0IDIwMTAgMTg6MzY6NTMgKzAyMDAKU3ViamVjdDogW1BBVENIXSBN
YWtlIGhlYWRlcnMgdXNhYmxlIGluIEN4eCBjb2RlLgoKLS0tCiBjMnhtbC5jICAgICAgIHwgICAg
NiArKystLS0KIGN0YWdzLmMgICAgICAgfCAgICA2ICsrKy0tLQogZXhwcmVzc2lvbi5jICB8ICAg
MTIgKysrKysrLS0tLS0tCiBleHByZXNzaW9uLmggIHwgICAgNiArKystLS0KIGdyYXBoLmMgICAg
ICAgfCAgICAyICstCiBsaWIuaCAgICAgICAgIHwgICAxMyArKysrKysrLS0tLS0tCiBsaW5lYXJp
emUuaCAgIHwgICAgNCArKy0tCiBwYXJzZS5jICAgICAgIHwgICAyMiArKysrKysrKysrKy0tLS0t
LS0tLS0tCiBwYXJzZS5oICAgICAgIHwgICAgNCAtLS0tCiBwcmUtcHJvY2Vzcy5jIHwgICAxMCAr
KysrKy0tLS0tCiBwdHJsaXN0LmggICAgIHwgICAgNCArKy0tCiBzeW1ib2wuYyAgICAgIHwgICAx
MCArKysrKy0tLS0tCiBzeW1ib2wuaCAgICAgIHwgICAxNSArKysrKysrKy0tLS0tLS0KIHRva2Vu
LmggICAgICAgfCAgICA0ICsrLS0KIDE0IGZpbGVzIGNoYW5nZWQsIDU4IGluc2VydGlvbnMoKyks
IDYwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2MyeG1sLmMgYi9jMnhtbC5jCmluZGV4IDM3
ZjI5Y2YuLjc0OWM2OTkgMTAwNjQ0Ci0tLSBhL2MyeG1sLmMKKysrIGIvYzJ4bWwuYwpAQCAtMTI4
LDcgKzEyOCw3IEBAIHN0YXRpYyB2b2lkIGV4YW1pbmVfbW9kaWZpZXJzKHN0cnVjdCBzeW1ib2wg
KnN5bSwgeG1sTm9kZVB0ciBub2RlKQogCiAJaW50IGk7CiAKLQlpZiAoc3ltLT5uYW1lc3BhY2Ug
IT0gTlNfU1lNQk9MKQorCWlmIChzeW0tPm5zICE9IE5TX1NZTUJPTCkKIAkJcmV0dXJuOwogCiAJ
LyppdGVyYXRlIG92ZXIgdGhlIDMyIGJpdCBiaXRmaWVsZCovCkBAIC0yMzYsNyArMjM2LDcgQEAg
c3RhdGljIHZvaWQgZXhhbWluZV9uYW1lc3BhY2Uoc3RydWN0IHN5bWJvbCAqc3ltKQogCWlmIChz
eW0tPmlkZW50ICYmIHN5bS0+aWRlbnQtPnJlc2VydmVkKQogCQlyZXR1cm47CiAKLQlzd2l0Y2go
c3ltLT5uYW1lc3BhY2UpIHsKKwlzd2l0Y2goc3ltLT5ucykgewogCWNhc2UgTlNfTUFDUk86CiAJ
CWV4YW1pbmVfbWFjcm8oc3ltLCByb290X25vZGUpOwogCQlicmVhazsKQEAgLTI1Myw3ICsyNTMs
NyBAQCBzdGF0aWMgdm9pZCBleGFtaW5lX25hbWVzcGFjZShzdHJ1Y3Qgc3ltYm9sICpzeW0pCiAJ
Y2FzZSBOU19LRVlXT1JEOgogCQlicmVhazsKIAlkZWZhdWx0OgotCQlkaWUoIlVucmVjb2duaXNl
ZCBuYW1lc3BhY2UgdHlwZSAlZCIsc3ltLT5uYW1lc3BhY2UpOworCQlkaWUoIlVucmVjb2duaXNl
ZCBuYW1lc3BhY2UgdHlwZSAlZCIsc3ltLT5ucyk7CiAJfQogCiB9CmRpZmYgLS1naXQgYS9jdGFn
cy5jIGIvY3RhZ3MuYwppbmRleCA3ZTEyOWE2Li43ZTA5Yzk1IDEwMDY0NAotLS0gYS9jdGFncy5j
CisrKyBiL2N0YWdzLmMKQEAgLTE0NSw3ICsxNDUsNyBAQCBzdGF0aWMgdm9pZCBleGFtaW5lX3N5
bWJvbChzdHJ1Y3Qgc3ltYm9sICpzeW0pCiAKIAlkZWZhdWx0OgogCQlkaWUoInVua25vd24gc3lt
Ym9sICVzIG5hbWVzcGFjZTolZCB0eXBlOiVkXG4iLCBzaG93X2lkZW50KHN5bS0+aWRlbnQpLAot
CQkgICAgc3ltLT5uYW1lc3BhY2UsIHN5bS0+dHlwZSk7CisJCSAgICBzeW0tPm5zLCBzeW0tPnR5
cGUpOwogCX0KIAlpZiAoIXN5bS0+a2luZCkKIAkJc3ltLT5raW5kID0gJ3YnOwpAQCAtMTU5LDcg
KzE1OSw3IEBAIHN0YXRpYyB2b2lkIGV4YW1pbmVfbmFtZXNwYWNlKHN0cnVjdCBzeW1ib2wgKnN5
bSkKIAlpZiAoc3ltLT5pZGVudCAmJiBzeW0tPmlkZW50LT5yZXNlcnZlZCkKIAkJcmV0dXJuOwog
Ci0Jc3dpdGNoKHN5bS0+bmFtZXNwYWNlKSB7CisJc3dpdGNoKHN5bS0+bnMpIHsKIAljYXNlIE5T
X0tFWVdPUkQ6CiAJY2FzZSBOU19QUkVQUk9DRVNTT1I6CiAJCXJldHVybjsKQEAgLTE3Nyw3ICsx
NzcsNyBAQCBzdGF0aWMgdm9pZCBleGFtaW5lX25hbWVzcGFjZShzdHJ1Y3Qgc3ltYm9sICpzeW0p
CiAJCWV4YW1pbmVfc3ltYm9sKHN5bSk7CiAJCWJyZWFrOwogCWRlZmF1bHQ6Ci0JCWRpZSgidW5r
bm93biBuYW1lc3BhY2UgJWQgc3ltYm9sOiVzIHR5cGU6JWRcbiIsIHN5bS0+bmFtZXNwYWNlLAor
CQlkaWUoInVua25vd24gbmFtZXNwYWNlICVkIHN5bWJvbDolcyB0eXBlOiVkXG4iLCBzeW0tPm5z
LAogCQkgICAgc2hvd19pZGVudChzeW0tPmlkZW50KSwgc3ltLT50eXBlKTsKIAl9CiAJYWRkX3Rh
ZyhzeW0pOwpkaWZmIC0tZ2l0IGEvZXhwcmVzc2lvbi5jIGIvZXhwcmVzc2lvbi5jCmluZGV4IDdl
MDZlNjAuLmUwMmY1YjAgMTAwNjQ0Ci0tLSBhL2V4cHJlc3Npb24uYworKysgYi9leHByZXNzaW9u
LmMKQEAgLTExOCw3ICsxMTgsNyBAQCBzdGF0aWMgc3RydWN0IHRva2VuICpwYXJzZV90eXBlKHN0
cnVjdCB0b2tlbiAqdG9rZW4sIHN0cnVjdCBleHByZXNzaW9uICoqdHJlZSkKIAlzdHJ1Y3Qgc3lt
Ym9sICpzeW07CiAJKnRyZWUgPSBhbGxvY19leHByZXNzaW9uKHRva2VuLT5wb3MsIEVYUFJfVFlQ
RSk7CiAJKCp0cmVlKS0+ZmxhZ3MgPSBJbnRfY29uc3RfZXhwcjsgLyogc2ljICovCi0JdG9rZW4g
PSB0eXBlbmFtZSh0b2tlbiwgJnN5bSwgTlVMTCk7CisJdG9rZW4gPSB0eXBlX25hbWUodG9rZW4s
ICZzeW0sIE5VTEwpOwogCWlmIChzeW0tPmlkZW50KQogCQlzcGFyc2VfZXJyb3IodG9rZW4tPnBv
cywKIAkJCSAgICAgInR5cGUgZXhwcmVzc2lvbiBzaG91bGQgbm90IGluY2x1ZGUgaWRlbnRpZmll
ciAiCkBAIC0xNjcsNyArMTY3LDcgQEAgc3RhdGljIHN0cnVjdCB0b2tlbiAqYnVpbHRpbl9vZmZz
ZXRvZl9leHByKHN0cnVjdCB0b2tlbiAqdG9rZW4sCiAJCXJldHVybiBleHBlY3QodG9rZW4sICco
JywgImFmdGVyIF9fYnVpbHRpbl9vZmZzZXQiKTsKIAogCXRva2VuID0gdG9rZW4tPm5leHQ7Ci0J
dG9rZW4gPSB0eXBlbmFtZSh0b2tlbiwgJnN5bSwgTlVMTCk7CisJdG9rZW4gPSB0eXBlX25hbWUo
dG9rZW4sICZzeW0sIE5VTEwpOwogCWlmIChzeW0tPmlkZW50KQogCQlzcGFyc2VfZXJyb3IodG9r
ZW4tPnBvcywKIAkJCSAgICAgInR5cGUgZXhwcmVzc2lvbiBzaG91bGQgbm90IGluY2x1ZGUgaWRl
bnRpZmllciAiCkBAIC00NTUsNyArNDU1LDcgQEAgc3RydWN0IHRva2VuICpwcmltYXJ5X2V4cHJl
c3Npb24oc3RydWN0IHRva2VuICp0b2tlbiwgc3RydWN0IGV4cHJlc3Npb24gKip0cmVlKQogCQkg
KgogCQkgKglpZiAodHlwZW9mKGEpID09IGludCkgLi4KIAkJICovCi0JCWlmIChzeW0gJiYgc3lt
LT5uYW1lc3BhY2UgPT0gTlNfVFlQRURFRikgeworCQlpZiAoc3ltICYmIHN5bS0+bnMgPT0gTlNf
VFlQRURFRikgewogCQkJc3BhcnNlX2Vycm9yKHRva2VuLT5wb3MsICJ0eXBlbmFtZSBpbiBleHBy
ZXNzaW9uIik7CiAJCQlzeW0gPSBOVUxMOwogCQl9CkBAIC00ODYsNyArNDg2LDcgQEAgc3RydWN0
IHRva2VuICpwcmltYXJ5X2V4cHJlc3Npb24oc3RydWN0IHRva2VuICp0b2tlbiwgc3RydWN0IGV4
cHJlc3Npb24gKip0cmVlKQogCQlpZiAodG9rZW4tPnNwZWNpYWwgPT0gJ1snICYmIGxvb2t1cF90
eXBlKHRva2VuLT5uZXh0KSkgewogCQkJZXhwciA9IGFsbG9jX2V4cHJlc3Npb24odG9rZW4tPnBv
cywgRVhQUl9UWVBFKTsKIAkJCWV4cHItPmZsYWdzID0gSW50X2NvbnN0X2V4cHI7IC8qIHNpYyAq
LwotCQkJdG9rZW4gPSB0eXBlbmFtZSh0b2tlbi0+bmV4dCwgJmV4cHItPnN5bWJvbCwgTlVMTCk7
CisJCQl0b2tlbiA9IHR5cGVfbmFtZSh0b2tlbi0+bmV4dCwgJmV4cHItPnN5bWJvbCwgTlVMTCk7
CiAJCQl0b2tlbiA9IGV4cGVjdCh0b2tlbiwgJ10nLCAiaW4gdHlwZSBleHByZXNzaW9uIik7CiAJ
CQlicmVhazsKIAkJfQpAQCAtNjA2LDcgKzYwNiw3IEBAIHN0YXRpYyBzdHJ1Y3QgdG9rZW4gKnR5
cGVfaW5mb19leHByZXNzaW9uKHN0cnVjdCB0b2tlbiAqdG9rZW4sCiAJaWYgKCFtYXRjaF9vcCh0
b2tlbiwgJygnKSB8fCAhbG9va3VwX3R5cGUodG9rZW4tPm5leHQpKQogCQlyZXR1cm4gdW5hcnlf
ZXhwcmVzc2lvbih0b2tlbiwgJmV4cHItPmNhc3RfZXhwcmVzc2lvbik7CiAJcCA9IHRva2VuOwot
CXRva2VuID0gdHlwZW5hbWUodG9rZW4tPm5leHQsICZleHByLT5jYXN0X3R5cGUsIE5VTEwpOwor
CXRva2VuID0gdHlwZV9uYW1lKHRva2VuLT5uZXh0LCAmZXhwci0+Y2FzdF90eXBlLCBOVUxMKTsK
IAogCWlmICghbWF0Y2hfb3AodG9rZW4sICcpJykpIHsKIAkJc3RhdGljIGNvbnN0IGNoYXIgKiBl
cnJvcltdID0gewpAQCAtNzMxLDcgKzczMSw3IEBAIHN0YXRpYyBzdHJ1Y3QgdG9rZW4gKmNhc3Rf
ZXhwcmVzc2lvbihzdHJ1Y3QgdG9rZW4gKnRva2VuLCBzdHJ1Y3QgZXhwcmVzc2lvbiAqKnRyCiAJ
CQlzdHJ1Y3Qgc3ltYm9sICpzeW07CiAJCQlpbnQgaXNfZm9yY2U7CiAKLQkJCXRva2VuID0gdHlw
ZW5hbWUobmV4dCwgJnN5bSwgJmlzX2ZvcmNlKTsKKwkJCXRva2VuID0gdHlwZV9uYW1lKG5leHQs
ICZzeW0sICZpc19mb3JjZSk7CiAJCQljYXN0LT5jYXN0X3R5cGUgPSBzeW07CiAJCQl0b2tlbiA9
IGV4cGVjdCh0b2tlbiwgJyknLCAiYXQgZW5kIG9mIGNhc3Qgb3BlcmF0b3IiKTsKIAkJCWlmICht
YXRjaF9vcCh0b2tlbiwgJ3snKSkgewpkaWZmIC0tZ2l0IGEvZXhwcmVzc2lvbi5oIGIvZXhwcmVz
c2lvbi5oCmluZGV4IDk3NzhkZTguLjY5OGM3NzggMTAwNjQ0Ci0tLSBhL2V4cHJlc3Npb24uaAor
KysgYi9leHByZXNzaW9uLmgKQEAgLTE5NiwxMyArMTk2LDEzIEBAIHN0YXRpYyBpbmxpbmUgc3Ry
dWN0IGV4cHJlc3Npb24gKmFsbG9jX2NvbnN0X2V4cHJlc3Npb24oc3RydWN0IHBvc2l0aW9uIHBv
cywgaW50CiB9CiAKIC8qIFR5cGUgbmFtZSBwYXJzaW5nICovCi1zdHJ1Y3QgdG9rZW4gKnR5cGVu
YW1lKHN0cnVjdCB0b2tlbiAqLCBzdHJ1Y3Qgc3ltYm9sICoqLCBpbnQgKik7CitzdHJ1Y3QgdG9r
ZW4gKnR5cGVfbmFtZShzdHJ1Y3QgdG9rZW4gKiwgc3RydWN0IHN5bWJvbCAqKiwgaW50ICopOwog
CiBzdGF0aWMgaW5saW5lIGludCBsb29rdXBfdHlwZShzdHJ1Y3QgdG9rZW4gKnRva2VuKQogewog
CWlmICh0b2tlbi0+cG9zLnR5cGUgPT0gVE9LRU5fSURFTlQpIHsKLQkJc3RydWN0IHN5bWJvbCAq
c3ltID0gbG9va3VwX3N5bWJvbCh0b2tlbi0+aWRlbnQsIE5TX1NZTUJPTCB8IE5TX1RZUEVERUYp
OwotCQlyZXR1cm4gc3ltICYmIChzeW0tPm5hbWVzcGFjZSAmIE5TX1RZUEVERUYpOworCQlzdHJ1
Y3Qgc3ltYm9sICpzeW0gPSBsb29rdXBfc3ltYm9sKHRva2VuLT5pZGVudCwgTlNfU1lNQk9MX09S
X1RZUEVERUYpOworCQlyZXR1cm4gc3ltICYmIChzeW0tPm5zICYgTlNfVFlQRURFRik7CiAJfQog
CXJldHVybiAwOwogfQpkaWZmIC0tZ2l0IGEvZ3JhcGguYyBiL2dyYXBoLmMKaW5kZXggMWE3N2Q3
NS4uN2UwODY4ZiAxMDA2NDQKLS0tIGEvZ3JhcGguYworKysgYi9ncmFwaC5jCkBAIC0xMjQsNyAr
MTI0LDcgQEAgc3RhdGljIHZvaWQgZ3JhcGhfY2FsbHMoc3RydWN0IGVudHJ5cG9pbnQgKmVwLCBp
bnQgaW50ZXJuYWwpCiAJCQkJaWYgKGluc24tPmZ1bmMtPnR5cGUgPT0gUFNFVURPX1NZTSkgewog
CQkJCQlmb3IgKHN5bSA9IGluc24tPmZ1bmMtPnN5bS0+aWRlbnQtPnN5bWJvbHM7CiAJCQkJCSAg
ICAgc3ltOyBzeW0gPSBzeW0tPm5leHRfaWQpIHsKLQkJCQkJCWlmIChzeW0tPm5hbWVzcGFjZSAm
IE5TX1NZTUJPTCAmJiBzeW0tPmVwKQorCQkJCQkJaWYgKHN5bS0+bnMgJiBOU19TWU1CT0wgJiYg
c3ltLT5lcCkKIAkJCQkJCQlicmVhazsKIAkJCQkJfQogCmRpZmYgLS1naXQgYS9saWIuaCBiL2xp
Yi5oCmluZGV4IDJjZWEyNTIuLjZkMjRmYzggMTAwNjQ0Ci0tLSBhL2xpYi5oCisrKyBiL2xpYi5o
CkBAIC0xNjQsMzEgKzE2NCwzMiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgZnJlZV9pbnN0cnVjdGlv
bl9saXN0KHN0cnVjdCBpbnN0cnVjdGlvbl9saXN0ICoqaGVhZCkKIAogc3RhdGljIGlubGluZSBz
dHJ1Y3QgaW5zdHJ1Y3Rpb24gKiBkZWxldGVfbGFzdF9pbnN0cnVjdGlvbihzdHJ1Y3QgaW5zdHJ1
Y3Rpb25fbGlzdCAqKmhlYWQpCiB7Ci0JcmV0dXJuIHVuZG9fcHRyX2xpc3RfbGFzdCgoc3RydWN0
IHB0cl9saXN0ICoqKWhlYWQpOworCXJldHVybiAoc3RydWN0IGluc3RydWN0aW9uICopdW5kb19w
dHJfbGlzdF9sYXN0KChzdHJ1Y3QgcHRyX2xpc3QgKiopaGVhZCk7CiB9CiAKIHN0YXRpYyBpbmxp
bmUgc3RydWN0IGJhc2ljX2Jsb2NrICogZGVsZXRlX2xhc3RfYmFzaWNfYmxvY2soc3RydWN0IGJh
c2ljX2Jsb2NrX2xpc3QgKipoZWFkKQogewotCXJldHVybiBkZWxldGVfcHRyX2xpc3RfbGFzdCgo
c3RydWN0IHB0cl9saXN0ICoqKWhlYWQpOworCXJldHVybiAoc3RydWN0IGJhc2ljX2Jsb2NrICop
ZGVsZXRlX3B0cl9saXN0X2xhc3QoKHN0cnVjdCBwdHJfbGlzdCAqKiloZWFkKTsKIH0KIAogc3Rh
dGljIGlubGluZSBzdHJ1Y3QgYmFzaWNfYmxvY2sgKmZpcnN0X2Jhc2ljX2Jsb2NrKHN0cnVjdCBi
YXNpY19ibG9ja19saXN0ICpoZWFkKQogewotCXJldHVybiBmaXJzdF9wdHJfbGlzdCgoc3RydWN0
IHB0cl9saXN0ICopaGVhZCk7CisJcmV0dXJuIChzdHJ1Y3QgYmFzaWNfYmxvY2sgKilmaXJzdF9w
dHJfbGlzdCgoc3RydWN0IHB0cl9saXN0ICopaGVhZCk7CiB9CisKIHN0YXRpYyBpbmxpbmUgc3Ry
dWN0IGluc3RydWN0aW9uICpsYXN0X2luc3RydWN0aW9uKHN0cnVjdCBpbnN0cnVjdGlvbl9saXN0
ICpoZWFkKQogewotCXJldHVybiBsYXN0X3B0cl9saXN0KChzdHJ1Y3QgcHRyX2xpc3QgKiloZWFk
KTsKKwlyZXR1cm4gKHN0cnVjdCBpbnN0cnVjdGlvbiAqKWxhc3RfcHRyX2xpc3QoKHN0cnVjdCBw
dHJfbGlzdCAqKWhlYWQpOwogfQogCiBzdGF0aWMgaW5saW5lIHN0cnVjdCBpbnN0cnVjdGlvbiAq
Zmlyc3RfaW5zdHJ1Y3Rpb24oc3RydWN0IGluc3RydWN0aW9uX2xpc3QgKmhlYWQpCiB7Ci0JcmV0
dXJuIGZpcnN0X3B0cl9saXN0KChzdHJ1Y3QgcHRyX2xpc3QgKiloZWFkKTsKKwlyZXR1cm4gKHN0
cnVjdCBpbnN0cnVjdGlvbiAqKWZpcnN0X3B0cl9saXN0KChzdHJ1Y3QgcHRyX2xpc3QgKiloZWFk
KTsKIH0KIAogc3RhdGljIGlubGluZSBwc2V1ZG9fdCBmaXJzdF9wc2V1ZG8oc3RydWN0IHBzZXVk
b19saXN0ICpoZWFkKQogewotCXJldHVybiBmaXJzdF9wdHJfbGlzdCgoc3RydWN0IHB0cl9saXN0
ICopaGVhZCk7CisJcmV0dXJuIChwc2V1ZG9fdClmaXJzdF9wdHJfbGlzdCgoc3RydWN0IHB0cl9s
aXN0ICopaGVhZCk7CiB9CiAKIHN0YXRpYyBpbmxpbmUgdm9pZCBjb25jYXRfc3ltYm9sX2xpc3Qo
c3RydWN0IHN5bWJvbF9saXN0ICpmcm9tLCBzdHJ1Y3Qgc3ltYm9sX2xpc3QgKip0bykKZGlmZiAt
LWdpdCBhL2xpbmVhcml6ZS5oIGIvbGluZWFyaXplLmgKaW5kZXggNTBiMzYwMS4uYTZkNjI5ZiAx
MDA2NDQKLS0tIGEvbGluZWFyaXplLmgKKysrIGIvbGluZWFyaXplLmgKQEAgLTMxNCw5ICszMTQs
OSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgcmVtb3ZlX2JiX2Zyb21fbGlzdChzdHJ1Y3QgYmFzaWNf
YmxvY2tfbGlzdCAqKmxpc3QsIHN0cnVjdCBiYQogfQogCiBzdGF0aWMgaW5saW5lIHZvaWQgcmVw
bGFjZV9iYl9pbl9saXN0KHN0cnVjdCBiYXNpY19ibG9ja19saXN0ICoqbGlzdCwKLQlzdHJ1Y3Qg
YmFzaWNfYmxvY2sgKm9sZCwgc3RydWN0IGJhc2ljX2Jsb2NrICpuZXcsIGludCBjb3VudCkKKwlz
dHJ1Y3QgYmFzaWNfYmxvY2sgKm9sZCwgc3RydWN0IGJhc2ljX2Jsb2NrICpuZXdsaXN0LCBpbnQg
Y291bnQpCiB7Ci0JcmVwbGFjZV9wdHJfbGlzdF9lbnRyeSgoc3RydWN0IHB0cl9saXN0ICoqKWxp
c3QsIG9sZCwgbmV3LCBjb3VudCk7CisJcmVwbGFjZV9wdHJfbGlzdF9lbnRyeSgoc3RydWN0IHB0
cl9saXN0ICoqKWxpc3QsIG9sZCwgbmV3bGlzdCwgY291bnQpOwogfQogCiBzdHJ1Y3QgZW50cnlw
b2ludCB7CmRpZmYgLS1naXQgYS9wYXJzZS5jIGIvcGFyc2UuYwppbmRleCA1MzcwNTVmLi4wZjZm
YzRiIDEwMDY0NAotLS0gYS9wYXJzZS5jCisrKyBiL3BhcnNlLmMKQEAgLTE4OCw3ICsxODgsNyBA
QCBzdGF0aWMgc3RydWN0IHN5bWJvbF9vcCBjaGFyX29wID0gewogCS50eXBlID0gS1dfU1BFQ0lG
SUVSLAogCS50ZXN0ID0gU2V0X1R8U2V0X0xvbmd8U2V0X1Nob3J0LAogCS5zZXQgPSBTZXRfVHxT
ZXRfQ2hhciwKLQkuY2xhc3MgPSBDQ2hhciwKKwkua2xhc3MgPSBDQ2hhciwKIH07CiAKIHN0YXRp
YyBzdHJ1Y3Qgc3ltYm9sX29wIGludF9vcCA9IHsKQEAgLTIwMSwxNCArMjAxLDE0IEBAIHN0YXRp
YyBzdHJ1Y3Qgc3ltYm9sX29wIGRvdWJsZV9vcCA9IHsKIAkudHlwZSA9IEtXX1NQRUNJRklFUiwK
IAkudGVzdCA9IFNldF9UfFNldF9TaWduZWR8U2V0X1Vuc2lnbmVkfFNldF9TaG9ydHxTZXRfVmxv
bmcsCiAJLnNldCA9IFNldF9UfFNldF9Eb3VibGUsCi0JLmNsYXNzID0gQ1JlYWwsCisJLmtsYXNz
ID0gQ1JlYWwsCiB9OwogCiBzdGF0aWMgc3RydWN0IHN5bWJvbF9vcCBmbG9hdF9vcCA9IHsKIAku
dHlwZSA9IEtXX1NQRUNJRklFUiB8IEtXX1NIT1JULAogCS50ZXN0ID0gU2V0X1R8U2V0X1NpZ25l
ZHxTZXRfVW5zaWduZWR8U2V0X1Nob3J0fFNldF9Mb25nLAogCS5zZXQgPSBTZXRfVHxTZXRfRmxv
YXQsCi0JLmNsYXNzID0gQ1JlYWwsCisJLmtsYXNzID0gQ1JlYWwsCiB9OwogCiBzdGF0aWMgc3Ry
dWN0IHN5bWJvbF9vcCBzaG9ydF9vcCA9IHsKQEAgLTIyMSwxNCArMjIxLDE0IEBAIHN0YXRpYyBz
dHJ1Y3Qgc3ltYm9sX29wIHNpZ25lZF9vcCA9IHsKIAkudHlwZSA9IEtXX1NQRUNJRklFUiwKIAku
dGVzdCA9IFNldF9TfFNldF9GbG9hdHxTZXRfRG91YmxlfFNldF9TaWduZWR8U2V0X1Vuc2lnbmVk
LAogCS5zZXQgPSBTZXRfU2lnbmVkLAotCS5jbGFzcyA9IENTSW50LAorCS5rbGFzcyA9IENTSW50
LAogfTsKIAogc3RhdGljIHN0cnVjdCBzeW1ib2xfb3AgdW5zaWduZWRfb3AgPSB7CiAJLnR5cGUg
PSBLV19TUEVDSUZJRVIsCiAJLnRlc3QgPSBTZXRfU3xTZXRfRmxvYXR8U2V0X0RvdWJsZXxTZXRf
U2lnbmVkfFNldF9VbnNpZ25lZCwKIAkuc2V0ID0gU2V0X1Vuc2lnbmVkLAotCS5jbGFzcyA9IENV
SW50LAorCS5rbGFzcyA9IENVSW50LAogfTsKIAogc3RhdGljIHN0cnVjdCBzeW1ib2xfb3AgbG9u
Z19vcCA9IHsKQEAgLTM2NCw3ICszNjQsNyBAQCBzdGF0aWMgc3RydWN0IHN5bWJvbF9vcCBtb2Rl
X3dvcmRfb3AgPSB7CiAKIHN0YXRpYyBzdHJ1Y3QgaW5pdF9rZXl3b3JkIHsKIAljb25zdCBjaGFy
ICpuYW1lOwotCWVudW0gbmFtZXNwYWNlIG5zOworCWVudW0gbmFtZV9zcGFjZSBuczsKIAl1bnNp
Z25lZCBsb25nIG1vZGlmaWVyczsKIAlzdHJ1Y3Qgc3ltYm9sX29wICpvcDsKIAlzdHJ1Y3Qgc3lt
Ym9sICp0eXBlOwpAQCAtOTc5LDcgKzk3OSw3IEBAIHN0YXRpYyBzdHJ1Y3QgdG9rZW4gKnR5cGVv
Zl9zcGVjaWZpZXIoc3RydWN0IHRva2VuICp0b2tlbiwgc3RydWN0IGRlY2xfc3RhdGUgKmN0CiAJ
CXJldHVybiB0b2tlbjsKIAl9CiAJaWYgKGxvb2t1cF90eXBlKHRva2VuLT5uZXh0KSkgewotCQl0
b2tlbiA9IHR5cGVuYW1lKHRva2VuLT5uZXh0LCAmc3ltLCBOVUxMKTsKKwkJdG9rZW4gPSB0eXBl
X25hbWUodG9rZW4tPm5leHQsICZzeW0sIE5VTEwpOwogCQljdHgtPmN0eXBlLmJhc2VfdHlwZSA9
IHN5bS0+Y3R5cGUuYmFzZV90eXBlOwogCQlhcHBseV9jdHlwZSh0b2tlbi0+cG9zLCAmc3ltLT5j
dHlwZSwgJmN0eC0+Y3R5cGUpOwogCX0gZWxzZSB7CkBAIC0xNDMzLDcgKzE0MzMsNyBAQCBzdGF0
aWMgc3RydWN0IHRva2VuICpkZWNsYXJhdGlvbl9zcGVjaWZpZXJzKHN0cnVjdCB0b2tlbiAqdG9r
ZW4sIHN0cnVjdCBkZWNsX3N0YQogCXdoaWxlICh0b2tlbl90eXBlKHRva2VuKSA9PSBUT0tFTl9J
REVOVCkgewogCQlzdHJ1Y3Qgc3ltYm9sICpzID0gbG9va3VwX3N5bWJvbCh0b2tlbi0+aWRlbnQs
CiAJCQkJCQkgTlNfVFlQRURFRiB8IE5TX1NZTUJPTCk7Ci0JCWlmICghcyB8fCAhKHMtPm5hbWVz
cGFjZSAmIE5TX1RZUEVERUYpKQorCQlpZiAoIXMgfHwgIShzLT5ucyAmIE5TX1RZUEVERUYpKQog
CQkJYnJlYWs7CiAJCWlmIChzLT50eXBlICE9IFNZTV9LRVlXT1JEKSB7CiAJCQlpZiAoc2VlbiAm
IFNldF9BbnkpCkBAIC0xNDUyLDcgKzE0NTIsNyBAQCBzdGF0aWMgc3RydWN0IHRva2VuICpkZWNs
YXJhdGlvbl9zcGVjaWZpZXJzKHN0cnVjdCB0b2tlbiAqdG9rZW4sIHN0cnVjdCBkZWNsX3N0YQog
CQkJCWJyZWFrOwogCQkJfQogCQkJc2VlbiB8PSBzLT5vcC0+c2V0OwotCQkJY2xhc3MgKz0gcy0+
b3AtPmNsYXNzOworCQkJY2xhc3MgKz0gcy0+b3AtPmtsYXNzOwogCQkJaWYgKHMtPm9wLT50eXBl
ICYgS1dfU0hPUlQpIHsKIAkJCQlzaXplID0gLTE7CiAJCQl9IGVsc2UgaWYgKHMtPm9wLT50eXBl
ICYgS1dfTE9ORyAmJiBzaXplKyspIHsKQEAgLTE4MzEsNyArMTgzMSw3IEBAIHN0YXRpYyBzdHJ1
Y3QgdG9rZW4gKnBhcmFtZXRlcl9kZWNsYXJhdGlvbihzdHJ1Y3QgdG9rZW4gKnRva2VuLCBzdHJ1
Y3Qgc3ltYm9sICpzCiAJcmV0dXJuIHRva2VuOwogfQogCi1zdHJ1Y3QgdG9rZW4gKnR5cGVuYW1l
KHN0cnVjdCB0b2tlbiAqdG9rZW4sIHN0cnVjdCBzeW1ib2wgKipwLCBpbnQgKmZvcmNlZCkKK3N0
cnVjdCB0b2tlbiAqdHlwZV9uYW1lKHN0cnVjdCB0b2tlbiAqdG9rZW4sIHN0cnVjdCBzeW1ib2wg
KipwLCBpbnQgKmZvcmNlZCkKIHsKIAlzdHJ1Y3QgZGVjbF9zdGF0ZSBjdHggPSB7LnByZWZlcl9h
YnN0cmFjdCA9IDF9OwogCWludCBjbGFzczsKQEAgLTIyOTUsNyArMjI5NSw3IEBAIHN0YXRpYyBz
dHJ1Y3QgdG9rZW4gKmxhYmVsX3N0YXRlbWVudChzdHJ1Y3QgdG9rZW4gKnRva2VuKQogCQlzdHJ1
Y3Qgc3ltYm9sICpzeW0gPSBhbGxvY19zeW1ib2wodG9rZW4tPnBvcywgU1lNX0xBQkVMKTsKIAkJ
LyogaXQncyBibG9jay1zY29wZSwgYnV0IHdlIHdhbnQgbGFiZWwgbmFtZXNwYWNlICovCiAJCWJp
bmRfc3ltYm9sKHN5bSwgdG9rZW4tPmlkZW50LCBOU19TWU1CT0wpOwotCQlzeW0tPm5hbWVzcGFj
ZSA9IE5TX0xBQkVMOworCQlzeW0tPm5zID0gTlNfTEFCRUw7CiAJCWZuX2xvY2FsX3N5bWJvbChz
eW0pOwogCQl0b2tlbiA9IHRva2VuLT5uZXh0OwogCQlpZiAoIW1hdGNoX29wKHRva2VuLCAnLCcp
KQpkaWZmIC0tZ2l0IGEvcGFyc2UuaCBiL3BhcnNlLmgKaW5kZXggNmIyMWUyMy4uYjI2YmQwMyAx
MDA2NDQKLS0tIGEvcGFyc2UuaAorKysgYi9wYXJzZS5oCkBAIC0zNSwxMCArMzUsNiBAQCBzdHJ1
Y3Qgc3RhdGVtZW50IHsKIAkJc3RydWN0IC8qIGRlY2xhcmF0aW9uICovIHsKIAkJCXN0cnVjdCBz
eW1ib2xfbGlzdCAqZGVjbGFyYXRpb247CiAJCX07Ci0JCXN0cnVjdCAvKiBsYWJlbF9hcmcgKi8g
ewotCQkJc3RydWN0IHN5bWJvbCAqbGFiZWw7Ci0JCQlzdHJ1Y3Qgc3RhdGVtZW50ICpsYWJlbF9z
dGF0ZW1lbnQ7Ci0JCX07CiAJCXN0cnVjdCB7CiAJCQlzdHJ1Y3QgZXhwcmVzc2lvbiAqZXhwcmVz
c2lvbjsKIAkJCXN0cnVjdCBleHByZXNzaW9uICpjb250ZXh0OwpkaWZmIC0tZ2l0IGEvcHJlLXBy
b2Nlc3MuYyBiL3ByZS1wcm9jZXNzLmMKaW5kZXggNjU2YWNhYS4uYjczNzFmMyAxMDA2NDQKLS0t
IGEvcHJlLXByb2Nlc3MuYworKysgYi9wcmUtcHJvY2Vzcy5jCkBAIC0xMDksNyArMTA5LDcgQEAg
c3RhdGljIHZvaWQgcmVwbGFjZV93aXRoX2ludGVnZXIoc3RydWN0IHRva2VuICp0b2tlbiwgdW5z
aWduZWQgaW50IHZhbCkKIHN0YXRpYyBzdHJ1Y3Qgc3ltYm9sICpsb29rdXBfbWFjcm8oc3RydWN0
IGlkZW50ICppZGVudCkKIHsKIAlzdHJ1Y3Qgc3ltYm9sICpzeW0gPSBsb29rdXBfc3ltYm9sKGlk
ZW50LCBOU19NQUNSTyB8IE5TX1VOREVGKTsKLQlpZiAoc3ltICYmIHN5bS0+bmFtZXNwYWNlICE9
IE5TX01BQ1JPKQorCWlmIChzeW0gJiYgc3ltLT5ucyAhPSBOU19NQUNSTykKIAkJc3ltID0gTlVM
TDsKIAlyZXR1cm4gc3ltOwogfQpAQCAtMTE0Niw3ICsxMTQ2LDcgQEAgc3RhdGljIGludCBkb19o
YW5kbGVfZGVmaW5lKHN0cnVjdCBzdHJlYW0gKnN0cmVhbSwgc3RydWN0IHRva2VuICoqbGluZSwg
c3RydWN0IHQKIAkJaWYgKGF0dHIgPCBzeW0tPmF0dHIpCiAJCQlnb3RvIG91dDsKIAotCQljbGVh
biA9IChhdHRyID09IHN5bS0+YXR0ciAmJiBzeW0tPm5hbWVzcGFjZSA9PSBOU19NQUNSTyk7CisJ
CWNsZWFuID0gKGF0dHIgPT0gc3ltLT5hdHRyICYmIHN5bS0+bnMgPT0gTlNfTUFDUk8pOwogCiAJ
CWlmICh0b2tlbl9saXN0X2RpZmZlcmVudChzeW0tPmV4cGFuc2lvbiwgZXhwYW5zaW9uKSB8fAog
CQkgICAgdG9rZW5fbGlzdF9kaWZmZXJlbnQoc3ltLT5hcmdsaXN0LCBhcmdsaXN0KSkgewpAQCAt
MTE3Myw3ICsxMTczLDcgQEAgc3RhdGljIGludCBkb19oYW5kbGVfZGVmaW5lKHN0cnVjdCBzdHJl
YW0gKnN0cmVhbSwgc3RydWN0IHRva2VuICoqbGluZSwgc3RydWN0IHQKIAkJX19mcmVlX3Rva2Vu
KHRva2VuKTsJLyogRnJlZSB0aGUgImRlZmluZSIgdG9rZW4sIGJ1dCBub3QgdGhlIHJlc3Qgb2Yg
dGhlIGxpbmUgKi8KIAl9CiAKLQlzeW0tPm5hbWVzcGFjZSA9IE5TX01BQ1JPOworCXN5bS0+bnMg
PSBOU19NQUNSTzsKIAlzeW0tPnVzZWRfaW4gPSBOVUxMOwogCXN5bS0+YXR0ciA9IGF0dHI7CiBv
dXQ6CkBAIC0xMjA5LDcgKzEyMDksNyBAQCBzdGF0aWMgaW50IGRvX2hhbmRsZV91bmRlZihzdHJ1
Y3Qgc3RyZWFtICpzdHJlYW0sIHN0cnVjdCB0b2tlbiAqKmxpbmUsIHN0cnVjdCB0bwogCWlmIChz
eW0pIHsKIAkJaWYgKGF0dHIgPCBzeW0tPmF0dHIpCiAJCQlyZXR1cm4gMTsKLQkJaWYgKGF0dHIg
PT0gc3ltLT5hdHRyICYmIHN5bS0+bmFtZXNwYWNlID09IE5TX1VOREVGKQorCQlpZiAoYXR0ciA9
PSBzeW0tPmF0dHIgJiYgc3ltLT5ucyA9PSBOU19VTkRFRikKIAkJCXJldHVybiAxOwogCX0gZWxz
ZSBpZiAoYXR0ciA8PSBTWU1fQVRUUl9OT1JNQUwpCiAJCXJldHVybiAxOwpAQCAtMTIxOSw3ICsx
MjE5LDcgQEAgc3RhdGljIGludCBkb19oYW5kbGVfdW5kZWYoc3RydWN0IHN0cmVhbSAqc3RyZWFt
LCBzdHJ1Y3QgdG9rZW4gKipsaW5lLCBzdHJ1Y3QgdG8KIAkJYmluZF9zeW1ib2woc3ltLCBsZWZ0
LT5pZGVudCwgTlNfTUFDUk8pOwogCX0KIAotCXN5bS0+bmFtZXNwYWNlID0gTlNfVU5ERUY7CisJ
c3ltLT5ucyA9IE5TX1VOREVGOwogCXN5bS0+dXNlZF9pbiA9IE5VTEw7CiAJc3ltLT5hdHRyID0g
YXR0cjsKIApkaWZmIC0tZ2l0IGEvcHRybGlzdC5oIGIvcHRybGlzdC5oCmluZGV4IGZiZmMwODAu
LmI4ODRlNGQgMTAwNjQ0Ci0tLSBhL3B0cmxpc3QuaAorKysgYi9wdHJsaXN0LmgKQEAgLTM5LDcg
KzM5LDcgQEAgc3RydWN0IHB0cl9saXN0IHsKIHZvaWQgKiB1bmRvX3B0cl9saXN0X2xhc3Qoc3Ry
dWN0IHB0cl9saXN0ICoqaGVhZCk7CiB2b2lkICogZGVsZXRlX3B0cl9saXN0X2xhc3Qoc3RydWN0
IHB0cl9saXN0ICoqaGVhZCk7CiBpbnQgZGVsZXRlX3B0cl9saXN0X2VudHJ5KHN0cnVjdCBwdHJf
bGlzdCAqKiwgdm9pZCAqLCBpbnQpOwotaW50IHJlcGxhY2VfcHRyX2xpc3RfZW50cnkoc3RydWN0
IHB0cl9saXN0ICoqLCB2b2lkICpvbGQsIHZvaWQgKm5ldywgaW50KTsKK2ludCByZXBsYWNlX3B0
cl9saXN0X2VudHJ5KHN0cnVjdCBwdHJfbGlzdCAqKiwgdm9pZCAqb2xkLCB2b2lkICpuZXdsaXN0
LCBpbnQpOwogZXh0ZXJuIHZvaWQgc29ydF9saXN0KHN0cnVjdCBwdHJfbGlzdCAqKiwgaW50ICgq
KShjb25zdCB2b2lkICosIGNvbnN0IHZvaWQgKikpOwogCiBleHRlcm4gdm9pZCAqKl9fYWRkX3B0
cl9saXN0KHN0cnVjdCBwdHJfbGlzdCAqKiwgdm9pZCAqLCB1bnNpZ25lZCBsb25nKTsKQEAgLTI3
MCw3ICsyNzAsNyBAQCBleHRlcm4gdm9pZCBwYWNrX3B0cl9saXN0KHN0cnVjdCBwdHJfbGlzdCAq
Kik7CiAKIHN0YXRpYyBpbmxpbmUgdm9pZCB1cGRhdGVfdGFnKHZvaWQgKnAsIHVuc2lnbmVkIGxv
bmcgdGFnKQogewotCXVuc2lnbmVkIGxvbmcgKnB0ciA9IHA7CisJdW5zaWduZWQgbG9uZyAqcHRy
ID0gKHVuc2lnbmVkIGxvbmcgKilwOwogCSpwdHIgPSB0YWcgfCAofjNVTCAmICpwdHIpOwogfQog
CmRpZmYgLS1naXQgYS9zeW1ib2wuYyBiL3N5bWJvbC5jCmluZGV4IDk2ZGZiZmEuLmE4Y2Q5OTkg
MTAwNjQ0Ci0tLSBhL3N5bWJvbC5jCisrKyBiL3N5bWJvbC5jCkBAIC0zOSwxMiArMzksMTIgQEAg
dm9pZCBhY2Nlc3Nfc3ltYm9sKHN0cnVjdCBzeW1ib2wgKnN5bSkKIAl9CiB9CiAKLXN0cnVjdCBz
eW1ib2wgKmxvb2t1cF9zeW1ib2woc3RydWN0IGlkZW50ICppZGVudCwgZW51bSBuYW1lc3BhY2Ug
bnMpCitzdHJ1Y3Qgc3ltYm9sICpsb29rdXBfc3ltYm9sKHN0cnVjdCBpZGVudCAqaWRlbnQsIGVu
dW0gbmFtZV9zcGFjZSBucykKIHsKIAlzdHJ1Y3Qgc3ltYm9sICpzeW07CiAKIAlmb3IgKHN5bSA9
IGlkZW50LT5zeW1ib2xzOyBzeW07IHN5bSA9IHN5bS0+bmV4dF9pZCkgewotCQlpZiAoc3ltLT5u
YW1lc3BhY2UgJiBucykgeworCQlpZiAoc3ltLT5ucyAmIG5zKSB7CiAJCQlzeW0tPnVzZWQgPSAx
OwogCQkJcmV0dXJuIHN5bTsKIAkJfQpAQCAtNTE1LDcgKzUxNSw3IEBAIHZvaWQgY2hlY2tfZGVj
bGFyYXRpb24oc3RydWN0IHN5bWJvbCAqc3ltKQogCXN0cnVjdCBzeW1ib2wgKm5leHQgPSBzeW07
CiAKIAl3aGlsZSAoKG5leHQgPSBuZXh0LT5uZXh0X2lkKSAhPSBOVUxMKSB7Ci0JCWlmIChuZXh0
LT5uYW1lc3BhY2UgIT0gc3ltLT5uYW1lc3BhY2UpCisJCWlmIChuZXh0LT5ucyAhPSBzeW0tPm5z
KQogCQkJY29udGludWU7CiAJCWlmIChzeW0tPnNjb3BlID09IG5leHQtPnNjb3BlKSB7CiAJCQlz
eW0tPnNhbWVfc3ltYm9sID0gbmV4dDsKQEAgLTUzOCw3ICs1MzgsNyBAQCB2b2lkIGNoZWNrX2Rl
Y2xhcmF0aW9uKHN0cnVjdCBzeW1ib2wgKnN5bSkKIAl9CiB9CiAKLXZvaWQgYmluZF9zeW1ib2wo
c3RydWN0IHN5bWJvbCAqc3ltLCBzdHJ1Y3QgaWRlbnQgKmlkZW50LCBlbnVtIG5hbWVzcGFjZSBu
cykKK3ZvaWQgYmluZF9zeW1ib2woc3RydWN0IHN5bWJvbCAqc3ltLCBzdHJ1Y3QgaWRlbnQgKmlk
ZW50LCBlbnVtIG5hbWVfc3BhY2UgbnMpCiB7CiAJc3RydWN0IHNjb3BlICpzY29wZTsKIAlpZiAo
c3ltLT5ib3VuZCkgewpAQCAtNTQ5LDcgKzU0OSw3IEBAIHZvaWQgYmluZF9zeW1ib2woc3RydWN0
IHN5bWJvbCAqc3ltLCBzdHJ1Y3QgaWRlbnQgKmlkZW50LCBlbnVtIG5hbWVzcGFjZSBucykKIAkJ
c3BhcnNlX2Vycm9yKHN5bS0+cG9zLCAiVHJ5aW5nIHRvIHVzZSByZXNlcnZlZCB3b3JkICclcycg
YXMgaWRlbnRpZmllciIsIHNob3dfaWRlbnQoaWRlbnQpKTsKIAkJcmV0dXJuOwogCX0KLQlzeW0t
Pm5hbWVzcGFjZSA9IG5zOworCXN5bS0+bnMgPSBuczsKIAlzeW0tPm5leHRfaWQgPSBpZGVudC0+
c3ltYm9sczsKIAlpZGVudC0+c3ltYm9scyA9IHN5bTsKIAlpZiAoc3ltLT5pZGVudCAmJiBzeW0t
PmlkZW50ICE9IGlkZW50KQpkaWZmIC0tZ2l0IGEvc3ltYm9sLmggYi9zeW1ib2wuaAppbmRleCBl
NTY3MzA1Li5hNDgzMDk2IDEwMDY0NAotLS0gYS9zeW1ib2wuaAorKysgYi9zeW1ib2wuaApAQCAt
MjQsMTMgKzI0LDE0IEBACiAgKiB0b2tlbiBjb250YWlucyB0aGUgaW5mb3JtYXRpb24gb24gd2hl
cmUgdGhlIHN5bWJvbCB3YXMKICAqIGRlY2xhcmVkLgogICovCi1lbnVtIG5hbWVzcGFjZSB7Citl
bnVtIG5hbWVfc3BhY2UgewogCU5TX05PTkUgPSAwLAogCU5TX01BQ1JPID0gMSwKIAlOU19UWVBF
REVGID0gMiwKIAlOU19TVFJVQ1QgPSA0LCAgLy8gQWxzbyB1c2VkIGZvciB1bmlvbnMgYW5kIGVu
dW1zLgogCU5TX0xBQkVMID0gOCwKIAlOU19TWU1CT0wgPSAxNiwKKwlOU19TWU1CT0xfT1JfVFlQ
RURFRiA9IDE4LAogCU5TX0lURVJBVE9SID0gMzIsCiAJTlNfUFJFUFJPQ0VTU09SID0gNjQsCiAJ
TlNfVU5ERUYgPSAxMjgsCkBAIC0xMDksNyArMTEwLDcgQEAgc3RydWN0IHN5bWJvbF9vcCB7CiAJ
c3RydWN0IHRva2VuICooKmF0dHJpYnV0ZSkoc3RydWN0IHRva2VuICp0b2tlbiwgc3RydWN0IHN5
bWJvbCAqYXR0ciwgc3RydWN0IGRlY2xfc3RhdGUgKmN0eCk7CiAJc3RydWN0IHN5bWJvbCAqKCp0
b19tb2RlKShzdHJ1Y3Qgc3ltYm9sICopOwogCi0JaW50IHRlc3QsIHNldCwgY2xhc3M7CisJaW50
IHRlc3QsIHNldCwga2xhc3M7CiB9OwogCiBleHRlcm4gaW50IGV4cGFuZF9zYWZlX3Aoc3RydWN0
IGV4cHJlc3Npb24gKmV4cHIsIGludCBjb3N0KTsKQEAgLTEyMSw3ICsxMjIsNyBAQCBleHRlcm4g
aW50IGV4cGFuZF9jb25zdGFudF9wKHN0cnVjdCBleHByZXNzaW9uICpleHByLCBpbnQgY29zdCk7
CiAKIHN0cnVjdCBzeW1ib2wgewogCWVudW0gdHlwZSB0eXBlOjg7Ci0JZW51bSBuYW1lc3BhY2Ug
bmFtZXNwYWNlOjk7CisJZW51bSBuYW1lX3NwYWNlIG5zOjk7CiAJdW5zaWduZWQgY2hhciB1c2Vk
OjEsIGF0dHI6MiwgZW51bV9tZW1iZXI6MSwgYm91bmQ6MTsKIAlzdHJ1Y3QgcG9zaXRpb24gcG9z
OwkJLyogV2hlcmUgdGhpcyBzeW1ib2wgd2FzIGRlY2xhcmVkICovCiAJc3RydWN0IHBvc2l0aW9u
IGVuZHBvczsJCS8qIFdoZXJlIHRoaXMgc3ltYm9sIGVuZHMqLwpAQCAtMjY3LDggKzI2OCw4IEBA
IGV4dGVybiB2b2lkIGFjY2Vzc19zeW1ib2woc3RydWN0IHN5bWJvbCAqKTsKIGV4dGVybiBjb25z
dCBjaGFyICogdHlwZV9kaWZmZXJlbmNlKHN0cnVjdCBjdHlwZSAqYzEsIHN0cnVjdCBjdHlwZSAq
YzIsCiAJdW5zaWduZWQgbG9uZyBtb2QxLCB1bnNpZ25lZCBsb25nIG1vZDIpOwogCi1leHRlcm4g
c3RydWN0IHN5bWJvbCAqbG9va3VwX3N5bWJvbChzdHJ1Y3QgaWRlbnQgKiwgZW51bSBuYW1lc3Bh
Y2UpOwotZXh0ZXJuIHN0cnVjdCBzeW1ib2wgKmNyZWF0ZV9zeW1ib2woaW50IHN0cmVhbSwgY29u
c3QgY2hhciAqbmFtZSwgaW50IHR5cGUsIGludCBuYW1lc3BhY2UpOworZXh0ZXJuIHN0cnVjdCBz
eW1ib2wgKmxvb2t1cF9zeW1ib2woc3RydWN0IGlkZW50ICosIGVudW0gbmFtZV9zcGFjZSk7Citl
eHRlcm4gc3RydWN0IHN5bWJvbCAqY3JlYXRlX3N5bWJvbChpbnQgc3RyZWFtLCBjb25zdCBjaGFy
ICpuYW1lLCBpbnQgdHlwZSwgaW50IG5hbWVfc3BhY2UpOwogZXh0ZXJuIHZvaWQgaW5pdF9zeW1i
b2xzKHZvaWQpOwogZXh0ZXJuIHZvaWQgaW5pdF9jdHlwZSh2b2lkKTsKIGV4dGVybiBzdHJ1Y3Qg
c3ltYm9sICphbGxvY19zeW1ib2woc3RydWN0IHBvc2l0aW9uLCBpbnQgdHlwZSk7CkBAIC0yNzks
NyArMjgwLDcgQEAgZXh0ZXJuIGludCBzaG93X3N5bWJvbF9leHByX2luaXQoc3RydWN0IHN5bWJv
bCAqc3ltKTsKIGV4dGVybiB2b2lkIHNob3dfdHlwZV9saXN0KHN0cnVjdCBzeW1ib2wgKik7CiBl
eHRlcm4gdm9pZCBzaG93X3N5bWJvbF9saXN0KHN0cnVjdCBzeW1ib2xfbGlzdCAqLCBjb25zdCBj
aGFyICopOwogZXh0ZXJuIHZvaWQgYWRkX3N5bWJvbChzdHJ1Y3Qgc3ltYm9sX2xpc3QgKiosIHN0
cnVjdCBzeW1ib2wgKik7Ci1leHRlcm4gdm9pZCBiaW5kX3N5bWJvbChzdHJ1Y3Qgc3ltYm9sICos
IHN0cnVjdCBpZGVudCAqLCBlbnVtIG5hbWVzcGFjZSk7CitleHRlcm4gdm9pZCBiaW5kX3N5bWJv
bChzdHJ1Y3Qgc3ltYm9sICosIHN0cnVjdCBpZGVudCAqLCBlbnVtIG5hbWVfc3BhY2UpOwogCiBl
eHRlcm4gc3RydWN0IHN5bWJvbCAqZXhhbWluZV9zeW1ib2xfdHlwZShzdHJ1Y3Qgc3ltYm9sICop
OwogZXh0ZXJuIHN0cnVjdCBzeW1ib2wgKmV4YW1pbmVfcG9pbnRlcl90YXJnZXQoc3RydWN0IHN5
bWJvbCAqKTsKQEAgLTM2Nyw3ICszNjgsNyBAQCBzdGF0aWMgaW5saW5lIGludCBnZXRfc3ltX3R5
cGUoc3RydWN0IHN5bWJvbCAqdHlwZSkKIAlyZXR1cm4gdHlwZS0+dHlwZTsKIH0KIAotc3RhdGlj
IGlubGluZSBzdHJ1Y3Qgc3ltYm9sICpsb29rdXBfa2V5d29yZChzdHJ1Y3QgaWRlbnQgKmlkZW50
LCBlbnVtIG5hbWVzcGFjZSBucykKK3N0YXRpYyBpbmxpbmUgc3RydWN0IHN5bWJvbCAqbG9va3Vw
X2tleXdvcmQoc3RydWN0IGlkZW50ICppZGVudCwgZW51bSBuYW1lX3NwYWNlIG5zKQogewogCWlm
ICghaWRlbnQtPmtleXdvcmQpCiAJCXJldHVybiBOVUxMOwpkaWZmIC0tZ2l0IGEvdG9rZW4uaCBi
L3Rva2VuLmgKaW5kZXggYTdlYzc3ZS4uZmQ4NTRhMCAxMDA2NDQKLS0tIGEvdG9rZW4uaAorKysg
Yi90b2tlbi5oCkBAIC0xNzUsNyArMTc1LDcgQEAgc3RydWN0IHRva2VuIHsKIHN0YXRpYyBpbmxp
bmUgc3RydWN0IHRva2VuICpjb250YWluaW5nX3Rva2VuKHN0cnVjdCB0b2tlbiAqKnApCiB7CiAJ
dm9pZCAqYWRkciA9IChjaGFyICopcCAtICgoY2hhciAqKSYoKHN0cnVjdCB0b2tlbiAqKTApLT5u
ZXh0IC0gKGNoYXIgKikwKTsKLQlyZXR1cm4gYWRkcjsKKwlyZXR1cm4gKHN0cnVjdCB0b2tlbiop
YWRkcjsKIH0KIAogI2RlZmluZSB0b2tlbl90eXBlKHgpICgoeCktPnBvcy50eXBlKQpAQCAtMjA1
LDcgKzIwNSw3IEBAIGV4dGVybiBzdHJ1Y3QgdG9rZW4gKnByZXByb2Nlc3Moc3RydWN0IHRva2Vu
ICopOwogCiBzdGF0aWMgaW5saW5lIGludCBtYXRjaF9vcChzdHJ1Y3QgdG9rZW4gKnRva2VuLCBp
bnQgb3ApCiB7Ci0JcmV0dXJuIHRva2VuLT5wb3MudHlwZSA9PSBUT0tFTl9TUEVDSUFMICYmIHRv
a2VuLT5zcGVjaWFsID09IG9wOworCXJldHVybiB0b2tlbi0+cG9zLnR5cGUgPT0gVE9LRU5fU1BF
Q0lBTCAmJiB0b2tlbi0+c3BlY2lhbCA9PSAodW5zaWduZWQgaW50KW9wOwogfQogCiBzdGF0aWMg
aW5saW5lIGludCBtYXRjaF9pZGVudChzdHJ1Y3QgdG9rZW4gKnRva2VuLCBzdHJ1Y3QgaWRlbnQg
KmlkKQotLSAKMS41LjQuMwoK
--20cf3040e2e62a5b6b0492fdca09--
