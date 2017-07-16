From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse-next and preview of 0.5.1-rc5
Date: Sat, 15 Jul 2017 22:34:46 -0400
Message-ID: <CANeU7Qkt4+QsgrrwUSwiiJ_V77gnJgb5YW0qSwwx1-uu9-GhLw@mail.gmail.com>
References: <CANeU7Qk-9RcNkWoEL5-0AKyd2Q30BvtjfivEG_KgD4kAH-aEdA@mail.gmail.com>
 <20170715182159.ltikqlbe6rktxfhz@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33293 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbdGPCer (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 15 Jul 2017 22:34:47 -0400
Received: by mail-pg0-f53.google.com with SMTP id k14so62900051pgr.0
        for <linux-sparse@vger.kernel.org>; Sat, 15 Jul 2017 19:34:47 -0700 (PDT)
In-Reply-To: <20170715182159.ltikqlbe6rktxfhz@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>

On Sat, Jul 15, 2017 at 2:22 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> [Sorry, I'm on vacation and very little computer access].

I am very glad to heard that you are back.

>
> I still object to the kill_unreachable_bbs() patch and I ask
> to reconsider it in favor of the original one.

Of course.  I will hold the RC5 for you. I haven't push the change to
master yet. It is only in sparse-next, I can still roll back the change in we
wants to.

Can you show me some C input file that your original patch will do the
right thing and current one will miss the opportunity to simplify?
Even for the case it is just a suspect of producing worse code is fine.
Just point me to some test case, I will investigate and compare the
results.

My guess is that, there is a good chance some where missing a simplify
opportunity. If it does make a difference and I can't fix it in a timely manner.
Let's use your patch and deal with it after the release. In the long run, I
would prefer not using the two pass deletion of the dead bb, if they can
produce the similar level of optimized result.

> Since this has already been discussed, I can only invite to read
> again the original patch and the one it fixes where the situation
> is explained, I think, clearly.

The original patch does not have test case showing the byte code
difference with this two approach. I need some test examples :-)

Again, glad to know that you are back.

Chris
