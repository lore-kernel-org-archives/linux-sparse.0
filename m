From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse-next and preview of 0.5.1-rc5
Date: Wed, 19 Jul 2017 20:19:02 -0700
Message-ID: <CANeU7QkevpEdcp-WmM820sjJ4-LhVyPHeGHETh64WG3jPzewhA@mail.gmail.com>
References: <CANeU7Qk-9RcNkWoEL5-0AKyd2Q30BvtjfivEG_KgD4kAH-aEdA@mail.gmail.com>
 <20170715182159.ltikqlbe6rktxfhz@ltop.local> <CANeU7Qkt4+QsgrrwUSwiiJ_V77gnJgb5YW0qSwwx1-uu9-GhLw@mail.gmail.com>
 <20170719221738.2gkctzmdjajz4uec@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:32935 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933025AbdGTDTD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 19 Jul 2017 23:19:03 -0400
Received: by mail-pg0-f44.google.com with SMTP id k14so8602700pgr.0
        for <linux-sparse@vger.kernel.org>; Wed, 19 Jul 2017 20:19:03 -0700 (PDT)
In-Reply-To: <20170719221738.2gkctzmdjajz4uec@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Jul 19, 2017 at 3:17 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Even now, I'm not really back. Just taking time to reply here
> while I have the opportunity to.

OK. Good to know then guessing


>> Can you show me some C input file that your original patch will do the
>> right thing and current one will miss the opportunity to simplify?
>> Even for the case it is just a suspect of producing worse code is fine.
>> Just point me to some test case, I will investigate and compare the
>> results.
>
> Test cases are test cases and code is code.
>
> I'll copy here verbatim the commit message of the patch that was fixed
> by the original patch (the one that had "Fixes: 51cfbc90a5e1462fcd624a1598ecd985a508a5d6

I still don't have a valid test case to difference sparse-next
and your patch series.

If your test case is that switch statement, I make a test case
out of it. Sparse-next and yoru patch show the same result
bytecode wise:

int *ptr;
int foo(int *p, int i)
{

switch (i - i) {        // will be optimized to 0
case 0:                 // will be the simple branch
return 0;
case 1:                 // will be optimized away
p = ptr;
do {            // will be an unreachable loop
   *p++ = 123;
} while (--i);
}
return 1;
}

$ ./test-linearize /tmp/d.c
/tmp/d.c:1:5: warning: symbol 'ptr' was not declared. Should it be static?
/tmp/d.c:2:5: warning: symbol 'foo' was not declared. Should it be static?
foo:
.L0:
<entry-point>
ret.32      $0

You know what I want. I want the test case can show sparse-next
have bug or less optimal than your series. If every thing else is
the same, the one in sparse-next is simpler.

>
>         commit 51cfbc90a5e1462fcd624a1598ecd985a508a5d6
>         Author: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>         Date:   2017-04-26 12:21:21 +0200
>
>             fix: kill unreachable BBs after killing a child
>
>             When simplifying a switch into a simple branch all the now
>             unused children of the current BB must be removed.
>             If one of these children become now orphaned, it is directly
>             killed (it will need to be killed soon or later since it is
>             unreachable).
>
>             However, if one of the killed children is the header of a loop
>             where some variables are updated this may cause problems.
>             Indeed, by killing the header (which contains the phisrc of
>             the entry value of the variable) the whole loop may become
>             unreachable but is not killed yet, OTOH simplification of
>             the associated OP_PHI may create a cycle which may then be
>             detected later by simplify_one_memop() which will issue a
>             "crazy programmer" warning while the programmer was innocent.

That sounds very much like the wine dead loop case recently report on
the mailing list. I think you are likely having a bug elsewhere make you
believe that you have to kill instruction there. I just tested, your patches
will do the dead loop on the wine test C file as well. We might talking about
the same bug.
>
>             This situation can be seen in code like:
>                     int *p;
>                     switch (i - i) {        // will be optimized to 0
>                     case 0:                 // will be the simple branch
>                             return 0;
>                     case 1:                 // will be optimized away
>                             p = ptr;
>                             do {            // will be an unreachable loop
>                                     *p++ = 123;
>                             } while (--i);
>                     }
>
>             Fix this by calling kill_unreachable_bbs() after having
>             simplified the switch into a branch. This will avoid to
>             create a cycle with because of the removed phisrc in the
>             header and as an added benefit will avoid to waste time
>             trying to simplify BBs that are unreachable.
>
>             In addition, it's now useless to call kill_bb() for each
>             removed switch's children as kill_unreachable_bbs() will
>             do that too.

The simple patch in sparse-next has the same output result

> It's not at all a problem of some missing optimization opportunity.
> It's a problem of applying some optimization (OP_PHI simplification)
> and then giving a warning for the consequence of this optimization
> (the "crazy programmer" warning) in incorrect conditions/wrong
> assumption (a variable must not be considered as undefined if it
> is part of an unreachable BB, it should just be ignored).
>
> I hope it is clear enough now.

Can you show me a test C code trigger the problem?

> I also assure that instead of quickly rewriting someone's patch
> (because you don't like it and think you can do better) it would
> be so much better to simply:
I did.
> - *say* what you don't like in the patch

Might have simpler way.

> - *ask* why things are done like this way

I also did. I repeatedly ask for the test C code that show the bug
if I don't immediately remove the dead code.

> - *ask* if things couldn't be done this other way instead.

Same as above. Show me the code please. I would much rather
looking at the test C code that demo the problem than arguing here.

Chris
