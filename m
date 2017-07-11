From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] V2 move kill_unreachable_bbs to outer cse stage Was Re:
 [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Tue, 11 Jul 2017 13:41:12 -0700
Message-ID: <CANeU7Qm+R4q_6ZF1=Oa-d5TtVcNfz+YhDePXq4-L6GoTyYAwvQ@mail.gmail.com>
References: <CANeU7QkCcx1d29megDn9bQ0g7rw04=ujsWCe_bN1Kc1NW_-NZw@mail.gmail.com>
 <20170709165157.w6jnjkwca7dwxj64@ltop.local> <CANeU7Qms0KKSWU0dyHomz1iEczdiYn_7SwsJZmPCSXDhsag0Tw@mail.gmail.com>
 <20170710070520.fzr3wqgaugkfocfo@ltop.local> <CANeU7QnoP5g2kww5Up1gW7ucWB2H7xuGdzQ-0bTei4cWxjAz=w@mail.gmail.com>
 <20170711092625.ux6xonjiqxhotczf@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34590 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932704AbdGKUlN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 11 Jul 2017 16:41:13 -0400
Received: by mail-pf0-f169.google.com with SMTP id q85so1694463pfq.1
        for <linux-sparse@vger.kernel.org>; Tue, 11 Jul 2017 13:41:13 -0700 (PDT)
In-Reply-To: <20170711092625.ux6xonjiqxhotczf@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Jul 11, 2017 at 2:26 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>>
>> You are right. I will never consider 2) as my goal. Simply because
>> if the compiler has to depend on certain order of optimization (delete
>> dead BB vs memops, CSE) and it can't figure out the order by itself.
>> Then I consider a bug in the compiler.
>
> You may qualify this as a bug but in the real world it's totally
> normal to have interactions between optimization passes (yes, this
> means that the result will depend on the order of the passes).
> This is especially true when it concern dead code elimination.
>
> Any decent compiler book will tell you a bit more about this.

OK. Apparently I haven't read any decent compiler books yet, that
is why I am not a good maintainer.

My sentence have two parts. You only read the first part about
the ordering. The second part you seem missing is that, if the
order make a difference, *and* the compiler can't to figure out
a the (optimal) order by itself, that is a bug.

It is just command sense. If I re-order my C source file
with some goto and moving code blocks around. The C compiler
should generate pretty much the same optimal code in the end.

If your investigation of comparing two approach to compile
the same source code, your patch generate better result. Then
we need to look at it. That might be reason to use your patch.
Maybe there is some other simple way to modify my patch to
generate as good a result as well. Do you have any example
you believe my simpler approach will generate worse code
then your not so complicate approach?

> But well, you're the maintainer, it's your responsability to
> make the good choices for the project.

Of course. I try really hard to make the right choice. I can only
make decision base on the information I have in hand. So far you
haven't conclude your investigation that the simpler approach will
generate worse code. You said it is different, different can be better
or be worse. If it turn out to be different but equivalent, then why not
just use the simpler approach?

If it is not, then let's look at why this pack blocks earlier will make
code better. Make some adjustment in the code, possible remove
dead block earlier like your patch suggested.

Chris

PS, Any decent compiler book you want to recommend? I want to
see it.
