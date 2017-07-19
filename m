From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-next and preview of 0.5.1-rc5
Date: Thu, 20 Jul 2017 00:17:40 +0200
Message-ID: <20170719221738.2gkctzmdjajz4uec@ltop.local>
References: <CANeU7Qk-9RcNkWoEL5-0AKyd2Q30BvtjfivEG_KgD4kAH-aEdA@mail.gmail.com>
 <20170715182159.ltikqlbe6rktxfhz@ltop.local>
 <CANeU7Qkt4+QsgrrwUSwiiJ_V77gnJgb5YW0qSwwx1-uu9-GhLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:38129 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbdGSWRo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 19 Jul 2017 18:17:44 -0400
Received: by mail-wr0-f178.google.com with SMTP id f21so7286719wrf.5
        for <linux-sparse@vger.kernel.org>; Wed, 19 Jul 2017 15:17:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Qkt4+QsgrrwUSwiiJ_V77gnJgb5YW0qSwwx1-uu9-GhLw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>

On Sat, Jul 15, 2017 at 10:34:46PM -0400, Christopher Li wrote:
> On Sat, Jul 15, 2017 at 2:22 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > [Sorry, I'm on vacation and very little computer access].
> 
> I am very glad to heard that you are back.

Even now, I'm not really back. Just taking time to reply here
while I have the opportunity to.
 
> > I still object to the kill_unreachable_bbs() patch and I ask
> > to reconsider it in favor of the original one.
> 
> Of course.  I will hold the RC5 for you. I haven't push the change to
> master yet. It is only in sparse-next, I can still roll back the change in we
> wants to.
> 
> Can you show me some C input file that your original patch will do the
> right thing and current one will miss the opportunity to simplify?
> Even for the case it is just a suspect of producing worse code is fine.
> Just point me to some test case, I will investigate and compare the
> results.
> 
> My guess is that, there is a good chance some where missing a simplify
> opportunity. If it does make a difference and I can't fix it in a timely manner.
> Let's use your patch and deal with it after the release. In the long run, I
> would prefer not using the two pass deletion of the dead bb, if they can
> produce the similar level of optimized result.
> 
> > Since this has already been discussed, I can only invite to read
> > again the original patch and the one it fixes where the situation
> > is explained, I think, clearly.
> 
> The original patch does not have test case showing the byte code
> difference with this two approach. I need some test examples :-)

Test cases are test cases and code is code.

I'll copy here verbatim the commit message of the patch that was fixed
by the original patch (the one that had "Fixes: 51cfbc90a5e1462fcd624a1598ecd985a508a5d6
 
	commit 51cfbc90a5e1462fcd624a1598ecd985a508a5d6
	Author: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
	Date:   2017-04-26 12:21:21 +0200
	
	    fix: kill unreachable BBs after killing a child
	    
	    When simplifying a switch into a simple branch all the now
	    unused children of the current BB must be removed.
	    If one of these children become now orphaned, it is directly
	    killed (it will need to be killed soon or later since it is
	    unreachable).
	    
	    However, if one of the killed children is the header of a loop
	    where some variables are updated this may cause problems.
	    Indeed, by killing the header (which contains the phisrc of
	    the entry value of the variable) the whole loop may become
	    unreachable but is not killed yet, OTOH simplification of
	    the associated OP_PHI may create a cycle which may then be
	    detected later by simplify_one_memop() which will issue a
	    "crazy programmer" warning while the programmer was innocent.
	    
	    This situation can be seen in code like:
	            int *p;
	            switch (i - i) {        // will be optimized to 0
	            case 0:                 // will be the simple branch
	                    return 0;
	            case 1:                 // will be optimized away
	                    p = ptr;
	                    do {            // will be an unreachable loop
	                            *p++ = 123;
	                    } while (--i);
	            }
	    
	    Fix this by calling kill_unreachable_bbs() after having
	    simplified the switch into a branch. This will avoid to
	    create a cycle with because of the removed phisrc in the
	    header and as an added benefit will avoid to waste time
	    trying to simplify BBs that are unreachable.
	    
	    In addition, it's now useless to call kill_bb() for each
	    removed switch's children as kill_unreachable_bbs() will
	    do that too.
	    
	    Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

So, in short, the problem that was solved then (the "crazy programmer"
problem) was that incorrect phi-node simplification was done in 
simplify_one_memop() if the phi-node was part of a loop that was
in fact unreachable (in this case, the situation is exactly as if
the phi-node was for some undefined variable, thus the
"crazy programmer" warning).

The unreachable loop was created by insert_branch() (which can be 
called by simplify_instruction()) and simplify_one_memop() is also
called by simplify_instruction(), in our case here, for an OP_LOAD).

So the only way, you can have the assurance that the problem cannot
happen is to call kill_unreachable_bbs() between call to insert_branch()
which delete a branch *and* the next call to simplify_one_memop().

Calling kill_unreachable_bbs() only *after* clean_up_insns() is
too late.

It's not at all a problem of some missing optimization opportunity.
It's a problem of applying some optimization (OP_PHI simplification)
and then giving a warning for the consequence of this optimization
(the "crazy programmer" warning) in incorrect conditions/wrong
assumption (a variable must not be considered as undefined if it
is part of an unreachable BB, it should just be ignored).

I hope it is clear enough now.

Is it annoying that we have to call kill_unreachable_bbs() there?
Yes, clearly it is.
Wouldn't it be nice if we could move the kill_unreachable_bbs() in
the cleanup_and_cse() loop?
Yes, it is (but then in this case, it should be done between the
clean_up_insns() and the CSE loop).
This would need some fundamental change in the way simplification
are done (like maybe moving the simplification of OP_LOADs out of
the clean_up_insns() loop), nothing for an -rc5.


I also assure that instead of quickly rewriting someone's patch
(because you don't like it and think you can do better) it would
be so much better to simply:
- *say* what you don't like in the patch
- *ask* why things are done like this way
- *ask* if things couldn't be done this other way instead.
It would be much less painfull, save a lot of time, you would look much
wiser and it would be much more respectuous of other's work & time.

-- Luc
