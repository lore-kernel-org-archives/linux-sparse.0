From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC v0 0/4] Give a type to constants too
Date: Thu, 16 Mar 2017 21:42:35 +0100
Message-ID: <20170316204233.gdmoriioei6u3vu2@macbook.local>
References: <20170311154725.87906-1-luc.vanoostenryck@gmail.com>
 <CA+55aFyqMScsVe8-5T=omdpSsFaYmdD-PbK3KqKW=1gXgitMaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34326 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753832AbdCPVOE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Mar 2017 17:14:04 -0400
Received: by mail-wr0-f196.google.com with SMTP id u48so7409149wrc.1
        for <linux-sparse@vger.kernel.org>; Thu, 16 Mar 2017 14:14:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+55aFyqMScsVe8-5T=omdpSsFaYmdD-PbK3KqKW=1gXgitMaA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

On Thu, Mar 16, 2017 at 10:25:08AM -0700, Linus Torvalds wrote:
> Sorry for not reacting to this earlier..

No problem, of course, but since you're looking over here, hehe,s
I wonder if you would have an opinion on:
   http://marc.info/?l=linux-sparse&m=148728997923939&w=4
and to a lesser degree:
   http://marc.info/?l=linux-sparse&m=148906980631077&w=4
I would appreciate it very much.

> On Sat, Mar 11, 2017 at 7:47 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > This is a RFC for giving a type to constants/PSEUDO_VALs.
> 
> This seems completely broken. Not from an implementation standpoint,
> but from a conceptual one.

Yes, I agree completely. I realized once I tried to make use of it.

> To explain, let me give a completely idiotic example:

...

> Linearization has fundamentally gotten rid of all the C types, and all
> you can find are some rough remnants of them (you can find the *size*
> of the type, and you can find the rough "type" of type - is it a
> pointer, FP value or integer. There aren't even any signs, although
> some _operations_ are signed (but not the pseudos).
> 
> The same pseudo can have many different types.
> 
>                     Linus

There is just one problem, like Dibyendu noticed, it is when you use
a constant in the variable part of a variadic function. In this case
you don't have any type/size information from the function and
nothing from the pseudo either.

I don't see how this could be done without requiring that pseudos
(which indded have indeed no type) have a fixed size that must not
be changed by CSE or the simplifications.


-- Luc
