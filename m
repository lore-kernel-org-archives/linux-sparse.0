From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Some thoughts on the SSA debate
Date: Tue, 12 Sep 2017 15:06:46 +0200
Message-ID: <CAExDi1QW8U=rkLX-JMzi=uQG0RTJ-bCjRT46m3CTb7LifKXMQA@mail.gmail.com>
References: <CACXZuxdGXjyMJAh8CCUUFbLXWaLfLJ121S8UbRp9NbE4B1koZA@mail.gmail.com>
 <20170909020604.5io7kuw6itquzbfp@ltop.local> <CACXZuxdtwsp=YXN_4q5Ox=6R6fKdz-6kLUcTYskJcwd6qvh5DQ@mail.gmail.com>
 <CAExDi1QyP5FRTrNgfEx7zK=bKQyPQ36gHgDSBRtqWOi=-Bf-sw@mail.gmail.com> <CACXZuxcQrFOaM8T5z-5tZNU3XnY8d4aOQ3FfRs2SSY+Gv1T7rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33264 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751326AbdILNGs (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 12 Sep 2017 09:06:48 -0400
Received: by mail-lf0-f65.google.com with SMTP id y15so5340130lfd.0
        for <linux-sparse@vger.kernel.org>; Tue, 12 Sep 2017 06:06:47 -0700 (PDT)
In-Reply-To: <CACXZuxcQrFOaM8T5z-5tZNU3XnY8d4aOQ3FfRs2SSY+Gv1T7rA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Sep 12, 2017 at 1:47 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi Luc,
>
> On 12 September 2017 at 11:48, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>>> I have some practical reasons for it:
>>>
>>> a) In the JIT world, we often want fast compilation. I already disable
>>> all subsequent phases, and generate code from the initial linear
>>> output.
>>
>> Amusingly, the Simple SSA method was (partially) created for such uses.
>> I think you can easily understand why.
>
> Yes, I think the SSA form is important for simplifications.

Sure, but the point here is about the Simple SSA method (which can
do the conversion of local variables on the fly, during linearization).
The advantage is that you have then converted the variables
which matter the most and this:
- very early
- you can easily combine simple optimization during the conversion
- with a very low cost (no need for another pass, no need to calculate
  the dominance frontiers).

> And for
> some back-ends such as NanoJIT which do not have optimizations that
> LLVM has, the Sparse layer can act as the optimizer.

And those optimizations are critical for sparse current usage as semantic
checker for the kernel:
- to be able to detect some situations
- to not have false warnings in the context checking.

> But the issue
> right now is that the simplifications are not always correct even with
> the new SSA so that I have to disable everything anyway.

It's what you do but it's not what I do.
The other part that is broken is simplify_loads() which try to convert
more variables after each simplification/CSE steps.
Since the code is copied from the code for the initial conversion
it's broken in the same ways.
I just disabled it and things are then correct.

Now, be assured that I understand very well that the way you use
sparse is quite different. Things like trying to reach a fix-point while
doing simplification is at the opposite spectrum from what people
would like for JIT.

> And having
> the phi nodes then actually complicates things.

I also want to insist once more that SSA is fundamental to sparse.
I won't do anything that purposely makes sparse more difficult to use
without SSA but you must understand that it's the least of my priorities.
Even more so because even without conversion in itself the 'normal'
already create phi-nodes for returns & some conditionals.
On the contrary, my priority is to make sparse to produce and keep
correct SSA.

>> Anyway, I'm more than a bit tired of this 'debate', mainly based by half-truths,
>> assumptions and misunderstandings.
>
> Given that there could be major changes in the output (at least for
> the initial one) then it is good to make sure that there is a proper
> consideration of pros and cons. I am not arguing against the new
> implementation at all - just saying it should be a later phase.

It's where we disagree. What I'm saying is:
- we want to also convert pointers & non-local variables decently
  (the general case is undecidable, anyway).
- you can't convert all the non-local variables at once. If you have
  several optimization steps/rounds then each of them can create
  more conversion opportunities.
- let see what is possible to have at which cost
- *if* there is some good enough advantage to do a first quick
  conversion on-the-fly let's do it (and it can be a very good thing,
  for some usage, to just do that and stop there).
- the extreme cases are not really concerned anyway as they don't
  want to run any of this
- not doing the conversion (of local variables) has also its cost since
  then you:
  * have to deal in the IR with stores and loads instructions for *every* access
  * are unable to do most simplifications, even the cheapest ones
  * have to deal at run-time with these memory accesses instead of being able
     to use registers.

>>
>> Meanwhile, the current code is broken and the existing code with SSSA
>> *can* be used to test, experiment, evaluate, compare, ...
>
> Okay that is exactly what I am giving you - feedback based on using
> the new implementation. In fact, I started with the assumption that it
> solved all the problems, only after using and testing it found that it
> didn't, i.e. later simplifications are still causing issues.

Be assured that it is something I didn't directly realize but it doesn't
change anything to what can be done at the initial stage. And as I said
above, you can put the single call to simplify_loads() in comment
and be done with it, just like I do here.

-- Luc
