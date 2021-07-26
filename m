Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D70DC4338F
	for <linux-sparse@archiver.kernel.org>; Mon, 26 Jul 2021 18:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CAD960F58
	for <linux-sparse@archiver.kernel.org>; Mon, 26 Jul 2021 18:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhGZRr6 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 26 Jul 2021 13:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhGZRr5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 26 Jul 2021 13:47:57 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F14C061757
        for <linux-sparse@vger.kernel.org>; Mon, 26 Jul 2021 11:28:25 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b7so11869292edu.3
        for <linux-sparse@vger.kernel.org>; Mon, 26 Jul 2021 11:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8ujBSNi6pxmVCS8Ii8J1Ztwc3y27a5tyF5UWMzCAvYo=;
        b=PjZmbVBTQ6q3hWS9gaeb2w2m/Bfp8lL1fN/PhhKpE8Ir4+0gSp7MpL9eOxR1FQH7lc
         WzX9xeEATc1LmBRxq8kabmfu1jp8PWBWUg/EW0qRuxP3jjKvJtlNVjDerbGXIR2Egs00
         ciJi7dcermZPdr0tX7aY9/apZIRdyrztypmbBznwYAmhArr5dDGZMv1XM4kaDnQIO90I
         zRIvn9Q0w+AmdZBmQMBxQaeGLbfC78Sq4C/rrscsgEy++DxTuXfklhDl/8I4X0WwUHd6
         s7on1ZdIuKWQy0yjbDSY/Ny5acEgzpTDa6XksDyLwLkwdZG6VhU2v6eH1Gf6XCujV7R7
         63pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8ujBSNi6pxmVCS8Ii8J1Ztwc3y27a5tyF5UWMzCAvYo=;
        b=eGusaqp819x6JzFPXn2fyN+j1WInMvIqXuOHrIKZfYeVkUZK7j3eGetyZMoJdrvSdM
         DAhHtPGHcIwvNB6+9hJUlqLLKzOoRa53J/QnsvAC2q1a31V3ls1svMAHJVz5M51+09yo
         nNnjMxEN4cmmgS/VbsIfvSsD1UBo1DHnr/6HbG9tv0LiS303N1EawyFYjP0NPoibZVQK
         nOQE1f3fntJTmVIXtb20P7t9gkXnTrUREyI5R+QdzcW6eZRe19tQdtQAULfV+c4bb/+F
         Sxf3BM87yrAFB+9oyZPFwwl12W3Y/U0HGQZbXGzdY/ztOZrNY/SoKsfwpPPWD4cP5a7S
         Di/w==
X-Gm-Message-State: AOAM532NqRFfgcuikZkJf0UTugKMv/x+0i8XWK4xWEMrhwH5wEaUglj0
        QMdlnpJgxFIgtWPhiGPT2Vfk0RsWCFw=
X-Google-Smtp-Source: ABdhPJwwHwP2Icyi/UM45kkNb1H0Oi/PoPbdXzw4J3IFjhvNcbRhhHb14HqK0Ft6pFwQXcyL9Q+UQg==
X-Received: by 2002:aa7:c50d:: with SMTP id o13mr2032748edq.153.1627324104404;
        Mon, 26 Jul 2021 11:28:24 -0700 (PDT)
Received: from mail ([2a02:a03f:b7fe:f700:7d98:546b:4541:6897])
        by smtp.gmail.com with ESMTPSA id cn21sm238344edb.81.2021.07.26.11.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 11:28:23 -0700 (PDT)
Date:   Mon, 26 Jul 2021 20:28:22 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ke Du <duke@naive.systems>
Cc:     linux-sparse@vger.kernel.org, Xiao Jia <xjia@naive.systems>
Subject: Re: check idea: include sparse as a library in C++
Message-ID: <20210726182822.ylmd3vtm44txowoi@mail>
References: <88596afa-76f2-8c2f-d80e-572d1e57369e@naive.systems>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="64jrpd33gnofsvfn"
Content-Disposition: inline
In-Reply-To: <88596afa-76f2-8c2f-d80e-572d1e57369e@naive.systems>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org


--64jrpd33gnofsvfn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 22, 2021 at 02:45:41AM -0400, Ke Du wrote:
> Hi,
> 
> I want to include sparse as a library in C++ and access fields of the
> structs such as symbol and expression directly, but some of the variables in
> sparse are keywords in C++ so they cannot be included in C++ directly. I
> have several fixes below that are not ideal, and any feedback is
> appreciated.
> 
> 1. Append an underscore to C++ keywords, for instance change new to new_.
> The change only involves the code that I included so there might be some C++
> keywords in sparse that are unchanged.
> 
> 2. Replace every keyword with a macro:
> 
>     #ifdef __cplusplus
>     #define NEW new_
>     #else
>     #define NEW new
>     #endif
> 
> Similar to solution 1, this is not complete, and both 1 and 2 involves about
> 200 changes already.
> 
> 3. When including sparse header files, guard them with
> 
>     #define new new_
>     #include ...
>     #define new_ new
> 
> This does not involve change to sparse but it imposes weird restriction to
> the ordering of other C++ libraries that I do not understand at all.
> 
> I can send the patches if one of the fixes is acceptable. Alternatively, if
> there is a better way, please let me know.

Hi,

Please forgive me for this late answer.

I don't mind at all to make header files like expression.h, symbol.h
more compatible with C++ like replacing or removing the names 'new',
'class', 'typename' & 'namespace' and adding a guarded 'extern "C"').
Maybe adding a few more '#ifdef __cplusplus' to isolate the type
definitions from the inline helpers would also help.

Would you need access to anything else than 'struct expression' and
'struct symbol'? If yes, the following patch should be enough.

Cheers,
-- Luc


diff --git a/ast-inspect.c b/ast-inspect.c
index b510cd9b1d2c..0899455cee12 100644
--- a/ast-inspect.c
+++ b/ast-inspect.c
@@ -128,7 +128,7 @@ void inspect_symbol(AstNode *node)
 				      builtin_typename(sym) ?: show_ident(sym->ident));
 	ast_append_child(node, "ctype.base_type:", sym->ctype.base_type,inspect_symbol);
 
