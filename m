Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736C33B2A2
	for <linux-sparse@vger.kernel.org>; Thu, 14 Dec 2023 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8XNj180"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2206FC433C9;
	Thu, 14 Dec 2023 13:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702559130;
	bh=vvWxHczSRZ54nyinw8QaMrRAsRULBqwm/eWYu/4ZY00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G8XNj180RGBpEPsz6VSicGYXDKdNOxMLGiIMll2SYQYP6CnHxeP10cZB5t/CBanQg
	 a8lVEU9znGpFW690A5nGi+l5t65D4jX6wA9idtUBkJB6udv6LjBlBNRqHzKaOR5x1I
	 mIPwJlSTup2AHmTBTIX+IgKl4S9Nq1bd6jUDWukzIuWwlT5fCUt4BvOjQiEjC+kfGf
	 2q2jkI4d7qrAjKgJUzTBvpsfHSQnL6A5R8F8LiUANX79YMfGZSdgzATZGbiQk2Oyuw
	 mQRP/v8xS76wdQfUFd3CfBqTcEr6hGlD9XQlBMz8aEKa95nN0M0W5yGQF923Lml9HR
	 56rW32K6Het8A==
Date: Thu, 14 Dec 2023 14:05:22 +0100
From: Luc Van Oostenryck <lucvoo@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	linux-sparse@vger.kernel.org
Subject: Re: [PATCH v2] parse: handle __cleanup__ attribute
Message-ID: <k6ztyjq24ik24qtsu3aqpipodzgq37i2ko42ag7wzn4t2ryrzf@i4gbxu7kvslt>
References: <8d596a06-9f25-4d9f-8282-deb2d03a6b0a@moroto.mountain>
 <i4s2gnr6rlq3yhmfiy7lkbsahnaioilksvmx3eocdjfh2434zo@zhxhwwgqpxt2>
 <44e22df1-734e-49c5-b20b-4f4cdbce24a6@suswa.mountain>
 <75ee8bd3-aa80-46dc-9f0c-874a8f4e9d48@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75ee8bd3-aa80-46dc-9f0c-874a8f4e9d48@suswa.mountain>

On Wed, Dec 13, 2023 at 01:14:29PM +0300, Dan Carpenter wrote:
> On Tue, Dec 12, 2023 at 12:39:40PM +0300, Dan Carpenter wrote:
> > > > @@ -2924,6 +2945,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
> > > >  
> > > >  	decl->ctype = ctx.ctype;
> > > >  	decl->ctype.modifiers |= mod;
> > > > +	decl->cleanup = ctx.cleanup;
> > > 
> > > Similarly, the attribute should only be applied to automatic variables,
> > > so this should not be needed/should be detected as an error.
> > > 
> > 
> > Yeah.  There are a couple other "cleanup" lines later in the function
> > that should be deleted as well, I see.
> 
> Hm...  Something went wrong.  When I remove this assignment then the
> cleanup function isn't saved here:

Mmmmhh yes, my bad.
I thought that the parsing functions followed closely the names of the
C grammar in the spec. They largely do but not in this case (they can't
because some context is needed to distinguish between 'declaration' and
'function-definition').

