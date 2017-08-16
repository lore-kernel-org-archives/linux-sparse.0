From: Christopher Li <sparse@chrisli.org>
Subject: Re: Some random thoughts regarding the SSA paper
Date: Wed, 16 Aug 2017 08:09:55 -0400
Message-ID: <CANeU7Q=r4A8WQrqaACQ2iak9CcEXds20peJrr1AqJ8tyxCF56Q@mail.gmail.com>
References: <CANeU7QmcVS_8oko6RhG_g_97AjUNVYa=KDqDocbXL5ney=mrJw@mail.gmail.com>
 <CACXZuxdnMFA5HPg3GXLWXP6+Mk8+UikcZsJZH8DJ227PYHyEfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:34212 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752029AbdHPMJ5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 08:09:57 -0400
Received: by mail-yw0-f175.google.com with SMTP id s143so21169573ywg.1
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 05:09:56 -0700 (PDT)
In-Reply-To: <CACXZuxdnMFA5HPg3GXLWXP6+Mk8+UikcZsJZH8DJ227PYHyEfQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Aug 16, 2017 at 5:55 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi Chris,
>
> I would argue that the simplest possible solution is what we should
> start with. The solution implemented based on this paper appears to be
> simple and elegant - and if this works correctly then why go for more
> complicated solutions? Theoretical scenarios are not very useful - in

Because the paper "simple and elegant" only cover the reducible
graph case. When you considering the irreducible graph source file
input, say having "goto", all the sudden it is not simple and elegant
any more. It is more like complex and ad-hoc.

> my view, if the solution works now with all known inputs then it is
> good enough.

Know input include "goto", period.

>>
>> - Cytron might still be worthwhile to implement due to the better
>>    worse case complexity.
>>
>>
>
> Certainly you should prototype this - even if just to compare. But I
> would suggest - lets merge the solution we have now. Additional
> solutions are always good to have.

Yes, I am doing the prototype as the side project. I start with building
the dominator tree as I mention in the list earlier. Another way to
evaluate the complexity of the code, just go take a look at the Clang,
how it promote the memory access into SSA pesudo. That is the
critical piece we are talking about here. It is actually not that complex
at all.

To fully evaluate the complexity suggest by this paper. I want to see
the full implementations with "gotos".


> The great thing about Sparse I find is that it is smaller and simpler
> than gcc or clang - and I would urge that this should be maintained.

Exactly. I am totally agree with you. My worries are the hidden complexity
dealing with gotos in that paper.

Chris
