From: "Mitesh Shah" <mshah@teja.com>
Subject: RE: attributes are not stored at right location for array variables
Date: Wed, 31 Jan 2007 14:33:28 -0800
Message-ID: <AKEOJDDJLNPHDAKOMMBHAEAIDAAA.mshah@teja.com>
References: <70318cbf0701311153k126d4aeam5f68f1c519d3a7af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.teja.com ([209.10.202.133]:34880 "EHLO mail.teja.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751614AbXAaWdJ (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 31 Jan 2007 17:33:09 -0500
In-Reply-To: <70318cbf0701311153k126d4aeam5f68f1c519d3a7af@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Chris Li <christ.li@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>


Yes, there are attributes that can be applied to types so I do not want to change that.

The problem I am seeing is only with array variables and if you see the function direct_delcalartor, when it starts processing array
variables, the ctye gets reassigned with the type of the variables instead of the ctype of the variable itself and in the next
iteration the attribute will be applied to the ctype of the type of the variable.

May be a patch specific to array variable will solve the problem.

Thanks,

-Mitesh



> -----Original Message-----
> From: Chris Li [mailto:christ.li@gmail.com]
> Sent: Wednesday, January 31, 2007 11:54 AM
> To: Mitesh Shah
> Cc: Linux-Sparse
> Subject: Re: attributes are not stored at right location for array
> variables
>
>
> Your patch assumes every attribute apply to node instead of type.
> Is there any attribute need to apply to type instead?
>
> For your change, apply_modifiers() need to change where it take the
> __mode__ attribute as well.
>
> Chris
>
>
> On 1/31/07, Mitesh Shah <mshah@teja.com> wrote:
> >
> > It seems that the attributes are not stored with the variable ctype when the variable is an array. For declaration such as,
> >
> > char c[100] __attribute__((aligned(64)));
> >
> > The attribute is stored with the array ctype instead of the variable C ctype.
> >
> > In function direct_declarator in parse.c at line 920 the ctype gets replaced with the array ctype and in the next
> iteration it is
> > passed to handle_attributes. handle_attributes should be passed the original ctype so here is the patch.
> >
> > Thanks,
> >
> > -Mitesh
> >
> > -------------------------------------------------------
> >
> > index 5077ee6..306b144 100644
> > --- a/parse.c
> > +++ b/parse.c
> > @@ -881,7 +881,7 @@ static struct token *direct_declarator(struct token *token, struct symbol *decl,
> >         }
> >
> >         for (;;) {
> > -               token = handle_attributes(token, ctype);
> > +               token = handle_attributes(token, &decl->ctype);
> >
> >                 if (token_type(token) != TOKEN_SPECIAL)
> >                         return token;
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
>
