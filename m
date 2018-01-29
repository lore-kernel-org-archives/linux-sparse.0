From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: wrong "imbalanced unlock" warning?
Date: Mon, 29 Jan 2018 19:24:38 +0100
Message-ID: <20180129182437.e33mntguu6ofsvwp@ltop.local>
References: <87k1w0d3re.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:51108 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750959AbeA2SYm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 29 Jan 2018 13:24:42 -0500
Received: by mail-wm0-f50.google.com with SMTP id f71so16167721wmf.0
        for <linux-sparse@vger.kernel.org>; Mon, 29 Jan 2018 10:24:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87k1w0d3re.fsf@suse.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?iso-8859-1?Q?Aur=E9lien?= Aptel <aaptel@suse.com>
Cc: linux-sparse@vger.kernel.org

On Mon, Jan 29, 2018 at 05:32:53PM +0100, Aurélien Aptel wrote:
> Hi,
> 
> While compiling the kernel cifs for-next (from here [1]) I've run into a
> strange sparse warning.
> 
> fs/cifs/smbdirect.c:1943:56: warning: context imbalance in 'smbd_recv_buf' - unexpected unlock
> 
> The code is basically doing:
> 
> 	int queue_length;
> 	....
> 	queue_length = info->reassembly_queue_length;
> 	....
> 	/*
> 	 * No need to lock if we are not at the
> 	 * end of the queue
> 	 */
> 	if (!queue_length)
> 	    spin_lock_irq(&info->reassembly_queue_lock);
> 	list_del(&response->list);
> 	queue_removed++;
> 	if (!queue_length)
> 	    spin_unlock_irq(&info->reassembly_queue_lock);
> 
> 
> I don't think there's anything wrong with this code.

Indeed.
Sparse issues a "context imbalance" warning if, at some point,
the code can be reached via two paths (or more) and the lock state
(the context) is not identical in each of these paths.

It's exactly what's happening in this function.
It can be annoying or seen as a limitation of sparse context
checking, on the other hand it's often what is wanted.


> I've tried adding a
> test in sparse validation/context.c to reproduce the warning:
> 
> add this at the bottom:
> 
>     static void warn_cifs(void)
>     {
> 
>         int x;
>         x = condition;
> 
>         if(!x)
>             a();
> 
>         if(!x)
>             r();
>     }
> 
> a() adds a lock, r() removes it.
> 
> and in validation/ run
> 
>     ./test-suite single context.c
>          TEST    Check -Wcontext (context.c)
>     context.c passed !

That's normal, because the code is very simple and sparse can see that
the second test is redundant.
If you add something between the two tests & lock/unlock something
that can change the condition then you will have the same behaviour
as the kernel code.

> I've played around with the test and tried to make it similar to
> smbdirect.c code (see attached file). Place it in validation and run
> ./test-suite single cifs.c
> 
> I've also checked out my system revision of sparse, but I couldn't make
> it fail either.
> 
> Although it doesn't look like it, maybe there is an issue in
> smbdirect.c, what do you think?

Well, now you have the explanation for sparse's warning but
looking only at the small part you copied, I have directly
several questions about the locking like, for example:
 - is it valid to deref info->reassembly_queue_length
   before taking the lock?
or equivalently:
 - is it possible that something is added to the queue
   after initializing queue_length but before the lock
   is taken?

I hope this answer your questions,
-- Luc Van Oostenryck
