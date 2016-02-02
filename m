From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Do not drop 'nocast' modifier when taking the address.
Date: Wed, 3 Feb 2016 04:25:44 +0800
Message-ID: <CANeU7Q=uxwTPGdxuh9f2=1dSeC3wdQtu+zgP8BzRJnqh5s_HKg@mail.gmail.com>
References: <201509182109.6ccgXDVp%fengguang.wu@intel.com>
	<55FC16F4.7060407@openvz.org>
	<55FC17B4.9060702@redhat.com>
	<20150918144026.GJ3317@rkaganb.sw.ru>
	<55FC22B4.9010301@redhat.com>
	<20150918150644.GB20668@wfg-t540p.sh.intel.com>
	<20160105135156.GB1044@macpro.local>
	<20160105162552.GA3478@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:37817 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757008AbcBBUZp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 2 Feb 2016 15:25:45 -0500
Received: by mail-ig0-f174.google.com with SMTP id 5so20362455igt.0
        for <linux-sparse@vger.kernel.org>; Tue, 02 Feb 2016 12:25:45 -0800 (PST)
In-Reply-To: <20160105162552.GA3478@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, Andrey Smetanin <asmetanin@virtuozzo.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Wed, Jan 6, 2016 at 12:25 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> With the following code:
>         typedef unsigned long __nocast cputime_t;
>
>         void task_cputime_adjusted(cputime_t *);
>
>         void current_task_runtime_100ns(void)
>         {
>                 cputime_t utime;
>
>                 task_cputime_adjusted(&utime);
>         }
>
> sparse emits the following message:
>         x.c:16:32: warning: incorrect type in argument 1 (different modifiers)
>         x.c:16:32:    expected unsigned long [nocast] [usertype] *<noident>
>         x.c:16:32:    got unsigned long *<noident>
>         x.c:16:32: warning: implicit cast to nocast type
>
> In other words, when taking the address of 'utime', sparse drops the 'nocast'
> modifier and then complains that task_cputime_adjusted() is not given a
> 'nocast' pointer as expected ...

I think there is a bug some where else. In the above example,
"cputime_t *" and "&utime" should have the same type regardless
pointer inherent the nocast attribute or not. I haven't fully understand
where the nocast attribute get dropped.

Chris
