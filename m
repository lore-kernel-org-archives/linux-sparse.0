From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] dissect: introduce sym_is_local() for reporter
Date: Wed, 12 Feb 2020 10:06:27 +0100
Message-ID: <20200212090626.GA19406@redhat.com>
References: <20200211160136.GA14027@redhat.com>
 <20200212004135.cyzcqtwwcuewa4gj@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38617 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728150AbgBLJGh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Feb 2020 04:06:37 -0500
In-Reply-To: <20200212004135.cyzcqtwwcuewa4gj@ltop.local>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

On 02/12, Luc Van Oostenryck wrote:
>
> On Tue, Feb 11, 2020 at 05:01:36PM +0100, Oleg Nesterov wrote:
> > Can be used to filter out the usage of local variables.
>
> ...
>
> > diff --git a/dissect.h b/dissect.h
> > index efe2c0b..178dba5 100644
> > --- a/dissect.h
> > +++ b/dissect.h
> > @@ -27,6 +27,11 @@ struct reporter
> >
> >  extern struct symbol *dissect_ctx;
> >
> > +static inline bool sym_is_local(struct symbol *sym)
> > +{
> > +	return sym->kind == 'v' && !(sym->ctype.modifiers & MOD_TOPLEVEL);
> > +}
> > +
>
> Shouldn't MOD_STATIC be added to the test?

perhaps I misread bind_symbol() ... but it seems to me MOD_TOPLEVEL is
enough. bind_symbol() does

	scope = block_scope;
	if (ns == NS_SYMBOL && toplevel(scope)) {
		mod = MOD_ADDRESSABLE | MOD_TOPLEVEL;
		...
		sym->ctype.modifiers |= mod;
	}

toplevel(block_scope) should be true after start_file_scope() sets
"block_scope = file_scope" and until start_function_scope(), right?

> It depends on what exactly you want for 'local'.

Yes, it should only return T if the symbol was defined inside some function.
If we have

	static int I;

in file scope, sym_is_local() should return false and so it does, test-dissect
outputs

	1:12                   def   v I                                int

Thanks for looking!

Oleg.
