From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Some random thoughts regarding the SSA paper
Date: Wed, 16 Aug 2017 13:24:19 +0100
Message-ID: <CACXZuxcjBJdM2Sy4KWjaU1Oofr+S3=1vRkznOd9WatycuOSWsw@mail.gmail.com>
References: <CANeU7QmcVS_8oko6RhG_g_97AjUNVYa=KDqDocbXL5ney=mrJw@mail.gmail.com>
 <CACXZuxdnMFA5HPg3GXLWXP6+Mk8+UikcZsJZH8DJ227PYHyEfQ@mail.gmail.com> <CANeU7Q=r4A8WQrqaACQ2iak9CcEXds20peJrr1AqJ8tyxCF56Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f182.google.com ([209.85.217.182]:35730 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbdHPMYU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 08:24:20 -0400
Received: by mail-ua0-f182.google.com with SMTP id d29so13127682uai.2
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 05:24:20 -0700 (PDT)
In-Reply-To: <CANeU7Q=r4A8WQrqaACQ2iak9CcEXds20peJrr1AqJ8tyxCF56Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>

Hi Chris,

On 16 August 2017 at 13:09, Christopher Li <sparse@chrisli.org> wrote:
> On Wed, Aug 16, 2017 at 5:55 AM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>> I would argue that the simplest possible solution is what we should
>> start with. The solution implemented based on this paper appears to be
>> simple and elegant - and if this works correctly then why go for more
>> complicated solutions? Theoretical scenarios are not very useful - in
>
> Because the paper "simple and elegant" only cover the reducible
> graph case. When you considering the irreducible graph source file
> input, say having "goto", all the sudden it is not simple and elegant
> any more. It is more like complex and ad-hoc.
>

The paper says that the algorithm creates correct SSA for all
programs. Specifically quoting:

<quote>
prove that the SSA construction algorithm constructs pruned SSA form
for all programs and minimal SSA form for programs with reducible
control flow
<endquote>

Secondly even for irreducible control flow, it provides an algorithm
for creating minimal SSA in section 3.2, right?

>> my view, if the solution works now with all known inputs then it is
>> good enough.
>
> Know input include "goto", period.
>

Luc's implementation seems to work fine with gotos? Have you tested
Luc's implementation? I think it is better to try out the solution and
see if there is a problem.

>>>
>>> - Cytron might still be worthwhile to implement due to the better
>>>    worse case complexity.
>>>
>>>
>>
>> Certainly you should prototype this - even if just to compare. But I
>> would suggest - lets merge the solution we have now. Additional
>> solutions are always good to have.
>
> Yes, I am doing the prototype as the side project. I start with building
> the dominator tree as I mention in the list earlier. Another way to
> evaluate the complexity of the code, just go take a look at the Clang,
> how it promote the memory access into SSA pesudo. That is the
> critical piece we are talking about here. It is actually not that complex
> at all.
>
> To fully evaluate the complexity suggest by this paper. I want to see
> the full implementations with "gotos".
>

In my tests Luc's implementation works fine with gotos. I have not
tested computed gotos, however. Yet the solution is simple and
elegant.

>
>> The great thing about Sparse I find is that it is smaller and simpler
>> than gcc or clang - and I would urge that this should be maintained.
>
> Exactly. I am totally agree with you. My worries are the hidden complexity
> dealing with gotos in that paper.
>

I am wondering if the complexity is only because Luc's implementation
creates SSA on the fly rather than as a second phase. I posted another
question on that topic.

Regards
Dibyendu
