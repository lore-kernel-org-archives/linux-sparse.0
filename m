From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] fix: try_to_simplify_bb eargerness part 2
Date: Sun, 30 Jul 2017 11:38:04 -0400
Message-ID: <CANeU7QkYo13a+7wJMpEFWpXKdDGm4ufkn18Nvfh14x65FSUEGw@mail.gmail.com>
References: <20170729233805.lvdhpk5bnyaj5zq6@ltop.local> <20170729235850.22180-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35532 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbdG3PiF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 30 Jul 2017 11:38:05 -0400
Received: by mail-pf0-f179.google.com with SMTP id t86so2041838pfe.2
        for <linux-sparse@vger.kernel.org>; Sun, 30 Jul 2017 08:38:05 -0700 (PDT)
In-Reply-To: <20170729235850.22180-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Michael Stefaniuc <mstefani@mykolab.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Jul 29, 2017 at 7:58 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> This is a temptative patch for the wine infinitive loop.

First thing first, is this patch for this RC5 release or after the release ?

I have no objection for this patch. If you want me to apply it, I am
happy to.

That being said, I am still not very comfortable with this situation
even with the patch applied. The patch is definitely an improvement, it
stop at least one bug situation. I am not able to reason this patch to make
sure that is enough.

Yes, we observe from there is a case simplify a branch with bb has
some phi cause problem.

Does all phi cause problem? Or only phi has uninitialized value cause
problem? Will adding this check enough for all possible input source code?
There is a lot of unknown we can't answer. There is not a good theory behind
it we can reason and prove it one way or the other. That is what I feel
uncomfortable about, the unknown.

This "try and error" process is very scary. The more I read on this
subject, what is the recommended best practices in the academia,
The more I realized sparse has been doing a lot of stuff relate to optimization
wrong. The phi node placement as you point out is a big one, there are others.
That is my general observation, not reason to against you patch though.
That is way beyond the scope of this patch any way.

I will apply it. My feel that it is still work in progress, not perfect yet.

Chris
