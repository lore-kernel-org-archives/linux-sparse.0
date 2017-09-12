From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Some thoughts on the SSA debate
Date: Tue, 12 Sep 2017 12:47:19 +0100
Message-ID: <CACXZuxcQrFOaM8T5z-5tZNU3XnY8d4aOQ3FfRs2SSY+Gv1T7rA@mail.gmail.com>
References: <CACXZuxdGXjyMJAh8CCUUFbLXWaLfLJ121S8UbRp9NbE4B1koZA@mail.gmail.com>
 <20170909020604.5io7kuw6itquzbfp@ltop.local> <CACXZuxdtwsp=YXN_4q5Ox=6R6fKdz-6kLUcTYskJcwd6qvh5DQ@mail.gmail.com>
 <CAExDi1QyP5FRTrNgfEx7zK=bKQyPQ36gHgDSBRtqWOi=-Bf-sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:35365 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbdILLrU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 12 Sep 2017 07:47:20 -0400
Received: by mail-vk0-f42.google.com with SMTP id w23so3815521vkw.2
        for <linux-sparse@vger.kernel.org>; Tue, 12 Sep 2017 04:47:20 -0700 (PDT)
In-Reply-To: <CAExDi1QyP5FRTrNgfEx7zK=bKQyPQ36gHgDSBRtqWOi=-Bf-sw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 12 September 2017 at 11:48, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>> I have some practical reasons for it:
>>
>> a) In the JIT world, we often want fast compilation. I already disable
>> all subsequent phases, and generate code from the initial linear
>> output.
>
> Amusingly, the Simple SSA method was (partially) created for such uses.
> I think you can easily understand why.

Yes, I think the SSA form is important for simplifications. And for
some back-ends such as NanoJIT which do not have optimizations that
LLVM has, the Sparse layer can act as the optimizer. But the issue
right now is that the simplifications are not always correct even with
the new SSA so that I have to disable everything anyway. And having
the phi nodes then actually complicates things.

>
>
> Anyway, I'm more than a bit tired of this 'debate', mainly based by half-truths,
> assumptions and misunderstandings.

Given that there could be major changes in the output (at least for
the initial one) then it is good to make sure that there is a proper
consideration of pros and cons. I am not arguing against the new
implementation at all - just saying it should be a later phase. I also
accept your point that currently there are issues with the SSA
construction, and accept that changes are necessary.

>
> As I have already stated twice, I've put the code for SSSA on hold, focusing
> instead on the *correct* conversion of the *others variables* (since SSSA is
> only concerned by local variables which can never be aliased to anything,
> depending on your code that can be most variables or only a small number).
>
> When I'll have something I'm happy with, I'll evaluate (read: "based
> on numbers")
> if there is any value left to the SSSA method or not. If I see there
> is a significant
> value for some uses, I'll submit it and we can have this 'debate'.
> *If* the code reaches upstream and bothers you too much, as you had
> already asked
> for, you will be able to disable it by simply doing so that the call
> to 'is_promotable()'
> always returns false and you will have all your nice stores & loads.
>
> Meanwhile, the current code is broken and the existing code with SSSA
> *can* be used to test, experiment, evaluate, compare, ...
>

Okay that is exactly what I am giving you - feedback based on using
the new implementation. In fact I started with the assumption that it
solved all the problems, only after using and testing it found that it
didn't, i.e. later simplifications are still causing issues.

Regards
Dibyendu
