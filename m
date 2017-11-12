From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/2] Fix illegal simplification of volatile stores
Date: Sun, 12 Nov 2017 19:48:13 +0100
Message-ID: <20171112184811.ciaoudtwo5bazaj6@ltop.local>
References: <20171111162500.69476-1-luc.vanoostenryck@gmail.com>
 <CANeU7QnJgGdWtM3KkJOtWG72v_soBZfeXGkqMUmQcv-L=NM5oQ@mail.gmail.com>
 <20171111225218.m3cqbid6ug7r57jw@ltop.local>
 <CANeU7QnSOro=WkH_VBoGGCPonAaw-hMGJTVG_8OQPzm19zKvaQ@mail.gmail.com>
 <CAExDi1QwQFQ+dci=j5KrB6_Q65JD496J0U4w_Hv7usHwb-qj-g@mail.gmail.com>
 <CANeU7Q=o+90-BL9RSwONBLmVfvD-RWkDubBskksuvLah1zi8fg@mail.gmail.com>
 <20171112111039.qo6uan73jazriu7n@ltop.local>
 <CANeU7QnLjm1cSD-KY49wXrx1WPNzoXu8TXuym7gei2Aioe+mTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:56060 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbdKLSsT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Nov 2017 13:48:19 -0500
Received: by mail-wm0-f50.google.com with SMTP id 9so5687367wme.4
        for <linux-sparse@vger.kernel.org>; Sun, 12 Nov 2017 10:48:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7QnLjm1cSD-KY49wXrx1WPNzoXu8TXuym7gei2Aioe+mTQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Nov 12, 2017 at 08:07:03PM +0800, Christopher Li wrote:
> On Sun, Nov 12, 2017 at 7:10 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > No Chris.
> > We spend a full month discussing about how you was willing to
> > accept a solution to finally accept my solution and claiming
> > it was what you meant since the beginning.
> 
> I have no idea what you are talking about any more.
> I recall there are two very serious bugs, one is the
> ptrlist iteration while modify. There other one is the
> wine deadloop bug. Both this two bus hold up the
> release.
> 
> You can also blame me for hold up the release too
> if that means you feel better.
> 
> 
> >
> > The first part of the series: pre-llvm-fixes is 16 patches.
> > These patches have been submittted in March, 8 months ago.
> > Is it normal to take 8 months to review 16 patches?
> 
> Luc, per our email exchange you know that one of the
> very important pull email was lost. And you said you
> believe and I don't need how show you the screen shot
> but I did any way.
> 
> Why do you pretend you all the sudden forget about
> this issue and roll back the time line to 8 month? Just
> to make me look bad?

I didn't at all forgot this and I still believe that at the
time you indeed never saw those pull requests (there was more
than one). But time passes and accumulates.
Even if you didn't saw the pull requests, you saw the posting
for the series, no? And it's since months that you're aware
that you didn't saw the pull request. There is also the mail
archive and, much more useful, patchwork that keep all the
patches. I also sent you a newer pull request 8 weeks ago,
right? And it was ignored for 7 weeks, right?
You could have send an email saying "sorry, I'll need a few weeks
more because now I don't have the time" but no, just nothing.

So, no, I don't roll back time to 8 months, it's just that I'm
waiting since 8 months to have these patches handled by you.

> Can we go back to get a solution to get the patch merged
> start from your llvm-fix series? I can not partial merge
> the branch. I do have issue with the OP_PUSH.
> That hold up the pull.

OK, that have at least the merit to be very clear.
 
> You have been very abusive to me on email. That
> makes me not want to reply to you. Basically feeding the
> trolls.
> 
> >
> > This is most probably your worst error.
> > Months ago, Linus gave you an advice. He said:
> >         Particularly with somebody like Luc, who sends
> >         involved patch series for core stuff and knows
> >         what he is doing, I think Chris could just do
> >         git merges, and lower the maintenance overhead
> >         a lot.
> 
> Come on, what Linus mean was I should use git merge
> rather than apply patches. You take it out of context
> of comparing applying patch vs git merge. You insert your
> own interpretation that I should not try to provide feed back
> and fix up with your branch.

I copied his words verbatim.
You seem to be very sure of what he meant, fine.

