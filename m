From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] fix: kill unreachable BBs after killing a child
Date: Tue, 9 May 2017 17:27:17 +0200
Message-ID: <20170509152716.weyudhvs7po23vnt@ltop.local>
References: <20170508185710.22021-1-luc.vanoostenryck@gmail.com>
 <CANeU7Q=RU6PbRFFd7ZT4=bQh7-rHW=c9K+9bUPReSKuQmq8FqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36274 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbdEIP1W (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 9 May 2017 11:27:22 -0400
Received: by mail-wr0-f196.google.com with SMTP id v42so970834wrc.3
        for <linux-sparse@vger.kernel.org>; Tue, 09 May 2017 08:27:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=RU6PbRFFd7ZT4=bQh7-rHW=c9K+9bUPReSKuQmq8FqQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, May 09, 2017 at 03:38:43AM -0700, Christopher Li wrote:
> On Mon, May 8, 2017 at 11:57 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > Fix this by calling kill_unreachable_bbs() after having
> > simplified the switch into a branch. This will avoid to
> > create a cycle with because of the removed phisrc in the
> > header and as an added benefit will avoid to waste time
> > trying to simplify BBs that are unreachable.
> >
> > In addition, it's now useless to call kill_bb() for each
> > removed switch's children as kill_unreachable_bbs() will
> > do that too.
> 
> I thin the fix is correct. Have some very minor comment.
> 
> > diff --git a/linearize.c b/linearize.c
> > index a9f36b823..ee9591897 100644
> > --- a/linearize.c
> > +++ b/linearize.c
> > @@ -642,8 +642,6 @@ static void set_activeblock(struct entrypoint *ep, struct basic_block *bb)
> >  static void remove_parent(struct basic_block *child, struct basic_block *parent)
> >  {
> >         remove_bb_from_list(&child->parents, parent, 1);
> > -       if (!child->parents)
> > -               kill_bb(child);
> 
> This makes every caller of remove_parent() need to clean up the
> unreachable basic blocks. Currently there is only one caller  "insert_branch()"
> which is fine. But if developer write a new code call this function, he might
> forget to clean up the unreachable basic blocks. Kind of like a trap.

Yes, true. I didn't liked it very much myself and hesitated to
remove the helper and directly calling remove_bb_from_list()
from insert_branch().  I'll do this now.
 
but note that in 'normal' situation, it's doesn't really matter
if the BB is killed now or not because:
1) it's only the direct descendant that is killed, the indirect
   ones have to wait anyway.
2) kill_unreachable_bbs() is called after each cleanup loops

> >
> >  /* Change a "switch" into a branch */
> > @@ -670,6 +668,7 @@ void insert_branch(struct basic_block *bb, struct instruction *jmp, struct basic
> >                 remove_parent(child, bb);
> >         } END_FOR_EACH_PTR(child);
> >         PACK_PTR_LIST(&bb->children);
> > +       kill_unreachable_bbs(bb->ep);
> 
> It is correct to do so. The kill unreachable is relative expensive.
> Need to go through
> all the basic block in a function.

I don't really agree with this.
When doing the patch I also at first thought the same but then
I changed my mind because:
1) it *only* need to run through all the BB (in fact the cost is
   O(nbr of BB edges) while there is a lot of places where we 
   loop through all *instructions*
2) the fact that the unneeded BB are killed as soon as possible
   means that the normal CSE+simplification won't wastly run
   anymore on the indirect descendant blocks (I can redo the
   measurements but I think I saw a measurable speedup because
   of this).

> If there function has more than one
> switch statement
> get simplified, then each simplification will go through each basic block again.
> Preferably  kill_unreachable() only run once at the finial stage.
> 
> I don't know how feasible to have remove_parent() mark the "ep" needs to clean.
> Then at some later point kill off the dead basic block all together.

Don't forget that the only reason for this patch is a *correctness*
issue when the removed BB is followed by a loop (if it has no other
entry point (which is generaly the case) and which thus become
unreachable).

We can mark the ep (the easiest is the reuse repeat_phase and add
REPEAT_FLOW (which I'll will need to do anyway for something else,
I'm polishing the patch)) but it won't change anything as we *must
not* allow simplifications to be done once there is such a dead
cycle and the only way to detect such cycles is via something
like the marker algorithm used by kill_unreachable_bbs().

> Currently simplify a switch statement should be relative rare.

Like a lot of things, it depends.
For example, the kernel use a lot inline functions or macro with
code like:
	...
	switch (sizeof(x)) {
	case 1: ...
	case 2: ...
	case 4: ...
	case 8: ...
	default: issue a build error
	}
Also, the simplification concerned here is 'insert_branch()'
which, like I explained in the commit message, is used by the
switch simplification but is also used by other branch
simplifications.

> Have two switch
> statement in same function get simplify at the same time should be
> even rarer.
> Might not worth the effort to optimize for that.
> 
> As it is, the patch is acceptable.

I really also would prefer that we would not have to walk the BBs
but I really think we don't have good others choices.
 
If we would really really want to avoid to call kill_unreachable_bss()
we could in simplify_one_memop(), once we detect a possible loop in the
addresses calculation (which is the core of the problem here: avoid
to detect such a false loop), instead of issuing a message is to first
call kill_unreachable_bbs() and then redo the memop simplification if
some BBs were killed and the concerned instruction still exist).
But:
- it's more complicated than needed
- the advanatge would only be based on the principle that
  kill_unreachable_bbs() is costly (which is not really)
- calling kill_unreachable_bbs() early has the advantage
  to avoid doing memop and instruction simplification and CSE
  on code that is in fact unreacheble (and those are more costly 
  because they are done on every instructions)
  I don't have the number anymore, but when testing what
  I saw (and I was a bit surprised at first) was that with the
  patch, compiling the kernel with sparse and calling test-linearize
  on GCC's testsuite and such was in fact slightly faster (but
  admitingly, the difference was small and it could have been
  within the accuracy of the measurementi. I can redo the 
  measurement if needed).

Also, when talking about performance, if you do some profiling
you very quickly realize:
- CSE is quite costly (it's not new, cfr.
   http://marc.info/?l=linux-sparse&m=111616763219436&w=4
  and commit b5a8032aaeaf2121a642ead32653d4288fa2983d)
  I have looked at this more than once but I don't see what we
  can do but:
  - avoid to call CSE on dead code
  - call CSE less often, possibly to not trying to reach the
    fix point, of course this impact the quality of the code
- memory allocation eats a lot of memory cycles too (about
  16-20%, not especially in userland but also by things
  like kernel's clear_page())
  But, see how you can easily win a speed up of 5%:
  http://marc.info/?l=linux-sparse&m=149198627609282&w=4
  There is a lot that can be done here. I have a few things
  in preparation but it won't be for soon.
- __add_ptr_list() is also surprinsingly high but I think that it's
  simply because it's really called a lot.

-- Luc
