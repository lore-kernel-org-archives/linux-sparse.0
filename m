From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: "unexpected unlock" when unlocking, conditional, lock in loop
Date: Sat, 6 Oct 2012 19:39:47 -0700
Message-ID: <20121007023946.GA30713@leaf>
References: <1349552876.20963@cat.he.net>
 <20121006202102.GA28179@leaf>
 <66AC2AD6-C0FA-4F60-850A-D8C9426184B8@coraid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:33564 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710Ab2JGCjx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 6 Oct 2012 22:39:53 -0400
Content-Disposition: inline
In-Reply-To: <66AC2AD6-C0FA-4F60-850A-D8C9426184B8@coraid.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ed Cashin <ecashin@coraid.com>
Cc: "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>

On Sat, Oct 06, 2012 at 08:56:57PM -0500, Ed Cashin wrote:
> On Oct 6, 2012, at 4:21 PM, Josh Triplett wrote:
> 
> > On Sat, Oct 06, 2012 at 12:47:56PM -0700, ecashin@coraid.com wrote:
> ...
> >> static spinlock_t lk;
> >> static struct sk_buff_head q;
> >> int demofn(void);
> >> 
> >> /* enters and returns with lk held */
> >> int demofn(void)
> >> {
> >> 	struct sk_buff *skb;
> >> 
> >> 	while ((skb = skb_dequeue(&q))) {
> >> 		spin_unlock_irq(&lk);
> >> #if 1
> >> 		dev_queue_xmit(skb);
> >> #else
> >> 		if (dev_queue_xmit(skb) == NET_XMIT_DROP && net_ratelimit())
> >> 			pr_warn("informative warning\n");
> >> #endif
> >> 		spin_lock_irq(&lk);
> >> 	}
> >> 	return 0;
> >> }
> > 
> > Sparse should *always* generate a context warning here; odd that it does
> > not in both cases.
> 
> I see.
> 
> > The right fix: annotate the function to explicitly say it starts and
> > stops with that lock held.  That should make the warning go away in
> > both cases.
> 
> 
> OK.  From the sparse man page section on context, along with
> include/linux/compiler.h, it sounds like the way to do exactly that 
> would be something unusual:
> 
> int demofn(void) __attribute__((context(&lk,1,1)))
> 
> ... but using that in demo.c causes sparse to warn me that it's 
> ignoring that attribute, so I doubt that can be what you mean.

I did mean precisely that; I don't know why Sparse complains about that
syntax.

- Josh Triplett
