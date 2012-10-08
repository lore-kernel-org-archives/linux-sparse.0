From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: "unexpected unlock" when unlocking, conditional, lock in loop
Date: Sun, 7 Oct 2012 19:01:12 -0700
Message-ID: <20121008020111.GB8836@leaf>
References: <1349552876.20963@cat.he.net>
 <20121006202102.GA28179@leaf>
 <66AC2AD6-C0FA-4F60-850A-D8C9426184B8@coraid.com>
 <20121007023946.GA30713@leaf>
 <E7D62B13-C7E3-4A4B-B579-81E773DDC641@coraid.com>
 <20121007194552.GA909@leaf>
 <E2F79A45-57FB-48C5-B8FC-27C431B1B2BB@coraid.com>
 <20121007233032.GA5508@leaf>
 <2077B668-BDF7-4B84-9E26-88C848CD9EC8@coraid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:50847 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092Ab2JHCBS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 7 Oct 2012 22:01:18 -0400
Content-Disposition: inline
In-Reply-To: <2077B668-BDF7-4B84-9E26-88C848CD9EC8@coraid.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ed Cashin <ecashin@coraid.com>
Cc: "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>

On Sun, Oct 07, 2012 at 07:35:44PM -0500, Ed Cashin wrote:
> On Oct 7, 2012, at 7:30 PM, Josh Triplett wrote:
> 
> > On Sun, Oct 07, 2012 at 04:28:16PM -0500, Ed Cashin wrote:
> >> On Oct 7, 2012, at 3:45 PM, Josh Triplett wrote:
> ...
> >>> From 0b862fc1a131a874d157420e9443f16a714596ef Mon Sep 17 00:00:00 2001
> >>> From: Josh Triplett <josh@joshtriplett.org>
> >>> Date: Sun, 7 Oct 2012 12:41:13 -0700
> >>> Subject: [PATCH] linux/compiler.h: Add __must_hold macro for functions called with a lock held
> >> 
> >> Ah.  OK.  So... would you like me to submit your patch to the LKML, or are you doing that?
> >> 
> >> It seems like a needed addition.
> > 
> > If you can confirm that it works for you, I'll send it to LKML with a
> > Tested-by from you.
> 
> Does my usage in demo.c (as shown below) look correct to you?  If so, then I can confirm that it eliminates the warnings as intended.
> 
> Similar usage in the original code that motivated this inquiry also passes sparse when using __must_hold() with your patch applied.
> 
> [ecashin@marino linux]$ nl -b a drivers/block/aoe/demo.c
>      1  #include <linux/netdevice.h>
>      2  #include <linux/compiler.h>
>      3  
>      4  static spinlock_t lk;
>      5  static struct sk_buff_head q;
>      6  int demofn(void);
>      7  
>      8  /* enters with lk held */
>      9  int demofn(void) __must_hold(&lk)
>     10  {
>     11          struct sk_buff *skb;
>     12  
>     13          while ((skb = skb_dequeue(&q))) {
>     14                  spin_unlock_irq(&lk);
>     15                  if (dev_queue_xmit(skb) == NET_XMIT_DROP && net_ratelimit())
>     16                          pr_warn("informative warning\n");
>     17                  spin_lock_irq(&lk);
>     18          }
>     19          return 0;
>     20  }
> [ecashin@marino linux]$ 

Yes, that looks right to me; glad to hear it works for you.  I'll send
the patch to LKML shortly.

Meanwhile, you've still found at least one bug in Sparse, since it
doesn't give the context warning if you leave out lines 15 and 16.

- Josh Triplett
