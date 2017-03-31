From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v6 00/15] prepare for LLVM fixes
Date: Fri, 31 Mar 2017 11:25:55 +0200
Message-ID: <CAExDi1Tvq6rcci0vV8rFwg4FXPzFNoSWF+XQ73vbeSBGJs86_g@mail.gmail.com>
References: <20170327173405.11405-1-luc.vanoostenryck@gmail.com>
 <7406f777-5e8b-5ae0-55e0-26a36ddb64b5@ramsayjones.plus.com>
 <20170327222212.jle5tzjevfsigvuw@macpro.local> <CA+55aFx+-mvbjN_m0A3ZFFVtBHEAwbmuruMS5P_082_Fr2auzg@mail.gmail.com>
 <CANeU7Q=d22MqFigDcaW1o59BTYV2rKNhfjjDCVpxA_JTDey_ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35549 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932817AbdCaJ0D (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 31 Mar 2017 05:26:03 -0400
Received: by mail-qt0-f196.google.com with SMTP id r5so9454547qtb.2
        for <linux-sparse@vger.kernel.org>; Fri, 31 Mar 2017 02:25:57 -0700 (PDT)
In-Reply-To: <CANeU7Q=d22MqFigDcaW1o59BTYV2rKNhfjjDCVpxA_JTDey_ag@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Fri, Mar 31, 2017 at 6:49 AM, Christopher Li <sparse@chrisli.org> wrote:
> On Wed, Mar 29, 2017 at 2:10 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> I do wish that sparse would use more of a real git workflow, instead
>> of just applying patches.
>>
>> Sending out patches to a mailing list is _wonderful_ for actually
>> doing code review and making people *aware* of what's going on, but
>> it's not a great maintenance model. It doesn't scale, and it makes for
>> lots of maintainer work.
>>
>> Particularly with somebody like Luc, who sends involved patch series
>> for core stuff and knows what he is doing, I think Chris could just do
>> git merges, and lower the maintenance overhead a lot.
>
> I have a pretty comfortable script system to deal with patches right now.
> So for me applying patches does not have significant overhead compare
> to git.
>
> Patches give me more flexibly on reviewing. Git merge is either merge
> with the whole thing or not. It is does not work if there is some thing
> change in between. I like to apply the patch and play with it a bit then
> move to the next one. I suppose I can write some script to follow git branch
> as one change at a time. My current patch series script is extremely flexible
> on cherry pick the patches and tracking which patch was rejected for
> what reason etc.

I understand perfectly that you're comfortable with your tools but I
think you're
overestimating them (remember how we had some patches that have been
wrongly and silently been merged? It's scary as hell!) and hugely
underestimating
the flexibility, ease, quality, speed, ... that a more git-oriented workflow,
like Linus is suggesting, could offer you. But yes it's a change.

Also, you must understand how unpractical your workflow is for others.
Especially the fact that everything is always rebased, make things much
more complicated than needed for my topics branches. The fact that often
you take patches in an order different that the submitted one doesn't help.
And things like the mis-merge force me to rebase my branches to compare
with what you have taken just to see if there wasn't another problem.

Very inefficient for me and ultimately for you too, believe me. But well ...

At least one thing that would already help a lot would be to limit the time
between a patch is submitted and the one where it is in a stable tree
(and sparse-next is not, certainly not its tip).

Also, I think that implicitly in Linus' message was that a maintainer, with
limited time, should not have to play a bit with a patch and then move on
to the next one.

-- Luc
