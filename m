From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 1/6] storage should not be inherited by pointers
Date: Fri, 25 Nov 2016 04:38:18 +0100
Message-ID: <20161125033817.GA14283@macbook.local>
References: <20161124170947.14379-1-luc.vanoostenryck@gmail.com>
 <20161124170947.14379-2-luc.vanoostenryck@gmail.com>
 <CANeU7QnGdG8x+1SzKP7e8f6Gan8VZh7MNMGpZ=E3JwSQ2xYkAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:34967 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751437AbcKYDxd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 24 Nov 2016 22:53:33 -0500
Received: by mail-wj0-f196.google.com with SMTP id o2so574253wje.2
        for <linux-sparse@vger.kernel.org>; Thu, 24 Nov 2016 19:53:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7QnGdG8x+1SzKP7e8f6Gan8VZh7MNMGpZ=E3JwSQ2xYkAw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Nov 25, 2016 at 10:09:25AM +0800, Christopher Li wrote:
> On Fri, Nov 25, 2016 at 1:09 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > Information about storage is needed for objects but once
> > you take the address of an object, its storage should be
> > irrelevant for the resulting pointer.
> >
> > Trying to keep the storage into the pointer's modifiers
> > (while it will be available in the base type anyway) only
> > create corner cases later.
> 
> Either way it is going to be very tricky. If you make the pointer
> does not inherent the object storage modifier, you need to change
> all the place that assume the pointer will inherent the object storage.

Thing is that nowhere should sparse assume this and from what I've seen
nowhere is this assumption done.

> Because C mostly deal with pointer, e.g. "a = b;", is actually
> "*(&a) = *(&b);". Pointer is all over the place.  Right now sparse
> make the pointer inherent the storage is convenient but not precise.
> Changing the underlining assumption will touch a lot of code.
> 
> The extremely tricky one is the context and address space
> store in "struct ctype". It is not a modifier but act like one.
> Address space should belong to the storage object. But
> right now address space is propagate to pointer as well.
> Most of the test is done on pointer level.

I'm not sure we're talking about the same thing.
The patch doesn't touch to anything related to address space
which have to be inherited by the '&/adressof' operator.
The patch only concern what must be done with MOD_STATIC,
MOD_EXTERN & MOD_TOPLEVEL when we're taking the address of an object.
This is certainly one point where taking the address of an object
and then later dereferencing the pointer is *not* the same as using
directly the object, it deosn't matter anymore if the object was
static.

I didn't gave an example where the actual situation is causing a problems
but this patch is in my opinion the right solution to the problem
exposed in Nicolai's patch 20/21 (but in this case the problem only
exist because of a combinaison of a very specific case and another
deficiency) which is brievly described just here under.

> > An example of the problem it can create is when the pointer
> > is dereferenced in an inlined function.
> >
> > Better to simply not put have the storage informations
> > for the pointer, which is what this patch does.
> 
> I think there will be other code changes associate with the assumption
> change.
> 
> One thing to verify is if sparse issues different set of warning
> on the Linux kernel check.

I'll will of course carefully check this but I really doubt there will be
any problems.

Luc
