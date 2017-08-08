From: Christopher Li <sparse@chrisli.org>
Subject: Re: Upcoming sparse release RC5
Date: Tue, 8 Aug 2017 00:43:13 -0400
Message-ID: <CANeU7QnkGAsgdFhUsGJH3WYif6CTscoGmoDo4UpdLe_e6=cYXQ@mail.gmail.com>
References: <CANeU7QmZXY5Q4GmBMh42WpdiRyYfA=Ddpvjk_35=_Rmhb=RMiA@mail.gmail.com>
 <CAExDi1Qshm920Te38c-HZsrWDtxVS-WP6HRXkeNujWySXX0mXg@mail.gmail.com>
 <CANeU7QnY20n-UHY07RotcAJzFtMREB-CcsE1WXLi=b=cwQCizQ@mail.gmail.com>
 <CAExDi1QVtkoFCXzSoP0mg+3gbE45Z-bOGLAtjsTi8tsQZMdcEg@mail.gmail.com>
 <CANeU7Q=9Ma3+gA21+=bLi38XFw5B1FDoVFUvtaxLR3V0oHeCig@mail.gmail.com>
 <20170808002331.f3g6l7yzhsq3vhxe@ltop.local> <CANeU7QmJmzumvNNFm5W=Ti8TJdw-BZ2DeR0t2UXO-R2vCjqh6Q@mail.gmail.com>
 <CAExDi1R6Vg8cztVA32nOEHKRgpiUcZnHfOoK6rshJq46FSaj2g@mail.gmail.com>
 <CANeU7QkU+GZA6J_B5SdZw0L=yvmYr_V=ue-h-TrZoWaGc-ATvg@mail.gmail.com>
 <CAExDi1QDDDTKb9Ht6-pquT1w5PS_G+yCBPtoYLofuMPVuxgN+Q@mail.gmail.com>
 <CANeU7Q=bCw0wYWsNTgbu=mLmDq40_Db-=f2rTb+UC2b8szpxvA@mail.gmail.com> <CA+55aFyB0nODr5eHnEE4_gfiff0o8L=nVakA=1Ngt=69DPWXZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34575 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750777AbdHHEnO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 8 Aug 2017 00:43:14 -0400
Received: by mail-pf0-f181.google.com with SMTP id o86so9824437pfj.1
        for <linux-sparse@vger.kernel.org>; Mon, 07 Aug 2017 21:43:14 -0700 (PDT)
In-Reply-To: <CA+55aFyB0nODr5eHnEE4_gfiff0o8L=nVakA=1Ngt=69DPWXZg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 7, 2017 at 11:31 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Aug 7, 2017 at 7:38 PM, Christopher Li <sparse@chrisli.org> wrote:
>>
>> You need to make "for-chris" fast forwardable from master.
>
> Chris, that makes no sense at all.
>
> If you ever apply any other patches than the patches from Luc,
> suddenly his "for-chris" is no longer fast-forwardeable.

You mean "for-chris" is not fast-forwardable to sparse-next.
master will stable able to fast forward to "for-chris".

That is fine. Because in my model, this "for-chris" is the stable
point. When he send out pull request, "for-chris" contain some
new bits which is not on sparse-next, sparse-next can not
fastforward to, sparse-next will *rebase* on "for-chris".

In other words, sparse-next will adept to solve that not
fast-forwardable problem.

In this case, sparse-next is the floating point. The stable
point is "for-chris". Any thing merge into "for-chris", I am not able to
rebase any more.

> Why do you want that stupid linear history in the first place? Why

Basically I want to have some place to test temporary patches.
Like the revert for the wine bug and later we drop the revert
when we have better patches.

> can't you just merge Luc's git tree? That's how git is supposed to
> work, and it makes it easier for everybody.

That is effective make Luc's git tree the stable branch. My sparse-next
is floating base on that. If I directly merge Luc's git tree from spase-next,
those unstable change will not be able to drop from the sparse-next history.

> This whole rebasing is a disease. It is basically *impossible* to work
> sanely with other people if you keep rebasing.
>
> You mustn't rebase other peoples work (because that causes tons of
> extra work for them) when you pull, and if you apply any other patches
> (or commit any of your own work), then Luc's branch by definition will
> need merging.

That is exactly what I am trying to avoid.  Not rebase Luc's change.
My purpose is that always use Luc's "for-chris" branch as base.
The spase-next only contain the unstable part of the experiment change.

> Nobody else works like you do. Yes, other people have unstable
> branches (eg git's own "pu" branch), but those are for experimental
> stuff, not for working with anybody else.

I think I have make it clear that sparse-next is the unstable experiment
branch. Before I use sparse-next, I also ask on the sparse mailing list if
I can have have a branch for experiment that I rebase. The feed back
I got back then was fine as long as I make it clear it is a branch will rebase.

> Rebasing really is wrong for any pubic tree. Its' fine for your own
> _private_ pacthes, as you develop and clean up a branch that you're
> still working on, but it shouldn't be an integration model.

Will it be better I keep using sparse-next-xxxxx as the experiment
branch and use "sparse-next" as a tag point to sparse-next?

If we don't rebase, then we will keep the revert and revert of the revert
in the history. I can change to that too. In that case, we might as well
just do it on the master branch, because we never rebase on it any way.

What is the recommended way to use experiment branch in git any
way?

Chris
