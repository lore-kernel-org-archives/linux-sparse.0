From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH RFC] Let pseudo->users loop on duplicate version of list
Date: Fri, 4 Aug 2017 12:38:37 +0200
Message-ID: <20170804103835.ahb3dv2t2ictuvwf@ltop.local>
References: <20170719211437.7axhrrjrvr4k6dvg@ltop.local>
 <CANeU7QmQ4JmD_wLoZ6r7bV7Uu4BASnvuHpmQ7VKAoZXR9FD93w@mail.gmail.com>
 <CAMHZB6E9LkHc4KR5ktoS2MzZpZpW09h4_U8XH+PVE4HTmi1LcQ@mail.gmail.com>
 <CANeU7Qmr00XPkKgE_60TyZMToGwGOgzsqbb3Gwj1JqKTZ1PW_Q@mail.gmail.com>
 <CAExDi1Tt4P9oFZVoEL9yWwU4N_Te5ZEtNe=KcvAYJuaHtbEVyQ@mail.gmail.com>
 <CANeU7Qn+O=yXQP11uw-i2R0rmDCiyNsvFZX4M=zwLO-4-MJk_A@mail.gmail.com>
 <20170803101835.qhxbyrvly3bhfxyd@ltop.local>
 <CANeU7Q=nH-mfJ4=ggHhN2xCS9OPHZhUPPXkXd9HGoc6gEhGm7w@mail.gmail.com>
 <20170804004110.ctq3w6lcv5jclur7@ltop.local>
 <CANeU7Q=qSLDM99=S3btE1OqZ_n_nHChtYvqi8H_48EHhc04JkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:37677 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbdHDKil (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 06:38:41 -0400
Received: by mail-wr0-f182.google.com with SMTP id 33so15221604wrz.4
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 03:38:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=qSLDM99=S3btE1OqZ_n_nHChtYvqi8H_48EHhc04JkA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Aug 03, 2017 at 10:22:34PM -0400, Christopher Li wrote:
> On Thu, Aug 3, 2017 at 8:41 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >>
> >> Can you give an example what nest looping will have to remain.
> >
> > Can you give the assurance that none will remains?
> 
> I can have the ptr ref count patch to check if such thing
> happen. But I am sure that is not what you are asking :-)

It was a rethorical question as a reponse to your own question
because your own asking to show something while we're talking
design and potentiality doesn't help at all.

> >> Converting recursive call into work queue without recursive
> >> is pretty stander algorithm. In theory, as long as you defer
> >> the inner loop calling into the work queue. It can always
> >> avoid the nest looping. In the extreme case you can think
> >> the work queue holding a copy of the list and move the inner
> >> loop body to the outer work queue.
> >
> > *standard algorithm*, *in theory*, ...
> 
> I am actually don't worry about weather it can be done or not.
> I am sure you don't need me to google converting recursion
> to iteration for you.

1) Converting a recursive algo to an iterative one is not always
   a good solution, for example the iterative one can be much
   more complex/less elegant. You may also need more memory
   (because you often need to store additional info).
   A typical example is searching in a tree: it can be done
   with iteration but it's generaly not done because the
   recursive version is so much simpler & elegant (and probably
   efficient too).
2) Converting something to a work queue is not the same as
   converting recursion to iteration anyway.
   Recursion vs. iteration is something about how walking through
   a data structure. Using a work queue is about how/when doing an
   operation on an object.

An example among other of complications you can have when converting
to work queue is something like:
Imagine you're iterating through a list of instruction checking/
searching after something. If found, you want to do an operation
on the instruction just found.
Sound like something for a work queue, right? Just put the
object you found in the work queue and let do the operation later.
Now what if the operation is about inserting another instruction
just before the one just found (like done when adding death notes)?
- if you do it immediatly, you have the context of the instruction
  and inserting the death notes is easy/cheap
- if you do the insertion later when processing the work queue
  you won't have anymore the context of the instruction
  and to insert the death note you will first have to 
  search after it (to have the context back) before you will
  be able to do the insertion and this search will cost you.

It's just an example but there is a whole class of similar situations.
Delaying thing by moving it to a work queue will also have negative
impact on cache (but in a way, it's also a problem of having lost the
context).

And again, I'm not telling that using workqueue is never a good solution,
I'm saying that most probably it won't always be a good solution.

-- Luc
