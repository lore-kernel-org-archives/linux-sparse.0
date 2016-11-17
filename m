From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] cleanup: remove evaluate_arguments()'s unused argument
Date: Thu, 17 Nov 2016 12:13:37 +0100
Message-ID: <20161117111336.GA499@macpro.local>
References: <20161102171623.17883-1-luc.vanoostenryck@gmail.com>
 <CANeU7Q=SJXw41JNRLJtKGOCgEPSnWhKZyRfMicS=suJwH73LNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36835 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964825AbcKQLNo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 06:13:44 -0500
Received: by mail-wm0-f46.google.com with SMTP id g23so303664709wme.1
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2016 03:13:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=SJXw41JNRLJtKGOCgEPSnWhKZyRfMicS=suJwH73LNg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Nov 17, 2016 at 05:57:52PM +0800, Christopher Li wrote:
> On Thu, Nov 3, 2016 at 1:16 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > Was slightly confusing when reading some code.
> > Better to remove it.
> >
> > @@ -2885,7 +2885,7 @@ static struct symbol *evaluate_call(struct expression *expr)
> >                 if (!sym->op->args(expr))
> >                         return NULL;
> >         } else {
> > -               if (!evaluate_arguments(sym, ctype, arglist))
> > +               if (!evaluate_arguments(ctype, arglist))
> >                         return NULL;
> 
> I think this is more or less fine, even though sym is not currently
> used in evaluate_arguments().
> ctype contain the function declare which usually is in a line earlier
> than the call expression.
> The "sym" argument in the most common case contain the symbol node,
> the ctype contain
> the base function type.
> 
> One case might be useful for "exvaluate_arguments" to use symbol node
> is to output
> the beginning position of the call expression. The "fn" symbol point
> to the previous line
> and arglist in the later part of the expression.
> 
> As I said, the node argument is currently not used. If you feel
> strongly about it
> I am fine with removing it as well.

Not much important to me, but said above, it's confusing: two args,
one called 'f', the other one 'fn' and one of them is unused ...

> Or maybe change it to "node" instead of "f", will that be better to understand?
Not much I think, 'node' has even less meaning to me than 'f'or 'fn'.
Better then to focus on the (potential) purpose of this arg.
If it's for the position, maybe pass only sym->pos.

But again, it's not important at all. Let not waste our time on it.

Luc
