From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 2/3] allow builtins to have prototype and evaluate/expand
 methods
Date: Tue, 7 Feb 2017 21:12:54 +0100
Message-ID: <20170207201253.4i2ye6inqwma65rf@macpro.local>
References: <20170123213728.89900-1-luc.vanoostenryck@gmail.com>
 <20170123213728.89900-3-luc.vanoostenryck@gmail.com>
 <CANeU7QkTLwcVq4Spv4CcZjpjuZybW1=39Z5hU=5Qu6jYGB8=EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35432 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752811AbdBGUVk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Feb 2017 15:21:40 -0500
Received: by mail-wr0-f195.google.com with SMTP id o16so6530892wra.2
        for <linux-sparse@vger.kernel.org>; Tue, 07 Feb 2017 12:21:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7QkTLwcVq4Spv4CcZjpjuZybW1=39Z5hU=5Qu6jYGB8=EA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Chris Li <christ.li@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>

On Wed, Feb 08, 2017 at 03:49:54AM +0800, Chris Li wrote:
> On Tue, Jan 24, 2017 at 5:37 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > So far, builtin functions which had some evaluate/expand method
> > couldn't also have a prototype because each would have its own symbol
> > and only the one for the prototype will be seen.
> > This also meant that the evaluate/expand functions had to take care
> > to set the correct types for they argumenst & results, which is fine
> > for some generic builtins like __builtin_constant_p() it's much less
> > practical for the ones like __builtin_bswap{16,32,64}().
> >
> > Fix this by marking the idents for the builtins we declare some
> > evaluate/expand methods has being the ident of a builtin function
> > and later at evaluation time, to share the methods between all the symbols
> > corresponding to an identifier so marked.
> 
> This certainly fix the problem for builtin functions. However, I think there
> is more general bug in sparse not limit to builtin functions. When the symbol
> is declare twice, the later one did not migrate all the declare information from
> the previous one.

I'm very well aware of this bug/problem, it creates all sort of complications
but I vaguely understood it was a design choice. To be 100%, you're talking
the fact that each declaration create a new symbol only related by their
identifier chain, right?

> In function external_declaration()
> 
>         check_declaration(decl);
>         if (decl->same_symbol)
>                 decl->definition = decl->same_symbol->definition;
> 
> Here it only migrates the definition. I think if you add symbol->op in
> the migration
> as well, it *should* work for your case. I haven't test this myself.
> If that works for you, it is a more general fix. Want to give it a try?
> 
> We might want to extract the migration code into a new function and
> later adding new code it. e.g. function attributes.

Yes and diagnose any compatibility.
I'll give it a try but I won't be able to do that before the weekend.

Luc
