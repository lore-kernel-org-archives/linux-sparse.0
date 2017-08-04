From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH RFC] Let pseudo->users loop on duplicate version of list
Date: Thu, 3 Aug 2017 22:22:34 -0400
Message-ID: <CANeU7Q=qSLDM99=S3btE1OqZ_n_nHChtYvqi8H_48EHhc04JkA@mail.gmail.com>
References: <CACXZuxfxUDJKGcH6wFhnxmfXM9jxmMOKyO=5zswQvfGbE88=sw@mail.gmail.com>
 <CANeU7Qk8VCsj_EDBrj9H1bjR5a-_bLPQJiza_-eC90j=qiw7xw@mail.gmail.com>
 <20170719211437.7axhrrjrvr4k6dvg@ltop.local> <CANeU7QmQ4JmD_wLoZ6r7bV7Uu4BASnvuHpmQ7VKAoZXR9FD93w@mail.gmail.com>
 <CAMHZB6E9LkHc4KR5ktoS2MzZpZpW09h4_U8XH+PVE4HTmi1LcQ@mail.gmail.com>
 <CANeU7Qmr00XPkKgE_60TyZMToGwGOgzsqbb3Gwj1JqKTZ1PW_Q@mail.gmail.com>
 <CAExDi1Tt4P9oFZVoEL9yWwU4N_Te5ZEtNe=KcvAYJuaHtbEVyQ@mail.gmail.com>
 <CANeU7Qn+O=yXQP11uw-i2R0rmDCiyNsvFZX4M=zwLO-4-MJk_A@mail.gmail.com>
 <20170803101835.qhxbyrvly3bhfxyd@ltop.local> <CANeU7Q=nH-mfJ4=ggHhN2xCS9OPHZhUPPXkXd9HGoc6gEhGm7w@mail.gmail.com>
 <20170804004110.ctq3w6lcv5jclur7@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33044 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbdHDCWg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 3 Aug 2017 22:22:36 -0400
Received: by mail-pf0-f180.google.com with SMTP id d67so2120784pfc.0
        for <linux-sparse@vger.kernel.org>; Thu, 03 Aug 2017 19:22:35 -0700 (PDT)
In-Reply-To: <20170804004110.ctq3w6lcv5jclur7@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Aug 3, 2017 at 8:41 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>>
>> Can you give an example what nest looping will have to remain.
>
> Can you give the assurance that none will remains?

I can have the ptr ref count patch to check if such thing
happen. But I am sure that is not what you are asking :-)

If you follow the observe and modify model. Put the modify
stage on the outer loop. Modify only one thing at  a time.
Then it is easy to reason weather "nest loop modify" exist.

What you are asking in more general setting is not going to
have trivial answer any way. It is equivalent of the truing halting
problem.

On the other hand, if you want to disprove this, you only need
one counter example.


>> Converting recursive call into work queue without recursive
>> is pretty stander algorithm. In theory, as long as you defer
>> the inner loop calling into the work queue. It can always
>> avoid the nest looping. In the extreme case you can think
>> the work queue holding a copy of the list and move the inner
>> loop body to the outer work queue.
>
> *standard algorithm*, *in theory*, ...

I am actually don't worry about weather it can be done or not.
I am sure you don't need me to google converting recursion
to iteration for you.

The question is weather it can be done on sparse cleanly.
It is hard to say without trying.


> You have all the advantages to decouple things and
> you have all the disadvantges to have decoupled things.
> It's not a B&W thing.

It is a white-gray-black thing if you know what I mean :-)
Black is the terminate condition.

>> > Well, it's not as if saying "let's do everything with work queues"
>> > solve anything in itself. It's a idea that would need lot of patches
>> > and big changes in a lot of code to show if it's up to its promise
>> > (and as I explain shortly here above, I have reasons to believe
>> > that it won't be possible to solve all the list problems with it).
>>
>> Right. It need a lot of discussion and patch experiment. Definitely
>> after the release.
>
> I think you very seriously underestimate the amount of work that will
> need to be done.

I realize there will be a lot of change. But actually sparse will need ssa
version of the dead code removal (correctness) and ssa version of constant
propagation any way. (performance, current we scan the whole insn list
to find out
optimization opportunity). A lot of similar algorithm already using work
queue. Some rewrites is expected as far as I can tell.

> I just send a patch.
> It's not very pretty and is only lightly tested but IMO it's vastly
> superior to the duplication of list.

I haven't see it. I saw there is an constant expression patch on the
mailing list.

>> I think that is let the tail wag the dog. Plus, I can demonstrate,
>> node split in FOR_EACH_PTR() can also have incorrect behavior as well.
>
> Yes yes, we know that since the beginning.

Then why ban reverse ptr loop? It is not going to help avoid the bad
situation.

>> We will have to use bigger hammer.  In short, it is going to be ugly.
>> e.g. have the list node has ref count and a pending change single list.
>
> Other solutions exist :)

Yes, idea and patch welcome.

Chris