-	switch (sym->namespace) {
+	switch (sym->ns) {
 		case NS_PREPROCESSOR:
 			break;
 		default:
diff --git a/c2xml.c b/c2xml.c
index 1a24c3a8120a..d60fee2e6434 100644
--- a/c2xml.c
+++ b/c2xml.c
@@ -144,7 +144,7 @@ static void examine_modifiers(struct symbol *sym, xmlNodePtr node)
 
 	int i;
 
-	if (sym->namespace != NS_SYMBOL)
+	if (sym->ns != NS_SYMBOL)
 		return;
 
 	/*iterate over the 32 bit bitfield*/
@@ -253,7 +253,7 @@ static void examine_namespace(struct symbol *sym)
 	if (sym->ident && sym->ident->reserved)
 		return;
 
-	switch(sym->namespace) {
+	switch(sym->ns) {
 	case NS_MACRO:
 		examine_macro(sym, root_node);
 		break;
@@ -270,7 +270,7 @@ static void examine_namespace(struct symbol *sym)
 	case NS_KEYWORD:
 		break;
 	default:
-		die("Unrecognised namespace type %d",sym->namespace);
+		die("Unrecognised namespace type %d",sym->ns);
 	}
 
 }
diff --git a/ctags.c b/ctags.c
index aa5f9718d847..1f7f2ce08489 100644
--- a/ctags.c
+++ b/ctags.c
@@ -161,7 +161,7 @@ static void examine_symbol(struct symbol *sym)
 
 	default:
 		die("unknown symbol %s namespace:%d type:%d\n", show_ident(sym->ident),
-		    sym->namespace, sym->type);
+		    sym->ns, sym->type);
 	}
 	if (!sym->kind)
 		sym->kind = 'v';
@@ -175,7 +175,7 @@ static void examine_namespace(struct symbol *sym)
 	if (sym->ident && sym->ident->reserved)
 		return;
 
