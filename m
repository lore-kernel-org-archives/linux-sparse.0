From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 4/7] add a method to external_declaration()
Date: Sun, 5 Mar 2017 16:12:20 +0100
Message-ID: <20170305151220.rsfs5wpdfixhstor@macpro.local>
References: <20170228094635.qbod5dwqwrw6etvt@macbook.local>
 <20170228100403.33184-1-luc.vanoostenryck@gmail.com>
 <20170228100403.33184-5-luc.vanoostenryck@gmail.com>
 <CANeU7Qk34VzZ6Q2oxEcFrreK=NOwmpSGbiVgvyckpp154xWJaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:33468 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752431AbdCEPMZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Mar 2017 10:12:25 -0500
Received: by mail-wr0-f180.google.com with SMTP id u48so101203791wrc.0
        for <linux-sparse@vger.kernel.org>; Sun, 05 Mar 2017 07:12:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Qk34VzZ6Q2oxEcFrreK=NOwmpSGbiVgvyckpp154xWJaQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Mar 05, 2017 at 10:04:01PM +0800, Christopher Li wrote:
> I am fine with the code logic change. However, I wish function has better names.
> It just looking at the function name, "external_decl" vs "external_declaration",
> it is hard to guess which function is lower level than the other.

Sure. I didn't liked it myself but at the moment I didn't got something
better. I'll try harder.
 
> > -               }
> > +               if (!is_typedef)
> > +                       process_decl(list, decl);
> 
> I think here better check the process_decl is not NULL.
> The caller might issue NULL call back which means it is not
> interested in adding the symbol to a list.

Yes, we can and it's cheap but I think we'll always need a
callback here. And even if we don't, it's easy enough to provide
a callback that do nothing which avoid to always have to test the
pointer here to handle an hypothetical corner case.

> > +static void default_process_decl(struct symbol_list **list, struct symbol *decl)
> > +{
> > +       if (!(decl->ctype.modifiers & (MOD_EXTERN | MOD_INLINE))) {
> > +               add_symbol(list, decl);
> > +               fn_local_symbol(decl);
> > +       }
> 
> Again, if I look at just pure function name "default_process_decl", it is
> very hard to me to guess what should happen in this function.
> After all, "process a declare" is very generic, it can mean any thing.

Yes, sure, but the keyword here is 'default' like in "don't care what this
is doing, it's the that's correct for most/normal situations".

> I suggest a more meaningful name related what the code does.
> e.g. "track_local_declaration". I don't know, I want to find a better name.
> You are welcome to suggest a better one.

I'll look for one.

> > +}
> > +
> > +struct token *external_declaration(struct token *token, struct symbol_list **list)
> > +{
> > +       return external_decl(token, default_process_decl, list);
> > +}
> 
> If I don't have a better function name for external_decl, I might just not use
> the wrapper function at all.

Yes, OK.
And to be honest, the current name 'external_declaration()' is far
from being a good name eithers: it doesn't give a hint on *what*
the function is doing and it's not only for 'extern' declaration.

Luc
