From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v6 00/15] prepare for LLVM fixes
Date: Fri, 31 Mar 2017 18:04:14 +0800
Message-ID: <CANeU7QmAkOSo9wOKBzpRd6prbY6kF5Bm=71OrYbt9sLq9cgJ0A@mail.gmail.com>
References: <20170327173405.11405-1-luc.vanoostenryck@gmail.com>
 <7406f777-5e8b-5ae0-55e0-26a36ddb64b5@ramsayjones.plus.com>
 <20170327222212.jle5tzjevfsigvuw@macpro.local> <CA+55aFx+-mvbjN_m0A3ZFFVtBHEAwbmuruMS5P_082_Fr2auzg@mail.gmail.com>
 <CANeU7Q=d22MqFigDcaW1o59BTYV2rKNhfjjDCVpxA_JTDey_ag@mail.gmail.com> <CAExDi1Tvq6rcci0vV8rFwg4FXPzFNoSWF+XQ73vbeSBGJs86_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:35239 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754730AbdCaKEQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 31 Mar 2017 06:04:16 -0400
Received: by mail-it0-f67.google.com with SMTP id y18so1568889itc.2
        for <linux-sparse@vger.kernel.org>; Fri, 31 Mar 2017 03:04:15 -0700 (PDT)
In-Reply-To: <CAExDi1Tvq6rcci0vV8rFwg4FXPzFNoSWF+XQ73vbeSBGJs86_g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Fri, Mar 31, 2017 at 5:25 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> I understand perfectly that you're comfortable with your tools but I
> think you're
> overestimating them (remember how we had some patches that have been
> wrongly and silently been merged? It's scary as hell!) and hugely
> underestimating

Well, I can try the git merge. On that case you bring up, it is a conflict
resolving. Even if I am using git merge I could still resolve the
conflict in the
wrong line order, because at that point and time, I don't think it matters.
Now I will not try to resolve it that way.

> Also, you must understand how unpractical your workflow is for others.
> Especially the fact that everything is always rebased, make things much
> more complicated than needed for my topics branches. The fact that often

It is not always rebase. I don't do rebase for no reason. The often situation
is that, I applied a patch series. Then there is an update of the series which
change some patch in that series.

I can totally using the git merge as interface to operate and make patch series
as my internal tool to review git commits. But that is not going to
get rid of rebase.
Rebase is because we want clean history.

e.g. If you send me a git merge request for V4, then I merge it on spase-next.
Then you release V5 branch with clean up history. Then I drop V4 and merge
V5 on sparse-next. Is that more acceptable to you?

We can try the merge with feature branch model and see how it goes.

> you take patches in an order different that the submitted one doesn't help.
> And things like the mis-merge force me to rebase my branches to compare
> with what you have taken just to see if there wasn't another problem.
>
> Very inefficient for me and ultimately for you too, believe me. But well ...

Let's try that. We can start with merge request.

>
> At least one thing that would already help a lot would be to limit the time
> between a patch is submitted and the one where it is in a stable tree
> (and sparse-next is not, certainly not its tip).

The reason to have sparse-next for me is allow to have clean history
for master branch.

> Also, I think that implicitly in Linus' message was that a maintainer, with
> limited time, should not have to play a bit with a patch and then move on
> to the next one.

The actual time spend is on review and testing the patch. Simple apply
takes no time for me all. As I said, I can make the patch thing as internal
tool to help me review commits.

Chris
