From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/2] Fix illegal simplification of volatile stores
Date: Sun, 12 Nov 2017 12:10:41 +0100
Message-ID: <20171112111039.qo6uan73jazriu7n@ltop.local>
References: <20171111162500.69476-1-luc.vanoostenryck@gmail.com>
 <CANeU7QnJgGdWtM3KkJOtWG72v_soBZfeXGkqMUmQcv-L=NM5oQ@mail.gmail.com>
 <20171111225218.m3cqbid6ug7r57jw@ltop.local>
 <CANeU7QnSOro=WkH_VBoGGCPonAaw-hMGJTVG_8OQPzm19zKvaQ@mail.gmail.com>
 <CAExDi1QwQFQ+dci=j5KrB6_Q65JD496J0U4w_Hv7usHwb-qj-g@mail.gmail.com>
 <CANeU7Q=o+90-BL9RSwONBLmVfvD-RWkDubBskksuvLah1zi8fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:55605 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbdKLLKt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Nov 2017 06:10:49 -0500
Received: by mail-wm0-f54.google.com with SMTP id 9so4501750wme.4
        for <linux-sparse@vger.kernel.org>; Sun, 12 Nov 2017 03:10:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=o+90-BL9RSwONBLmVfvD-RWkDubBskksuvLah1zi8fg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Nov 12, 2017 at 05:57:32PM +0800, Christopher Li wrote:
> On Sun, Nov 12, 2017 at 1:19 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > The LLVM fixes series and the 66 others series.
> 
> I see one pull request for llvm fixes. Where is your other 66
> freaking pull request?
> 
> > Chris ...
> > v0.5.1 was out mid-August (and you made a very long and painful thing of it).
> 
> Well it is kind of long and painful due to the bugs we found
> at the last stage. What do you expect? ship with the bugs?

No Chris. 
We spend a full month discussing about how you was willing to
accept a solution to finally accept my solution and claiming
it was what you meant since the beginning.

> > You ignored the last pull request for 7 weeks.
> 
> Yes, that is 68 patches it take some time for me to
> go through. Didn't the sending patches documents
> mention 15 patches at a time?

The first part of the series: pre-llvm-fixes is 16 patches.
These patches have been submittted in March, 8 months ago.
Is it normal to take 8 months to review 16 patches?

> Yes, I have very limited time to hack on sparse.
> But I do have the best intention for sparse.
> I do give me my effort to work on sparse with the
> resource on my hand. Recently I have been traveling
> a lot so my time is very spotted. I haven't been the
> best of maintainer and I apologize for that.
> I do want to work with you to get this thing merged.
> 
> As we agree, I don't pull if I am not complete happy with
> the series.

This is most probably your worst error.
Months ago, Linus gave you an advice. He said:
	Particularly with somebody like Luc, who sends
	involved patch series for core stuff and knows
	what he is doing, I think Chris could just do
	git merges, and lower the maintenance overhead
	a lot.

You choose to not listen to this advice. It's your right,
of course but choices have consequences.


> Why do you keep refusing to make any change
> to your pull request.

I refuse to make frivolous changes 8 months after a series
been submitted, like you asked last week.
I'm very reluctant to make non-bug related changes 8 months
after a series have been submitted.

The issue with SETVAL having no type have been discussed on
the mailing list in March, there were several patches, several
ideas and opinions. Some patches were dropped but a working
solution emerged. This solution was developped, integrated
with all the others changes, *tested* and was satisfying
to the person involved.
Who didn't participated in these discussions?

> I even offer I pull into topic branch
> and I personally fix it for you on top your change. You have
> no reply on that regard.

You already proposed this some times ago, at least twice IIRC,
and I said that I would be fine with this.
But you must also understand that, given the limited time you
have to accept patches, I have serious doubt about this.

> If you want the code get merged, you need to work with
> maintainer.

If you want to maintain a project, you need to work reasonably
with the developpers. Taking 24 months to take a good series
without having even really reviewed it is not what I call
working reasonably well with devs.
Same here with the 8 months old LLVM series.

> Smearing the maintain and refuse to make any
> change does not help to get your code merge. It only
> help you to advance your political agenda.

Isn't that a bit easy?
I've been very very patient with you, I have spent a lot
of time and energy trying to improve sparse, mainly fixing
bugs. Look at the activity of the last 8 years and look at
the activity of the last 12 months. Improving sparse, this
is my agenda. And you, what have you helped exactly here?

> For example, if you drop the unresolved OP_PUSH patches
> from the series. I can pull your llvm-fix now.
> Do you want to do that? Or that is not an option for you?

It's an option but:
1) You must understand that this represent work.
   Since, you have so limited time, you could:
   - be efficient
   - respect people's time & work.
2) The actual solution is working and tested.
   Removing the OP_PUSH would be a regression.

The correct solution, IMO, is to integrate the current
solution and if you can come with a better one, please do.
Integrate this solution and test it and if it appears to
be a superior solution, replace the actual one with yours.
 
> >
> >> That series I just send out one important
> >> feed back about the OP_PUSH. I thought I have send that one out
> >> but I just find out it haven't. That is my bad.
> >
> > Is that serious?
> 
> Well not as serious as you don't provide any solutions to resolve
> the issue in hand. I am object to the OP_PUSH, that one need more
> discussion. Can we have a solution to merge the rest?
> 
> > Given how you have been so good the last 2-3 years at ignoring
> > patches & series, must I, once more, trust you and believe this?
> 
> Luc, being an open source developer, you need to
> have an open mind. It has came to my attention you
> seems have some dubious intentions of doing things.

Chris, I think you should take a bit time to think about
what you should change to how you work for sparse.
Try to put yourself for a moment in the skin and head
of the developers who have spent time to contribute to sparse,
have submitted some patches. Go ask to these devs why they don't
bother anymore to send patches and to hack on sparse.
Try to list what you expect from a project you want to contribute.

For my part, as I have already said, I'm tired, very very tired
of all this. I also have accumulated way to much patches since
way too long time. And this begin, slowly but surely, to be a
problem for the development I'm doing. I need to have all these
patches consolidated, it's what I'm doing since last week.

-- Luc
