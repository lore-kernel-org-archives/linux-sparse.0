From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH RFC] Let pseudo->users loop on duplicate version of list
Date: Wed, 19 Jul 2017 19:34:14 -0700
Message-ID: <CANeU7Qmr00XPkKgE_60TyZMToGwGOgzsqbb3Gwj1JqKTZ1PW_Q@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36871 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932115AbdGTCeP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 19 Jul 2017 22:34:15 -0400
Received: by mail-pg0-f46.google.com with SMTP id y129so8044903pgy.4
        for <linux-sparse@vger.kernel.org>; Wed, 19 Jul 2017 19:34:15 -0700 (PDT)
In-Reply-To: <CAMHZB6E9LkHc4KR5ktoS2MzZpZpW09h4_U8XH+PVE4HTmi1LcQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Jul 19, 2017 at 3:51 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Some add_user() can be called in this loop. so it's just a question
> to some input code complex enough to have an add_user()
> done on the same pseudo as the one concerned in the outer
> loop.

Can you point me to a call stack that trigger the add_user()?

I have run the full kernel compile did not trigger it. The other two
nested loop delete was catches within the first 15 files or so.

> I stated several times that the only real solution will be to mark the
> elements as being deleted (and only effectively delete them in some
> safe situations) exactly like it is done for instruction (which are probably
> the type the most often deleted from lists. Trying to effectively
> removing them from lists like it is currently done for the others types
> would most probably fail in the most horrible ways).
> It's a simple & clean solution, provably correct in *all* situations.
> But I don't remember having seen any replies from you on this subject.

That is because you are away and you did not read through the email.
I did comment on it. It doesn't correct in *all* situations. We need bigger
hammer.

I locate it out for you.

http://marc.info/?l=linux-sparse&m=149987902920449&w=3
==========quote================
Even Luc's suggestion for "mark and sweep" to delete the ptrlist
is not going to help with the nested loop split. I will add that check.
I don't expect new offenders but let's make sure about it.
==========end quote=============

http://marc.info/?l=linux-sparse&m=149969288517115&w=3
=============quote===============
> I earlier suggested to instead change the way elements are 'deleted'
> (like instructions are already never removed from their list but
> just marked as deleted).

That looks simple but it has hidden complications as well. The issue is that
we need to find out which list need this kind of special treatment. Who is
the outer loop. If the same function can be both call as the outer
loop and inner
loop then it is complicate to decide when it should do the finalize.
There is also
the price to pay for walking the list twice which does not exist if nested loop
can be avoided.

=============end quote==============


Chris
