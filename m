From: Chris Li <christ.li@gmail.com>
Subject: Re: RFC: ptrlist insert during iteration
Date: Thu, 10 Aug 2017 20:27:22 -0400
Message-ID: <CANeU7Q=1NSJEoWyTs9C-A992j=yiK4iFAstg3JJjPgkenOkTog@mail.gmail.com>
References: <CANeU7QnyNWOLe+u+ZOKr0EGPn9_RJ7T=sPi5mMiC-UTvaqeoEw@mail.gmail.com>
 <20170810232843.j4bofztgv3umunzd@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:35915 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751488AbdHKA1X (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Aug 2017 20:27:23 -0400
Received: by mail-yw0-f178.google.com with SMTP id u207so14275348ywc.3
        for <linux-sparse@vger.kernel.org>; Thu, 10 Aug 2017 17:27:23 -0700 (PDT)
In-Reply-To: <20170810232843.j4bofztgv3umunzd@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Thu, Aug 10, 2017 at 7:28 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>> It is pretty complicate, but do able if we really want to do it.
>
> Yes, it's pretty complicated. Too complicate for something that should
> be very very simple: just add an element to a list.

It is also a dare. I don't think there is much simpler way to do insert
while looping properly in ptrlist. I welcome any one to give it a try.
Report back if you have super clever way to do it. To define properly,
the ptrlist looping while modify should behave as if it is a traditional
double link list. New item add to before the current position,
it will not show up in the loop. Insert after the current position, it will
show up in the loop. That is for the normal direction looping.

>
> I think that sequences are only needed for instructions: bb->insns.
> All other current use just need a 'set'.
>
> == For instructions ==
> * delete is already safe (insns are just marked as ->bb = NULL)
> * insert-at-front is only used to add death notes and this shouldn't
>   be a problem for nested ptrlist walking.
> * concat is only used when packing BB and should be a problem
> * add-at-end is used during linearization and some BB simplifications
>   and shouldn't be a problem either
>
> == For sets ==
> * 'delete' should be done by marking the element as deleted if there
>   is a possiblity of nested ptrlist walking
> * if 'add' is only done at the end, I don't see well how we can have
>   a problem, even with backward walking.
> * even if somehow safe, 'add' or 'delete' operations should never be
>   done in inner ptrlist walking because the outer will become meaningless
>   if the set change (*any kind of change*) while iterating on the set
>   In other words, what would mean "do this on all elements of the set"
>   if elements are added or removed from the set while iterating on them?
>   [It may be that is some specific cases, it is meaningful but in general
>    it's not].

I think that is exactly the problem with set. When you have looping
and modify (insert for example), it is very hard to define consistent
behavior.  Should the new inserted element shows in the loop or
not? The double link list is very consistent. Consistent is good.

> == Conclusion ==
> We should audit the code much better that I did here but:
> 1) modification of sets in inner loops must be avoided in all case
>    if we want to do well defined operations on them

Agree.

> 2) most cases should be already safe
> 3) maybe we should use another API for sets & sequences

I think the consistent behavior will be very hard to address in
set. If the compiler get different result run to run, that is bad.

> 4) maybe it would even be good to use separate implementation for them

I do have some plan(in my head) to use work queue to avoid the
looping. I believe the looping while modify can be avoided. Most
of the classic compiler algorithm, in their pseudo code form, already
avoid looping while modify. But that is getting off topic here.

Chris
