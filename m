From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v6 00/15] prepare for LLVM fixes
Date: Fri, 31 Mar 2017 12:49:01 +0800
Message-ID: <CANeU7Q=d22MqFigDcaW1o59BTYV2rKNhfjjDCVpxA_JTDey_ag@mail.gmail.com>
References: <20170327173405.11405-1-luc.vanoostenryck@gmail.com>
 <7406f777-5e8b-5ae0-55e0-26a36ddb64b5@ramsayjones.plus.com>
 <20170327222212.jle5tzjevfsigvuw@macpro.local> <CA+55aFx+-mvbjN_m0A3ZFFVtBHEAwbmuruMS5P_082_Fr2auzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:33483 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbdCaEtD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 31 Mar 2017 00:49:03 -0400
Received: by mail-io0-f195.google.com with SMTP id f84so4951492ioj.0
        for <linux-sparse@vger.kernel.org>; Thu, 30 Mar 2017 21:49:02 -0700 (PDT)
In-Reply-To: <CA+55aFx+-mvbjN_m0A3ZFFVtBHEAwbmuruMS5P_082_Fr2auzg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Wed, Mar 29, 2017 at 2:10 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> I do wish that sparse would use more of a real git workflow, instead
> of just applying patches.
>
> Sending out patches to a mailing list is _wonderful_ for actually
> doing code review and making people *aware* of what's going on, but
> it's not a great maintenance model. It doesn't scale, and it makes for
> lots of maintainer work.
>
> Particularly with somebody like Luc, who sends involved patch series
> for core stuff and knows what he is doing, I think Chris could just do
> git merges, and lower the maintenance overhead a lot.

I have a pretty comfortable script system to deal with patches right now.
So for me applying patches does not have significant overhead compare
to git.

Patches give me more flexibly on reviewing. Git merge is either merge
with the whole thing or not. It is does not work if there is some thing
change in between. I like to apply the patch and play with it a bit then
move to the next one. I suppose I can write some script to follow git branch
as one change at a time. My current patch series script is extremely flexible
on cherry pick the patches and tracking which patch was rejected for
what reason etc.

That being said, I do wish there is a way to figure out which patches
haven't changed in the new series. e.g. from V4 to V5, only a few patches
actually change. I can just focus on those changed one. I suppose I can
write a script to detect the same patch on different series.

> NOTE! If you do git merges using the github interface, things often go
> south *very* quickly.  github likes to do "merges" using rebase,
> probably because it caters to projects who don't understand about the
> whole "keep a sane history". So it's really really easy to use github
> in ways that interact really badly with good git workflows. But you
> *can* do merges entirely using github, if you actually know what
> you're doing and are careful to not do rebasing merges with core
> contributors (using rebase for the occasional small patch series from
> random fly-by contributors is ok, but I think even then github screws
> up signed-off chains).

I notices that too. I don't use the github web ui merge. I just merge change
by hand.

Chris
