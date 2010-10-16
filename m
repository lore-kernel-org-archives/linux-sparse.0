From: Tomas Klacko <tomas.klacko@gmail.com>
Subject: Re: including sparse headers in C++ code
Date: Sat, 16 Oct 2010 18:03:53 +0200
Message-ID: <AANLkTimZb1PsnKcMQ_Ka6dkk7fNwXiJb6_U4GcckLsF4@mail.gmail.com>
References: <AANLkTinGSRQYqR2h+V0nAB+vn4xWCGxgbmGHuMm-xHyB@mail.gmail.com>
	<20101009205930.GA4684@feather>
	<AANLkTinaDZZmyeaK+rAvLCdZ-90n17WhABRsZGUBBcSH@mail.gmail.com>
	<AANLkTi=8EkK+_9pOA8fbDgYGfz-bPGj6XhLUnfSkdGeV@mail.gmail.com>
	<20101011224656.GN19804@ZenIV.linux.org.uk>
	<AANLkTinWYFf0CqBt9FJ9QyeGCU6754GotQM06U4vMqRa@mail.gmail.com>
	<AANLkTimdy9TwwSJM=rwTjXdRsnove6A2b0=d4M_dOin0@mail.gmail.com>
	<AANLkTimhh3zj8kgvaSQq9_CS711mLw8skrWL4yUgvJzT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42963 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177Ab0JPQEK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 16 Oct 2010 12:04:10 -0400
Received: by iwn35 with SMTP id 35so2097438iwn.19
        for <linux-sparse@vger.kernel.org>; Sat, 16 Oct 2010 09:03:54 -0700 (PDT)
In-Reply-To: <AANLkTimhh3zj8kgvaSQq9_CS711mLw8skrWL4yUgvJzT@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org

Hi,

On Wed, Oct 13, 2010 at 2:37 AM, Christopher Li <sparse@chrisli.org> wr=
ote:
> On Tue, Oct 12, 2010 at 3:45 PM, Tomas Klacko <tomas.klacko@gmail.com=
> wrote:

>> diff --git a/parse.h b/parse.h
>> index 6b21e23..f2193e7 100644
>> --- a/parse.h
>> +++ b/parse.h
>> @@ -35,10 +35,12 @@ struct statement {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct /* declaration */ {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct symbol_list *d=
eclaration;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>> +#ifndef __cplusplus
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct /* label_arg */ {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct symbol *label;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct statement *lab=
el_statement;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>> +#endif
>
> What is this #ifndef =A0for?

I use it to avoid this error:

[...]/sparse/parse.h:65: error: declaration of =91statement*
statement::<anonymous union>::<anonymous struct>::label_statement=92
[...]sparse/parse.h:41: error: conflicts with previous declaration
=91statement* statement::<anonymous union>::<anonymous
struct>::label_statement=92

>> =A0/* Silly type-safety check ;) */
>> =A0#define DECLARE_PTR_LIST(listname,type) =A0 =A0 =A0 =A0struct lis=
tname { type *list[1]; }
>> -#define CHECK_TYPE(head,ptr) =A0 =A0 =A0 =A0 =A0 (void)(&(ptr) =3D=3D=
 &(head)->list[0])
>> =A0#define TYPEOF(head) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __typeof=
__(&(head)->list[0])
>> =A0#define VRFY_PTR_LIST(head) =A0 =A0 =A0 =A0 =A0 =A0(void)(sizeof(=
(head)->list[0]))
>>
>> +#ifndef __cplusplus
>> +#define CHECK_TYPE(head,ptr) =A0 =A0 =A0 =A0 =A0 (void)(&(ptr) =3D=3D=
 &(head)->list[0])
>> +#else
>> +/* I don't know yet how to do this better in C++. */
>> +#define CHECK_TYPE(head,ptr) (void)((void*)&(ptr) =3D=3D (void*)&(h=
ead)->list[0])
>> +#endif
>
> If you can't get CHECK_TYPE work in C++, you might just make it an em=
pty define
> instead of doing useless point dancing. At least it is clear that it =
does not
> do any thing here.

True. How about
#define CHECK_TYPE (head,ptr)   (void)(1)
?

I have processed your comments and this is the next patch version:

=46rom df482c2ca34900186667ca68ca8dbbbe9a14f798 Mon Sep 17 00:00:00 200=
1
=46rom: Tomas Klacko <tomas.klacko@gmail.com>
Date: Sat, 16 Oct 2010 15:48:27 +0200
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
 parse.h       |    2 ++
 pre-process.c |   10 +++++-----
 ptrlist.h     |   12 +++++++++---
 symbol.c      |   10 +++++-----
 symbol.h      |   15 ++++++++-------
 token.h       |    4 ++--
 14 files changed, 67 insertions(+), 57 deletions(-)

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
 		die("unknown symbol %s namespace:%d type:%d\n", show_ident(sym->iden=
t),
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
-		struct symbol *sym =3D lookup_symbol(token->ident, NS_SYMBOL | NS_TY=
PEDEF);
-		return sym && (sym->namespace & NS_TYPEDEF);
+		struct symbol *sym =3D lookup_symbol(token->ident, NS_SYMBOL_OR_TYPE=
DEF);
+		return sym && (sym->ns & NS_TYPEDEF);
 	}
 	return 0;
 }
