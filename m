From: Christopher Li <sparse@chrisli.org>
Subject: Re: Potential incorrect simplification
Date: Sun, 6 Aug 2017 11:51:24 -0400
Message-ID: <CANeU7QnbtvGQMBZjfBSA-njbMMrPVcTb4xTOU8kd_JPb14n63Q@mail.gmail.com>
References: <CACXZuxeRXsYWgwihs1nmmTYaLoyhw+PDAy6jEemkZJFpySdfQA@mail.gmail.com>
 <CAExDi1TtcpZtnEV6ctyA9MacJA_9h4njmhd-MSA3KgOq8oK_gA@mail.gmail.com>
 <CACXZuxfxNNh+ThcT=7Xr98tToL2GimFi7UOTSwgNq6mfLLGNfA@mail.gmail.com>
 <20170328141113.kbrwdva6ttsrokts@macpro.local> <CACXZuxen9UFGNp8=-OQHoqRQJ5F__rwQoCJJ6TdkAo6HEXWOQw@mail.gmail.com>
 <CA+55aFx6g3-+6tJ_6Uqu4K1pQoDnqcXrjSGYsryLjjksEtT06A@mail.gmail.com>
 <CANeU7Qk-4U2G_6CZ7KHbGZiqRe9=fpNOzE4eyfLjz3fnd_n3ww@mail.gmail.com>
 <20170806140035.f2tqkmiufjytiwri@ltop.local> <CANeU7QnjRSnnSc8ew69-0M7XP2zoSVh3jhCciYDRVF0i24d=sQ@mail.gmail.com>
 <20170806150712.seci4rq2nhuqx2mc@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36304 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbdHFPv0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Aug 2017 11:51:26 -0400
Received: by mail-pf0-f169.google.com with SMTP id c28so24087441pfe.3
        for <linux-sparse@vger.kernel.org>; Sun, 06 Aug 2017 08:51:26 -0700 (PDT)
In-Reply-To: <20170806150712.seci4rq2nhuqx2mc@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 6, 2017 at 11:07 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>> Legal SSA form means it preserve the normal SSA
>> properties. E.g. the dominance property of SSA.
>
> And under which conditions are SSA properties *defined*?

Not sure I understand what you are asking:
Quote from previous email about the definition of the properties.

http://marcusdenker.de/talks/08CC/08IntroSSA.pdf
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=CE=A6-Functions are placed in all basic blocks of the
Dominance Frontier.

Dominance Property of SSA:
1. If x is used in a Phi-function in block N,
then the definition of x dominates *every* <=3D=3D=3D=3D notice "every"
predecessor of N.
2. If x is used in a non-Phi statement in N,
then the definition of x dominates N
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

If we are asking when should we follow those properties.
I think *always*.


>
>> > As I've already tried to explain you several times:
>> >         it's a *symptom* that something have been wrong, either:
>> >         - the initial code had some undefined variables
>>
>> The source code has some variable uninitialized is still valid
>> C source code.
>
> It's valid in the sense that code is written like this and
> compilers (and checkers!) should better try to process it
> in a usefull manner.
>
> But accessing such variable is *undefined behaviour*.

That is true but not relevant. I am pointing out sparse does
incorrect transformation produce "usage before define"
IR, which break the SSA dominance property. Which
can be avoided.

>
>> In such condition the compiler produce transformation
>> that break the dominance property of SSA is wrong IMHO.
>
> The SSA properties are not defined for this kind of input.

That is just your view. It is clearly not the view in academia.

I think that is precise what is wrong here. Let's put away us
vs academia who is more correct. We can still discuss the
consequence of choose to breaking the property or not.

Given the condition input C code can have uninitialized variable

We have two design choice here.
1. Break the SSA dominance property. That is the current garbage
    in garbage out model.

    Let that face the consequence here:

    Because we choice to break the SSA dominance property.
    All those classic SSA based algorithm that relied on the
    SSA dominance property might break. Pretty much guarantee
    you can find the case to make it break.

   In is very annoying that I can't use classic SSA algorithm safely.

2. Do not break the SSA dominance property. Give the uninitialized
    variable an implicit defined as "uninitialized". That is the method
    describe in Appel's book. It is also the model gcc and llvm use as
    well as far as I can tell.

   The consequence is that , I can use the class SSA algorithm
   without worry about what consequence it might have breaking
   the SSA dominance property.


> It's not that the compiler that produce a transformation
> that break the property, the property wasn't there/defined
> since the beginning. The compiler only (maybe) made it obvious
> that the input is wrong.

That is just you view. See my analyse above.

> Your use of 'legal/illegal' only create dramatic black/white
> situations which doesn't help you to understand the situation.
> You can call it 'legal' but its semantic is undefined.
> If its semantic is not defined, it means that all those nice
> discussions about breaking SSA property is meaningless.

No, my definition is clearly defined. "add %r1 <- %r1, 4"
breaking the SSA dominance property as define above has
a clear answer yes or not. It is black and white.

The consequence is also black and white. Don't break it
we can safely use the classic ssa algorithm. Break it there
is no theory guarantee.

> Good.
> You can avoid to produce such IR if you first detect uninitialized
> variables (and emit a diagnostic and stop things there).
> Do you a good plan to detect uninitialized variables?

All variable start with a define value "uninitialized" unless clear
specified otherwise.
This method is already describe in the book I quote.

>
> In textbook and articles, yes, they suppose that the input is well
> defined and leave others input as an exercise for the reader.

It is not about textbook and etc.
It is about the consequence weather we can use the classic ssa
algorithm safely.

>> Please refer back
>> Dominance Property of SSA:
>> 1. If x is used in a Phi-function in block N,
>> then the definition of x dominates *every* <=3D=3D=3D=3D notice "every"
>> predecessor of N.
>
> For input without undefined behaviour, yes surely.

Please the analyse above. If you choice to break it, there is not
even a question you break it or not. It is very clearly defined.
You need to face the consequence.


>
>> It has incoming edge to the phi node, it need to be defined.
>
> And what happen if it is in fact undefined?

I am getting tired of repeat my self here. There is no undefined
here if we start every variable in the entry node with define to
uninitialized, unless specify otherwise.

Refer to the book for more detail description of the algorithm
how to convert to SSA. We don't need to reinvent the wheel.


> No.
> The only interesting things are:
>   "what do we do when we have an input that is not well formed, undefined=
"

See the above consequence reasoning.

> and even more interesting:
>   "how do we *detect* this and how do we emit a diagnostic that is useful=
".

We don't need to detect it. Every variable start with defined to uninitiali=
zed
unless specify otherwise.

> Also, let's not forget that the (primary) goal of a compiler is to
> produce (good) code (for well defined inputs). But most significant
> ones doesn't stop there and try hard to produce usefull diagnostic for
> the other inputs. And sparse, as a semantic *checker*, should be even
> more concerned by this aspect.

True but irrelevant to my discussion. My point is you make the choice,
you face the consequence. Our garbage in garbage out choice is not
a good one because I can't use classic ssa algorithms safely.


Chris
