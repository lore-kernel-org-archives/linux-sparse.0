From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Do not drop 'nocast' modifier when taking the address.
Date: Wed, 3 Feb 2016 12:09:16 +0800
Message-ID: <CANeU7Qmch59PjG6FTk9kYoQ0Lg97pvP_SM+Nvccn+JPBW1Vunw@mail.gmail.com>
References: <201509182109.6ccgXDVp%fengguang.wu@intel.com>
	<55FC16F4.7060407@openvz.org>
	<55FC17B4.9060702@redhat.com>
	<20150918144026.GJ3317@rkaganb.sw.ru>
	<55FC22B4.9010301@redhat.com>
	<20150918150644.GB20668@wfg-t540p.sh.intel.com>
	<20160105135156.GB1044@macpro.local>
	<20160105162552.GA3478@macpro.local>
	<CANeU7Q=uxwTPGdxuh9f2=1dSeC3wdQtu+zgP8BzRJnqh5s_HKg@mail.gmail.com>
	<20160203034357.GA3332@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:34088 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755282AbcBCEJR (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 2 Feb 2016 23:09:17 -0500
Received: by mail-io0-f175.google.com with SMTP id 9so42295073iom.1
        for <linux-sparse@vger.kernel.org>; Tue, 02 Feb 2016 20:09:17 -0800 (PST)
In-Reply-To: <20160203034357.GA3332@macbook.lan>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, Andrey Smetanin <asmetanin@virtuozzo.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Wed, Feb 3, 2016 at 11:43 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
pped.
>
> The nocast mod is dropped and lost in the function create_pointer().
> In the example above, "cputime_t *" has type :
>         unsigned long [nocast] [usertype] *
> while &utime is just:
>         unsigned long *

That is my point. Why does "&utime" get drop but "cputime_t *" does not?
They both are pointer of a base type. They both create pointers.

It seems to me the bug is sparse not treating this two case consistently.

> So, for sparse and its extended notion of type, the type we get when
> taking the address of a [variable of some] type X is not the same as
> directly using a pointer to the type X.

In C language type system,  these two should be the same type. It is a
bug in sparse if they are not. I would rather get that bug fixed.

> Which is very fine, just that MOD_NOCAST is dropped while the example
> shows that it should not.

I think that is a separate issue weather MOD_NOCAST should be inherent
from pointer base type. Same with MOD_STORAGE.

Chris
