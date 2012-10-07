From: Ed Cashin <ecashin@coraid.com>
Subject: Re: "unexpected unlock" when unlocking, conditional, lock in loop
Date: Sat, 6 Oct 2012 20:56:57 -0500
Message-ID: <66AC2AD6-C0FA-4F60-850A-D8C9426184B8@coraid.com>
References: <1349552876.20963@cat.he.net> <20121006202102.GA28179@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from server505g.appriver.com ([98.129.35.12]:2992 "EHLO
	server505.appriver.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751082Ab2JGCCE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 6 Oct 2012 22:02:04 -0400
In-Reply-To: <20121006202102.GA28179@leaf>
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>

On Oct 6, 2012, at 4:21 PM, Josh Triplett wrote:

> On Sat, Oct 06, 2012 at 12:47:56PM -0700, ecashin@coraid.com wrote:
...
>> static spinlock_t lk;
>> static struct sk_buff_head q;
>> int demofn(void);
>> 
>> /* enters and returns with lk held */
>> int demofn(void)
>> {
>> 	struct sk_buff *skb;
>> 
>> 	while ((skb = skb_dequeue(&q))) {
>> 		spin_unlock_irq(&lk);
>> #if 1
>> 		dev_queue_xmit(skb);
>> #else
>> 		if (dev_queue_xmit(skb) == NET_XMIT_DROP && net_ratelimit())
>> 			pr_warn("informative warning\n");
>> #endif
>> 		spin_lock_irq(&lk);
>> 	}
>> 	return 0;
>> }
> 
> Sparse should *always* generate a context warning here; odd that it does
> not in both cases.

I see.

> The right fix: annotate the function to explicitly say it starts and
> stops with that lock held.  That should make the warning go away in
> both cases.


OK.  From the sparse man page section on context, along with
include/linux/compiler.h, it sounds like the way to do exactly that 
would be something unusual:

int demofn(void) __attribute__((context(&lk,1,1)))

... but using that in demo.c causes sparse to warn me that it's 
ignoring that attribute, so I doubt that can be what you mean.

Were you thinking of changes like the ones below?  These changes
stop the warnings, but it bothers me that they imply that the function
is called without the lock held, __attribute__((context(x,0,1))), when
that's not really true.

[ecashin@marino linux]$ diff -u drivers/block/aoe/demo.c.20121006 drivers/block/aoe/demo.c
--- drivers/block/aoe/demo.c.20121006   2012-10-06 21:12:11.769751545 -0400
+++ drivers/block/aoe/demo.c    2012-10-06 21:51:01.453595477 -0400
@@ -5,10 +5,11 @@
 int demofn(void);
 
 /* enters with lk held */
-int demofn(void)
+int demofn(void) __acquires(&lk)
 {
        struct sk_buff *skb;
 
+       __acquire(lk);
        while ((skb = skb_dequeue(&q))) {
                spin_unlock_irq(&lk);
 #if 0
[ecashin@marino linux]$ 

Thanks very much.

-- 
  Ed Cashin
  ecashin@coraid.com


