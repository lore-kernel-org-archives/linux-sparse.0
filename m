From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Some random thoughts regarding the SSA paper
Date: Wed, 16 Aug 2017 10:55:09 +0100
Message-ID: <CACXZuxdnMFA5HPg3GXLWXP6+Mk8+UikcZsJZH8DJ227PYHyEfQ@mail.gmail.com>
References: <CANeU7QmcVS_8oko6RhG_g_97AjUNVYa=KDqDocbXL5ney=mrJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f179.google.com ([209.85.217.179]:33926 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751287AbdHPJzK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 05:55:10 -0400
Received: by mail-ua0-f179.google.com with SMTP id q25so11965120uah.1
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 02:55:10 -0700 (PDT)
In-Reply-To: <CANeU7QmcVS_8oko6RhG_g_97AjUNVYa=KDqDocbXL5ney=mrJw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>

Hi Chris,

On 16 August 2017 at 07:33, Christopher Li <sparse@chrisli.org> wrote:
> I have spend some time reading the paper
>
> http://compilers.cs.uni-saarland.de/papers/bbhlmz13cc.pdf
>
> "Simple and Efficient SSA Construction". Which is luc's SSA
> conversion is based on:
>
> Here is some random thoughts about the paper I might just
> share with you guys. If I make a mistake some where along
> the line, I am very glad if some one can point it out to me.
>
> - I think the main point of the paper doing SSA without
>   the CFG is not particular useful to us. We need to generate
>   CFG *anyway*.
>
> - The "Simple and Efficient" part has obvious limitation on
>   reducible graph. Once go over the fence of irreducible graph,
>    the solution is no longer simple nor efficient. For irreducible
>    graph it do need the CFG. That means the CFG is actuall
>    unavoidable consider source can have irreducible graph.
>

I would argue that the simplest possible solution is what we should
start with. The solution implemented based on this paper appears to be
simple and elegant - and if this works correctly then why go for more
complicated solutions? Theoretical scenarios are not very useful - in
my view, if the solution works now with all known inputs then it is
good enough.

>
> - Cytron might still be worthwhile to implement due to the better
>    worse case complexity.
>
>

Certainly you should prototype this - even if just to compare. But I
would suggest - lets merge the solution we have now. Additional
solutions are always good to have.

The great thing about Sparse I find is that it is smaller and simpler
than gcc or clang - and I would urge that this should be maintained.

Regards
Dibyendu
