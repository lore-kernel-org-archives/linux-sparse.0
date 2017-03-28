From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v6 00/15] prepare for LLVM fixes
Date: Tue, 28 Mar 2017 11:10:17 -0700
Message-ID: <CA+55aFx+-mvbjN_m0A3ZFFVtBHEAwbmuruMS5P_082_Fr2auzg@mail.gmail.com>
References: <20170327173405.11405-1-luc.vanoostenryck@gmail.com>
 <7406f777-5e8b-5ae0-55e0-26a36ddb64b5@ramsayjones.plus.com> <20170327222212.jle5tzjevfsigvuw@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:35175 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752509AbdC1SKd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Mar 2017 14:10:33 -0400
Received: by mail-it0-f68.google.com with SMTP id y18so5052325itc.2
        for <linux-sparse@vger.kernel.org>; Tue, 28 Mar 2017 11:10:32 -0700 (PDT)
In-Reply-To: <20170327222212.jle5tzjevfsigvuw@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

On Mon, Mar 27, 2017 at 3:22 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> It's a time somehow painfull, I agree. It's why I try also push
> the serie on github when the serie is worth of it (and complete).
> in this case you can find everything at:
>         https://github.com/lucvoo/sparse/commits/llvm-fixes-v6
>
> (and yes, this tree contains a few more patches, not in the serie
> already submitted but not yet in sparse-next).

I do wish that sparse would use more of a real git workflow, instead
of just applying patches.

Sending out patches to a mailing list is _wonderful_ for actually
doing code review and making people *aware* of what's going on, but
it's not a great maintenance model. It doesn't scale, and it makes for
lots of maintainer work.

Particularly with somebody like Luc, who sends involved patch series
for core stuff and knows what he is doing, I think Chris could just do
git merges, and lower the maintenance overhead a lot.

NOTE! If you do git merges using the github interface, things often go
south *very* quickly.  github likes to do "merges" using rebase,
probably because it caters to projects who don't understand about the
whole "keep a sane history". So it's really really easy to use github
in ways that interact really badly with good git workflows. But you
*can* do merges entirely using github, if you actually know what
you're doing and are careful to not do rebasing merges with core
contributors (using rebase for the occasional small patch series from
random fly-by contributors is ok, but I think even then github screws
up signed-off chains).

               Linus
