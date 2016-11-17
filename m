From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] cleanup: remove evaluate_arguments()'s unused argument
Date: Thu, 17 Nov 2016 17:57:52 +0800
Message-ID: <CANeU7Q=SJXw41JNRLJtKGOCgEPSnWhKZyRfMicS=suJwH73LNg@mail.gmail.com>
References: <20161102171623.17883-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:38375 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934622AbcKQJ5y (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 04:57:54 -0500
Received: by mail-it0-f44.google.com with SMTP id j191so36120042ita.1
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2016 01:57:53 -0800 (PST)
In-Reply-To: <20161102171623.17883-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Nov 3, 2016 at 1:16 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Was slightly confusing when reading some code.
> Better to remove it.
>
> @@ -2885,7 +2885,7 @@ static struct symbol *evaluate_call(struct expression *expr)
>                 if (!sym->op->args(expr))
>                         return NULL;
>         } else {
> -               if (!evaluate_arguments(sym, ctype, arglist))
> +               if (!evaluate_arguments(ctype, arglist))
>                         return NULL;

I think this is more or less fine, even though sym is not currently
used in evaluate_arguments().
ctype contain the function declare which usually is in a line earlier
than the call expression.
The "sym" argument in the most common case contain the symbol node,
the ctype contain
the base function type.

One case might be useful for "exvaluate_arguments" to use symbol node
is to output
the beginning position of the call expression. The "fn" symbol point
to the previous line
and arglist in the later part of the expression.

As I said, the node argument is currently not used. If you feel
strongly about it
I am fine with removing it as well.

Or maybe change it to "node" instead of "f", will that be better to understand?

Chris
