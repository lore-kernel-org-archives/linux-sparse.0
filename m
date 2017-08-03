From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH RFC] Let pseudo->users loop on duplicate version of list
Date: Thu, 3 Aug 2017 19:48:59 -0400
Message-ID: <CANeU7Q=nH-mfJ4=ggHhN2xCS9OPHZhUPPXkXd9HGoc6gEhGm7w@mail.gmail.com>
References: <CACXZuxeGmWGFbMmJCKi+aZbbxx89upb=_Vzqe7Ta99mOGHuVrg@mail.gmail.com>
 <CANeU7Qk+81ABEnGLxwbHnx510JWk7U8s=RnFqm_jM8pj-4EyDw@mail.gmail.com>
 <CACXZuxfxUDJKGcH6wFhnxmfXM9jxmMOKyO=5zswQvfGbE88=sw@mail.gmail.com>
 <CANeU7Qk8VCsj_EDBrj9H1bjR5a-_bLPQJiza_-eC90j=qiw7xw@mail.gmail.com>
 <20170719211437.7axhrrjrvr4k6dvg@ltop.local> <CANeU7QmQ4JmD_wLoZ6r7bV7Uu4BASnvuHpmQ7VKAoZXR9FD93w@mail.gmail.com>
 <CAMHZB6E9LkHc4KR5ktoS2MzZpZpW09h4_U8XH+PVE4HTmi1LcQ@mail.gmail.com>
 <CANeU7Qmr00XPkKgE_60TyZMToGwGOgzsqbb3Gwj1JqKTZ1PW_Q@mail.gmail.com>
 <CAExDi1Tt4P9oFZVoEL9yWwU4N_Te5ZEtNe=KcvAYJuaHtbEVyQ@mail.gmail.com>
 <CANeU7Qn+O=yXQP11uw-i2R0rmDCiyNsvFZX4M=zwLO-4-MJk_A@mail.gmail.com> <20170803101835.qhxbyrvly3bhfxyd@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36297 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751804AbdHCXtA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 3 Aug 2017 19:49:00 -0400
Received: by mail-pf0-f196.google.com with SMTP id t83so183298pfj.3
        for <linux-sparse@vger.kernel.org>; Thu, 03 Aug 2017 16:49:00 -0700 (PDT)
In-Reply-To: <20170803101835.qhxbyrvly3bhfxyd@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Aug 3, 2017 at 6:18 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Wed, Aug 02, 2017 at 08:50:14PM -0400, Christopher Li wrote:
>> On Wed, Aug 2, 2017 at 7:44 PM, Luc Van Oostenryck
>> <luc.vanoostenryck@gmail.com> wrote:
>> >> http://marc.info/?l=linux-sparse&m=149987902920449&w=3
>> >> ==========quote================
>> >> Even Luc's suggestion for "mark and sweep" to delete the ptrlist
>> >> is not going to help with the nested loop split. I will add that check.
>> >> I don't expect new offenders but let's make sure about it.
>> >> ==========end quote=============
>> >
>> > I don't think you understood what I meant.
>>
>> I don't think so. Can you please explain?
>>
>> Let's give it an example on the insert case.
>
> Yes yes.
> I already said the 7th July that reverse list walking and list
> splitting will be another beast but the subject of this patch
> is the *deletion* of elements from lists.

The text you quote from me clearing is discussing node split here.
" nested loop *split*". Even though the title of the email was original
about delete. The discussion expand to split because I haven't realize
that is a problem earlier. I consider this as the same category delete.
It is basically looping and modify the list at the same time.
I want to find a solution to solve this both situations.

> We don't have to pack all lists.
> The ones that we pack can be packed at some specific place/moment.

Right, we need to make sure the packing *never* call from the same list
looping body. There is no easy way to find out this did not happen.

>> I am thinking breaking the recursive calling into work queue.
>> Then there is no nest loop. If you known why that will not work,
>> please point out. I do assume I can convert the recursive call
>> to non recursive using work queue. Again I haven't dig very deep yet.
>
> Oh, I'm sure that using a work queue will work in some case.
> I'm even sure that it's a good idea for some case. But I don't
> think it will solve all problems because:
> - some nested loops will remains

Can you give an example what nest looping will have to remain.

Converting recursive call into work queue without recursive
is pretty stander algorithm. In theory, as long as you defer
the inner loop calling into the work queue. It can always
avoid the nest looping. In the extreme case you can think
the work queue holding a copy of the list and move the inner
loop body to the outer work queue.

In reality, we don't want to move every thing into work queue.
I think the loop just observe. Defer the modification into work queue
is relative conceptually clean.

> - it will be hard to avoid nested loops because we generaly don't
>   know if we're nested or not. The mains ep - bbs - insns loop

We don't mind nested looping as long as we don't modify it.
We can always know that we are about to modify the bb or insns.
That is a good place to move to the work queue.

My mental model is that, have the detect and modify phase.
The detect phase do all the looping as needed. Look but don't touch.
The modify request is push into work queue and execute after the
loop has been done.

>   is obvious but what for other loops?
> - using a work list is not without problems either. For example,
>   we'll have no/few control over when things are effectively be
>   done. Sometimes it will be fine, sometimes it won't be acceptable.
>   If during some operation, we must delete *this* element or
>   add a new element *here in the list* just pushing something
>   on a work list and saying "OK, it will be done some time later"
>   won't solve the problem, won't keep things coherent, ...

That usually means you have some other things need to defer as well.
You don't have to do it on the spot on the loop. Have a work queue is
actually easier to reason and enforce such ordering.
You can consider our current CSE loop as a poor form of work queue.
It just have one bit of flag for each stage. It does not point to which
insn need to be changed.

You can think it this way, the delete mark and sweep is just another way
to defer the delete as well. In the extreme case, we defer to never delete.

>>
>> If you know how to solve the insert case, please explain.
>
> Well, it's not as if saying "let's do everything with work queues"
> solve anything in itself. It's a idea that would need lot of patches
> and big changes in a lot of code to show if it's up to its promise
> (and as I explain shortly here above, I have reasons to believe
> that it won't be possible to solve all the list problems with it).

Right. It need a lot of discussion and patch experiment. Definitely
after the release.

As I said in the other email. If you have better  patch to solve the
nest loop delete on pseudo list for RC5. Feel free to replace the
current one on sparse. I am aware of the current solution is not perfect.
It can iterate on deleted ptr entry.

>
> For the reverse walking and insert, I haven't thought much about
> it yet. I won't be surprised that it will need some change in the
> ptrlist struct & macros.
> Maybe it's an operation that is not common enough that trying to ban
> it wouldn't be a big constraint on existing & future code.

I think that is let the tail wag the dog. Plus, I can demonstrate,
node split in FOR_EACH_PTR() can also have incorrect behavior as well.
Basically node split will change list->list[] and list->nr. That can have
impact on forward iteration too. The reverse one is just more obvious.


> If all the ones we have go away once everything have been converted
> to using work queues then fine, but what if they don't, what if
> we can't convert everything to using work queues?

We will have to use bigger hammer.  In short, it is going to be ugly.
e.g. have the list node has ref count and a pending change single list.

>
> On the other hand, avoiding the problem of list deletion (which seems
> to be an operation much more common than reverse & insert) by marking
> deleted elements is something that can be done easily, with minimal
> code impact and that *will* solve *all* problems with list deletion
> (but yes, only list deletion).

Yes, I consider that as a short term thing until we find a better way to handle
more general modification including insert.

Chris
