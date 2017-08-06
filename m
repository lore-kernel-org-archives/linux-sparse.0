From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Potential incorrect simplification
Date: Sun, 6 Aug 2017 21:52:23 +0200
Message-ID: <CAMHZB6EMCtU63D10GfQiJ0pgrJurZhcsBY9aw0ohqP_QQDA_pw@mail.gmail.com>
References: <CAExDi1TtcpZtnEV6ctyA9MacJA_9h4njmhd-MSA3KgOq8oK_gA@mail.gmail.com>
 <CACXZuxfxNNh+ThcT=7Xr98tToL2GimFi7UOTSwgNq6mfLLGNfA@mail.gmail.com>
 <20170328141113.kbrwdva6ttsrokts@macpro.local> <CACXZuxen9UFGNp8=-OQHoqRQJ5F__rwQoCJJ6TdkAo6HEXWOQw@mail.gmail.com>
 <CA+55aFx6g3-+6tJ_6Uqu4K1pQoDnqcXrjSGYsryLjjksEtT06A@mail.gmail.com>
 <CANeU7Qk-4U2G_6CZ7KHbGZiqRe9=fpNOzE4eyfLjz3fnd_n3ww@mail.gmail.com>
 <20170806140035.f2tqkmiufjytiwri@ltop.local> <CANeU7QnjRSnnSc8ew69-0M7XP2zoSVh3jhCciYDRVF0i24d=sQ@mail.gmail.com>
 <20170806150712.seci4rq2nhuqx2mc@ltop.local> <CANeU7QnbtvGQMBZjfBSA-njbMMrPVcTb4xTOU8kd_JPb14n63Q@mail.gmail.com>
 <20170806165156.onm2bzojkueit6ec@ltop.local> <CANeU7QnqdkrtxbCzc8_g6BBjFzdcw4XgfB-8vmBq6esb7mq9aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35228 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751349AbdHFTwZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Aug 2017 15:52:25 -0400
Received: by mail-qk0-f182.google.com with SMTP id d145so31104677qkc.2
        for <linux-sparse@vger.kernel.org>; Sun, 06 Aug 2017 12:52:24 -0700 (PDT)
In-Reply-To: <CANeU7QnqdkrtxbCzc8_g6BBjFzdcw4XgfB-8vmBq6esb7mq9aw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 6, 2017 at 8:35 PM, Christopher Li <sparse@chrisli.org> wrote:
>>> That is true but not relevant.
>>
>> It's very relevant because its semantic is not defined.
>> In other words, you can do anything you like (for the
>> standard point of view).
>
> You can keep on arguing semantic is not defined.
> When you have "usage before define" like the following:
>           and.32      %r3 <- %r4, $-65
>           or.32       %r4 <- %r3, $64
>
> It has direct consequence classic SSA algorithm can
> not be done safely on later stage.

Who has said the contrary? me?

>> It's also relevant because you will then probably want
>> to avoid to (generate code which) access such vars *and*
>> want to detect them.
>
> Do you know that your request is unreasonable?

Uh? It's what all compilers do and what the current sparse *try* to do.

> Detecting the usage of uninitialized variable in a program
> is equivalent of the Turing halting problem. It is not Turing
> commutable, there is no easy way to do it correctly in all
> the situation.

"want to avoid" doesn't mean "will avoid in all such cases and only such cases".


>> This is also what I'm doing for various reasons.
>> But once you initialize it with a special value, by definition,
>> it's not uninitialized anymore.
>
> That is useless argument. You can call it what you want.

It's not an argument.

> It  does not change the fact that:
>           and.32      %r3 <- %r4, $-65
>           or.32       %r4 <- %r3, $64
>
> Break the SSA dominance property. We shouldn't generate code
> like that. We do have a choice not to do it this way.

Again, who said the contrary?

>> I was referring to the 'internal bug' case.
>> The current "crazy programmer" warning is as much a kind of
>> assert on the internal consistency of the SSA form than a detection
>> of uninitialized variables.
>
> In my book, we shouldn't get into that case at all. When we have
>           add %r1 <- %r1, 4
> We already screw up the SSA form.

Yes, it's called a 'bug'.

>>> Refer to the book for more detail description of the algorithm
>>> how to convert to SSA. We don't need to reinvent the wheel.
>>
>> Who's talking about reinventing the wheel?
>> Your question was about "is it legal SSA form" (in the current sparse code)
>> and I explained to you that it was the symptom of a problem.
>
> Yes, you keep on arguing this is the result of uninitialized variable.
> Nothing to worry about.

You asked a question about the *current* behaviour of sparse
and I explained the reason of this behaviour.
It's not because explain this that I'm also saying
"that is the correct behaviour and nothing must be changed about".

And you know that I don't think so because we already talked about it.
And I already said you that I have code that redo the SSA construction
and that this code doesn't have the issues with undef vars because
I used a special value for them.

And you know that it is already written and working relatively well
like passing all the tests from the testsuite because I told you so
only a few days ago.

> Then how to fix it is just technical details.
> I care less about warning uninitialized variable warning, which
> we can't do a perfect job any way. I am more worry about those
> screw up SSA forms.

It's where we disagree.
You're talking about this SSA thing as if you're busy writing a
compiler but currently and since its creation sparse is a
*semantic checker* used in *complement* of a real compiler
to give warnings that the compiler doesn't bother with.

My opinion is that it is *very* valuable to given the best possible
warnings and yes it sucks that so many things relative to
compiler technology are undecidable or NP-hard & friends.
But this only means that it is impossible to do a *perfect* job,
not that it is impossible to do a *good* job.

Writting a toy compiler is very easy, every student who had some
"compiler 101" course had to write one. It's maybe fun but is it useful?
What's the point of a compiler giving no or bad warnings?
What's the point of a non-optimizing compiler?
And you need decent optimizations to give decent warnings.

> The impression I get from the previous discussion is that, we kind of
> willfully do it and blame the source has uninitialized variable, without
> realized that our internal IR transformation has serious problem of
> breaking SSA property as well.

It's not my impression at all.
At best it's "sorry but for the moment we can't deal with this".
And again, you know very well that I'm very aware that our SSA
has serious problems, I told you about it.

> Now that RC5 is almost out of the door.  It is my intention to start this
> discussion to clarify things and point out things I believe is wrong.
> I know it is going to be a controversial topic :-)

I have a feeling that the 150+ patches that are pending since
January-March will have to wait even more.
Same for a series that is waiting since more than 2 years now.
Am I wrong?

-- Luc
