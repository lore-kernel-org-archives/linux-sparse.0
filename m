From: Christopher Li <sparse@chrisli.org>
Subject: Re: RFC: One strange idea inspired by the SSSA
Date: Mon, 21 Aug 2017 12:40:45 -0400
Message-ID: <CANeU7QkZD4OFjdpTH3Dz5Yq6XMxRvi=+L=G2K5soxFTycDxi_Q@mail.gmail.com>
References: <CANeU7Qn2zyruhC5r1bMM8uOzCvk_6xvezQCWdV_U6jAxQiVuDg@mail.gmail.com>
 <CAMHZB6EuyzzTiJdwPC5p727628uDhyt1aRQFdg+Yj6V3hmDozw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.161.182]:34007 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753689AbdHUQkq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 21 Aug 2017 12:40:46 -0400
Received: by mail-yw0-f182.google.com with SMTP id s143so94625939ywg.1
        for <linux-sparse@vger.kernel.org>; Mon, 21 Aug 2017 09:40:46 -0700 (PDT)
In-Reply-To: <CAMHZB6EuyzzTiJdwPC5p727628uDhyt1aRQFdg+Yj6V3hmDozw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 21, 2017 at 10:14 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Mon, Aug 21, 2017 at 3:28 PM, Christopher Li <sparse@chrisli.org> wrot=
e:
>> The SSSA paper idea is interesting. It get the simple case
>> handle very fast. However, I see it has two draw backs.
>> 1) Creating the redundant phi node and using per pseudo
>>     ptrmap[block] -> pesudo mapping has over head in terms
>>     of memory allocation and execution.
>
> I've checked yesterday evening on some big functions and the
> ptrmap use 26 times less memory than the ptrlist. I then added
> the call needed to free all ptrmap as soon as they're not needed.
> I really think this memory for ptrmap is a non-issue.

Do you have insight then why the SSSA is 2% slower than
the RC5 without the short cut case? I expect with simpler
effective approach it should be at least similar or faster.
It do less work than RC5 in terms of finding dorminator etc.

>> My have a hunch that the SSA promoting from the instruction
>> level is kind of unavoidable. e.g. some promotion might happen
>> after CSE.
>
> Right.

Good

>
>> If we take that as an assumption. Then I have this idea similar
>> to the SSSA paper in the sense that it take advantage of the
>> source file that is reducible graph. Instead of inserting the phi
>> instruction on all possible block join point.
>
> Mind to explain what you mean by 'all possible block join point' and
> why you believe the method do this?

I am reading the paper there seems to be recursive go through
the parents. My understanding might be wrong. I am trying to
think why SSSA is slower.

readVariable(variable, block):
    if currentDef[variable] contains block:
    # local value numbering
        return currentDef[variable][block]
    # global value numbering
    return readVariableRecursive(variable, block)  <=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

readVariableRecursive(variable, block):
   if block not in sealedBlocks:
        # Incomplete CFG
        val =E2=86=90 new Phi(block)
        incompletePhis[block][variable] =E2=86=90 val
   else if |block.preds| =3D 1:
       # Optimize the common case of one predecessor: No phi needed
       val =E2=86=90 readVariable(variable, block.preds[0]) <=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D recursion?
   else:
       # Break potential cycles with operandless phi
       val =E2=86=90 new Phi(block)
       writeVariable(variable, block, val)
   val =E2=86=90 addPhiOperands(variable, val)
   writeVariable(variable, block, val)
   return val



>
>> We can do some thing
>> else that can be beneficial to the classic SSA promotion algorithm.
>> We can mark the DF local defined in the Appel "morden
>> compiler implementation in java" page 406.
>>
>> DF local(n) define as: The successor of n that is not strictly
>> dominated by n.
>
> Don't you need the whole CFG for this (when you have
> a loop, for example)?

I haven't play out all the detail yet. The idea about the loop:

while (expr_a()) {
      loop_body_blocks;
}
after_loop_blok;

We known that every variable declare in the loop_body_blocks
with indentation level =3D=3D 2 is going to dominate the rest of the
loop_body_blocks where line number > the current define place.

And we know that that define domination ends at the last block
in side loop_body_blocks for the same indentation level.

We can have a stack system while we recursive linearize
the statement. That is the idea. I haven't plan out the detail.

>
>> ...
>>
>> So if we mark those DF local(n) for a block during linearization.
>> Then we don't need to go through the dominating *tree* to find
>> DF(n). We know that during linearization. This can serve as
>> some thing similar to the "single store short cut", except that
>> it can place the phi node properly.
>
> The SSSA method already do something very close to the
> 'single-store shortcut'. I strongly encourage you to play a bit
> with 'test-linearize -fdump-linearize=3Donly' on some examples.
>
> Also, we must not forget that it's all a question of trade-off.
> The advantage of this method is that it can do a good part
> of the job on-the-fly, without needing the CFG. With the CFG

Why is SSSA slower that is part I don't understand.
In the method I describe, there is no recursion more than
what is needed for the linearization. It should do better than
SSSA in micro benchmarks if that idea is implementable.

> you can do some smarter things but then you first need to build
> everything blindly and only then you can begin to be smarter.

You don't need to be blindly, that is my strange idea.
When you are building the loop body blocks. You can already
see in this indentation level, where the domination ends.
When you recursive to deeper indentation level, you can
save your context of the understanding into a stack. Each
indentation level have their own context stack. They can
reference to the upper level's context for bail out etc.

So if there is no gotos. Every linearization should already
know where the domination terminates (from the context stack).

> It's the same if you want pruned SSA. Then you only have
> to do the conversion for live variables but ... you first need
> to calculate the liveness information. Idem about the
> dominance graph.

My strange idea, if work out, can actually help build the
dominance graph on the fly. The only weakness is that
if there is crazy goto jump to other indentation level not
even in the context stack, then we need to do the dominator
tree the old fashion way.


Chris
