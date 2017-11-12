From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/2] Fix illegal simplification of volatile stores
Date: Mon, 13 Nov 2017 00:06:10 +0100
Message-ID: <20171112230609.ch3u4vfnasaex3sz@ltop.local>
References: <20171111162500.69476-1-luc.vanoostenryck@gmail.com>
 <CANeU7QnJgGdWtM3KkJOtWG72v_soBZfeXGkqMUmQcv-L=NM5oQ@mail.gmail.com>
 <20171111225218.m3cqbid6ug7r57jw@ltop.local>
 <CANeU7QnSOro=WkH_VBoGGCPonAaw-hMGJTVG_8OQPzm19zKvaQ@mail.gmail.com>
 <CAExDi1QwQFQ+dci=j5KrB6_Q65JD496J0U4w_Hv7usHwb-qj-g@mail.gmail.com>
 <CANeU7Q=o+90-BL9RSwONBLmVfvD-RWkDubBskksuvLah1zi8fg@mail.gmail.com>
 <20171112111039.qo6uan73jazriu7n@ltop.local>
 <CANeU7QnLjm1cSD-KY49wXrx1WPNzoXu8TXuym7gei2Aioe+mTQ@mail.gmail.com>
 <20171112184811.ciaoudtwo5bazaj6@ltop.local>
 <CANeU7QnW5x7nmrsXdR9WP+dtbGsZdYsp4nk4fUn0NZx8SnGwkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:55404 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750943AbdKLXGR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Nov 2017 18:06:17 -0500
Received: by mail-wm0-f45.google.com with SMTP id 9so6298990wme.4
        for <linux-sparse@vger.kernel.org>; Sun, 12 Nov 2017 15:06:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7QnW5x7nmrsXdR9WP+dtbGsZdYsp4nk4fUn0NZx8SnGwkg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Nov 13, 2017 at 06:10:26AM +0800, Christopher Li wrote:
> On Mon, Nov 13, 2017 at 2:48 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > I didn't at all forgot this and I still believe that at the
> > time you indeed never saw those pull requests (there was more
> > than one). But time passes and accumulates.
> > Even if you didn't saw the pull requests, you saw the posting
> > for the series, no? And it's since months that you're aware
> > that you didn't saw the pull request. There is also the mail
> > archive and, much more useful, patchwork that keep all the
> > patches. I also sent you a newer pull request 8 weeks ago,
> > right? And it was ignored for 7 weeks, right?
> > You could have send an email saying "sorry, I'll need a few weeks
> > more because now I don't have the time" but no, just nothing.
> 
> Luc, that is what I did. Didn't you receive this email on Oct 17:
> =======================================
> Yes, I have the off line review write up. Let me send it out.
> 
> Thanks for the reminding.
> 
> Chris
> =======================================

But did you sent this review out? When?
 
> What kind of games you are trying to play here?
> 
> The reason those email is hard to write, even after I have
> the offline review is that. I know for a fact that you are going
> to make a big deal of OP_PUSH.

No. I've clearly expressed that I'm quite tired.
I have no intention to make any fight about this OP_PUSH.
 
> It is not about the technical merit any more. It is about
> Chris is not a good maintainer there for Luc should do
> whatever he want.

I have already explained that giving some review in a reasonable
amount of time after a series is first submitted is one thing.
Asking for cosmetic changes (or what I tend to call "surface"
changes) months later is another thing.
The difference being that new code is developed on top
of the old one. And yes, it's always possible to rebase
everything, when it's valuable functional changes.

> You are making your series not touchable. Amount all
> all patch email send over the mailing list. How much can
> I actually pull from according our agreement? Zero.

I consider our agreement as finished.
Pull anything you like.
 
> There is only one valid git pull request, the llvm-fix one.
> It is hold up by the OP_PUSH. I have full screen of
> patch you send I can't apply.

The reason why I insisted about the llvm series is that
because it's the oldest and a lot of further development
depends on it.

