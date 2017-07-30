From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] fix: try_to_simplify_bb eargerness part 2
Date: Sun, 30 Jul 2017 18:04:49 +0200
Message-ID: <CAMHZB6ECGgH4GAaMow9NN4x-NZhb5T7H44KjjUE2L9=iyWUYFA@mail.gmail.com>
References: <20170729233805.lvdhpk5bnyaj5zq6@ltop.local> <20170729235850.22180-1-luc.vanoostenryck@gmail.com>
 <CANeU7QkYo13a+7wJMpEFWpXKdDGm4ufkn18Nvfh14x65FSUEGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:37790 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753963AbdG3QEv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 30 Jul 2017 12:04:51 -0400
Received: by mail-qk0-f170.google.com with SMTP id z18so56744105qka.4
        for <linux-sparse@vger.kernel.org>; Sun, 30 Jul 2017 09:04:50 -0700 (PDT)
In-Reply-To: <CANeU7QkYo13a+7wJMpEFWpXKdDGm4ufkn18Nvfh14x65FSUEGw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Michael Stefaniuc <mstefani@mykolab.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Jul 30, 2017 at 5:38 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Sat, Jul 29, 2017 at 7:58 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> This is a temptative patch for the wine infinitive loop.
>
> First thing first, is this patch for this RC5 release or after the release ?

It's was draft/temptative patch for -rc5.

> I have no objection for this patch. If you want me to apply it, I am
> happy to.

Please don't, I'm still working on it.

> That being said, I am still not very comfortable with this situation
> even with the patch applied. The patch is definitely an improvement, it
> stop at least one bug situation. I am not able to reason this patch to make
> sure that is enough.

I don't like at all this situation also.
The problem is quite complex and deep.

This patch seems to solve the problem and (at least something
similar) is needed but my first analysis was also right and thus something
similar is still needed for simplify_branch_branch().

Also, the revert would not be a good solution because it would
only avoid to trigger the problem on this input but won't solve anything.

> Yes, we observe from there is a case simplify a branch with bb has
> some phi cause problem.
>
> Does all phi cause problem? Or only phi has uninitialized value cause
> problem?

The problem is unrelated to undefined *var* but these wrong branch
simplification bypass some pseudo definition which, in a way,
become undefined on some paths which then create the problem
you saw with setne %r11, %r11, 0

> Will adding this check enough for all possible input source code?
> There is a lot of unknown we can't answer. There is not a good theory behind
> it we can reason and prove it one way or the other. That is what I feel
> uncomfortable about, the unknown.

You're not alone.

> This "try and error" process is very scary.

Well, I don't see things exactly the same.
For me, there is a code base, there are bugs in the code,
we discover the bugs and we fix them.

But yes, this is quite annoying, especially with try_to_simplify_bb()
on which I already spend many hours on it.

> The more I realized sparse has been doing a lot of stuff relate to optimization
> wrong. The phi node placement as you point out is a big one, there are others.
> That is my general observation, not reason to against you patch though.
> That is way beyond the scope of this patch any way.

The two big things that need to be fixed regarding optimization are:
- the placement of the phi-node
- associate each phi's source to the phi-node's parent
  (Linus may object on this, he at least objected 10 years ago)
The last point will then allow tfix some issues I'm aware of regarding
liveness and make things much easier when manipulating phis.

-- Luc
