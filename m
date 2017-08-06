From: Christopher Li <sparse@chrisli.org>
Subject: Re: Potential incorrect simplification
Date: Sun, 6 Aug 2017 14:35:34 -0400
Message-ID: <CANeU7QnqdkrtxbCzc8_g6BBjFzdcw4XgfB-8vmBq6esb7mq9aw@mail.gmail.com>
References: <CAExDi1TtcpZtnEV6ctyA9MacJA_9h4njmhd-MSA3KgOq8oK_gA@mail.gmail.com>
 <CACXZuxfxNNh+ThcT=7Xr98tToL2GimFi7UOTSwgNq6mfLLGNfA@mail.gmail.com>
 <20170328141113.kbrwdva6ttsrokts@macpro.local> <CACXZuxen9UFGNp8=-OQHoqRQJ5F__rwQoCJJ6TdkAo6HEXWOQw@mail.gmail.com>
 <CA+55aFx6g3-+6tJ_6Uqu4K1pQoDnqcXrjSGYsryLjjksEtT06A@mail.gmail.com>
 <CANeU7Qk-4U2G_6CZ7KHbGZiqRe9=fpNOzE4eyfLjz3fnd_n3ww@mail.gmail.com>
 <20170806140035.f2tqkmiufjytiwri@ltop.local> <CANeU7QnjRSnnSc8ew69-0M7XP2zoSVh3jhCciYDRVF0i24d=sQ@mail.gmail.com>
 <20170806150712.seci4rq2nhuqx2mc@ltop.local> <CANeU7QnbtvGQMBZjfBSA-njbMMrPVcTb4xTOU8kd_JPb14n63Q@mail.gmail.com>
 <20170806165156.onm2bzojkueit6ec@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34802 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751341AbdHFSfg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Aug 2017 14:35:36 -0400
Received: by mail-pf0-f174.google.com with SMTP id o86so25570877pfj.1
        for <linux-sparse@vger.kernel.org>; Sun, 06 Aug 2017 11:35:36 -0700 (PDT)
In-Reply-To: <20170806165156.onm2bzojkueit6ec@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 6, 2017 at 12:51 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Sun, Aug 06, 2017 at 11:51:24AM -0400, Christopher Li wrote:
>> On Sun, Aug 6, 2017 at 11:07 AM, Luc Van Oostenryck
>> <luc.vanoostenryck@gmail.com> wrote:
>> >> Legal SSA form means it preserve the normal SSA
>> >> properties. E.g. the dominance property of SSA.
>> >
>> > And under which conditions are SSA properties *defined*?
>>
>> Not sure I understand what you are asking:
>> Quote from previous email about the definition of the properties.
>>
>> http://marcusdenker.de/talks/08CC/08IntroSSA.pdf
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =CE=A6-Functions are placed in all basic blocks of the
>> Dominance Frontier.
>>
>> Dominance Property of SSA:
>> 1. If x is used in a Phi-function in block N,
>> then the definition of x dominates *every* <=3D=3D=3D=3D notice "every"
>> predecessor of N.
>> 2. If x is used in a non-Phi statement in N,
>> then the definition of x dominates N
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> If we are asking when should we follow those properties.
>> I think *always*.
>
> It's typically things that are not discussed about in papers.
> They assume proper, well defined inputs (or even simplified
> situation only) or that it is easy enough to force it to be
> well defined that it's not useful to talk about it.

Your understanding is wrong. The book I quote already clearly
discuss how to handle uninitialized variable in SSA form. I quote
it in the email before and I will quote it again here:

quote my email :----------------
There is actually not many books explicit discuss handle
of uninitialized variables. The best explicit description I can
find is in this book
"modern compiler implementation in java" by Andrew W. Appel
Chapter 19.1 page 402. After 6 list item of Path-convergence
criterion (of phi function).

Quote: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
We consider the start node to contain an implicit definition of
*every* variable., either because the variable may be a formal
parameter or to represent the notion of a <-- *uninitialized* with
special cases.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
----------------------------



>> That is true but not relevant.
>
> It's very relevant because its semantic is not defined.
> In other words, you can do anything you like (for the
> standard point of view).

You can keep on arguing semantic is not defined.
When you have "usage before define" like the following:
          and.32      %r3 <- %r4, $-65
          or.32       %r4 <- %r3, $64

It has direct consequence classic SSA algorithm can
not be done safely on later stage.

> It's also relevant because you will then probably want
> to avoid to (generate code which) access such vars *and*
> want to detect them.

Do you know that your request is unreasonable?

Detecting the usage of uninitialized variable in a program
is equivalent of the Turing halting problem. It is not Turing
commutable, there is no easy way to do it correctly in all
the situation.

It is also irreverent if I want to give warning to uninitialized variable
usage or not. I want sparse don't generate code like:
          and.32      %r3 <- %r4, $-65
          or.32       %r4 <- %r3, $64

Do it more like the gcc or llvm does. Don't break the dominance
property of SSA for no good reason.