> >> Come on, what Linus mean was I should use git merge
> >> rather than apply patches. You take it out of context
> >> of comparing applying patch vs git merge. You insert your
> >> own interpretation that I should not try to provide feed back
> >> and fix up with your branch.
> >
> > I copied his words verbatim.
> > You seem to be very sure of what he meant, fine.
> 
> Of course. Stop using Linus email as justification of forcing
> your code in, even when it is questionable not having technical
> merit.
> 
> The review and merge process is design to keep the bad bits
> out. You are handicapping me by insist on refuse to make any
> fix up changes.
> 
> >
> > Because I don't comment on code that I somehow disagree with,
> > or is not to my taste but which is working well enough that
> > I don't want to block.
> 
> So it is not about technical merit any more. It is about some
> one you disagree with.

You seem to have missed the word "code" here above.
I'll rephrase:
   I don't comment on code if I disagree with the code
   or if the code is not to my taste but still I find
   the code valuable enough that I don't want to block
   it's inclusion.
 
> And what is the reason for not reviewing this:
> "Simplify expr->flags assignement":
> 
> https://patchwork.kernel.org/patch/10042019/

That's exactly the kind of code I find completly without any
value:
- if you make some measurement, please add the mean value
  *AND* the standard deviation
- it's a change for some "optimization" but you state yourself
  in the mail that you don't know if it make any kind of difference.

I suppose, you find it valuable enough, then let's agree we disagree
and since I really don't care about this code and since to me this
change has no "positive" value, it also has no real negative value.
So, I don't comment on this code saying it has no value.

> You are basically starving my patches so that you can claim
> "patch proposed and dropped".

I starving nothing at all.
I would if I would have somehow nacked your patch.

> Luc, you have make it personal. You need to be more open
> minded with the person you have technical disagreement
> with. The more you do this kind of stuff the more it shows
> that you are not ready to become a good open source maintainer.

You see personnal things where there isn't.
 
> > In my world, evidences are patches, working patches, integrated
> > with the rest of the code and reasonably tested.
> > I have a solution which do that, it has been submitted and used
> > by me and Dibyendu. You claim to have a superior solution, OK.
> > Where are the patches? Where can we see the whole thing integrated
> > with all the others fixes? On what have this been tested?
> 
> Come on, I want to get some feed back from you first before
> I develop that into a full working series. Since you are the one
> insist on type-less constant so you might able to see some reasoning
> I don't. So far you provide none.

I don't insist on anything. You have said yourself that I gave no
arguments and it's kinda true.
What I have is a working, integrated and tested set of patches.
 
> Fine, I will follow up with this one.
> 
> > The code is there Chris, it has been submitted, it has my SoB and
> > thus agree with the license. You have fully the right to take my
> > code, you don't need my blessing.
> > If you want to take the code I wrote, take some bits and drop some
> > others and if you think it's a good idea, that's how you can be
> > useful to sparse, fine, please do.
> 
> Of course I don't want to partial apply the series.
> But I do have technical reason to hold of the OP_PUSH.
> What is the solution you suggest here if I don't agree with
> OP_PUSH?

As I said here above: make your own patches with your own solution,
integrate them with the rest of the code and test it.
And when you will have a something working well enough, post them
on the ML so that people can see it and test it on their side.

> I can of course follow up with the PSEUDO_VAL.size one.
> But what about your other part of the series. Can you purpose
> a different pull request without OP_PUSH?

I could but why for? This LLVM series is important, a lot
of my changes depends on it.
Let's first solve this issue with the OP_PUSH.

> Let's discuss a working model I can do my job rejecting some
> patch if really necessary. How many email have we exchange
> and not having a solution?
> 
> >
> > So, now it's me that is holding things? Incredible.
> 
> Yes, by refusing to get a workable solutions if I reject OP_PUSH.

I only ask that you replace it with your solution that you claim
is superior.
Do you maybe expect that I implement your ideas?

> Am I not allow to reject the OP_PUSH because it lack of
> technical merit?

You're the maintainer, you have all the rights you want about
which the code is accepted or not.

> The whole reason I am hesitate to send out that OP_PUSH
> review is because I know you will this kind of behavior.

Funny thing when you have yourself said in late July:
	Warning ahead, the OP_PUSH need more discussion.
	It is not going to apply very quickly.

To which I replied:
	The fact that you said in advance, without any
	kind of discussion, and without having participated
	in any sort of way in the initial discussion, that
	it will be a slow thing (thus a painful thing) make me
	just want to drop the whole thing and move on with
	something else.


I've now spend enough time with this and this is my last email
on the whole subject.

-- Luc Van Oostenryck
