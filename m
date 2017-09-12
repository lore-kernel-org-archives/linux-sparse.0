From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Some thoughts on the SSA debate
Date: Tue, 12 Sep 2017 12:48:57 +0200
Message-ID: <CAExDi1QyP5FRTrNgfEx7zK=bKQyPQ36gHgDSBRtqWOi=-Bf-sw@mail.gmail.com>
References: <CACXZuxdGXjyMJAh8CCUUFbLXWaLfLJ121S8UbRp9NbE4B1koZA@mail.gmail.com>
 <20170909020604.5io7kuw6itquzbfp@ltop.local> <CACXZuxdtwsp=YXN_4q5Ox=6R6fKdz-6kLUcTYskJcwd6qvh5DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:38201 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751512AbdILKs7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 12 Sep 2017 06:48:59 -0400
Received: by mail-lf0-f54.google.com with SMTP id q132so25218455lfe.5
        for <linux-sparse@vger.kernel.org>; Tue, 12 Sep 2017 03:48:59 -0700 (PDT)
In-Reply-To: <CACXZuxdtwsp=YXN_4q5Ox=6R6fKdz-6kLUcTYskJcwd6qvh5DQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Sep 12, 2017 at 12:06 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> H Luc,
>
> On 9 September 2017 at 03:06, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> On Fri, Sep 08, 2017 at 11:28:57AM +0100, Dibyendu Majumdar wrote:
>>>
>>> 1. Firstly I think it is important to retain the existing "pre-phi"
>>> linear code. This is fine for backends such as LLVM which do a good
>>> job of transforming code anyway. It is also usually less buggy and
>>> serves as a baseline for correctness. So after careful consideration I
>>> would vote against adding phi instructions in the initial phase.
>>
>> That's forgetting that even with the "old/current" method create
>> phi-nodes during linearization:
>> - for the return mechanism
>> - for some conditionals
>>
>> This also doesn't really take in account the fact that the SSA form
>> is pretty fundamental to sparse (like it's most modern compilers).
>>
>
> I do not agree that the phi nodes "must" be present in the initial
> linear output.

I fail to see where someone said they must.

It's a fact though, that currently, during linearization, sparse already
create phi-nodes for return values and for some conditional expressions.

> I have some practical reasons for it:
>
> a) In the JIT world, we often want fast compilation. I already disable
> all subsequent phases, and generate code from the initial linear
> output.

Amusingly, the Simple SSA method was (partially) created for such uses.
I think you can easily understand why.


Anyway, I'm more than a bit tired of this 'debate', mainly based by half-truths,
assumptions and misunderstandings.

As I have already stated twice, I've put the code for SSSA on hold, focusing
instead on the *correct* conversion of the *others variables* (since SSSA is
only concerned by local variables which can never be aliased to anything,
depending on your code that can be most variables or only a small number).

When I'll have something I'm happy with, I'll evaluate (read: "based
on numbers")
if there is any value left to the SSSA method or not. If I see there
is a significant
value for some uses, I'll submit it and we can have this 'debate'.
*If* the code reaches upstream and bothers you too much, as you had
already asked
for, you will be able to disable it by simply doing so that the call
to 'is_promotable()'
always returns false and you will have all your nice stores & loads.

Meanwhile, the current code is broken and the existing code with SSSA
*can* be used to test, experiment, evaluate, compare, ...

-- Luc
