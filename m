From: Christopher Li <sparse@chrisli.org>
Subject: Re: Potential incorrect simplification
Date: Sun, 6 Aug 2017 19:34:50 -0400
Message-ID: <CANeU7QkFwMw-yFSXpQ1pTzf9fiVFLWtpqCju0hu2Z50dqHR4OA@mail.gmail.com>
References: <CAExDi1TtcpZtnEV6ctyA9MacJA_9h4njmhd-MSA3KgOq8oK_gA@mail.gmail.com>
 <CACXZuxfxNNh+ThcT=7Xr98tToL2GimFi7UOTSwgNq6mfLLGNfA@mail.gmail.com>
 <20170328141113.kbrwdva6ttsrokts@macpro.local> <CACXZuxen9UFGNp8=-OQHoqRQJ5F__rwQoCJJ6TdkAo6HEXWOQw@mail.gmail.com>
 <CA+55aFx6g3-+6tJ_6Uqu4K1pQoDnqcXrjSGYsryLjjksEtT06A@mail.gmail.com>
 <CANeU7Qk-4U2G_6CZ7KHbGZiqRe9=fpNOzE4eyfLjz3fnd_n3ww@mail.gmail.com>
 <20170806140035.f2tqkmiufjytiwri@ltop.local> <CANeU7QnjRSnnSc8ew69-0M7XP2zoSVh3jhCciYDRVF0i24d=sQ@mail.gmail.com>
 <20170806150712.seci4rq2nhuqx2mc@ltop.local> <CANeU7QnbtvGQMBZjfBSA-njbMMrPVcTb4xTOU8kd_JPb14n63Q@mail.gmail.com>
 <20170806165156.onm2bzojkueit6ec@ltop.local> <CANeU7QnqdkrtxbCzc8_g6BBjFzdcw4XgfB-8vmBq6esb7mq9aw@mail.gmail.com>
 <CAMHZB6EMCtU63D10GfQiJ0pgrJurZhcsBY9aw0ohqP_QQDA_pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35842 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751355AbdHFXew (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Aug 2017 19:34:52 -0400
Received: by mail-pg0-f54.google.com with SMTP id v77so26997936pgb.3
        for <linux-sparse@vger.kernel.org>; Sun, 06 Aug 2017 16:34:52 -0700 (PDT)
In-Reply-To: <CAMHZB6EMCtU63D10GfQiJ0pgrJurZhcsBY9aw0ohqP_QQDA_pw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 6, 2017 at 3:52 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Sun, Aug 6, 2017 at 8:35 PM, Christopher Li <sparse@chrisli.org> wrote:
>>>> That is true but not relevant.
>>>
>>> It's very relevant because its semantic is not defined.
>>> In other words, you can do anything you like (for the
>>> standard point of view).
>>
>> You can keep on arguing semantic is not defined.
>> When you have "usage before define" like the following:
>>           and.32      %r3 <- %r4, $-65
>>           or.32       %r4 <- %r3, $64
>>
>> It has direct consequence classic SSA algorithm can
>> not be done safely on later stage.
>
> Who has said the contrary? me?

If you have no problem with getting avoid producing the
offending IR. The we are in agreement. No problem there.
For a second I think you are going to defend why it should
do that way, as if that is the more correct way.



>>>> It's also relevant because you will then probably want
>>> to avoid to (generate code which) access such vars *and*
>>> want to detect them.
>>
>> Do you know that your request is unreasonable?
>
> Uh? It's what all compilers do and what the current sparse *try* to do.

Keep trying. We can try all right. I just give the upper bound that
this thing can be done correctly in every aspect easily. But that
is getting off topic here.

The topic really want to focus on is those SSA form that violate the
SSA dominance property. Let's agree on not producing those.


>> Detecting the usage of uninitialized variable in a program
>> is equivalent of the Turing halting problem. It is not Turing
>> commutable, there is no easy way to do it correctly in all
>> the situation.
>
> "want to avoid" doesn't mean "will avoid in all such cases and only such cases".

Sure, do what you can. Again, that is not the topic I want to discuss.
It is a different topic than the one I want to focus on, the "usage before
define" kind of the SSA form.

>>> This is also what I'm doing for various reasons.
>>> But once you initialize it with a special value, by definition,
>>> it's not uninitialized anymore.
>>
>> That is useless argument. You can call it what you want.
>
> It's not an argument.
>
>> It  does not change the fact that:
>>           and.32      %r3 <- %r4, $-65
>>           or.32       %r4 <- %r3, $64
>>
>> Break the SSA dominance property. We shouldn't generate code
>> like that. We do have a choice not to do it this way.
>
> Again, who said the contrary?

So we are in agreement. Great.

>
>>> I was referring to the 'internal bug' case.
>>> The current "crazy programmer" warning is as much a kind of
>>> assert on the internal consistency of the SSA form than a detection
>>> of uninitialized variables.
>>
>> In my book, we shouldn't get into that case at all. When we have
>>           add %r1 <- %r1, 4
>> We already screw up the SSA form.
>
> Yes, it's called a 'bug'.

Glad to heard that.


>
>>>> Refer to the book for more detail description of the algorithm
>>>> how to convert to SSA. We don't need to reinvent the wheel.
>>>
>>> Who's talking about reinventing the wheel?
>>> Your question was about "is it legal SSA form" (in the current sparse code)
>>> and I explained to you that it was the symptom of a problem.
>>
>> Yes, you keep on arguing this is the result of uninitialized variable.
>> Nothing to worry about.
>
> You asked a question about the *current* behaviour of sparse
> and I explained the reason of this behaviour.

I ask the question weather this SSA form is legal (in the sense
that preserving SSA property if you want to be more specific.)

You are saying you did not answer my question directly. You did not
pass judgement on weather this thing is legal or not. You just say why
it was done this way.

> It's not because explain this that I'm also saying
> "that is the correct behaviour and nothing must be changed about".
>
> And you know that I don't think so because we already talked about it.
> And I already said you that I have code that redo the SSA construction
> and that this code doesn't have the issues with undef vars because
> I used a special value for them.

That is what I want to find out, if your new SSA form have the similar
problem violating the SSA property or not.

>
> And you know that it is already written and working relatively well
> like passing all the tests from the testsuite because I told you so
> only a few days ago.

Good. I really hope it does not violate the SSA dominance property.
I don't want yet another SSA construction that violate the SSA dominance
property. Which means I still need to get ones that doesn't violating the
property so I can use classic SSA algorithms.


>
>> Then how to fix it is just technical details.
>> I care less about warning uninitialized variable warning, which
>> we can't do a perfect job any way. I am more worry about those
>> screw up SSA forms.
>
> It's where we disagree.
> You're talking about this SSA thing as if you're busy writing a
> compiler but currently and since its creation sparse is a
> *semantic checker* used in *complement* of a real compiler
> to give warnings that the compiler doesn't bother with.

That is actually the case. I am serious considering introduce
the classic SSA algorithms like dead code eliminate using ssa.
constant propagation using ssa. etc. It is going to work a lot better
than the current simplification process as far as I can tell.

Please don't mix the raising warning thing as if do proper SSA
hinder you raise warning about uninitialized value. It is actually
the reverse, do proper SSA will help you find out using uninitialized
value better.

But as I said, we can't get the warning perfect right due to nature
of the problem.

> My opinion is that it is *very* valuable to given the best possible
> warnings and yes it sucks that so many things relative to
> compiler technology are undecidable or NP-hard & friends.
> But this only means that it is impossible to do a *perfect* job,
> not that it is impossible to do a *good* job.

No disagreement here. Warning and proper SSA form is two different
thing.

> Writting a toy compiler is very easy, every student who had some
> "compiler 101" course had to write one. It's maybe fun but is it useful?
> What's the point of a compiler giving no or bad warnings?
> What's the point of a non-optimizing compiler?
> And you need decent optimizations to give decent warnings.

Agree. No disagreement there. I just point out we can't do
perfect job there. I am more concern about the proper SSA form.
It is two different topic.

>> The impression I get from the previous discussion is that, we kind of
>> willfully do it and blame the source has uninitialized variable, without
>> realized that our internal IR transformation has serious problem of
>> breaking SSA property as well.
>
> It's not my impression at all.
> At best it's "sorry but for the moment we can't deal with this".
> And again, you know very well that I'm very aware that our SSA
> has serious problems, I told you about it.

You told me about the placement of phi node. I look it up. Yes
it is a big problem. But that "usage before define" and violating the
SSA dominance property you never told me about. I found it out
myself with some help from the experts. You does not seem to
understand what property SSA should have in the first few response
to my email, questioning how to define "illegal SSA".  That is my
impression, I can be wrong.

If you are saying sorry we don't know how to do proper SSA.
The algorithm I point out from the book can already handle uninitialized
value. It can serve as a starting point if we don't know how to do it.

>> Now that RC5 is almost out of the door.  It is my intention to start this
>> discussion to clarify things and point out things I believe is wrong.
>> I know it is going to be a controversial topic :-)
>
> I have a feeling that the 150+ patches that are pending since
> January-March will have to wait even more.
> Same for a series that is waiting since more than 2 years now.
> Am I wrong?

No, and sorry about that. I was too busy at that time. But now I have
allocate some time for sparse. Let's do the review process again
after the release.

Topic like this which will have impact on the patches, also define the
direction sparse will be handing. I give it more priority.

Chris
