From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/7] Fix handling of ident-less declarations
Date: Sat, 14 Feb 2009 10:45:41 -0800
Message-ID: <70318cbf0902141045q2552f1aetdd0ba0e462a21bad@mail.gmail.com>
References: <E1LYJZx-0001ls-Nn@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:49256 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbZBNSpm (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 14 Feb 2009 13:45:42 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1057205rvb.1
        for <linux-sparse@vger.kernel.org>; Sat, 14 Feb 2009 10:45:41 -0800 (PST)
In-Reply-To: <E1LYJZx-0001ls-Nn@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

On Sat, Feb 14, 2009 at 4:25 AM, Al Viro <viro@ftp.linux.org.uk> wrote:
>
> The rule for ident-less declaration is

wow, great.

The series applies to the tree fine. First impression of the series
looks fine. I am still working on it.

Thanks for the patches. BTW, this is not the "lazy type evaluation"
you are talking about right?

Chris

>        declaration -> declaration-specifiers ;
> not
>        declaration -> declaration-specifiers abstract-declarator;
>
> IOW, struct foo; is OK and so's struct foo {int x; int y;} (and even
> simply int; is allowed by syntax - it's rejected by constraints, but
> that's a separate story), but not struct foo (void); and its ilk.
>
> See C99 6.7p1 for syntax; C90 is the same in that area and gcc also
> behaves the same way.  Unlike gcc I've made it a warning (gcc produces
> a hard error for those).
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  parse.c                    |   10 +++++++++-
>  validation/missing-ident.c |   18 ++++++++++++++++++
>  2 files changed, 27 insertions(+), 1 deletions(-)
>  create mode 100644 validation/missing-ident.c
>
> diff --git a/parse.c b/parse.c
> index 73e7b65..6100fc2 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -2265,14 +2265,22 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
>        token = declaration_specifiers(token, &ctype, 0);
>        decl = alloc_symbol(token->pos, SYM_NODE);
>        decl->ctype = ctype;
> +       /* Just a type declaration? */
> +       if (match_op(token, ';')) {
> +               apply_modifiers(token->pos, &decl->ctype);
> +               return token->next;
> +       }
> +
>        token = declarator(token, decl, &ident, 0);
>        apply_modifiers(token->pos, &decl->ctype);
>
>        decl->endpos = token->pos;
>
>        /* Just a type declaration? */
> -       if (!ident)
> +       if (!ident) {
> +               warning(token->pos, "missing identifier in declaration");
>                return expect(token, ';', "end of type declaration");
> +       }
>
>        /* type define declaration? */
>        is_typedef = (ctype.modifiers & MOD_TYPEDEF) != 0;
> diff --git a/validation/missing-ident.c b/validation/missing-ident.c
> new file mode 100644
> index 0000000..ce73983
> --- /dev/null
> +++ b/validation/missing-ident.c
> @@ -0,0 +1,18 @@
> +int [2];
> +int *;
> +int (*);
> +int ();
> +int;
> +struct foo;
> +union bar {int x; int y;};
> +struct baz {int x, :3, y:2;};
> +/*
> + * check-name: handling of identifier-less declarations
> + *
> + * check-error-start
> +missing-ident.c:1:8: warning: missing identifier in declaration
> +missing-ident.c:2:6: warning: missing identifier in declaration
> +missing-ident.c:3:8: warning: missing identifier in declaration
> +missing-ident.c:4:7: warning: missing identifier in declaration
> + * check-error-end
> + */
> --
> 1.5.6.6
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
