From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/2] Fix illegal simplification of volatile stores
Date: Mon, 13 Nov 2017 06:10:26 +0800
Message-ID: <CANeU7QnW5x7nmrsXdR9WP+dtbGsZdYsp4nk4fUn0NZx8SnGwkg@mail.gmail.com>
References: <20171111162500.69476-1-luc.vanoostenryck@gmail.com>
 <CANeU7QnJgGdWtM3KkJOtWG72v_soBZfeXGkqMUmQcv-L=NM5oQ@mail.gmail.com>
 <20171111225218.m3cqbid6ug7r57jw@ltop.local> <CANeU7QnSOro=WkH_VBoGGCPonAaw-hMGJTVG_8OQPzm19zKvaQ@mail.gmail.com>
 <CAExDi1QwQFQ+dci=j5KrB6_Q65JD496J0U4w_Hv7usHwb-qj-g@mail.gmail.com>
 <CANeU7Q=o+90-BL9RSwONBLmVfvD-RWkDubBskksuvLah1zi8fg@mail.gmail.com>
 <20171112111039.qo6uan73jazriu7n@ltop.local> <CANeU7QnLjm1cSD-KY49wXrx1WPNzoXu8TXuym7gei2Aioe+mTQ@mail.gmail.com>
 <20171112184811.ciaoudtwo5bazaj6@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:48216 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750921AbdKLWK1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Nov 2017 17:10:27 -0500
Received: by mail-yw0-f176.google.com with SMTP id q1so12043676ywh.5
        for <linux-sparse@vger.kernel.org>; Sun, 12 Nov 2017 14:10:27 -0800 (PST)
In-Reply-To: <20171112184811.ciaoudtwo5bazaj6@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Nov 13, 2017 at 2:48 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> I didn't at all forgot this and I still believe that at the
> time you indeed never saw those pull requests (there was more
> than one). But time passes and accumulates.
> Even if you didn't saw the pull requests, you saw the posting
> for the series, no? And it's since months that you're aware
> that you didn't saw the pull request. There is also the mail
> archive and, much more useful, patchwork that keep all the
> patches. I also sent you a newer pull request 8 weeks ago,
> right? And it was ignored for 7 weeks, right?
> You could have send an email saying "sorry, I'll need a few weeks
> more because now I don't have the time" but no, just nothing.

Luc, that is what I did. Didn't you receive this email on Oct 17:
=======================================
Yes, I have the off line review write up. Let me send it out.

Thanks for the reminding.

Chris
=======================================

What kind of games you are trying to play here?

The reason those email is hard to write, even after I have
the offline review is that. I know for a fact that you are going
to make a big deal of OP_PUSH.

It is not about the technical merit any more. It is about
Chris is not a good maintainer there for Luc should do
whatever he want.

You are making your series not touchable. Amount all
all patch email send over the mailing list. How much can
I actually pull from according our agreement? Zero.

There is only one valid git pull request, the llvm-fix one.
It is hold up by the OP_PUSH. I have full screen of
patch you send I can't apply.

>> Come on, what Linus mean was I should use git merge
>> rather than apply patches. You take it out of context
>> of comparing applying patch vs git merge. You insert your
>> own interpretation that I should not try to provide feed back
>> and fix up with your branch.
>
> I copied his words verbatim.
> You seem to be very sure of what he meant, fine.

Of course. Stop using Linus email as justification of forcing
your code in, even when it is questionable not having technical
merit.

The review and merge process is design to keep the bad bits
out. You are handicapping me by insist on refuse to make any
fix up changes.

>
> Because I don't comment on code that I somehow disagree with,
> or is not to my taste but which is working well enough that
> I don't want to block.

So it is not about technical merit any more. It is about some
one you disagree with.

And what is the reason for not reviewing this:
"Simplify expr->flags assignement":

https://patchwork.kernel.org/patch/10042019/

You are basically starving my patches so that you can claim
"patch proposed and dropped".

Luc, you have make it personal. You need to be more open
minded with the person you have technical disagreement
with. The more you do this kind of stuff the more it shows
that you are not ready to become a good open source maintainer.

>
> In my world, evidences are patches, working patches, integrated
> with the rest of the code and reasonably tested.
> I have a solution which do that, it has been submitted and used
> by me and Dibyendu. You claim to have a superior solution, OK.
> Where are the patches? Where can we see the whole thing integrated
> with all the others fixes? On what have this been tested?

Come on, I want to get some feed back from you first before
I develop that into a full working series. Since you are the one
insist on type-less constant so you might able to see some reasoning
I don't. So far you provide none.

Fine, I will follow up with this one.

> The code is there Chris, it has been submitted, it has my SoB and
> thus agree with the license. You have fully the right to take my
> code, you don't need my blessing.
> If you want to take the code I wrote, take some bits and drop some
> others and if you think it's a good idea, that's how you can be
> useful to sparse, fine, please do.

Of course I don't want to partial apply the series.
But I do have technical reason to hold of the OP_PUSH.
What is the solution you suggest here if I don't agree with
OP_PUSH?

I can of course follow up with the PSEUDO_VAL.size one.
But what about your other part of the series. Can you purpose
a different pull request without OP_PUSH?

Let's discuss a working model I can do my job rejecting some
patch if really necessary. How many email have we exchange
and not having a solution?

>
> So, now it's me that is holding things? Incredible.

Yes, by refusing to get a workable solutions if I reject OP_PUSH.

Am I not allow to reject the OP_PUSH because it lack of
technical merit?

The whole reason I am hesitate to send out that OP_PUSH
review is because I know you will this kind of behavior.

Chris