diff --git a/graph.c b/graph.c
index 1a77d75..7e0868f 100644
--- a/graph.c
+++ b/graph.c
@@ -124,7 +124,7 @@ static void graph_calls(struct entrypoint *ep, int =
internal)
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
+	return (struct instruction *)undo_ptr_list_last((struct ptr_list **)h=
ead);
 }

 static inline struct basic_block * delete_last_basic_block(struct
basic_block_list **head)
 {
-	return delete_ptr_list_last((struct ptr_list **)head);
+	return (struct basic_block *)delete_ptr_list_last((struct ptr_list **=
)head);
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
+	replace_ptr_list_entry((struct ptr_list **)list, old, newlist, count)=
;
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

-struct token *typename(struct token *token, struct symbol **p, int *fo=
rced)
+struct token *type_name(struct token *token, struct symbol **p, int *f=
orced)
 {
 	struct decl_state ctx =3D {.prefer_abstract =3D 1};
 	int class;
@@ -2295,7 +2295,7 @@ static struct token *label_statement(struct token=
 *token)
 		struct symbol *sym =3D alloc_symbol(token->pos, SYM_LABEL);
 		/* it's block-scope, but we want label namespace */
 		bind_symbol(sym, token->ident, NS_SYMBOL);
-		sym->namespace =3D NS_LABEL;
+		sym->ns =3D NS_LABEL;
 		fn_local_symbol(sym);
 		token =3D token->next;
 		if (!match_op(token, ','))
diff --git a/parse.h b/parse.h
index 6b21e23..f2193e7 100644
--- a/parse.h
+++ b/parse.h
@@ -35,10 +35,12 @@ struct statement {
 		struct /* declaration */ {
 			struct symbol_list *declaration;
 		};
+#ifndef __cplusplus
 		struct /* label_arg */ {
 			struct symbol *label;
 			struct statement *label_statement;
 		};
+#endif
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
index fbfc080..99e50da 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -14,10 +14,16 @@

 /* Silly type-safety check ;) */
 #define DECLARE_PTR_LIST(listname,type)	struct listname { type *list[1=
]; }
-#define CHECK_TYPE(head,ptr)		(void)(&(ptr) =3D=3D &(head)->list[0])
 #define TYPEOF(head)			__typeof__(&(head)->list[0])
 #define VRFY_PTR_LIST(head)		(void)(sizeof((head)->list[0]))

+#ifndef __cplusplus
+#define CHECK_TYPE(head,ptr)		(void)(&(ptr) =3D=3D &(head)->list[0])
+#else
+/* I don't know yet how to do this better in C++. */
+#define CHECK_TYPE(head,ptr)   (void)(1)
+#endif
+
 /*
  * The "unnecessary" statement expression is there to shut up a totall=
y
  * bogus gcc warning about unused expressions, brought on by the fact
@@ -39,7 +45,7 @@ struct ptr_list {
 void * undo_ptr_list_last(struct ptr_list **head);
 void * delete_ptr_list_last(struct ptr_list **head);
 int delete_ptr_list_entry(struct ptr_list **, void *, int);
-int replace_ptr_list_entry(struct ptr_list **, void *old, void *new, i=
nt);
+int replace_ptr_list_entry(struct ptr_list **, void *old, void *newlis=
t, int);
 extern void sort_list(struct ptr_list **, int (*)(const void *, const =
void *));

 extern void **__add_ptr_list(struct ptr_list **, void *, unsigned long=
);
@@ -270,7 +276,7 @@ extern void pack_ptr_list(struct ptr_list **);

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

-void bind_symbol(struct symbol *sym, struct ident *ident, enum namespa=
ce ns)
+void bind_symbol(struct symbol *sym, struct ident *ident, enum name_sp=
ace ns)
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
 extern const char * type_difference(struct ctype *c1, struct ctype *c2=
,
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
@@ -279,7 +280,7 @@ extern int show_symbol_expr_init(struct symbol *sym=
);
 extern void show_type_list(struct symbol *);
 extern void show_symbol_list(struct symbol_list *, const char *);
 extern void add_symbol(struct symbol_list **, struct symbol *);
-extern void bind_symbol(struct symbol *, struct ident *, enum namespac=
e);
+extern void bind_symbol(struct symbol *, struct ident *, enum name_spa=
ce);

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
 	void *addr =3D (char *)p - ((char *)&((struct token *)0)->next - (cha=
r *)0);
-	return addr;
+	return (struct token*)addr;
 }

 #define token_type(x) ((x)->pos.type)
@@ -205,7 +205,7 @@ extern struct token *preprocess(struct token *);

 static inline int match_op(struct token *token, int op)
 {
-	return token->pos.type =3D=3D TOKEN_SPECIAL && token->special =3D=3D =
op;
+	return token->pos.type =3D=3D TOKEN_SPECIAL && token->special =3D=3D =
(unsigned int)op;
 }

 static inline int match_ident(struct token *token, struct ident *id)
--=20
1.5.4.3


Also, I have notices this:

lib.h:static inline void add_symbol(struct symbol_list **list, struct
symbol *sym)
symbol.h:extern void add_symbol(struct symbol_list **, struct symbol *)=
;

but I did not find add_symbol definition in *.c.
What's the purpose?

Tomas Klacko
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
