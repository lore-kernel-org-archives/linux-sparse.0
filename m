From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: fun with declarations and definitions
Date: Fri, 6 Feb 2009 05:36:55 +0000
Message-ID: <20090206053655.GS28946@ZenIV.linux.org.uk>
References: <20090202073018.GB28946@ZenIV.linux.org.uk> <70318cbf0902021907w634ffc6dm693022b23a0eabfc@mail.gmail.com> <20090203041317.GH28946@ZenIV.linux.org.uk> <70318cbf0902051040m7506a365s784a591667358f1f@mail.gmail.com> <498B3435.8010506@knosof.co.uk> <20090205202811.GO28946@ZenIV.linux.org.uk> <20090205211921.GP28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:58668 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbZBFFg5 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 6 Feb 2009 00:36:57 -0500
Content-Disposition: inline
In-Reply-To: <20090205211921.GP28946@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Derek M Jones <derek@knosof.co.uk>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

On Thu, Feb 05, 2009 at 09:19:21PM +0000, Al Viro wrote:
> IOW, direct_declarator() (which doubles for direct-abstract-declarator) should
> have more than one-bit indication of which case we've got.  Right now it's
> done by "have we passed a non-NULL ident ** to store the identifier being
> declared"; that's not enough.  What we need is explicit 'is that a part of
> parameter declaration' flag; then the rule turns into
> 	if (p && *p)
> 		fn = 1; /* we'd seen identifier already, can't be nested */
> 	else if match_op(next, ')')
> 		fn = 1; /* empty list can't be direct-declarator or
> 			 * direct-abstract-declarator */
> 	else
> 		fn = (in_parameter && lookup_type(next));

Umm...  It's a bit more subtle (p goes NULL after the nested one is
handled), so we need to keep track of "don't allow nested declarator from
that point on" explicitly.  Patch follows:

Subject: [PATCH] Handle nested declarators vs. parameter lists correctly