Would the following patch be OK for you when applied on top of your v2?
It contains:
- the attribute can be removed from the list of ignored attributes
- I prefer to add the "attribute_cleanup," on its own line
- I added some checks and a few corresponding testcases
- the s/D("__cleanup__"/D("cleanup"/
- and the removal of 'sym->cleanup = ctx.cleanup;' from typename() which
  I think is still unneeded.

Best regards,
-- Luc


diff --git a/gcc-attr-list.h b/gcc-attr-list.h
index c78001757229..928ea3889e01 100644
--- a/gcc-attr-list.h
+++ b/gcc-attr-list.h
@@ -24,7 +24,6 @@ GCC_ATTR(brk_interrupt)
 GCC_ATTR(callee_pop_aggregate_return)
 GCC_ATTR(cb)
 GCC_ATTR(cdecl)
-GCC_ATTR(cleanup)
 GCC_ATTR(cmse_nonsecure_call)
 GCC_ATTR(cmse_nonsecure_entry)
 GCC_ATTR(cold)
diff --git a/parse.c b/parse.c
index e5b5e6acc062..f868bf63a0f5 100644
--- a/parse.c
+++ b/parse.c
@@ -79,11 +79,11 @@ typedef struct token *attr_t(struct token *, struct symbol *,
 			     struct decl_state *);
 
 static attr_t
-	attribute_packed, attribute_aligned, attribute_cleanup,
-	attribute_modifier,
+	attribute_packed, attribute_aligned, attribute_modifier,
 	attribute_function,
 	attribute_bitwise,
 	attribute_address_space, attribute_context,
+	attribute_cleanup,
 	attribute_designated_init,
 	attribute_transparent_union, ignore_attribute,
 	attribute_mode, attribute_force;
@@ -542,7 +542,7 @@ static struct init_keyword {
 	/* Attributes */
 	D("packed",		&packed_op),
 	D("aligned",		&aligned_op),
-	D("__cleanup__",	&cleanup_op),
+	D("cleanup",		&cleanup_op),
 	D("nocast",		&attr_mod_op,		.mods = MOD_NOCAST),
 	D("noderef",		&attr_mod_op,		.mods = MOD_NODEREF),
 	D("safe",		&attr_mod_op,		.mods = MOD_SAFE),
@@ -1125,10 +1125,18 @@ static struct token *attribute_cleanup(struct token *token, struct symbol *attr,
 	struct expression *expr = NULL;
 
 	if (match_op(token, '(')) {
-		token = parens_expression(token, &expr, "in attribute");
+		token = token->next;
+		if (match_op(token, ')'))
+			sparse_error(token->pos, "an argument is expected for attribute 'cleanup'");
+		else if (token_type(token) != TOKEN_IDENT)
+			sparse_error(token->pos, "argument is not an identifier");
+		token = primary_expression(token, &expr);
 		if (expr && expr->type == EXPR_SYMBOL)
 			ctx->cleanup = expr;
+		return expect(token, ')', "after attribute's argument'");
 	}
+
+	sparse_error(token->pos, "an argument is expected for attribute 'cleanup'");
 	return token;
 }
 
@@ -1984,7 +1992,6 @@ struct token *typename(struct token *token, struct symbol **p, int *forced)
 	token = declarator(token, &ctx);
 	apply_modifiers(token->pos, &ctx);
 	sym->ctype = ctx.ctype;
-	sym->cleanup = ctx.cleanup;
 	sym->endpos = token->pos;
 	class = ctx.storage_class;
 	if (forced)
diff --git a/validation/parsing/attr-cleanup.c b/validation/parsing/attr-cleanup.c
new file mode 100644
index 000000000000..ac64649c2ac1
--- /dev/null
+++ b/validation/parsing/attr-cleanup.c
@@ -0,0 +1,33 @@
+#define __cleanup(F)	__attribute__((__cleanup__(F)))
+
+void fun(int *ptr);
+
+int test(int n);
+int test(int n)
+{
+	int var __attribute__((cleanup(fun))) = 1;
+	int alt __cleanup(fun) = 2;
+	int mis __cleanup(0) = 3;
+	int non __attribute__((cleanup));
+	int mis __attribute__((cleanup()));
+	int two __attribute__((cleanup(fun, fun)));
+
+        for (int i __cleanup(fun) = 0; i < n; i++)
+		;
+
+	var = 5;
+	return 0;
+}
+
+/*
+ * check-name: attr-cleanup
+ * check-command: sparse -Wunknown-attribute $file
+ *
+ * check-error-start
+parsing/attr-cleanup.c:10:17: error: argument is not an identifier
+parsing/attr-cleanup.c:11:39: error: an argument is expected for attribute 'cleanup'
+parsing/attr-cleanup.c:12:40: error: an argument is expected for attribute 'cleanup'
+parsing/attr-cleanup.c:13:43: error: Expected ) after attribute's argument'
+parsing/attr-cleanup.c:13:43: error: got ,
+ * check-error-end
+ */
