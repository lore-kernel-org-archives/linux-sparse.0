Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76AE1A275
	for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2026 12:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792412189; cv=none; b=pXmNljuSQ/jgh+JHnQUT3KD1hsaZgPmx1dVN7j272Ik3bZ5TvjSvsANRRLaJDjmMtv1IDcQ3ESxoHoSHuhqdwcDktM0wh+oDmM/7XgplZuzDAl0kI1P2hsrchmtF0SvLi0ShWLhjz7VUqTD4VgEyNeMGN5DMpLm6iZdykW8i/zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792412189; c=relaxed/simple;
	bh=rmBunQBFp+1QL9mmqeDcIuq+Nieaxx/qv3UB6s/lLn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ivyk6W/BFDn/ECUoj9/moODW4NNOfoYY/rmlZB85lEltat45iuu/K3hZN4btMNUUEqKVG/qUZSUFkjo8vkNoPoG4fn7o3bj40iH39Brfsz1qs8rxvYqXiGmysqLlfsmfbyIZeuYLv3m4zylSjVdrT70dYEcjZXyIhObkKVWAs3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=1ccRZFkg; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="1ccRZFkg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1792412180;
	bh=tKWddZHFRQqEACtGax7J2gSAs8orBwxSZ4ySsPvUf5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=1ccRZFkgqkvDg/s1MAG54ZupU2eIQSUIVi1hpwEIvilxNrOQuxXUEHsDUv5DGW84r
	 8eQshNzQJ3AyNsinHWx1I03IgH6Jg8tpvw0g00G/gG6BTDNzn3PfWFdvlHSAhJj3Jz
	 vzeaXYI4w1p4cK8I0EakTfMf/h1NM4bgEMLwWbY8=
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 0457AFB812;
	Mon, 19 Oct 2026 12:16:19 +0000 (UTC)
Date: Mon, 19 Oct 2026 12:16:16 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Chris Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] accept an empty attribute argument list
Message-ID: <atYKEM2RE72WZFBi@shell.ilvokhin.com>
References: <20260605113045.483498-1-d@ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605113045.483498-1-d@ilvokhin.com>

On Fri, Jun 05, 2026 at 11:30:45AM +0000, Dmitry Ilvokhin wrote:
> GCC and clang accept an empty argument list for attributes, e.g.
> __attribute__((nonnull())), and treat it the same as the bare
> __attribute__((nonnull)). sparse instead rejects it with
> "an expression is expected before ')'".
> 
> ignore_attribute() and recover_unknown_attribute() consume the optional
> argument list with parens_expression(), which requires a non-empty
> expression, so an empty () is rejected. The bare form is fine because it
> takes no parentheses and skips that path.
> 
> This turned up in the Linux kernel: the cleanup.h guard macros expand
> __nonnull_args() to __attribute__((__nonnull__())).
> 
>   https://lore.kernel.org/all/aiJi0WcYE8FZt-jO@stanley.mountain/
> 
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> ---
>  parse.c                              | 17 +++++++++++++----
>  validation/attribute-nonnull-empty.c | 12 ++++++++++++
>  2 files changed, 25 insertions(+), 4 deletions(-)
>  create mode 100644 validation/attribute-nonnull-empty.c
> 
> diff --git a/parse.c b/parse.c
> index 9389079e..3b380156 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -1106,8 +1106,13 @@ static struct token *autotype_specifier(struct token *token, struct symbol *sym,
>  static struct token *ignore_attribute(struct token *token, struct symbol *attr, struct decl_state *ctx)
>  {
>  	struct expression *expr = NULL;
> -	if (match_op(token, '('))
> -		token = parens_expression(token, &expr, "in attribute");
> +	if (match_op(token, '(')) {
> +		/* Accept an empty argument list, e.g. __attribute__((nonnull())) */
> +		if (match_op(token->next, ')'))
> +			token = token->next->next;
> +		else
> +			token = parens_expression(token, &expr, "in attribute");
> +	}
>  	return token;
>  }
>  
> @@ -1362,8 +1367,12 @@ static struct token *recover_unknown_attribute(struct token *token)
>  	if (Wunknown_attribute)
>  		warning(token->pos, "unknown attribute '%s'", show_ident(token->ident));
>  	token = token->next;
> -	if (match_op(token, '('))
> -		token = parens_expression(token, &expr, "in attribute");
> +	if (match_op(token, '(')) {
> +		if (match_op(token->next, ')'))
> +			token = token->next->next;
> +		else
> +			token = parens_expression(token, &expr, "in attribute");
> +	}
>  	return token;
>  }
>  
> diff --git a/validation/attribute-nonnull-empty.c b/validation/attribute-nonnull-empty.c
> new file mode 100644
> index 00000000..c4021f61
> --- /dev/null
> +++ b/validation/attribute-nonnull-empty.c
> @@ -0,0 +1,12 @@
> +/*
> + * An empty attribute argument list, like __attribute__((nonnull())), is
> + * accepted by GCC and Clang (equivalent to the bare __attribute__((nonnull)))
> + * and must be parsed by sparse too.
> + */
> +extern void *bare (void *d, const void *s) __attribute__((nonnull));
> +extern void *empty(void *d, const void *s) __attribute__((nonnull()));
> +extern void *args (void *d, const void *s) __attribute__((nonnull(1, 2)));
> +
> +/*
> + * check-name: attribute with empty argument list
> + */
> -- 
> 2.53.0-Meta
>

Friendly ping on the patch.

Recently, I had some time to migrate raw __attribute__((nonnull)) usages
to __nonnull_args() in Linux kernel, but then remembered Sparse still
can't parse it properly.

I can re-spin the patch if it is a preferred.
