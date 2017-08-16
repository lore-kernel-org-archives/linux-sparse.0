From: Christopher Li <sparse@chrisli.org>
Subject: Re: Some random thoughts regarding the SSA paper
Date: Wed, 16 Aug 2017 08:03:25 -0400
Message-ID: <CANeU7Qnt6wpb+dgPNNX0rvtfMdjwDqW4LAp59PHpQV9ye9Qa9w@mail.gmail.com>
References: <CANeU7QmcVS_8oko6RhG_g_97AjUNVYa=KDqDocbXL5ney=mrJw@mail.gmail.com>
 <20170816071507.tbbboeu7htdypweq@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:36415 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751522AbdHPMD1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 08:03:27 -0400
Received: by mail-yw0-f173.google.com with SMTP id u207so21077601ywc.3
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 05:03:26 -0700 (PDT)
In-Reply-To: <20170816071507.tbbboeu7htdypweq@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Wed, Aug 16, 2017 at 3:15 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Wed, Aug 16, 2017 at 02:33:30AM -0400, Christopher Li wrote:
>> I have spend some time reading the paper
>>
>> http://compilers.cs.uni-saarland.de/papers/bbhlmz13cc.pdf
>>
>> "Simple and Efficient SSA Construction". Which is luc's SSA
>> conversion is based on:
>>
>> Here is some random thoughts about the paper I might just
>> share with you guys. If I make a mistake some where along
>> the line, I am very glad if some one can point it out to me.
>>
>> - I think the main point of the paper doing SSA without
>>   the CFG is not particular useful to us. We need to generate
>>   CFG *anyway*.
>
> I think you mis-understnd the point.
> Of course the CFG is needed at the end. The point of the article
> is that with their method you don't have to *first* build
> a CFG and a non-SSA representation and *then directly convert*
> this into the SSA form (and maybe having to throw away most of
> what was previously build) because their method construct
> the CFG and the SSA form at once, directly from the AST.

For our purpose, yes.
The paper did make some claim is towards making SSA
on the AST level without going to CFG, don't need dominator
analyze etc.. Claim that as an advantage. I don't want to go
there. It is not your patch are about.

>
> In short it does the SSA construction directly during
> the linearization. OTOH, with the current method (and the
> traditional ones) we have first to linearize and do all
> access to local vars as memory access and what all of this
> is done, we need another pass which will create the SSA form
> and destroy most load & write to these local vars.

I still think that directly build from AST without the CFG is
overrated  in this paper.

First of all, you can't actually avoid CFG if you are considering
"goto". The whole reason of having "goto" as the ugly case is
exactly due the the paper try to avoid CFG. My impression is
that, the solution of handling of the "goto" is actually very ad-hoc.

Second, local vars as memory access is actually done in the
AST level. Source code "a = b;" at AST level before linearization
it is already become "* (&a) = * (&b);", due to C language syntax.
So you are actually not saving the memory access stage.
You can not because only after pointer alias analyse you can remove
the pointer. You can't do effective do pointer alias analyse due
to you don't have CFG. (consider the "goto" case).

You just convert the memory access into the pseudo slightly
earlier. But considering complexity to plug the "goto" hole,
and the cleanup stage after it. The complexity is much higher
(both in code and execution time) than the paper suggested,
which is the simple reducible graph case .

To sum up. I think my point is still valid.
- The CFG stage is not actually avoidable (considering "goto").
- There is hidden complexity considering "goto" and irreducible graph.
   BTW, Does your branch handle "goto" and irreducible graph yet?
   I only take a brief scroll of it, I can't really tell.


Chris
