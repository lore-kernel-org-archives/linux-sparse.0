From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 00/21] improve constexpr handling
Date: Wed, 23 Nov 2016 05:05:29 +0100
Message-ID: <20161123040528.GA74337@macpro.local>
References: <87lh75jh9l.fsf@gmail.com>
 <CANeU7QnzjJ5g+nGik21qsFAZ_5La3GOKVcTAx6=NOhVrVmrEQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:36608 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756167AbcKWEFe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 22 Nov 2016 23:05:34 -0500
Received: by mail-wj0-f196.google.com with SMTP id jb2so102589wjb.3
        for <linux-sparse@vger.kernel.org>; Tue, 22 Nov 2016 20:05:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7QnzjJ5g+nGik21qsFAZ_5La3GOKVcTAx6=NOhVrVmrEQA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Nicolai Stange <nicstange@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>

On Wed, Nov 23, 2016 at 11:12:02AM +0800, Christopher Li wrote:
> +static int a[] = {
> +       [(int)0] = 0,           // OK
> +       [(int)(int)0] = 0,      // OK
> +       [(int)0.] = 0,          // OK
> +       [(int)(int)0.] = 0,     // OK
> +       [(int)__builtin_choose_expr(0, 0, 0)] = 0,      // OK
> +       [(int)__builtin_choose_expr(0, 0, 0.)] = 0,     // OK
> +
> +       [(int)(float)0] = 0,    // KO
> 
> Why is this one KO? It seems perfectly fine to force a floating
> type into a integer constant expression.
> 
> per [6.6.6]  quote: on integer constant expression:
>  " and floating constants that are the
> immediate operands of casts. Cast operators in an integer constant
> expression shall only
> convert arithmetic types to integer types,"

But, quoting the beginning of 6.6/6:
    An integer constant expression shall have integer type and shall
    only have operands that are integer constants, enumeration constants,
    character constants, sizeof expressions whose results are integer
    constants, and **floating constants** that are the immediate operands
    of casts.

and the part '(float) 0' is none of these.

> +       [(int)(float)0.] = 0,   // KO
> +
> +       [(int)(void*)0] = 0,    // KO
> Also this one should be fine?

same for '(void *) 0'.

It's obvious for me and you that those once casted to (int) should
evaluate to '0' and thus are constant expression but the strict
interpretation of the standard say something else.

And to be honest, I find ridiculous that '(int) 0.0' is a integer
constant expression and '(int)(float)0' is not.

IIRC, Nicolai had foreseen to relax those if needed, possibly even
in one of the later patch or to introduce a '-Wstrict' option or
something like this.


Luc
