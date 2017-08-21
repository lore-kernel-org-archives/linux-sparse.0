From: Christopher Li <sparse@chrisli.org>
Subject: RFC: One strange idea inspired by the SSSA
Date: Mon, 21 Aug 2017 09:28:16 -0400
Message-ID: <CANeU7Qn2zyruhC5r1bMM8uOzCvk_6xvezQCWdV_U6jAxQiVuDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:35144 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753387AbdHUN2S (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 21 Aug 2017 09:28:18 -0400
Received: by mail-yw0-f176.google.com with SMTP id s187so6034665ywf.2
        for <linux-sparse@vger.kernel.org>; Mon, 21 Aug 2017 06:28:18 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The SSSA paper idea is interesting. It get the simple case
handle very fast. However, I see it has two draw backs.
1) Creating the redundant phi node and using per pseudo
    ptrmap[block] -> pesudo mapping has over head in terms
    of memory allocation and execution.
2) it does not handle the case access memory via pointers.
    This draw back is a major one.
    This means we need to have other means of promoting
    memory access to pseudo, (may be using classing SSA
    conversion?)


My have a hunch that the SSA promoting from the instruction
level is kind of unavoidable. e.g. some promotion might happen
after CSE.

If we take that as an assumption. Then I have this idea similar
to the SSSA paper in the sense that it take advantage of the
source file that is reducible graph. Instead of inserting the phi
instruction on all possible block join point. We can do some thing
else that can be beneficial to the classic SSA promotion algorithm.
We can mark the DF local defined in the Appel "morden
compiler implementation in java" page 406.

DF local(n) define as: The successor of n that is not strictly
dominated by n.

I have this observation that, for the function without goto,
(it can have break/continue/return,  I need to think more about
switch, case is like goto)

the DF local(n) is actually trivial without goto. When we do
the linearization. We already know where the DF local(n) are.

Let's image the source code has been properly format by
indent. Without goto, the code block that has indentation
level 1 (top level statements inside the function)  will dominate
the rest of the code(which have a bigger line number) in that function.

For statement if else, for/while loop. The body of those statement
will have a indentation level > 1. It means variable define there
will not dominate the rest of code. But we know exactly where the
domination ends. It is the end of this indentation level with in the
scope.

So if we mark those DF local(n) for a block during linearization.
Then we don't need to go through the dominating *tree* to find
DF(n). We know that during linearization. This can serve as
some thing similar to the "single store short cut", except that
it can place the phi node properly.

Another thing we can do is that, we can try to handle the
common case using goto for bail out. In that case it
is a DAG does not create loops. The DF local(n) might still
be trivial. My guess is that swith/case statement can be handle
in similar way. Case statement  is a special kind of goto that
does not create loops. I need to think more about that.

Of course that is the optimal case the function does not have
goto, or only have goto that jump to higher level indentation
in the same coding block. That is the short cut path.

If the function has not friendly gotos. we let the classic
SSA algorithm handle it. Which means it will build DF without
assumption on the CFG. If there is a level 1 indentation block
and there is no goto fly over it. That block can still serve as
splitting point. The function can be split as the top half and
bottom half. Calculate dominating tree  in the two smaller graph.
This process can happen recursively. This will break the
very long function into chain of much smaller CFG, which are
easier to calculate.  This will avoid the long chain problem (if
possible) in paper "A Simple, Fast Dominance Algorithm" by
Cooper et al.


This is my original idea, inspired by the SSSA paper.  I am sure
my first write up did not explain this idea well. Please ask question
if you have one.

Feed back?

Chris
