From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] Do not drop 'nocast' modifier when taking the address.
Date: Wed, 3 Feb 2016 10:15:56 +0100
Message-ID: <20160203091555.GA3563@macbook.lan>
References: <55FC16F4.7060407@openvz.org>
 <55FC17B4.9060702@redhat.com>
 <20150918144026.GJ3317@rkaganb.sw.ru>
 <55FC22B4.9010301@redhat.com>
 <20150918150644.GB20668@wfg-t540p.sh.intel.com>
 <20160105135156.GB1044@macpro.local>
 <20160105162552.GA3478@macpro.local>
 <CANeU7Q=uxwTPGdxuh9f2=1dSeC3wdQtu+zgP8BzRJnqh5s_HKg@mail.gmail.com>
 <20160203034357.GA3332@macbook.lan>
 <CANeU7Qmch59PjG6FTk9kYoQ0Lg97pvP_SM+Nvccn+JPBW1Vunw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34331 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbcBCJQA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 3 Feb 2016 04:16:00 -0500
Received: by mail-wm0-f44.google.com with SMTP id 128so155326386wmz.1
        for <linux-sparse@vger.kernel.org>; Wed, 03 Feb 2016 01:16:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Qmch59PjG6FTk9kYoQ0Lg97pvP_SM+Nvccn+JPBW1Vunw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Fengguang Wu <fengguang.wu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, Andrey Smetanin <asmetanin@virtuozzo.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Wed, Feb 03, 2016 at 12:09:16PM +0800, Christopher Li wrote:
> On Wed, Feb 3, 2016 at 11:43 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> pped.
> >
> > The nocast mod is dropped and lost in the function create_pointer().
> > In the example above, "cputime_t *" has type :
> >         unsigned long [nocast] [usertype] *
> > while &utime is just:
> >         unsigned long *
> 
> That is my point. Why does "&utime" get drop but "cputime_t *" does not?
> They both are pointer of a base type. They both create pointers.

Well with "cputime_t *" you got the pointer directly, by its own declaration;
with "&utime" you really _create_ one with the "&"/"addressof" operator.

The function "create_pointer()" is only called when evaluating an expression
using the addressof operator or when when an array of a function is degenerated
into a pointer.

> It seems to me the bug is sparse not treating this two case consistently.
> 
> > So, for sparse and its extended notion of type, the type we get when
> > taking the address of a [variable of some] type X is not the same as
> > directly using a pointer to the type X.
> 
> In C language type system,  these two should be the same type. It is a
> bug in sparse if they are not. I would rather get that bug fixed.

They _have_ the same type if we limit ourselves to the pure C type system,
but they differ once we look also at the sparse & gcc extension to the
type system, like the nocast attribute here.
 
Now, whether they should be the same or not is a question of defining the
semantic of the addressof operator on sparse's type extension.

> > Which is very fine, just that MOD_NOCAST is dropped while the example
> > shows that it should not.
> 
> I think that is a separate issue weather MOD_NOCAST should be inherent
> from pointer base type.

I'm not sure to understand you here.

> Same with MOD_STORAGE.
> 
> Chris

Luc