Seeing a typedef name after ( means that we have a parameter-type-list
only if we are parsing a parameter declaration or a typename; otherwise
it might very well be a redeclaration (e.g. int (T); when T had been a
typedef in outer scope).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 parse.c                        |   26 +++++++++++++++-----------
 validation/nested-declarator.c |   11 +++++++++++
 2 files changed, 26 insertions(+), 11 deletions(-)
 create mode 100644 validation/nested-declarator.c

diff --git a/parse.c b/parse.c
index 7e3191a..73e7b65 100644
--- a/parse.c
+++ b/parse.c
@@ -1227,7 +1227,7 @@ static struct token *abstract_array_declarator(struct token *token, struct symbo
 }
 
 static struct token *parameter_type_list(struct token *, struct symbol *, struct ident **p);
-static struct token *declarator(struct token *token, struct symbol *sym, struct ident **p);
+static struct token *declarator(struct token *token, struct symbol *sym, struct ident **p, int);
 
 static struct token *handle_attributes(struct token *token, struct ctype *ctype, unsigned int keywords)
 {
@@ -1247,13 +1247,15 @@ static struct token *handle_attributes(struct token *token, struct ctype *ctype,
 	return token;
 }
 
-static struct token *direct_declarator(struct token *token, struct symbol *decl, struct ident **p)
+static struct token *direct_declarator(struct token *token, struct symbol *decl, struct ident **p, int prefer_abstract)
 {
 	struct ctype *ctype = &decl->ctype;
+	int dont_nest = 0;
 
 	if (p && token_type(token) == TOKEN_IDENT) {
 		*p = token->ident;
 		token = token->next;
+		dont_nest = 1;
 	}
 
 	for (;;) {
@@ -1275,14 +1277,16 @@ static struct token *direct_declarator(struct token *token, struct symbol *decl,
 			int fn;
 
 			next = handle_attributes(next, ctype, KW_ATTRIBUTE);
-			fn = (p && *p) || match_op(next, ')') || lookup_type(next);
+			fn = dont_nest || match_op(next, ')') ||
+				(prefer_abstract && lookup_type(next));
 
 			if (!fn) {
 				struct symbol *base_type = ctype->base_type;
-				token = declarator(next, decl, p);
+				token = declarator(next, decl, p, prefer_abstract);
 				token = expect(token, ')', "in nested declarator");
 				while (ctype->base_type != base_type)
 					ctype = &ctype->base_type->ctype;
+				dont_nest = 1;
 				p = NULL;
 				continue;
 			}
@@ -1336,10 +1340,10 @@ static struct token *pointer(struct token *token, struct ctype *ctype)
 	return token;
 }
 
-static struct token *declarator(struct token *token, struct symbol *sym, struct ident **p)
+static struct token *declarator(struct token *token, struct symbol *sym, struct ident **p, int prefer_abstract)
 {
 	token = pointer(token, &sym->ctype);
-	return direct_declarator(token, sym, p);
+	return direct_declarator(token, sym, p, prefer_abstract);
 }
 
 static struct token *handle_bitfield(struct token *token, struct symbol *decl)
@@ -1399,7 +1403,7 @@ static struct token *declaration_list(struct token *token, struct symbol_list **
 		struct ident *ident = NULL;
 		struct symbol *decl = alloc_symbol(token->pos, SYM_NODE);
 		decl->ctype = ctype;
-		token = declarator(token, decl, &ident);
+		token = declarator(token, decl, &ident, 0);
 		decl->ident = ident;
 		if (match_op(token, ':')) {
 			token = handle_bitfield(token, decl);
@@ -1439,7 +1443,7 @@ static struct token *parameter_declaration(struct token *token, struct symbol **
 	sym = alloc_symbol(token->pos, SYM_NODE);
 	sym->ctype = ctype;
 	*tree = sym;
-	token = declarator(token, sym, &ident);
+	token = declarator(token, sym, &ident, 1);
 	sym->ident = ident;
 	apply_modifiers(token->pos, &sym->ctype);
 	sym->endpos = token->pos;
@@ -1451,7 +1455,7 @@ struct token *typename(struct token *token, struct symbol **p, int mod)
 	struct symbol *sym = alloc_symbol(token->pos, SYM_NODE);
 	*p = sym;
 	token = declaration_specifiers(token, &sym->ctype, 0);
-	token = declarator(token, sym, NULL);
+	token = declarator(token, sym, NULL, 1);
 	apply_modifiers(token->pos, &sym->ctype);
 	if (sym->ctype.modifiers & MOD_STORAGE & ~mod)
 		warning(sym->pos, "storage class in typename (%s)",
@@ -2261,7 +2265,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 	token = declaration_specifiers(token, &ctype, 0);
 	decl = alloc_symbol(token->pos, SYM_NODE);
 	decl->ctype = ctype;
-	token = declarator(token, decl, &ident);
+	token = declarator(token, decl, &ident, 0);
 	apply_modifiers(token->pos, &decl->ctype);
 
 	decl->endpos = token->pos;
@@ -2333,7 +2337,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 		decl = alloc_symbol(token->pos, SYM_NODE);
 		decl->ctype = ctype;
 		token = declaration_specifiers(token, &decl->ctype, 1);
-		token = declarator(token, decl, &ident);
+		token = declarator(token, decl, &ident, 0);
 		apply_modifiers(token->pos, &decl->ctype);
 		decl->endpos = token->pos;
 		if (!ident) {
diff --git a/validation/nested-declarator.c b/validation/nested-declarator.c
new file mode 100644
index 0000000..24ed833
--- /dev/null
+++ b/validation/nested-declarator.c
@@ -0,0 +1,11 @@
+typedef int T;
+extern void f(int);
+static void g(int x)
+{
+	int (T);
+	T = x;
+	f(T);
+}
+/*
+ * check-name: nested declarator vs. parameters
+ */
-- 
1.5.6.6

