From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH RFC] Let pseudo->users loop on duplicate version of list
Date: Fri, 4 Aug 2017 02:41:12 +0200
Message-ID: <20170804004110.ctq3w6lcv5jclur7@ltop.local>
References: <CACXZuxfxUDJKGcH6wFhnxmfXM9jxmMOKyO=5zswQvfGbE88=sw@mail.gmail.com>
 <CANeU7Qk8VCsj_EDBrj9H1bjR5a-_bLPQJiza_-eC90j=qiw7xw@mail.gmail.com>
 <20170719211437.7axhrrjrvr4k6dvg@ltop.local>
 <CANeU7QmQ4JmD_wLoZ6r7bV7Uu4BASnvuHpmQ7VKAoZXR9FD93w@mail.gmail.com>
 <CAMHZB6E9LkHc4KR5ktoS2MzZpZpW09h4_U8XH+PVE4HTmi1LcQ@mail.gmail.com>
 <CANeU7Qmr00XPkKgE_60TyZMToGwGOgzsqbb3Gwj1JqKTZ1PW_Q@mail.gmail.com>
 <CAExDi1Tt4P9oFZVoEL9yWwU4N_Te5ZEtNe=KcvAYJuaHtbEVyQ@mail.gmail.com>
 <CANeU7Qn+O=yXQP11uw-i2R0rmDCiyNsvFZX4M=zwLO-4-MJk_A@mail.gmail.com>
 <20170803101835.qhxbyrvly3bhfxyd@ltop.local>
 <CANeU7Q=nH-mfJ4=ggHhN2xCS9OPHZhUPPXkXd9HGoc6gEhGm7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33424 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751866AbdHDAlQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 3 Aug 2017 20:41:16 -0400
Received: by mail-wr0-f193.google.com with SMTP id y43so2002962wrd.0
        for <linux-sparse@vger.kernel.org>; Thu, 03 Aug 2017 17:41:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=nH-mfJ4=ggHhN2xCS9OPHZhUPPXkXd9HGoc6gEhGm7w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Aug 03, 2017 at 07:48:59PM -0400, Christopher Li wrote:
> On Thu, Aug 3, 2017 at 6:18 AM, Luc Van Oostenryck wrote:
> > We don't have to pack all lists.
> > The ones that we pack can be packed at some specific place/moment.
> 
> Right, we need to make sure the packing *never* call from the same list
> looping body. There is no easy way to find out this did not happen.
> 
> >> I am thinking breaking the recursive calling into work queue.
> >> Then there is no nest loop. If you known why that will not work,
> >> please point out. I do assume I can convert the recursive call
> >> to non recursive using work queue. Again I haven't dig very deep yet.
> >
> > Oh, I'm sure that using a work queue will work in some case.
> > I'm even sure that it's a good idea for some case. But I don't
> > think it will solve all problems because:
> > - some nested loops will remains
> 
> Can you give an example what nest looping will have to remain.

Can you give the assurance that none will remains? 

I said "I think that ..." and of course, I have reasons to
think so. It was explained here under.

> Converting recursive call into work queue without recursive
> is pretty stander algorithm. In theory, as long as you defer
> the inner loop calling into the work queue. It can always
> avoid the nest looping. In the extreme case you can think
> the work queue holding a copy of the list and move the inner
> loop body to the outer work queue.

*standard algorithm*, *in theory*, ...
 
> In reality, we don't want to move every thing into work queue.
> I think the loop just observe. Defer the modification into work queue
> is relative conceptually clean.
> 
> > - it will be hard to avoid nested loops because we generaly don't
> >   know if we're nested or not. The mains ep - bbs - insns loop
> 
> We don't mind nested looping as long as we don't modify it.
> We can always know that we are about to modify the bb or insns.
> That is a good place to move to the work queue.
> 
> My mental model is that, have the detect and modify phase.
> The detect phase do all the looping as needed. Look but don't touch.
> The modify request is push into work queue and execute after the
> loop has been done.
> 
> >   is obvious but what for other loops?
> > - using a work list is not without problems either. For example,
> >   we'll have no/few control over when things are effectively be
> >   done. Sometimes it will be fine, sometimes it won't be acceptable.
> >   If during some operation, we must delete *this* element or
> >   add a new element *here in the list* just pushing something
> >   on a work list and saying "OK, it will be done some time later"
> >   won't solve the problem, won't keep things coherent, ...
> 
> That usually means you have some other things need to defer as well.
> You don't have to do it on the spot on the loop. Have a work queue is
> actually easier to reason and enforce such ordering.

You have all the advantages to decouple things and
you have all the disadvantges to have decoupled things.
It's not a B&W thing.

> > Well, it's not as if saying "let's do everything with work queues"
> > solve anything in itself. It's a idea that would need lot of patches
> > and big changes in a lot of code to show if it's up to its promise
> > (and as I explain shortly here above, I have reasons to believe
> > that it won't be possible to solve all the list problems with it).
> 
> Right. It need a lot of discussion and patch experiment. Definitely
> after the release.

I think you very seriously underestimate the amount of work that will
need to be done.
 
> As I said in the other email. If you have better  patch to solve the
> nest loop delete on pseudo list for RC5. Feel free to replace the
> current one on sparse. I am aware of the current solution is not perfect.
> It can iterate on deleted ptr entry.

I just send a patch.
It's not very pretty and is only lightly tested but IMO it's vastly
superior to the duplication of list.

> > For the reverse walking and insert, I haven't thought much about
> > it yet. I won't be surprised that it will need some change in the
> > ptrlist struct & macros.
> > Maybe it's an operation that is not common enough that trying to ban
> > it wouldn't be a big constraint on existing & future code.
> 
> I think that is let the tail wag the dog. Plus, I can demonstrate,
> node split in FOR_EACH_PTR() can also have incorrect behavior as well.

Yes yes, we know that since the beginning.

> > If all the ones we have go away once everything have been converted
> > to using work queues then fine, but what if they don't, what if
> > we can't convert everything to using work queues?
> 
> We will have to use bigger hammer.  In short, it is going to be ugly.
> e.g. have the list node has ref count and a pending change single list.

Other solutions exist :)
 
> > On the other hand, avoiding the problem of list deletion (which seems
> > to be an operation much more common than reverse & insert) by marking
> > deleted elements is something that can be done easily, with minimal
> > code impact and that *will* solve *all* problems with list deletion
> > (but yes, only list deletion).
> 
> Yes, I consider that as a short term thing until we find a better way to handle
> more general modification including insert.

Good to hear that.

-- Luc
