From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: RFC: ptrlist insert during iteration
Date: Fri, 11 Aug 2017 13:10:55 +0200
Message-ID: <20170811111053.7vimy5kgzwcmuw2y@ltop.local>
References: <CANeU7QnyNWOLe+u+ZOKr0EGPn9_RJ7T=sPi5mMiC-UTvaqeoEw@mail.gmail.com>
 <20170810232843.j4bofztgv3umunzd@ltop.local>
 <CANeU7Q=1NSJEoWyTs9C-A992j=yiK4iFAstg3JJjPgkenOkTog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:33195 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752096AbdHKLK7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 11 Aug 2017 07:10:59 -0400
Received: by mail-wm0-f44.google.com with SMTP id k20so1742377wmg.0
        for <linux-sparse@vger.kernel.org>; Fri, 11 Aug 2017 04:10:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=1NSJEoWyTs9C-A992j=yiK4iFAstg3JJjPgkenOkTog@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Chris Li <christ.li@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Thu, Aug 10, 2017 at 08:27:22PM -0400, Chris Li wrote:
> On Thu, Aug 10, 2017 at 7:28 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >> It is pretty complicate, but do able if we really want to do it.
> >
> > Yes, it's pretty complicated. Too complicate for something that should
> > be very very simple: just add an element to a list.
> 
> It is also a dare. I don't think there is much simpler way to do insert
> while looping properly in ptrlist. I welcome any one to give it a try.
> Report back if you have super clever way to do it. To define properly,
> the ptrlist looping while modify should behave as if it is a traditional
> double link list. New item add to before the current position,
> it will not show up in the loop. Insert after the current position, it will
> show up in the loop. That is for the normal direction looping.
> 
> >
> > I think that sequences are only needed for instructions: bb->insns.
> > All other current use just need a 'set'.
> >
> > == For instructions ==
> > * delete is already safe (insns are just marked as ->bb = NULL)
> > * insert-at-front is only used to add death notes and this shouldn't
> >   be a problem for nested ptrlist walking.
> > * concat is only used when packing BB and should be a problem
> > * add-at-end is used during linearization and some BB simplifications
> >   and shouldn't be a problem either
> >
> > == For sets ==
> > * 'delete' should be done by marking the element as deleted if there
> >   is a possiblity of nested ptrlist walking
> > * if 'add' is only done at the end, I don't see well how we can have
> >   a problem, even with backward walking.
> > * even if somehow safe, 'add' or 'delete' operations should never be
> >   done in inner ptrlist walking because the outer will become meaningless
> >   if the set change (*any kind of change*) while iterating on the set
> >   In other words, what would mean "do this on all elements of the set"
> >   if elements are added or removed from the set while iterating on them?
> >   [It may be that is some specific cases, it is meaningful but in general
> >    it's not].
> 
> I think that is exactly the problem with set. When you have looping
> and modify (insert for example), it is very hard to define consistent
> behavior.  Should the new inserted element shows in the loop or
> not?

Yes, but again, if we see things strictly from the mathematical
point-of-view, it's not that it is hard to define behaviour, it's
simply that things are *always* inconsistent.
If you write your outer loop in mathematical language as:
  for all x in <this set>: ...
things become clearer as the set is modified while the operations
are done/the properties are checked/...

*Probably* we want to have something like:
  X' = { x in X ! .... } U ...
for the inner loop and thinsg are in fact OK there but for
the outer loop things are simply and plainly wrong.

> The double link list is very consistent. Consistent is good.

Double linked list is an implementation detail. It is easier to
maintain *local consistency* at the structure level. *But* ...
if this list is used the represent a set then the problem above
remains, it's not a question of implementation.
 
> ...
> If the compiler get different result run to run, that is bad.

It's not because a set has no ordering that the implementation
*must* create indeterminism (from run to run) when giving an order
to its elements, using an order when accessing its elements.
It just means that we can choose the order.

And yes, it's really much better if sparse can give exactly the
same behaviour from run to run, in other words: reproducible results.
It currently doesn't (for reasons I haven't yet understood) and
it is *very* annoying when comparing results between versions
at instruction level as I very often do.

-- Luc
