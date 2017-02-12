From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 2/3] allow builtins to have prototype and evaluate/expand
 methods
Date: Sun, 12 Feb 2017 16:03:33 +0100
Message-ID: <20170212150332.33xlxmzohgb7hrpp@macpro.local>
References: <20170123213728.89900-1-luc.vanoostenryck@gmail.com>
 <20170123213728.89900-3-luc.vanoostenryck@gmail.com>
 <CANeU7QkTLwcVq4Spv4CcZjpjuZybW1=39Z5hU=5Qu6jYGB8=EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35570 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbdBLPDh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Feb 2017 10:03:37 -0500
Received: by mail-wm0-f66.google.com with SMTP id u63so14608125wmu.2
        for <linux-sparse@vger.kernel.org>; Sun, 12 Feb 2017 07:03:37 -0800 (PST)
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
> 
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

OK, I've look at this.
The difference between your patch and mine is that yours share/
migrate the methods for all symbols while mine purposely did that
for builtins only. The reasons I did this way was to avoid to share
methods between things that don't need to, for example if someone
define a function that have the same name as one of the numerous
attributes (which are not reserved keywords and aren't necessarily
protected by leading double underscore). But having look at this now,
I see that it should never be a problem when this happen (but is it
a good idea?).

Anyway, I've retest with your patch and everything is fine, as
expected, and I'm sending a new version of the serie.

Luc