>
>> >> In such condition the compiler produce transformation
>> >> that break the dominance property of SSA is wrong IMHO.
>> >
>> > The SSA properties are not defined for this kind of input.
>>
>> That is just your view. It is clearly not the view in academia.
>
> Really?

Of course. There is already books rewritten about how to handle
uninitialized variable. You keep on arguing this thing is not
defined. Those people on the academia does not know what they
are doing, they haven't discuss how to handle uninitialized variable.
It is clearly not the case. The book is the prove.

If you follow the definition I quote, one for phi node,  two for SSA.
You can actually deduce the same conclusion yourself. If you
have the patient for it, I can deduce it step by step for you.


>> 2. Do not break the SSA dominance property. Give the uninitialized
>>     variable an implicit defined as "uninitialized". That is the method
>>     describe in Appel's book. It is also the model gcc and llvm use as
>>     well as far as I can tell.
>
> This is also what I'm doing for various reasons.
> But once you initialize it with a special value, by definition,
> it's not uninitialized anymore.

That is useless argument. You can call it what you want.
It  does not change the fact that:
          and.32      %r3 <- %r4, $-65
          or.32       %r4 <- %r3, $64

Break the SSA dominance property. We shouldn't generate code
like that. We do have a choice not to do it this way.

> I was referring to the 'internal bug' case.
> The current "crazy programmer" warning is as much a kind of
> assert on the internal consistency of the SSA form than a detection
> of uninitialized variables.

In my book, we shouldn't get into that case at all. When we have
          add %r1 <- %r1, 4
We already screw up the SSA form. We should look into what
transformation produce that illegal SSA form and make sure it does
not produce the IR violate the SSA property.


>
>> Refer to the book for more detail description of the algorithm
>> how to convert to SSA. We don't need to reinvent the wheel.
>
> Who's talking about reinventing the wheel?
> Your question was about "is it legal SSA form" (in the current sparse cod=
e)
> and I explained to you that it was the symptom of a problem.

Yes, you keep on arguing this is the result of uninitialized variable.
Nothing to worry about.

My point about not reinventing the wheel is that, there is clearly
SSA conversion algorithms clearly take into the account that variable
can be uninitialized, how to do the SSA conversion in that case.
If we use those algorithms, it will get us closer to the gcc and llvm
IR in terms of uninitialized variables.

There is no reason to break the SSA property for no good reason.
It is no like we don't have a choice and we have to break it. We are
willingly break it because we don't know better about SSA.

> Nobody is claiming that the current situation is a good one.

Great, that is some step towards consensus.

If we agree sparse shouldn't generate the following.

          and.32      %r3 <- %r4, $-65
          or.32       %r4 <- %r3, $64

Let's fix it then.

We can start with the proper placement of the phi node and use
the algorithm in the Appel book for example. That is a good starting
point.

>> We don't need to detect it. Every variable start with defined to uniniti=
alized
>> unless specify otherwise.
>
> If you give a special distinguished value to uninitialized vars (or
> to every until they receive a real one or the same to pseudos) then
> you can detect them when you got this special distinguished value.
> It's one method.
>
> The *current* method is to check these self-definition cycles.
> It's an inferior method IMO (and apparently you too) but it has
> the advantage to be simple *and* to do an internal self-consistency
> check at the same time.
>
> Do I mean that we should keep the current method?
> Not at all.
> Do I mean that we should keep thsi check for the self-consistency
> check? Yes, probably, at least as an option.

Well, let's agree on we shouldn't produce
          and.32      %r3 <- %r4, $-65
          or.32       %r4 <- %r3, $64

first at principle level.

Then how to fix it is just technical details.
I care less about warning uninitialized variable warning, which
we can't do a perfect job any way. I am more worry about those
screw up SSA forms.

> Is there some better way to do this sort of check?
> Maybe and it will also depends on the details of the implementation.

As I said the algorithm in Appel's books is a good starting point.
It clearly already consider the uninitialized variable situation and
give a solution for it.


>> True but irrelevant to my discussion. My point is you make the choice,
>> you face the consequence. Our garbage in garbage out choice is not
>> a good one because I can't use classic ssa algorithms safely.
>
> But if there is an internal bug, this algo will also not be safe,
> so the utility for some self-consistency/validity checks.

The impression I get from the previous discussion is that, we kind of
willfully do it and blame the source has uninitialized variable, without
realized that our internal IR transformation has serious problem of
breaking SSA property as well.

Now that RC5 is almost out of the door.  It is my intention to start this
discussion to clarify things and point out things I believe is wrong.
I know it is going to be a controversial topic :-)

> Next time, instead of asking a question like "is it legal ..."
> simply state something like:
>  "the current situation with this and that is annoying because
>   this and that. I'm planning to change it by this so that ..."
> and it will be much more easier for everybody to understand what
> you're really asking for.

Sure. I am just describing my mental model, how I come to that
conclusion. Previously I sense some thing is wrong, but I could
not articulate it clearly. It clearly shows in my our email discussion
as well.

Now I did more search and thing it very well through. I can point out
exactly what is wrong and why it is wrong. I already layout all my
necessarily material to support my argument in my first email.
I just keep referring back to it.

Chris
