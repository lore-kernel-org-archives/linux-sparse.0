From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: contextual attributes
Date: Mon, 17 Nov 2008 23:10:28 +0100
Message-ID: <1226959828.4014.4.camel@johannes.berg>
References: <8763mmuirz.fsf@aryx.cs.uiuc.edu>
	 (sfid-20081117_224927_421372_B9FEACFC)
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:42972 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625AbYKQWLR (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 17 Nov 2008 17:11:17 -0500
In-Reply-To: <8763mmuirz.fsf@aryx.cs.uiuc.edu> (sfid-20081117_224927_421372_B9FEACFC)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Yoann Padioleau <padator@wanadoo.fr>
Cc: linux-sparse@vger.kernel.org

On Mon, 2008-11-17 at 15:47 -0600, Yoann Padioleau wrote:

> Is it possible by using the __attribute((context(x,y)) sparse
> attribute to enforce statically that all the callers of 
> certain functions do certain actions such as disabling interrupts ?

In theory yes, but only half my patches got merged so no. If you search
the list you'll find a set of patches from myself that allow you to do
this, see below.

I have asked that those patches that got merged are reverted for the
time being until we can work on a decent implementation, but that hasn't
happen either so the current sparse git tree is fairly broken wrt.
context attributes...

> int __assume_disabled_interrupt    
> startpoint() 
> {
> 	return 1;
> }
> 
> 
> int f1ok()
> {
> 	spin_lock_irq();
> 	startpoint();
> 	spin_unlock_irq();
> }
> 
> 
> int f1bad()
> {
> 	startpoint();
> }

You'd have to annotate startpoint() with
__attribute__((context(irqsoff,1,1)))

and spin_lock_irq() with __attribute__((context(irqsoff,0,1))) and 1,0
for unlock, in addition to the regular locks.

[or something like that, the syntax isn't firm in my mind right now]

johannes

