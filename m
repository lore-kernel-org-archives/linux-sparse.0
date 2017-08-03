From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH RFC] Let pseudo->users loop on duplicate version of list
Date: Thu, 3 Aug 2017 12:18:38 +0200
Message-ID: <20170803101835.qhxbyrvly3bhfxyd@ltop.local>
References: <CACXZuxeGmWGFbMmJCKi+aZbbxx89upb=_Vzqe7Ta99mOGHuVrg@mail.gmail.com>
 <CANeU7Qk+81ABEnGLxwbHnx510JWk7U8s=RnFqm_jM8pj-4EyDw@mail.gmail.com>
 <CACXZuxfxUDJKGcH6wFhnxmfXM9jxmMOKyO=5zswQvfGbE88=sw@mail.gmail.com>
 <CANeU7Qk8VCsj_EDBrj9H1bjR5a-_bLPQJiza_-eC90j=qiw7xw@mail.gmail.com>
 <20170719211437.7axhrrjrvr4k6dvg@ltop.local>
 <CANeU7QmQ4JmD_wLoZ6r7bV7Uu4BASnvuHpmQ7VKAoZXR9FD93w@mail.gmail.com>
 <CAMHZB6E9LkHc4KR5ktoS2MzZpZpW09h4_U8XH+PVE4HTmi1LcQ@mail.gmail.com>
 <CANeU7Qmr00XPkKgE_60TyZMToGwGOgzsqbb3Gwj1JqKTZ1PW_Q@mail.gmail.com>
 <CAExDi1Tt4P9oFZVoEL9yWwU4N_Te5ZEtNe=KcvAYJuaHtbEVyQ@mail.gmail.com>
 <CANeU7Qn+O=yXQP11uw-i2R0rmDCiyNsvFZX4M=zwLO-4-MJk_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37832 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbdHCKSs (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 3 Aug 2017 06:18:48 -0400
Received: by mail-wm0-f44.google.com with SMTP id t201so11205041wmt.0
        for <linux-sparse@vger.kernel.org>; Thu, 03 Aug 2017 03:18:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Qn+O=yXQP11uw-i2R0rmDCiyNsvFZX4M=zwLO-4-MJk_A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Aug 02, 2017 at 08:50:14PM -0400, Christopher Li wrote:
> On Wed, Aug 2, 2017 at 7:44 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >> http://marc.info/?l=linux-sparse&m=149987902920449&w=3
> >> ==========quote================
> >> Even Luc's suggestion for "mark and sweep" to delete the ptrlist
> >> is not going to help with the nested loop split. I will add that check.
> >> I don't expect new offenders but let's make sure about it.
> >> ==========end quote=============
> >
> > I don't think you understood what I meant.
> 
> I don't think so. Can you please explain?
> 
> Let's give it an example on the insert case.

Yes yes.
I already said the 7th July that reverse list walking and list
splitting will be another beast but the subject of this patch
is the *deletion* of elements from lists.
 
> > It's very simple: *all* lists need this 'treatement'.
> 
> I mean you need to identify the caller who is the outer loop, the outer
> loop caller need to do the list packing. That is what I mean by
> special treatment.
> If packing inside the inner loop, that is the problem we try to avoid.
> 
> That is assume we still pack list. If we never pack list, then it is
> not a problem
> here per say.

We don't have to pack all lists.
The ones that we pack can be packed at some specific place/moment.

> >
> > Walking twice?
> 
> I am more worry about the incorrect behavior on insert and packing
> than walk twice.
> 
> >
> > In general, we can't avoid nested loops.
> 
> I am thinking breaking the recursive calling into work queue.
> Then there is no nest loop. If you known why that will not work,
> please point out. I do assume I can convert the recursive call
> to non recursive using work queue. Again I haven't dig very deep yet.

Oh, I'm sure that using a work queue will work in some case.
I'm even sure that it's a good idea for some case. But I don't
think it will solve all problems because:
- some nested loops will remains
- it will be hard to avoid nested loops because we generaly don't
  know if we're nested or not. The mains ep - bbs - insns loop
  is obvious but what for other loops?
- using a work list is not without problems either. For example,
  we'll have no/few control over when things are effectively be
  done. Sometimes it will be fine, sometimes it won't be acceptable.
  If during some operation, we must delete *this* element or
  add a new element *here in the list* just pushing something
  on a work list and saying "OK, it will be done some time later"
  won't solve the problem, won't keep things coherent, ...

> >
> > Look at what is done currently with instructions: when we want to 'delete'
> > an instruction we simply set it's ->bb to NULL which basically means:
> > "for now, please just ignore this instruction". In other words, instructions
> > are *never* removed from their lists, they are simply marked as being
> > deleted. You don't need to know if you're in a nested loop or not.
> > You will never have the problem with deletion on nested list walking
> > because they are never removed from the lists.
> 
> Right, but does not help the insert case.

Sure, it's another problem.
 
> > Why do you think it has been done so?
> > Do you think it's bad and it would be better to effectively remove
> > instructions from their lists like others types?
> > Do you think it would be good or even possible to avoid having
> > nested loops of instructions?
> > I don't think so.
> 
> Please, I *do* understand why it is done that way. I am trying to point out that
> did not solve all the problem if inner function want to modify the list.
> aka insert. That seems to be the point haven't come across to you.
> 
> If you know how to solve the insert case, please explain.

Well, it's not as if saying "let's do everything with work queues"
solve anything in itself. It's a idea that would need lot of patches
and big changes in a lot of code to show if it's up to its promise
(and as I explain shortly here above, I have reasons to believe
that it won't be possible to solve all the list problems with it).

For the reverse walking and insert, I haven't thought much about
it yet. I won't be surprised that it will need some change in the
ptrlist struct & macros.
Maybe it's an operation that is not common enough that trying to ban
it wouldn't be a big constraint on existing & future code.
If all the ones we have go away once everything have been converted
to using work queues then fine, but what if they don't, what if
we can't convert everything to using work queues?

On the other hand, avoiding the problem of list deletion (which seems
to be an operation much more common than reverse & insert) by marking
deleted elements is something that can be done easily, with minimal
code impact and that *will* solve *all* problems with list deletion
(but yes, only list deletion).

-- Luc
