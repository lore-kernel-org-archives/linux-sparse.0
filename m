From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Some thoughts on the SSA debate
Date: Sat, 9 Sep 2017 04:06:06 +0200
Message-ID: <20170909020604.5io7kuw6itquzbfp@ltop.local>
References: <CACXZuxdGXjyMJAh8CCUUFbLXWaLfLJ121S8UbRp9NbE4B1koZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:35622 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757210AbdIICGO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 8 Sep 2017 22:06:14 -0400
Received: by mail-wr0-f179.google.com with SMTP id m18so7016632wrm.2
        for <linux-sparse@vger.kernel.org>; Fri, 08 Sep 2017 19:06:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxdGXjyMJAh8CCUUFbLXWaLfLJ121S8UbRp9NbE4B1koZA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Sep 08, 2017 at 11:28:57AM +0100, Dibyendu Majumdar wrote:
> Hi,
> 
> Having tried out the newssa approach for a bit, and after working on
> another backend that doesn't use SSA phi nodes, I would like to share
> some of my personal thoughts with regards to the changes:
> 
> 1. Firstly I think it is important to retain the existing "pre-phi"
> linear code. This is fine for backends such as LLVM which do a good
> job of transforming code anyway. It is also usually less buggy and
> serves as a baseline for correctness. So after careful consideration I
> would vote against adding phi instructions in the initial phase.

That's forgetting that even with the "old/current" method create
phi-nodes during linearization:
- for the return mechanism
- for some conditionals

This also doesn't really take in account the fact that the SSA form
is pretty fundamental to sparse (like it's most modern compilers).

If you have a backend that doesn't understand phi-nodes, it means
that this backend doesn't know and doesn't care about SSA and in
this case you have to call unssa() to put back  the IR in 'normal'
form.
 
> 2. It also appears to me that the original phi instructions, while not
> textbook correct in terms of placement, are internally consistent,

No.
For *some* purposes/aspect, they are somehow consistent and the current
code can do something relatively sensical with them (and often it
seems to be more because of simple coincidence).
But this doesn't change the fact that a lof ot things can't possibly
be done correctly with the actual phi-nodes.

I already explain what are the problems and here it is again:
- broken because the phi-nodes are put not at the meet point but
  at a place where the value is needed, where there was a load.
  this place *may* be in the right BB but often it's in a 'later'
  BB. Real problems then arise when:
  * changing some BB edges (like removing a dead parent, BB merge, ...)
  * some undefined values are (conceptually) present (and the current
    code ignore them).
- broken because when a phi-node is created it somehow inherit the
  phi-sources of any 'parent' phi-nodes when there are some. This
  is even more broken than the previous situation. You can't possibly
  do anything sensical with this.

> 3. It also appears that the SSA construction approach by Matthias
> Braun et al is inadequate in the sense that it is not a full solution
> and requires additional hacks.

This is a misrepresentation of the situation. And what are those 'hacks'
are you talking about?
There are 2 things with their method:
1) It only converts 'purely local variables', the ones that can't possibly
   be aliased to anything.
   It can be adapted to also convert more variables but this would,
   of course, requires doing some sort of alias analysis before the
   conversion and thus before the linearization which is absurd.

   The whole advantage of this method is to be able to do a quick
   conversion of the most essential variables and this with a very
   low cost. This can be very useful when:
   - you're in a lightweight environment and can't afford heavier
     methods (think JIT for example)
   - as a preliminary step for doing alias analysis with code already
     in SSA form or to be able to do some fast optimization/simplification
     before doing alais analysis (and then convert the others variables,
     when possible).

   In case, it is not clear, the current method do this in two steps too:
   - first in simplify_symbol_usage()
   - later in simplify_memops()/simplify_loads()
   but for sure the first step convert more variables than the SSSA method
   (and is not only the SSA conversion is broken, but the detection of
   aliasing is also wrong (but I do't know yet if it is just a small bug
   or if it is more fundamental).

2) The article doesn't explain how to deal with gotos.
   The article also doesn't explain how to deal with ifs, do-whiles,
   switches, ... The article is just that, an article presenting a method.
   It's not a step-by-step guide on how to write a compiler which will
   explain all the practical difficulties you will have.


> 4. Final thought is that although I was previously suggesting changes
> should go into master, I think for such a large piece of fundamental
> work maybe the changes should be done on a dedicated branch and only
> merged when completely tested and validated.

Isn't what is done? Is the code for SSSA already upstreamed?


-- Luc Van Oostenryck
