From: Christopher Li <sparse@chrisli.org>
Subject: Re: Potential incorrect simplification
Date: Sun, 6 Aug 2017 20:38:11 -0400
Message-ID: <CANeU7Q=zFg7D8vtMG2PTbjtOw9q6AjZjoQS5BvaOqPZg372ZYw@mail.gmail.com>
References: <CA+55aFx6g3-+6tJ_6Uqu4K1pQoDnqcXrjSGYsryLjjksEtT06A@mail.gmail.com>
 <CANeU7Qk-4U2G_6CZ7KHbGZiqRe9=fpNOzE4eyfLjz3fnd_n3ww@mail.gmail.com>
 <20170806140035.f2tqkmiufjytiwri@ltop.local> <CANeU7QnjRSnnSc8ew69-0M7XP2zoSVh3jhCciYDRVF0i24d=sQ@mail.gmail.com>
 <20170806150712.seci4rq2nhuqx2mc@ltop.local> <CANeU7QnbtvGQMBZjfBSA-njbMMrPVcTb4xTOU8kd_JPb14n63Q@mail.gmail.com>
 <20170806165156.onm2bzojkueit6ec@ltop.local> <CANeU7QnqdkrtxbCzc8_g6BBjFzdcw4XgfB-8vmBq6esb7mq9aw@mail.gmail.com>
 <CAMHZB6EMCtU63D10GfQiJ0pgrJurZhcsBY9aw0ohqP_QQDA_pw@mail.gmail.com>
 <CANeU7QkFwMw-yFSXpQ1pTzf9fiVFLWtpqCju0hu2Z50dqHR4OA@mail.gmail.com> <20170807003126.xjahzeki2aff32kq@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35452 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751374AbdHGAiN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Aug 2017 20:38:13 -0400
Received: by mail-pg0-f43.google.com with SMTP id v189so27389219pgd.2
        for <linux-sparse@vger.kernel.org>; Sun, 06 Aug 2017 17:38:12 -0700 (PDT)
In-Reply-To: <20170807003126.xjahzeki2aff32kq@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 6, 2017 at 8:31 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>> You are saying you did not answer my question directly. You did not
>> pass judgement on weather this thing is legal or not. You just say why
>> it was done this way.
>
> Because answering this question with an 'yes' or a 'no' is pointless.
> Imagine that some authority on compiler would have answered to you
> 'yes' I consider that as legal because this or that. Would it have
> helped you? I don't think so. Same with 'no'.

It is not pointless if sparse don't produce the "usage before define"
code.

>
>> > It's not because explain this that I'm also saying
>> > "that is the correct behaviour and nothing must be changed about".
>> >
>> > And you know that I don't think so because we already talked about it.
>> > And I already said you that I have code that redo the SSA construction
>> > and that this code doesn't have the issues with undef vars because
>> > I used a special value for them.
>>
>> That is what I want to find out, if your new SSA form have the similar
>> problem violating the SSA property or not.
>
> It would have been easier to simply ask it.

I did in another email.

>> It is actually
>> the reverse, do proper SSA will help you find out using uninitialized
>> value better.
>>
>> But as I said, we can't get the warning perfect right due to nature
>> of the problem.
>
> Yes, it's pretty well known about uninitialized vars.
>
>> > My opinion is that it is *very* valuable to given the best possible
>> > warnings and yes it sucks that so many things relative to
>> > compiler technology are undecidable or NP-hard & friends.
>> > But this only means that it is impossible to do a *perfect* job,
>> > not that it is impossible to do a *good* job.
>>
>> No disagreement here. Warning and proper SSA form is two different
>> thing.
>
> Good.
>
>> You told me about the placement of phi node. I look it up. Yes
>> it is a big problem. But that "usage before define" and violating the
>> SSA dominance property you never told me about.
>
> I certainly not said something like "usage before define" since it's
> just a symptom. I told you about solving problmes with the handling
> of undefined vars.

OK. I don't know what is the detail of handle undefined vars
from you description.

>
>> You does not seem to
>> understand what property SSA should have in the first few response
>> to my email, questioning how to define "illegal SSA".  That is my
>> impression, I can be wrong.
>
> Your impression is very wrong.
> Otherwise I wouldn't have bothered to write code to redo the SSA
> construction thing and told you that there is a lot of problems
> with the current SSA.

All good then.

>> >> Now that RC5 is almost out of the door.  It is my intention to start this
>> >> discussion to clarify things and point out things I believe is wrong.
>> >> I know it is going to be a controversial topic :-)
>> >
>> > I have a feeling that the 150+ patches that are pending since
>> > January-March will have to wait even more.
>> > Same for a series that is waiting since more than 2 years now.
>> > Am I wrong?
>>
>> No, and sorry about that. I was too busy at that time. But now I have
>> allocate some time for sparse. Let's do the review process again
>> after the release.
>
> OK good to hear that.
> I insist very heavily that I would like those to be handled *before*
> moving further witht the SSA thing. Especially for Nicolai's series
> which is waiting since a scandalous amount of time.

No problem. One at a time.

Chris
