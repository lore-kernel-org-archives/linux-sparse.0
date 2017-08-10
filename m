From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: RFC: ptrlist insert during iteration
Date: Fri, 11 Aug 2017 01:28:44 +0200
Message-ID: <20170810232843.j4bofztgv3umunzd@ltop.local>
References: <CANeU7QnyNWOLe+u+ZOKr0EGPn9_RJ7T=sPi5mMiC-UTvaqeoEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35126 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751361AbdHJX2t (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Aug 2017 19:28:49 -0400
Received: by mail-wm0-f54.google.com with SMTP id m85so30637382wma.0
        for <linux-sparse@vger.kernel.org>; Thu, 10 Aug 2017 16:28:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QnyNWOLe+u+ZOKr0EGPn9_RJ7T=sPi5mMiC-UTvaqeoEw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Chris Li <christ.li@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Wed, Aug 09, 2017 at 11:56:48PM -0400, Chris Li wrote:
> I have give this a little bit more thought.
> Find more bugs in the previous proposal.
> 
> Data structure:
> occupier mask:
>      indicate which ptrlist entry is valid.
> insert mask:
>      Indicate which ptrlist entry is new insert during current loop.
> 
> I find out for each ptr iteration. The insert mask need to restart
> with fresh zero.
> e.g. if the insert mask start with 00010B, and after the current
> ptr iteration, the insert mask become 00110B. The loop iterator
> has no way to tell if the new bit was insert before or after the
> original bit.
> 
> That is the reason insert mask will need to start fresh zero
> for each pointer iteration.
> 
> If there is nest loops, the inner loop will need to maintain and
> merge the insert mask for the outer loop.
> 
> It need some thing similar to the ptrlist refcount to do some
> save/merge on the insert mask context when iterator
> enter/exit the ptrlist node.
> 
> It is pretty complicate, but do able if we really want to do it.

Yes, it's pretty complicated. Too complicate for something that should
be very very simple: just add an element to a list.

Happily, I think we don't need this. Here is why:

First, we must realize that we use ptrlist for two different things:
1) just as container for object, in other words: a set.
2) to store a sequence of objects, an ordered set.
Each of these have different properties & operations:
1) for sets:
   - is-empty
   - size
   - add
   - lookup
   - delete
   - iterate
2) for sequences:
   - is-empty?
   - size
   - add-at-end
   - insert(-in-front)
   - delete
   - iterate
   - concat

Soon we may use them for another use too: fifo, aka stack
   - push
   - pop
   - [is-empty]
but that is another story.

I think that sequences are only needed for instructions: bb->insns.
All other current use just need a 'set'. 

== For instructions ==
* delete is already safe (insns are just marked as ->bb = NULL)
* insert-at-front is only used to add death notes and this shouldn't
  be a problem for nested ptrlist walking.
* concat is only used when packing BB and should be a problem
* add-at-end is used during linearization and some BB simplifications
  and shouldn't be a problem either

== For sets ==
* 'delete' should be done by marking the element as deleted if there
  is a possiblity of nested ptrlist walking
* if 'add' is only done at the end, I don't see well how we can have
  a problem, even with backward walking.
* even if somehow safe, 'add' or 'delete' operations should never be
  done in inner ptrlist walking because the outer will become meaningless
  if the set change (*any kind of change*) while iterating on the set
  In other words, what would mean "do this on all elements of the set"
  if elements are added or removed from the set while iterating on them?
  [It may be that is some specific cases, it is meaningful but in general
   it's not].

== Conclusion ==
We should audit the code much better that I did here but:
1) modification of sets in inner loops must be avoided in all case
   if we want to do well defined operations on them
2) most cases should be already safe
3) maybe we should use another API for sets & sequences
4) maybe it would even be good to use separate implementation for them

-- Luc
