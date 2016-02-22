From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Do not drop 'nocast' modifier when taking the address.
Date: Tue, 23 Feb 2016 02:41:34 +0800
Message-ID: <CANeU7QkYdQrXpS8+bCNE3nXyW556_63-PUGJDFQb56nX-DcFpg@mail.gmail.com>
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
	<20160203091555.GA3563@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:33208 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871AbcBVSlf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Feb 2016 13:41:35 -0500
Received: by mail-io0-f175.google.com with SMTP id z135so187450413iof.0
        for <linux-sparse@vger.kernel.org>; Mon, 22 Feb 2016 10:41:34 -0800 (PST)
In-Reply-To: <20160203091555.GA3563@macbook.lan>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, Andrey Smetanin <asmetanin@virtuozzo.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Wed, Feb 3, 2016 at 5:15 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Well with "cputime_t *" you got the pointer directly, by its own declaration;
> with "&utime" you really _create_ one with the "&"/"addressof" operator.
>
> The function "create_pointer()" is only called when evaluating an expression
> using the addressof operator or when when an array of a function is degenerated
> into a pointer.

Yes, I take a closer look. My previous understanding of how the MOD_PTRINHERIT
works was wrong.

Now I see the pointer is created differently. In the parsing stage, it is
created by the "pointer" function. In the evaluation stage it is created
by the "create_pointer" function. The "pointer" function has no treatment for
MOD_PTRINHERIT at all.

Ideally it would be nice to unify the pointer create some how. It is
easier to have
inconsistent modifier other than MOD_NOCAST. As a simply fix, your patch is
fine. Applied.

>
> They _have_ the same type if we limit ourselves to the pure C type system,
> but they differ once we look also at the sparse & gcc extension to the
> type system, like the nocast attribute here.
>
> Now, whether they should be the same or not is a question of defining the
> semantic of the addressof operator on sparse's type extension.

I think sparse should treat them with same semantic. It does not make sense
if they are not the same.

Thanks.

Chris
