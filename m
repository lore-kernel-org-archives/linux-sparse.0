From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: "unexpected unlock" when unlocking, conditional, lock in loop
Date: Sat, 6 Oct 2012 13:21:02 -0700
Message-ID: <20121006202102.GA28179@leaf>
References: <1349552876.20963@cat.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:55515 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932181Ab2JFUVJ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 6 Oct 2012 16:21:09 -0400
Content-Disposition: inline
In-Reply-To: <1349552876.20963@cat.he.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: ecashin@coraid.com
Cc: linux-sparse@vger.kernel.org

On Sat, Oct 06, 2012 at 12:47:56PM -0700, ecashin@coraid.com wrote:
> Hi.  I have a function that enters with a lock held and does
> an unlock inside a loop.
> 
> Sparse 0.4.4 is fine with this function until I introduce a conditional
> between the unlock and the next lock.  In the minimal example below,
> changing the "#if 1" to "#if 0" makes sparse generate the warning
> below:
> 
> cd ~/git/linux && PATH=/opt/bin:$PATH make drivers/block/aoe/aoe.ko C=1
> make[1]: Nothing to be done for `all'.
> make[1]: Nothing to be done for `relocs'.
>   CHK     include/linux/version.h
>   CHK     include/generated/utsrelease.h
>   CALL    scripts/checksyscalls.sh
>   CHECK   drivers/block/aoe/demo.c
> /build/ecashin/git/linux/arch/x86/include/asm/spinlock.h:81:9: warning: context imbalance in 'demofn' - unexpected unlock
>   CC [M]  drivers/block/aoe/demo.o
>   LD [M]  drivers/block/aoe/aoe.o
>   MODPOST 1 modules
>   CC      drivers/block/aoe/aoe.mod.o
>   LD [M]  drivers/block/aoe/aoe.ko
> 
> I'm using 3.6.0-rc7 kernel sources.
> 
> Granted, I'm unusually tired today, but I can't think of a way that
> conditionally printing a warning has changed the locking, so I
> could use some help in determining whether this is a sparse bug
> that might be fixed, one that I have to work around, or some
> confusion of mine.
> 
> /* demo.c */
> #include <linux/netdevice.h>
> 
> static spinlock_t lk;
> static struct sk_buff_head q;
> int demofn(void);
> 
> /* enters and returns with lk held */
> int demofn(void)
> {
> 	struct sk_buff *skb;
> 
> 	while ((skb = skb_dequeue(&q))) {
> 		spin_unlock_irq(&lk);
> #if 1
> 		dev_queue_xmit(skb);
> #else
> 		if (dev_queue_xmit(skb) == NET_XMIT_DROP && net_ratelimit())
> 			pr_warn("informative warning\n");
> #endif
> 		spin_lock_irq(&lk);
> 	}
> 	return 0;
> }

Sparse should *always* generate a context warning here; odd that it does
not in both cases.

The right fix: annotate the function to explicitly say it starts and
stops with that lock held.  That should make the warning go away in
both cases.

- Josh Triplett
