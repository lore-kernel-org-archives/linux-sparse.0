From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v6 00/15] prepare for LLVM fixes
Date: Fri, 31 Mar 2017 23:42:59 +0800
Message-ID: <CANeU7QktwCNd1rU0u5dwRtyT+nb5uvUn29b-nLdt5it5PB3UjA@mail.gmail.com>
References: <20170327173405.11405-1-luc.vanoostenryck@gmail.com>
 <7406f777-5e8b-5ae0-55e0-26a36ddb64b5@ramsayjones.plus.com>
 <20170327222212.jle5tzjevfsigvuw@macpro.local> <CA+55aFx+-mvbjN_m0A3ZFFVtBHEAwbmuruMS5P_082_Fr2auzg@mail.gmail.com>
 <CANeU7Q=d22MqFigDcaW1o59BTYV2rKNhfjjDCVpxA_JTDey_ag@mail.gmail.com>
 <CAExDi1Tvq6rcci0vV8rFwg4FXPzFNoSWF+XQ73vbeSBGJs86_g@mail.gmail.com>
 <CANeU7QmAkOSo9wOKBzpRd6prbY6kF5Bm=71OrYbt9sLq9cgJ0A@mail.gmail.com> <CAMHZB6H9e8S_BPsXv8dVSnRStZVKHCZcf_cOtL4Yome4_U2Zwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:36085 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933217AbdCaPnB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 31 Mar 2017 11:43:01 -0400
Received: by mail-it0-f66.google.com with SMTP id 190so2368826itm.3
        for <linux-sparse@vger.kernel.org>; Fri, 31 Mar 2017 08:43:00 -0700 (PDT)
In-Reply-To: <CAMHZB6H9e8S_BPsXv8dVSnRStZVKHCZcf_cOtL4Yome4_U2Zwg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Fri, Mar 31, 2017 at 8:19 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Merge conflicts are fine, not a problem at all. The problem is if they are not
> detected or if, in the case we're talking about, the tools try to be too smart,
> use a too small context and apply a patch where it should never have been.

For the record. In that case, my patch script did not auto apply it for me.
Underlying it is just using "git am" and "git am" refuse to apply that patch.
The part that is wrong is that I manually force apply it, I think it is just
patch seeking a few lines and it is not. That is where it is wrong.

That is also the reason I can just look at the patch series log and find out
other case like that.

>
>>> Also, you must understand how unpractical your workflow is for others.
>>> Especially the fact that everything is always rebased, make things much
>>> more complicated than needed for my topics branches. The fact that often
>>
>> It is not always rebase. I don't do rebase for no reason.
>
> Of course, it's not what I meant.
> What I wanted to say is that since the patches are applied from email
> (via patchwork, quilt, git am, ... ) they necessarily have a different parent
> that they had on the developer side, thus a different history.

True.

> While this is not really a problem for a few isolated patches,
> it becomes a problem when you're developing several series:
> the newer ones depending on the old ones.
> And the longer it takes for patches to reach the upstream tree,
> the more the dev tree and the official tree (can) diverge and when it
> accumulate, it create problems.

In that case, the problem can be solve by sending git merge request.
I have done git merge for sparse before, it is not like I refuse git merge. It

>
>> The often situation
>> is that, I applied a patch series. Then there is an update of the series which
>> change some patch in that series.
>
> IMO, the whole series need to be throwed away, awaiting for a new version
> of it.

That is what I did for sparse-next. I throw away the V4 and re-apply the V6.
If you mean the V4 should have never been applied, Then Ramsey would not
be able to report the 32 bit is broken. Part of the V6 fix would not exist.


>
>> I can totally using the git merge as interface to operate and make patch series
>> as my internal tool to review git commits. But that is not going to
>> get rid of rebase.
>> Rebase is because we want clean history.
>
> I'm not sure what you mean by "clean history" and what is the advantage.
> If you hate revert, and patches to correct others patches, I wholly understand
> I hate this also. It's why a serie would reach upstream when really finished,
> well tested and so one.

Just as you said, "Clean history" is avoiding unnecessary revert and reply in
the commit log. The catch 22 here is that, it need to publish some where so
other people can test and report what is been broken.

> OK, I can resent everything properly for a pull request.
> Let me know exactly what you need/want.

For git merge request. I just need a git remote and git branch where I can do
git fetch with. We can try that wit sparse-next and see how it goes.


Chris