-	switch(sym->namespace) {
+	switch(sym->ns) {
 	case NS_KEYWORD:
 	case NS_PREPROCESSOR:
 		return;
@@ -193,7 +193,7 @@ static void examine_namespace(struct symbol *sym)
 		examine_symbol(sym);
 		break;
 	default:
-		die("unknown namespace %d symbol:%s type:%d\n", sym->namespace,
+		die("unknown namespace %d symbol:%s type:%d\n", sym->ns,
 		    show_ident(sym->ident), sym->type);
 	}
 	add_tag(sym);
diff --git a/evaluate.c b/evaluate.c
index 61f59ee3908e..b44c69066996 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3308,7 +3308,7 @@ static struct symbol *evaluate_offsetof(struct expression *expr)
 
 static void check_label_declaration(struct position pos, struct symbol *label)
 {
-	switch (label->namespace) {
+	switch (label->ns) {
 	case NS_LABEL:
 		if (label->stmt)
 			break;
diff --git a/expression.c b/expression.c
index 221d7780a76e..076f7270951c 100644
--- a/expression.c
+++ b/expression.c
@@ -484,7 +484,7 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 		 *
 		 *	if (typeof(a) == int) ..
 		 */
-		if (sym && sym->namespace == NS_TYPEDEF) {
+		if (sym && sym->ns == NS_TYPEDEF) {
 			sparse_error(token->pos, "typename in expression");
 			sym = NULL;
 		}
diff --git a/expression.h b/expression.h
index f733c07697c8..b41d4c755fc5 100644
--- a/expression.h
+++ b/expression.h
@@ -265,6 +265,8 @@ struct expression {
 	};
 };
 
+#ifndef __cplusplus
+
 ///
 // Constant expression values
 // --------------------------
@@ -323,7 +325,7 @@ static inline int lookup_type(struct token *token)
 {
 	if (token->pos.type == TOKEN_IDENT) {
 		struct symbol *sym = lookup_symbol(token->ident, NS_SYMBOL | NS_TYPEDEF);
-		return sym && (sym->namespace & NS_TYPEDEF);
+		return sym && (sym->ns & NS_TYPEDEF);
 	}
 	return 0;
 }
@@ -340,4 +342,5 @@ struct token *compound_statement(struct token *, struct statement *);
 void cast_value(struct expression *expr, struct symbol *newtype,
 	struct expression *old, struct symbol *oldtype);
 
+#endif	// __cplusplus
 #endif
diff --git a/graph.c b/graph.c
index be4cf282c0c7..7222fd79ba5b 100644
--- a/graph.c
+++ b/graph.c
@@ -142,7 +142,7 @@ static void graph_calls(struct entrypoint *ep, int internal)
 				if (insn->func->type == PSEUDO_SYM) {
 					for (sym = insn->func->sym->ident->symbols;
 					     sym; sym = sym->next_id) {
-						if (sym->namespace & NS_SYMBOL && sym->ep)
+						if (sym->ns & NS_SYMBOL && sym->ep)
 							break;
 					}
 
diff --git a/lib.h b/lib.h
index b96e31927a6f..9809feeeccfd 100644
--- a/lib.h
+++ b/lib.h
@@ -85,6 +85,8 @@ DECLARE_PTR_LIST(string_list, char);
 
 typedef struct pseudo *pseudo_t;
 
+#ifndef __cplusplus
+
 #ifdef __GNUC__
 #define FORMAT_ATTR(pos) __attribute__ ((__format__ (__printf__, pos, pos+1)))
 #define NORETURN_ATTR __attribute__ ((__noreturn__))
@@ -247,4 +249,5 @@ static inline void add_ident(struct ident_list **list, struct ident *ident)
 
 #define hashval(x) ((unsigned long)(x))
 
+#endif	// __cplusplus
 #endif
diff --git a/parse.c b/parse.c
index bc1c0602fcb4..72850468a833 100644
--- a/parse.c
+++ b/parse.c
@@ -238,7 +238,7 @@ static struct symbol_op char_op = {
 	.type = KW_SPECIFIER,
 	.test = Set_T|Set_Long|Set_Short,
 	.set = Set_T|Set_Char,
-	.class = CInt,
+	.type_class = CInt,
 };
 
 static struct symbol_op int_op = {
@@ -251,14 +251,14 @@ static struct symbol_op double_op = {
 	.type = KW_SPECIFIER,
 	.test = Set_T|Set_Signed|Set_Unsigned|Set_Short|Set_Vlong,
 	.set = Set_T|Set_Double,
-	.class = CReal,
+	.type_class = CReal,
 };
 
 static struct symbol_op float_op = {
 	.type = KW_SPECIFIER,
 	.test = Set_T|Set_Signed|Set_Unsigned|Set_Short|Set_Long,
 	.set = Set_T|Set_Float,
-	.class = CReal,
+	.type_class = CReal,
 };
 
 static struct symbol_op short_op = {
@@ -271,14 +271,14 @@ static struct symbol_op signed_op = {
 	.type = KW_SPECIFIER,
 	.test = Set_S|Set_Float|Set_Double|Set_Signed|Set_Unsigned,
 	.set = Set_Signed,
-	.class = CSInt,
+	.type_class = CSInt,
 };
 
 static struct symbol_op unsigned_op = {
 	.type = KW_SPECIFIER,
 	.test = Set_S|Set_Float|Set_Double|Set_Signed|Set_Unsigned,
 	.set = Set_Unsigned,
-	.class = CUInt,
+	.type_class = CUInt,
 };
 
 static struct symbol_op long_op = {
@@ -291,7 +291,7 @@ static struct symbol_op int128_op = {
 	.type = KW_SPECIFIER,
 	.test = Set_S|Set_T|Set_Char|Set_Short|Set_Int|Set_Float|Set_Double|Set_Long|Set_Vlong|Set_Int128,
 	.set =  Set_T|Set_Int128|Set_Vlong,
-	.class = CInt,
+	.type_class = CInt,
 };
 
 static struct symbol_op if_op = {
@@ -583,7 +583,7 @@ static const char *ignored_attributes[] = {
 };
 
 
-static void init_keyword(int stream, struct init_keyword *kw, enum namespace ns)
+static void init_keyword(int stream, struct init_keyword *kw, enum name_space ns)
 {
 	struct symbol *sym = create_symbol(stream, kw->name, SYM_KEYWORD, ns);
 	sym->ident->keyword = 1;
@@ -1526,7 +1526,7 @@ static struct token *declaration_specifiers(struct token *token, struct decl_sta
 	while (token_type(token) == TOKEN_IDENT) {
 		struct symbol *s = lookup_symbol(token->ident,
 						 NS_TYPEDEF | NS_SYMBOL);
-		if (!s || !(s->namespace & NS_TYPEDEF))
+		if (!s || !(s->ns & NS_TYPEDEF))
 			break;
 		if (s->type != SYM_KEYWORD) {
 			if (seen & Set_Any)
@@ -1545,7 +1545,7 @@ static struct token *declaration_specifiers(struct token *token, struct decl_sta
 				break;
 			}
 			seen |= s->op->set;
-			class += s->op->class;
+			class += s->op->type_class;
 			if (s->op->set & Set_Int128)
 				rank = 3;
 			else if (s->op->set & Set_Char)
@@ -1727,11 +1727,11 @@ static int is_nested(struct token *token, struct token **p,
 	return 1;
 }
 
-enum kind {
+enum type_class {
 	Empty, K_R, Proto, Bad_Func,
 };
 
-static enum kind which_func(struct token *token,
+static enum type_class which_func(struct token *token,
 			    struct ident **n,
 			    int prefer_abstract)
 {
@@ -1792,14 +1792,14 @@ static struct token *direct_declarator(struct token *token, struct decl_state *c
 	}
 
 	if (match_op(token, '(')) {
-		enum kind kind = which_func(token, p, ctx->prefer_abstract);
+		enum type_class class = which_func(token, p, ctx->prefer_abstract);
 		struct symbol *fn;
 		fn = alloc_indirect_symbol(token->pos, ctype, SYM_FN);
 		ctype->modifiers |= ctx->f_modifiers;
 		token = token->next;
-		if (kind == K_R)
+		if (class == K_R)
 			token = identifier_list(token, fn);
-		else if (kind == Proto)
+		else if (class == Proto)
 			token = parameter_type_list(token, fn);
 		token = expect(token, ')', "in function declarator");
 		fn->endpos = token->pos;
diff --git a/pre-process.c b/pre-process.c
index 3fb250828fa6..ca069ed021dc 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -127,7 +127,7 @@ static void replace_with_integer(struct token *token, unsigned int val)
 static struct symbol *lookup_macro(struct ident *ident)
 {
 	struct symbol *sym = lookup_symbol(ident, NS_MACRO | NS_UNDEF);
-	if (sym && sym->namespace != NS_MACRO)
+	if (sym && sym->ns != NS_MACRO)
 		sym = NULL;
 	return sym;
 }
@@ -1359,7 +1359,7 @@ static int do_define(struct position pos, struct token *token, struct ident *nam
 		if (attr < sym->attr)
 			goto out;
 
-		clean = (attr == sym->attr && sym->namespace == NS_MACRO);
+		clean = (attr == sym->attr && sym->ns == NS_MACRO);
 
 		if (token_list_different(sym->expansion, expansion) ||
 		    token_list_different(sym->arglist, arglist)) {
@@ -1388,7 +1388,7 @@ static int do_define(struct position pos, struct token *token, struct ident *nam
 			__free_token(token);
 	}
 
-	sym->namespace = NS_MACRO;
+	sym->ns = NS_MACRO;
 	sym->used_in = NULL;
 	sym->attr = attr;
 out:
@@ -1526,7 +1526,7 @@ static int do_handle_undef(struct stream *stream, struct token **line, struct to
 	if (sym) {
 		if (attr < sym->attr)
 			return 1;
-		if (attr == sym->attr && sym->namespace == NS_UNDEF)
+		if (attr == sym->attr && sym->ns == NS_UNDEF)
 			return 1;
 	} else if (attr <= SYM_ATTR_NORMAL)
 		return 1;
@@ -1536,7 +1536,7 @@ static int do_handle_undef(struct stream *stream, struct token **line, struct to
 		bind_symbol(sym, left->ident, NS_MACRO);
 	}
 
-	sym->namespace = NS_UNDEF;
+	sym->ns = NS_UNDEF;
 	sym->used_in = NULL;
 	sym->attr = attr;
 
diff --git a/ptrlist.h b/ptrlist.h
index 5a3dcbeb97ae..e281309fb74d 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -28,6 +28,7 @@
 
 DECLARE_PTR_LIST(ptr_list, void);
 
+#ifndef __cplusplus
 
 void * undo_ptr_list_last(struct ptr_list **head);
 void * delete_ptr_list_last(struct ptr_list **head);
@@ -310,4 +311,5 @@ static inline void *tag_ptr(void *ptr, unsigned long tag)
 	return (void *)(tag | (unsigned long)ptr);
 }
 
+#endif // __cpluplus
 #endif /* PTR_LIST_H */
diff --git a/symbol.c b/symbol.c
index 91352a3a447b..5a8c638728ce 100644
--- a/symbol.c
+++ b/symbol.c
@@ -57,12 +57,12 @@ void access_symbol(struct symbol *sym)
 	}
 }
 
-struct symbol *lookup_symbol(struct ident *ident, enum namespace ns)
+struct symbol *lookup_symbol(struct ident *ident, enum name_space ns)
 {
 	struct symbol *sym;
 
 	for (sym = ident->symbols; sym; sym = sym->next_id) {
-		if (sym->namespace & ns) {
+		if (sym->ns & ns) {
 			sym->used = 1;
 			return sym;
 		}
@@ -696,7 +696,7 @@ void check_declaration(struct symbol *sym)
 	struct symbol *next = sym;
 
 	while ((next = next->next_id) != NULL) {
-		if (next->namespace != sym->namespace)
+		if (next->ns != sym->ns)
 			continue;
 		if (sym->scope == next->scope) {
 			sym->same_symbol = next;
@@ -730,7 +730,7 @@ static void inherit_static(struct symbol *sym)
 		return;
 
 	for (prev = sym->next_id; prev; prev = prev->next_id) {
-		if (prev->namespace != NS_SYMBOL)
+		if (prev->ns != NS_SYMBOL)
 			continue;
 		if (prev->scope != file_scope)
 			continue;
@@ -742,7 +742,7 @@ static void inherit_static(struct symbol *sym)
 	}
 }
 
-void bind_symbol_with_scope(struct symbol *sym, struct ident *ident, enum namespace ns, struct scope *scope)
+void bind_symbol_with_scope(struct symbol *sym, struct ident *ident, enum name_space ns, struct scope *scope)
 {
 	if (sym->bound) {
 		sparse_error(sym->pos, "internal error: symbol type already bound");
@@ -752,7 +752,7 @@ void bind_symbol_with_scope(struct symbol *sym, struct ident *ident, enum namesp
 		sparse_error(sym->pos, "Trying to use reserved word '%s' as identifier", show_ident(ident));
 		return;
 	}
-	sym->namespace = ns;
+	sym->ns = ns;
 	sym->next_id = ident->symbols;
 	ident->symbols = sym;
 	if (sym->ident && sym->ident != ident)
@@ -776,7 +776,7 @@ void bind_symbol_with_scope(struct symbol *sym, struct ident *ident, enum namesp
 	bind_scope(sym, scope);
 }
 
-void bind_symbol(struct symbol *sym, struct ident *ident, enum namespace ns)
+void bind_symbol(struct symbol *sym, struct ident *ident, enum name_space ns)
 {
 	struct scope *scope = block_scope;;
 
@@ -787,10 +787,10 @@ void bind_symbol(struct symbol *sym, struct ident *ident, enum namespace ns)
 	bind_symbol_with_scope(sym, ident, ns, scope);
 }
 
-struct symbol *create_symbol(int stream, const char *name, int type, int namespace)
+struct symbol *create_symbol(int stream, const char *name, int type, int ns)
 {
 	struct ident *ident = built_in_ident(name);
-	struct symbol *sym = lookup_symbol(ident, namespace);
+	struct symbol *sym = lookup_symbol(ident, ns);
 
 	if (sym && sym->type != type)
 		die("symbol %s created with different types: %d old %d", name,
@@ -800,7 +800,7 @@ struct symbol *create_symbol(int stream, const char *name, int type, int namespa
 		struct token *token = built_in_token(stream, ident);
 
 		sym = alloc_symbol(token->pos, type);
-		bind_symbol(sym, token->ident, namespace);
+		bind_symbol(sym, token->ident, ns);
 	}
 	return sym;
 }
diff --git a/symbol.h b/symbol.h
index 5270fcd73a10..503c9f092d46 100644
--- a/symbol.h
+++ b/symbol.h
@@ -40,7 +40,7 @@
  * token contains the information on where the symbol was
  * declared.
  */
-enum namespace {
+enum name_space {
 	NS_NONE = 0,
 	NS_MACRO = 1,
 	NS_TYPEDEF = 2,
@@ -134,7 +134,7 @@ struct symbol_op {
 	struct symbol *(*to_mode)(struct symbol *);
 	void (*asm_modifier)(struct token *token, unsigned long *mods, unsigned long mod);
 
-	int test, set, class;
+	int test, set, type_class;
 };
 
 
@@ -144,7 +144,7 @@ struct symbol_op {
 
 struct symbol {
 	enum type type:8;
-	enum namespace namespace:9;
+	enum name_space ns:9;
 	unsigned char used:1, attr:2, enum_member:1, bound:1;
 	struct position pos;		/* Where this symbol was declared */
 	struct position endpos;		/* Where this symbol ends*/
@@ -220,6 +220,8 @@ struct symbol {
 	pseudo_t pseudo;
 };
 
+#ifndef __cplusplus
+
 /* Modifiers */
 #define MOD_AUTO		0x00000001
 #define MOD_REGISTER		0x00000002
@@ -330,8 +332,8 @@ extern void access_symbol(struct symbol *);
 extern const char * type_difference(struct ctype *c1, struct ctype *c2,
 	unsigned long mod1, unsigned long mod2);
 
-extern struct symbol *lookup_symbol(struct ident *, enum namespace);
-extern struct symbol *create_symbol(int stream, const char *name, int type, int namespace);
+extern struct symbol *lookup_symbol(struct ident *, enum name_space);
+extern struct symbol *create_symbol(int stream, const char *name, int type, int ns);
 extern void init_symbols(void);
 extern void init_builtins(int stream);
 extern void init_linearized_builtins(int stream);
@@ -345,8 +347,8 @@ extern int show_symbol_expr_init(struct symbol *sym);
 extern void show_type_list(struct symbol *);
 extern void show_symbol_list(struct symbol_list *);
 extern void add_symbol(struct symbol_list **, struct symbol *);
-extern void bind_symbol(struct symbol *, struct ident *, enum namespace);
-extern void bind_symbol_with_scope(struct symbol *, struct ident *, enum namespace, struct scope *);
+extern void bind_symbol(struct symbol *, struct ident *, enum name_space);
+extern void bind_symbol_with_scope(struct symbol *, struct ident *, enum name_space, struct scope *);
 
 extern struct symbol *examine_symbol_type(struct symbol *);
 extern struct symbol *examine_pointer_target(struct symbol *);
@@ -552,7 +554,7 @@ static inline long long extend_value(long long val, struct symbol *ctype)
 	return bits_extend(val, size, is_signed);
 }
 
-static inline struct symbol *lookup_keyword(struct ident *ident, enum namespace ns)
+static inline struct symbol *lookup_keyword(struct ident *ident, enum name_space ns)
 {
 	if (!ident->keyword)
 		return NULL;
@@ -589,4 +591,5 @@ static inline void combine_address_space(struct position pos,
 	}
 }
 
+#endif	// __cplusplus
 #endif /* SYMBOL_H */
diff --git a/token.h b/token.h
index bccac0e4aba5..1f3601a94497 100644
--- a/token.h
+++ b/token.h
@@ -197,6 +197,8 @@ struct token {
 	};
 };
 
+#ifndef __cplusplus
+
 #define MAX_STRING 8191
 
 static inline struct token *containing_token(struct token **p)
@@ -249,4 +251,5 @@ static inline int match_token_zero(struct token *token)
 	return token->number[0] == '0' && !token->number[1];
 }
 
+#endif	// __cplusplus
 #endif

--64jrpd33gnofsvfn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpp.diff"

diff --git a/ast-inspect.c b/ast-inspect.c
index b510cd9b1d2c..0899455cee12 100644
--- a/ast-inspect.c
+++ b/ast-inspect.c
@@ -128,7 +128,7 @@ void inspect_symbol(AstNode *node)
 				      builtin_typename(sym) ?: show_ident(sym->ident));
 	ast_append_child(node, "ctype.base_type:", sym->ctype.base_type,inspect_symbol);
 
-	switch (sym->namespace) {
+	switch (sym->ns) {
 		case NS_PREPROCESSOR:
 			break;
 		default:
diff --git a/c2xml.c b/c2xml.c
index 1a24c3a8120a..d60fee2e6434 100644
--- a/c2xml.c
+++ b/c2xml.c
@@ -144,7 +144,7 @@ static void examine_modifiers(struct symbol *sym, xmlNodePtr node)
 
 	int i;
 
-	if (sym->namespace != NS_SYMBOL)
+	if (sym->ns != NS_SYMBOL)
 		return;
 
 	/*iterate over the 32 bit bitfield*/
@@ -253,7 +253,7 @@ static void examine_namespace(struct symbol *sym)
 	if (sym->ident && sym->ident->reserved)
 		return;
 
-	switch(sym->namespace) {
+	switch(sym->ns) {
 	case NS_MACRO:
 		examine_macro(sym, root_node);
 		break;
@@ -270,7 +270,7 @@ static void examine_namespace(struct symbol *sym)
 	case NS_KEYWORD:
 		break;
 	default:
-		die("Unrecognised namespace type %d",sym->namespace);
+		die("Unrecognised namespace type %d",sym->ns);
 	}
 
 }
diff --git a/ctags.c b/ctags.c
index aa5f9718d847..1f7f2ce08489 100644
--- a/ctags.c
+++ b/ctags.c
@@ -161,7 +161,7 @@ static void examine_symbol(struct symbol *sym)
 
 	default:
 		die("unknown symbol %s namespace:%d type:%d\n", show_ident(sym->ident),
-		    sym->namespace, sym->type);
+		    sym->ns, sym->type);
 	}
 	if (!sym->kind)
 		sym->kind = 'v';
@@ -175,7 +175,7 @@ static void examine_namespace(struct symbol *sym)
 	if (sym->ident && sym->ident->reserved)
 		return;
 
-	switch(sym->namespace) {
+	switch(sym->ns) {
 	case NS_KEYWORD:
 	case NS_PREPROCESSOR:
 		return;
@@ -193,7 +193,7 @@ static void examine_namespace(struct symbol *sym)
 		examine_symbol(sym);
 		break;
 	default:
-		die("unknown namespace %d symbol:%s type:%d\n", sym->namespace,
+		die("unknown namespace %d symbol:%s type:%d\n", sym->ns,
 		    show_ident(sym->ident), sym->type);
 	}
 	add_tag(sym);
diff --git a/evaluate.c b/evaluate.c
index 61f59ee3908e..b44c69066996 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3308,7 +3308,7 @@ static struct symbol *evaluate_offsetof(struct expression *expr)
 
 static void check_label_declaration(struct position pos, struct symbol *label)
 {
-	switch (label->namespace) {
+	switch (label->ns) {
 	case NS_LABEL:
 		if (label->stmt)
 			break;
diff --git a/expression.c b/expression.c
index 221d7780a76e..076f7270951c 100644
--- a/expression.c
+++ b/expression.c
@@ -484,7 +484,7 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 		 *
 		 *	if (typeof(a) == int) ..
 		 */
-		if (sym && sym->namespace == NS_TYPEDEF) {
+		if (sym && sym->ns == NS_TYPEDEF) {
 			sparse_error(token->pos, "typename in expression");
 			sym = NULL;
 		}
diff --git a/expression.h b/expression.h
index f733c07697c8..b41d4c755fc5 100644
--- a/expression.h
+++ b/expression.h
@@ -265,6 +265,8 @@ struct expression {
 	};
 };
 
+#ifndef __cplusplus
+
 ///
 // Constant expression values
 // --------------------------
@@ -323,7 +325,7 @@ static inline int lookup_type(struct token *token)
 {
 	if (token->pos.type == TOKEN_IDENT) {
 		struct symbol *sym = lookup_symbol(token->ident, NS_SYMBOL | NS_TYPEDEF);
-		return sym && (sym->namespace & NS_TYPEDEF);
+		return sym && (sym->ns & NS_TYPEDEF);
 	}
 	return 0;
 }
@@ -340,4 +342,5 @@ struct token *compound_statement(struct token *, struct statement *);
 void cast_value(struct expression *expr, struct symbol *newtype,
 	struct expression *old, struct symbol *oldtype);
 
+#endif	// __cplusplus
 #endif
diff --git a/graph.c b/graph.c
index be4cf282c0c7..7222fd79ba5b 100644
--- a/graph.c
+++ b/graph.c
@@ -142,7 +142,7 @@ static void graph_calls(struct entrypoint *ep, int internal)
 				if (insn->func->type == PSEUDO_SYM) {
 					for (sym = insn->func->sym->ident->symbols;
 					     sym; sym = sym->next_id) {
-						if (sym->namespace & NS_SYMBOL && sym->ep)
+						if (sym->ns & NS_SYMBOL && sym->ep)
 							break;
 					}
 
diff --git a/lib.h b/lib.h
index b96e31927a6f..9809feeeccfd 100644
--- a/lib.h
+++ b/lib.h
@@ -85,6 +85,8 @@ DECLARE_PTR_LIST(string_list, char);
 
 typedef struct pseudo *pseudo_t;
 
+#ifndef __cplusplus
+
 #ifdef __GNUC__
 #define FORMAT_ATTR(pos) __attribute__ ((__format__ (__printf__, pos, pos+1)))
 #define NORETURN_ATTR __attribute__ ((__noreturn__))
@@ -247,4 +249,5 @@ static inline void add_ident(struct ident_list **list, struct ident *ident)
 
 #define hashval(x) ((unsigned long)(x))
 
+#endif	// __cplusplus
 #endif
diff --git a/parse.c b/parse.c
index bc1c0602fcb4..72850468a833 100644
--- a/parse.c
+++ b/parse.c
@@ -238,7 +238,7 @@ static struct symbol_op char_op = {
 	.type = KW_SPECIFIER,
 	.test = Set_T|Set_Long|Set_Short,
 	.set = Set_T|Set_Char,
-	.class = CInt,
+	.type_class = CInt,
 };
 
 static struct symbol_op int_op = {
@@ -251,14 +251,14 @@ static struct symbol_op double_op = {
 	.type = KW_SPECIFIER,
 	.test = Set_T|Set_Signed|Set_Unsigned|Set_Short|Set_Vlong,
 	.set = Set_T|Set_Double,
-	.class = CReal,
+	.type_class = CReal,
 };
 
 static struct symbol_op float_op = {
 	.type = KW_SPECIFIER,
 	.test = Set_T|Set_Signed|Set_Unsigned|Set_Short|Set_Long,
 	.set = Set_T|Set_Float,
-	.class = CReal,
+	.type_class = CReal,
 };
 
 static struct symbol_op short_op = {
@@ -271,14 +271,14 @@ static struct symbol_op signed_op = {
 	.type = KW_SPECIFIER,
 	.test = Set_S|Set_Float|Set_Double|Set_Signed|Set_Unsigned,
 	.set = Set_Signed,
-	.class = CSInt,
+	.type_class = CSInt,
 };
 
 static struct symbol_op unsigned_op = {
 	.type = KW_SPECIFIER,
 	.test = Set_S|Set_Float|Set_Double|Set_Signed|Set_Unsigned,
 	.set = Set_Unsigned,
-	.class = CUInt,
+	.type_class = CUInt,
 };
 
 static struct symbol_op long_op = {
@@ -291,7 +291,7 @@ static struct symbol_op int128_op = {
 	.type = KW_SPECIFIER,
 	.test = Set_S|Set_T|Set_Char|Set_Short|Set_Int|Set_Float|Set_Double|Set_Long|Set_Vlong|Set_Int128,
 	.set =  Set_T|Set_Int128|Set_Vlong,
-	.class = CInt,
+	.type_class = CInt,
 };
 
 static struct symbol_op if_op = {
@@ -583,7 +583,7 @@ static const char *ignored_attributes[] = {
 };
 
 
-static void init_keyword(int stream, struct init_keyword *kw, enum namespace ns)
+static void init_keyword(int stream, struct init_keyword *kw, enum name_space ns)
 {
 	struct symbol *sym = create_symbol(stream, kw->name, SYM_KEYWORD, ns);
 	sym->ident->keyword = 1;
@@ -1526,7 +1526,7 @@ static struct token *declaration_specifiers(struct token *token, struct decl_sta
 	while (token_type(token) == TOKEN_IDENT) {
 		struct symbol *s = lookup_symbol(token->ident,
 						 NS_TYPEDEF | NS_SYMBOL);
-		if (!s || !(s->namespace & NS_TYPEDEF))
+		if (!s || !(s->ns & NS_TYPEDEF))
 			break;
 		if (s->type != SYM_KEYWORD) {
 			if (seen & Set_Any)
@@ -1545,7 +1545,7 @@ static struct token *declaration_specifiers(struct token *token, struct decl_sta
 				break;
 			}
 			seen |= s->op->set;
-			class += s->op->class;
+			class += s->op->type_class;
 			if (s->op->set & Set_Int128)
 				rank = 3;
 			else if (s->op->set & Set_Char)
@@ -1727,11 +1727,11 @@ static int is_nested(struct token *token, struct token **p,
 	return 1;
 }
 
-enum kind {
+enum type_class {
 	Empty, K_R, Proto, Bad_Func,
 };
 
-static enum kind which_func(struct token *token,
+static enum type_class which_func(struct token *token,
 			    struct ident **n,
 			    int prefer_abstract)
 {
@@ -1792,14 +1792,14 @@ static struct token *direct_declarator(struct token *token, struct decl_state *c
 	}
 
 	if (match_op(token, '(')) {
-		enum kind kind = which_func(token, p, ctx->prefer_abstract);
+		enum type_class class = which_func(token, p, ctx->prefer_abstract);
 		struct symbol *fn;
 		fn = alloc_indirect_symbol(token->pos, ctype, SYM_FN);
 		ctype->modifiers |= ctx->f_modifiers;
 		token = token->next;
-		if (kind == K_R)
+		if (class == K_R)
 			token = identifier_list(token, fn);
-		else if (kind == Proto)
+		else if (class == Proto)
 			token = parameter_type_list(token, fn);
 		token = expect(token, ')', "in function declarator");
 		fn->endpos = token->pos;
diff --git a/pre-process.c b/pre-process.c
index 3fb250828fa6..ca069ed021dc 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -127,7 +127,7 @@ static void replace_with_integer(struct token *token, unsigned int val)
 static struct symbol *lookup_macro(struct ident *ident)
 {
 	struct symbol *sym = lookup_symbol(ident, NS_MACRO | NS_UNDEF);
-	if (sym && sym->namespace != NS_MACRO)
+	if (sym && sym->ns != NS_MACRO)
 		sym = NULL;
 	return sym;
 }
@@ -1359,7 +1359,7 @@ static int do_define(struct position pos, struct token *token, struct ident *nam
 		if (attr < sym->attr)
 			goto out;
 
-		clean = (attr == sym->attr && sym->namespace == NS_MACRO);
+		clean = (attr == sym->attr && sym->ns == NS_MACRO);
 
 		if (token_list_different(sym->expansion, expansion) ||
 		    token_list_different(sym->arglist, arglist)) {
@@ -1388,7 +1388,7 @@ static int do_define(struct position pos, struct token *token, struct ident *nam
 			__free_token(token);
 	}
 
-	sym->namespace = NS_MACRO;
+	sym->ns = NS_MACRO;
 	sym->used_in = NULL;
 	sym->attr = attr;
 out:
@@ -1526,7 +1526,7 @@ static int do_handle_undef(struct stream *stream, struct token **line, struct to
 	if (sym) {
 		if (attr < sym->attr)
 			return 1;
-		if (attr == sym->attr && sym->namespace == NS_UNDEF)
+		if (attr == sym->attr && sym->ns == NS_UNDEF)
 			return 1;
 	} else if (attr <= SYM_ATTR_NORMAL)
 		return 1;
@@ -1536,7 +1536,7 @@ static int do_handle_undef(struct stream *stream, struct token **line, struct to
 		bind_symbol(sym, left->ident, NS_MACRO);
 	}
 
-	sym->namespace = NS_UNDEF;
+	sym->ns = NS_UNDEF;
 	sym->used_in = NULL;
 	sym->attr = attr;
 
diff --git a/ptrlist.h b/ptrlist.h
index 5a3dcbeb97ae..e281309fb74d 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -28,6 +28,7 @@
 
 DECLARE_PTR_LIST(ptr_list, void);
 
+#ifndef __cplusplus
 
 void * undo_ptr_list_last(struct ptr_list **head);
 void * delete_ptr_list_last(struct ptr_list **head);
@@ -310,4 +311,5 @@ static inline void *tag_ptr(void *ptr, unsigned long tag)
 	return (void *)(tag | (unsigned long)ptr);
 }
 
+#endif // __cpluplus
 #endif /* PTR_LIST_H */
diff --git a/symbol.c b/symbol.c
index 91352a3a447b..5a8c638728ce 100644
--- a/symbol.c
+++ b/symbol.c
@@ -57,12 +57,12 @@ void access_symbol(struct symbol *sym)
 	}
 }
 
-struct symbol *lookup_symbol(struct ident *ident, enum namespace ns)
+struct symbol *lookup_symbol(struct ident *ident, enum name_space ns)
 {
 	struct symbol *sym;
 
 	for (sym = ident->symbols; sym; sym = sym->next_id) {
-		if (sym->namespace & ns) {
+		if (sym->ns & ns) {
 			sym->used = 1;
 			return sym;
 		}
@@ -696,7 +696,7 @@ void check_declaration(struct symbol *sym)
 	struct symbol *next = sym;
 
 	while ((next = next->next_id) != NULL) {
-		if (next->namespace != sym->namespace)
+		if (next->ns != sym->ns)
 			continue;
 		if (sym->scope == next->scope) {
 			sym->same_symbol = next;
@@ -730,7 +730,7 @@ static void inherit_static(struct symbol *sym)
 		return;
 
 	for (prev = sym->next_id; prev; prev = prev->next_id) {
-		if (prev->namespace != NS_SYMBOL)
+		if (prev->ns != NS_SYMBOL)
 			continue;
 		if (prev->scope != file_scope)
 			continue;
@@ -742,7 +742,7 @@ static void inherit_static(struct symbol *sym)
 	}
 }
 
-void bind_symbol_with_scope(struct symbol *sym, struct ident *ident, enum namespace ns, struct scope *scope)
+void bind_symbol_with_scope(struct symbol *sym, struct ident *ident, enum name_space ns, struct scope *scope)
 {
 	if (sym->bound) {
 		sparse_error(sym->pos, "internal error: symbol type already bound");
@@ -752,7 +752,7 @@ void bind_symbol_with_scope(struct symbol *sym, struct ident *ident, enum namesp
 		sparse_error(sym->pos, "Trying to use reserved word '%s' as identifier", show_ident(ident));
 		return;
 	}
-	sym->namespace = ns;
+	sym->ns = ns;
 	sym->next_id = ident->symbols;
 	ident->symbols = sym;
 	if (sym->ident && sym->ident != ident)
@@ -776,7 +776,7 @@ void bind_symbol_with_scope(struct symbol *sym, struct ident *ident, enum namesp
 	bind_scope(sym, scope);
 }
 
-void bind_symbol(struct symbol *sym, struct ident *ident, enum namespace ns)
+void bind_symbol(struct symbol *sym, struct ident *ident, enum name_space ns)
 {
 	struct scope *scope = block_scope;;
 
@@ -787,10 +787,10 @@ void bind_symbol(struct symbol *sym, struct ident *ident, enum namespace ns)
 	bind_symbol_with_scope(sym, ident, ns, scope);
 }
 
-struct symbol *create_symbol(int stream, const char *name, int type, int namespace)
+struct symbol *create_symbol(int stream, const char *name, int type, int ns)
 {
 	struct ident *ident = built_in_ident(name);
-	struct symbol *sym = lookup_symbol(ident, namespace);
+	struct symbol *sym = lookup_symbol(ident, ns);
 
 	if (sym && sym->type != type)
 		die("symbol %s created with different types: %d old %d", name,
@@ -800,7 +800,7 @@ struct symbol *create_symbol(int stream, const char *name, int type, int namespa
 		struct token *token = built_in_token(stream, ident);
 
 		sym = alloc_symbol(token->pos, type);
-		bind_symbol(sym, token->ident, namespace);
+		bind_symbol(sym, token->ident, ns);
 	}
 	return sym;
 }
diff --git a/symbol.h b/symbol.h
index 5270fcd73a10..503c9f092d46 100644
--- a/symbol.h
+++ b/symbol.h
@@ -40,7 +40,7 @@
  * token contains the information on where the symbol was
  * declared.
  */
-enum namespace {
+enum name_space {
 	NS_NONE = 0,
 	NS_MACRO = 1,
 	NS_TYPEDEF = 2,
@@ -134,7 +134,7 @@ struct symbol_op {
 	struct symbol *(*to_mode)(struct symbol *);
 	void (*asm_modifier)(struct token *token, unsigned long *mods, unsigned long mod);
 
-	int test, set, class;
+	int test, set, type_class;
 };
 
 
@@ -144,7 +144,7 @@ struct symbol_op {
 
 struct symbol {
 	enum type type:8;
-	enum namespace namespace:9;
+	enum name_space ns:9;
 	unsigned char used:1, attr:2, enum_member:1, bound:1;
 	struct position pos;		/* Where this symbol was declared */
 	struct position endpos;		/* Where this symbol ends*/
@@ -220,6 +220,8 @@ struct symbol {
 	pseudo_t pseudo;
 };
 
+#ifndef __cplusplus
+
 /* Modifiers */
 #define MOD_AUTO		0x00000001
 #define MOD_REGISTER		0x00000002
@@ -330,8 +332,8 @@ extern void access_symbol(struct symbol *);
 extern const char * type_difference(struct ctype *c1, struct ctype *c2,
 	unsigned long mod1, unsigned long mod2);
 
-extern struct symbol *lookup_symbol(struct ident *, enum namespace);
-extern struct symbol *create_symbol(int stream, const char *name, int type, int namespace);
+extern struct symbol *lookup_symbol(struct ident *, enum name_space);
+extern struct symbol *create_symbol(int stream, const char *name, int type, int ns);
 extern void init_symbols(void);
 extern void init_builtins(int stream);
 extern void init_linearized_builtins(int stream);
@@ -345,8 +347,8 @@ extern int show_symbol_expr_init(struct symbol *sym);
 extern void show_type_list(struct symbol *);
 extern void show_symbol_list(struct symbol_list *);
 extern void add_symbol(struct symbol_list **, struct symbol *);
-extern void bind_symbol(struct symbol *, struct ident *, enum namespace);
-extern void bind_symbol_with_scope(struct symbol *, struct ident *, enum namespace, struct scope *);
+extern void bind_symbol(struct symbol *, struct ident *, enum name_space);
+extern void bind_symbol_with_scope(struct symbol *, struct ident *, enum name_space, struct scope *);
 
 extern struct symbol *examine_symbol_type(struct symbol *);
 extern struct symbol *examine_pointer_target(struct symbol *);
@@ -552,7 +554,7 @@ static inline long long extend_value(long long val, struct symbol *ctype)
 	return bits_extend(val, size, is_signed);
 }
 
-static inline struct symbol *lookup_keyword(struct ident *ident, enum namespace ns)
+static inline struct symbol *lookup_keyword(struct ident *ident, enum name_space ns)
 {
 	if (!ident->keyword)
 		return NULL;
@@ -589,4 +591,5 @@ static inline void combine_address_space(struct position pos,
 	}
 }
 
+#endif	// __cplusplus
 #endif /* SYMBOL_H */
diff --git a/token.h b/token.h
index bccac0e4aba5..1f3601a94497 100644
--- a/token.h
+++ b/token.h
@@ -197,6 +197,8 @@ struct token {
 	};
 };
 
+#ifndef __cplusplus
+
 #define MAX_STRING 8191
 
 static inline struct token *containing_token(struct token **p)
@@ -249,4 +251,5 @@ static inline int match_token_zero(struct token *token)
 	return token->number[0] == '0' && !token->number[1];
 }
 
+#endif	// __cplusplus
 #endif

--64jrpd33gnofsvfn--
