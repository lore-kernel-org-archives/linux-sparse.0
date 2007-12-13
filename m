From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: annotating semaphores.
Date: Thu, 13 Dec 2007 14:00:09 -0800
Message-ID: <70318cbf0712131400j607b8f55mbb64e9b8cb7f8682@mail.gmail.com>
References: <20071212200053.GA19747@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:18497 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933779AbXLMWAK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 13 Dec 2007 17:00:10 -0500
Received: by rv-out-0910.google.com with SMTP id k20so698497rvb.1
        for <linux-sparse@vger.kernel.org>; Thu, 13 Dec 2007 14:00:09 -0800 (PST)
In-Reply-To: <20071212200053.GA19747@redhat.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: linux-sparse@vger.kernel.org

On Dec 12, 2007 12:00 PM, Dave Jones <davej@redhat.com> wrote:
> Today I came across a bug in the kernel cpufreq code where
> we were missing a bunch of up_write() calls in error paths
> of a function.
>
> I've been trying to get sparse's context checking to pick up
> on the errors and failing.  The kernel patch below is what I have
> so far, but it seems to report no output whatsoever.
> What am I missing ?

Can you share the example buggy cpufreq code that miss the up_write() calls?

> --- a/lib/rwsem-spinlock.c
> +++ b/lib/rwsem-spinlock.c
> @@ -162,6 +162,7 @@ void fastcall __sched __down_read(struct rw_semaphore *sem)
>
>         tsk->state = TASK_RUNNING;
>   out:
> +       __acquire(sem);
>         ;
>  }

That is not needed. Because the __down_read is not an inline function. The
extern void FASTCALL(__down_read(struct rw_semaphore *sem)) __acquires(sem);
declare should be good enough.

Chris
