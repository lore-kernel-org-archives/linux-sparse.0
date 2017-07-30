From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] fix: try_to_simplify_bb eargerness part 2
Date: Sun, 30 Jul 2017 13:06:32 -0400
Message-ID: <CANeU7Qk+UOfbiggFDC5YfGGiWQVeGrarTsqk0DKsA==Gp_ndyw@mail.gmail.com>
References: <20170729233805.lvdhpk5bnyaj5zq6@ltop.local> <20170729235850.22180-1-luc.vanoostenryck@gmail.com>
 <CANeU7QkYo13a+7wJMpEFWpXKdDGm4ufkn18Nvfh14x65FSUEGw@mail.gmail.com> <CAMHZB6ECGgH4GAaMow9NN4x-NZhb5T7H44KjjUE2L9=iyWUYFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35753 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754109AbdG3RGe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 30 Jul 2017 13:06:34 -0400
Received: by mail-pg0-f50.google.com with SMTP id v190so129379956pgv.2
        for <linux-sparse@vger.kernel.org>; Sun, 30 Jul 2017 10:06:34 -0700 (PDT)
In-Reply-To: <CAMHZB6ECGgH4GAaMow9NN4x-NZhb5T7H44KjjUE2L9=iyWUYFA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Michael Stefaniuc <mstefani@mykolab.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Jul 30, 2017 at 12:04 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> It's was draft/temptative patch for -rc5.
>
Thanks for the clarification.

>
> Please don't, I'm still working on it.

Of course, I don't apply it now. I will wait for your git pull to apply.

> I don't like at all this situation also.
> The problem is quite complex and deep.
>
> This patch seems to solve the problem and (at least something
> similar) is needed but my first analysis was also right and thus something
> similar is still needed for simplify_branch_branch().
>
> Also, the revert would not be a good solution because it would
> only avoid to trigger the problem on this input but won't solve anything.

I totally agree. The revert is temporary bandage to buy us more time to fix
the real problem. That is well understood. We still have the question to answer
will RC5 and follow up official release have the revert or not.

Currently I am leaning towards keep the revert for this release but I can
be convinced otherwise.

> The problem is unrelated to undefined *var* but these wrong branch
> simplification bypass some pseudo definition which, in a way,
> become undefined on some paths which then create the problem
> you saw with setne %r11, %r11, 0

Yes, we all know "setne %r11, %r11, 0" is the big offender.
We just don't have a clear picture why it get there.

> Well, I don't see things exactly the same.
> For me, there is a code base, there are bugs in the code,
> we discover the bugs and we fix them.

Sorry that came out wrong, I mean to said there is some more
deeper issue.

> But yes, this is quite annoying, especially with try_to_simplify_bb()
> on which I already spend many hours on it.

I also spend many hours on it haven't able to crack it yet. The best I can
do is make it simplify the original huge test input as a much smaller
test case.

"Help me, Obi-Wan Kenobi. You're my only hope."


> The two big things that need to be fixed regarding optimization are:
> - the placement of the phi-node
> - associate each phi's source to the phi-node's parent
>   (Linus may object on this, he at least objected 10 years ago)

We will revisit this after the release. I have my wish list as well.

Right now let's solve this bug first. At least come to a decision
what to do with it on the upcoming release.

Chris
