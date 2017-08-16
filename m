From: Christopher Li <sparse@chrisli.org>
Subject: Re: Some random thoughts regarding the SSA paper
Date: Wed, 16 Aug 2017 08:42:05 -0400
Message-ID: <CANeU7Q=byg+e9qKhyO9cuVgrveqmWUajv_e6AWuK4PsJV4+T4g@mail.gmail.com>
References: <CANeU7QmcVS_8oko6RhG_g_97AjUNVYa=KDqDocbXL5ney=mrJw@mail.gmail.com>
 <CACXZuxdnMFA5HPg3GXLWXP6+Mk8+UikcZsJZH8DJ227PYHyEfQ@mail.gmail.com>
 <CANeU7Q=r4A8WQrqaACQ2iak9CcEXds20peJrr1AqJ8tyxCF56Q@mail.gmail.com> <CACXZuxcjBJdM2Sy4KWjaU1Oofr+S3=1vRkznOd9WatycuOSWsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:33422 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752092AbdHPMmG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 08:42:06 -0400
Received: by mail-yw0-f171.google.com with SMTP id p68so21719247ywg.0
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 05:42:06 -0700 (PDT)
In-Reply-To: <CACXZuxcjBJdM2Sy4KWjaU1Oofr+S3=1vRkznOd9WatycuOSWsw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Aug 16, 2017 at 8:24 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> The paper says that the algorithm creates correct SSA for all
> programs. Specifically quoting:
>
> <quote>
> prove that the SSA construction algorithm constructs pruned SSA form
> for all programs and minimal SSA form for programs with reducible
> control flow
> <endquote>
>
> Secondly even for irreducible control flow, it provides an algorithm
> for creating minimal SSA in section 3.2, right?

It do provide a solution. and the price is high. The complexity is
O(B*B*V*V).  Go look at page 15 of the paper.

>
> Luc's implementation seems to work fine with gotos? Have you tested
> Luc's implementation? I think it is better to try out the solution and
> see if there is a problem.

I haven't, as I said I try to finish reading the paper before looking that
the implementation. If  Luc is the paper suggestion to fix up the irreducible
case. , then we are down the road for O(B*B*V*V) complexity.

>>> The great thing about Sparse I find is that it is smaller and simpler
>>> than gcc or clang - and I would urge that this should be maintained.
>>
>> Exactly. I am totally agree with you. My worries are the hidden complexity
>> dealing with gotos in that paper.
>>
>
> I am wondering if the complexity is only because Luc's implementation
> creates SSA on the fly rather than as a second phase. I posted another
> question on that topic.

My way of seeing it, the complexity is introduced when you have input
source contain irreducible grahy. This paper doe not have good way to
deal with it. It can solve it, but that is O(B*B*V*V) complexity.

In other words, we can some input source that cause the method describe
in this paper quadruple to the size of the input.

Chris
