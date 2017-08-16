From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Some random thoughts regarding the SSA paper
Date: Wed, 16 Aug 2017 09:15:08 +0200
Message-ID: <20170816071507.tbbboeu7htdypweq@ltop.local>
References: <CANeU7QmcVS_8oko6RhG_g_97AjUNVYa=KDqDocbXL5ney=mrJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33340 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751212AbdHPHPM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 03:15:12 -0400
Received: by mail-wm0-f53.google.com with SMTP id k20so28303709wmg.0
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 00:15:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QmcVS_8oko6RhG_g_97AjUNVYa=KDqDocbXL5ney=mrJw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Wed, Aug 16, 2017 at 02:33:30AM -0400, Christopher Li wrote:
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

I think you mis-understnd the point.
Of course the CFG is needed at the end. The point of the article
is that with their method you don't have to *first* build
a CFG and a non-SSA representation and *then directly convert*
this into the SSA form (and maybe having to throw away most of
what was previously build) because their method construct
the CFG and the SSA form at once, directly from the AST.

In short it does the SSA construction directly during
the linearization. OTOH, with the current method (and the
traditional ones) we have first to linearize and do all
access to local vars as memory access and what all of this
is done, we need another pass which will create the SSA form
and destroy most load & write to these local vars.

-- Luc