> I usually tolerate small disagreement on the patches in the
> pull request, just suck it up.
> 
> The OP_PUSH is too big a change for that. If I merge it
> then revert it in the later part of the branch. It is kind of
> ugly. So I want to know what is the option I have here
> to resolve this issue?
> 
> >
> > You choose to not listen to this advice. It's your right,
> > of course but choices have consequences.
> 
> Yes, you can abuse me and justify forking sparse.
> 
> >> Why do you keep refusing to make any change
> >> to your pull request.
> >
> > I refuse to make frivolous changes 8 months after a series
> > been submitted, like you asked last week.
> > I'm very reluctant to make non-bug related changes 8 months
> > after a series have been submitted.
> >
> > The issue with SETVAL having no type have been discussed on
> > the mailing list in March, there were several patches, several
> > ideas and opinions. Some patches were dropped but a working
> > solution emerged. This solution was developped, integrated
> > with all the others changes, *tested* and was satisfying
> > to the person involved.
> > Who didn't participated in these discussions?
> 
> Come on. You are CC on the SETVAL patch. Others comments
> on it. You ever did. Why?
> I join late to the discussion but you are the one did not finish it.
> 
> Also why you did not review my other code changes?

Because I don't comment on code that I somehow disagree with,
or is not to my taste but which is working well enough that
I don't want to block.

> I might be late to do it. But I do think careful about your changes.
> 
> > You already proposed this some times ago, at least twice IIRC,
> > and I said that I would be fine with this.
> 
> Then for the OP_PUSH I think that is a much better solutions.
> Because until now you fail to express why SETVAL.size patch
> is technically inferior to your OP_PUSH. I have evidence to show
> otherwise.

In my world, evidences are patches, working patches, integrated
with the rest of the code and reasonably tested.
I have a solution which do that, it has been submitted and used
by me and Dibyendu. You claim to have a superior solution, OK.
Where are the patches? Where can we see the whole thing integrated
with all the others fixes? On what have this been tested?

> If you think the only problem of SETVAL.size is not complete,
> why don't admit that? I can provide the rest of the change make
> it complete. It take a rebase to cleanly drop OP_PUSH. It would
> be best if you can provide a pull point that does not have OP_PUSH.
> If I do it, it will means I rebase or revert your patches.
> With your blessing, I will go ahead and do it.
> 
> 
> > But you must also understand that, given the limited time you
> > have to accept patches, I have serious doubt about this.
> 
> You can keep your doubt. It is free. Give me your blessing
> of me droping OP_PUSH I will show you the code.

The code is there Chris, it has been submitted, it has my SoB and
thus agree with the license. You have fully the right to take my
code, you don't need my blessing.
If you want to take the code I wrote, take some bits and drop some
others and if you think it's a good idea, that's how you can be
useful to sparse, fine, please do.

> > If you want to maintain a project, you need to work reasonably
> > with the developpers. Taking 24 months to take a good series
> > without having even really reviewed it is not what I call
> > working reasonably well with devs.
> > Same here with the 8 months old LLVM series.
> 
> Good. 8 months old. I am doing nothing in that 8 month.
> Not applying one single patch and not releasing one single
> bits. Thank you.
> 
> Can we going back to find a solutions to merge the bits
> quicker?

So, now it's me that is holding things? Incredible.

> Give me your blessing I can do the dirty work.
> Make you the condensing one that review and throw
> rock on my branch for reviews. I well come that.
>
> > Isn't that a bit easy?
> > I've been very very patient with you, I have spent a lot
> > of time and energy trying to improve sparse, mainly fixing
> > bugs. Look at the activity of the last 8 years and look at
> > the activity of the last 12 months. Improving sparse, this
> > is my agenda. And you, what have you helped exactly here?
> 
> I am very much appreciate your work and help on sparse.
> If that is not very clear to you. I repeat it here.
> I am very much appreciate your help. Thank you.
> 
> What I am helping you? If you say nothing then I am fine
> with that.
> 
> >> For example, if you drop the unresolved OP_PUSH patches
> >> from the series. I can pull your llvm-fix now.
> >> Do you want to do that? Or that is not an option for you?
> >
> > It's an option but:
> > 1) You must understand that this represent work.
> >    Since, you have so limited time, you could:
> >    - be efficient
> >    - respect people's time & work.
> > 2) The actual solution is working and tested.
> >    Removing the OP_PUSH would be a regression.
> 
> The OP_PUSH is too much a issue apply the revert it.
> Especially it haven't merge yet.

OK, fine. Again, at least it's very clear.
 
-- Luc
