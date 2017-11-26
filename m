From: Christopher Li <sparse@chrisli.org>
Subject: Re: [GIT PULL] llvm fixes
Date: Mon, 27 Nov 2017 01:42:55 +0800
Message-ID: <CANeU7Q=pZAuzju8EJACZ9HVKzM6C=L0PDY6xnid6Ub5=RkuXwg@mail.gmail.com>
References: <20170918095135.12066-1-luc.vanoostenryck@gmail.com>
 <20171117095147.a4v4alrcr77rafut@ltop.local> <CANeU7QnTtcKP9ukNqGmMzfVMviYwYEfYFhgLRHHGxCqR7sPGEQ@mail.gmail.com>
 <20171117195004.s472oqlldfrgiz2t@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yb0-f175.google.com ([209.85.213.175]:38083 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbdKZRm4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 26 Nov 2017 12:42:56 -0500
Received: by mail-yb0-f175.google.com with SMTP id v77so2726444ybi.5
        for <linux-sparse@vger.kernel.org>; Sun, 26 Nov 2017 09:42:56 -0800 (PST)
In-Reply-To: <20171117195004.s472oqlldfrgiz2t@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Nov 18, 2017 at 3:50 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>> Do you see any problem using the pseudo value with size patch?
>> Now it has the second patch to work with llvm as well. Should be testable.
>
> I already said in June-August that I tried this approach and that
> it didn't work (well, I'm sure that it is possible to make it work,
> it's just more complex that it seems).
>
> I'm sure it's testable (but what does that mean exactly?).
> I'm convinced it passes the testsuite and kernel check.
> But given that, as stated here above, nowhere in the code
> this information is needed, it's pretty normal that the
> changes have zero effect there. OTOH, these changes have
> impact on a few things related to the level below, thus
> *it is needed* to test things at IR level.
>
> Now, I have no hard problem with the PSEUDO_VAL.size
> approach from a theorical point of view (even if I would
> prefer the mathematical PoV that 0 is 0, 1 is 1, etc.).
> I even think that *eventually* it may very well be
> the right solution (probably the whole typing at IR
> level need to be revisited).

I think constant pseudo have a size is the right
solution in the long run. I

> On a practical level, things are differents:
> - The introduction of PSEUDO_VAL.size create
>   a segragation between pseudos of the same value
>   but different uses (different sizes).
>   This has impact on the CSE.
>   Admittingly, there shouldn't be any impact and it's
>   maybe a sign that something is wrong elsewhere.

As you said, it should be some thing CSE done wrong
to cause it a problem. The pseudo register has a size
being implicit on that. If CSE merge two instruction with
different source pseudo size into one, that seems wrong.

If you know a special test case can trigger that, I would
like to see it as well.

> - There are places in the code where kinds of implicit
>   castings are done (the OP_SET_* instructions are
>   especially concerned). Some may consider this as a
>   bug, to me it's at least a problem.
>   To solve the problems there you need to:
>   1) identify all places where such is done
>   2) look if the pseudo is a constant
>   3) if it is a constant, look at its type/size
>   4) make the needed adjustment.

If there is a size change during the implicit cast,
it can be a good thing to make the truncate and
size extend more obvious. I think you have some idea
relate to that.

Chris
