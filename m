From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH RFC] Let pseudo->users loop on duplicate version of list
Date: Wed, 2 Aug 2017 20:50:14 -0400
Message-ID: <CANeU7Qn+O=yXQP11uw-i2R0rmDCiyNsvFZX4M=zwLO-4-MJk_A@mail.gmail.com>
References: <CANeU7QmpvfZutvnSwrjH7ZYXhw3S3HDh19eHXkBGY7oz7ADtmw@mail.gmail.com>
 <CANeU7Q=d_+QD+MSGyYqwL82M2RdC_AFVaeR-y87z3U3OKjNBKw@mail.gmail.com>
 <CACXZuxerM5i33YgKn=GfnWQe+pViCUfUmJ10sz0K-+PjG28uwA@mail.gmail.com>
 <CANeU7QkTAQ6XaAGrd1PmQ_4Jcv2vxD-cK_9+kKFbyX5b+Pg+Wg@mail.gmail.com>
 <CACXZuxeGmWGFbMmJCKi+aZbbxx89upb=_Vzqe7Ta99mOGHuVrg@mail.gmail.com>
 <CANeU7Qk+81ABEnGLxwbHnx510JWk7U8s=RnFqm_jM8pj-4EyDw@mail.gmail.com>
 <CACXZuxfxUDJKGcH6wFhnxmfXM9jxmMOKyO=5zswQvfGbE88=sw@mail.gmail.com>
 <CANeU7Qk8VCsj_EDBrj9H1bjR5a-_bLPQJiza_-eC90j=qiw7xw@mail.gmail.com>
 <20170719211437.7axhrrjrvr4k6dvg@ltop.local> <CANeU7QmQ4JmD_wLoZ6r7bV7Uu4BASnvuHpmQ7VKAoZXR9FD93w@mail.gmail.com>
 <CAMHZB6E9LkHc4KR5ktoS2MzZpZpW09h4_U8XH+PVE4HTmi1LcQ@mail.gmail.com>
 <CANeU7Qmr00XPkKgE_60TyZMToGwGOgzsqbb3Gwj1JqKTZ1PW_Q@mail.gmail.com> <CAExDi1Tt4P9oFZVoEL9yWwU4N_Te5ZEtNe=KcvAYJuaHtbEVyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:32920 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751188AbdHCAuQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 2 Aug 2017 20:50:16 -0400
Received: by mail-pf0-f182.google.com with SMTP id d67so27491684pfc.0
        for <linux-sparse@vger.kernel.org>; Wed, 02 Aug 2017 17:50:16 -0700 (PDT)
In-Reply-To: <CAExDi1Tt4P9oFZVoEL9yWwU4N_Te5ZEtNe=KcvAYJuaHtbEVyQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Aug 2, 2017 at 7:44 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>> http://marc.info/?l=linux-sparse&m=149987902920449&w=3
>> ==========quote================
>> Even Luc's suggestion for "mark and sweep" to delete the ptrlist
>> is not going to help with the nested loop split. I will add that check.
>> I don't expect new offenders but let's make sure about it.
>> ==========end quote=============
>
> I don't think you understood what I meant.

I don't think so. Can you please explain?

Let's give it an example on the insert case.

The outer loop is doing

FOR_EACH_PTR_REVERSE(bbs, bb) {
             /* the outer loop macro is holding the
               __nr = list->nr;
                __list = list;
                It is using __nr as the slot number point to the current slot.
              */

              ...
              add_bb(bbs, new_bb);
              /* now list->list[] array has been split.
                   list->nr has less entry.
                __nr does not know about that. it is not  going to
point to the right element */

              ...
} END_FOR_EACH_PTR_REVERSE(bb);

The key insight here is that, we need to preserv list->list[] array not changed,
also list->nr not changed for make reverse ptr loop work.

For the delete case, set bb->ep = NULL; marking the bb dead works.
It does not touch list->list[] nor list->nr. As long as you skip the bb which
bb->ep == NULL you are fine.

Let's look at the insert case.

regardless how you set bb->ep. When you insert the new bb into the list,
the list split will modify list->list[] and list->nr. There is no way
to defer that.
It *will* mess up with the outer loop __nr slot pointer.

How does your purpose method handle this case?
Please explain. I am listening.

>
>> http://marc.info/?l=linux-sparse&m=149969288517115&w=3
>> =============quote===============
>>> I earlier suggested to instead change the way elements are 'deleted'
>>> (like instructions are already never removed from their list but
>>> just marked as deleted).
>>
>> That looks simple but it has hidden complications as well. The issue is that
>> we need to find out which list need this kind of special treatment.
>
> It's very simple: *all* lists need this 'treatement'.

I mean you need to identify the caller who is the outer loop, the outer
loop caller need to do the list packing. That is what I mean by
special treatment.
If packing inside the inner loop, that is the problem we try to avoid.

That is assume we still pack list. If we never pack list, then it is
not a problem
here per say. But we still need to deal with the insert problem.

>
> Walking twice?

I am more worry about the incorrect behavior on insert and packing
than walk twice.

>
> In general, we can't avoid nested loops.

I am thinking breaking the recursive calling into work queue.
Then there is no nest loop. If you known why that will not work,
please point out. I do assume I can convert the recursive call
to non recursive using work queue. Again I haven't dig very deep yet.

>
> Look at what is done currently with instructions: when we want to 'delete'
> an instruction we simply set it's ->bb to NULL which basically means:
> "for now, please just ignore this instruction". In other words, instructions
> are *never* removed from their lists, they are simply marked as being
> deleted. You don't need to know if you're in a nested loop or not.
> You will never have the problem with deletion on nested list walking
> because they are never removed from the lists.

Right, but does not help the insert case.


>
> Why do you think it has been done so?
> Do you think it's bad and it would be better to effectively remove
> instructions from their lists like others types?
> Do you think it would be good or even possible to avoid having
> nested loops of instructions?
> I don't think so.

Please, I *do* understand why it is done that way. I am trying to point out that
did not solve all the problem if inner function want to modify the list.
aka insert. That seems to be the point haven't come across to you.

If you know how to solve the insert case, please explain.

Chris
