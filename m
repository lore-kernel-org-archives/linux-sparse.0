From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse 0.2 - incomprehensible context warnings
Date: Wed, 31 Jan 2007 15:06:23 -0800
Message-ID: <20070131230623.GA28548@chrisli.org>
References: <20061205220710.GA12614@p15091797.pureserver.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sccrmhc15.comcast.net ([63.240.77.85]:53167 "EHLO
	sccrmhc15.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161080AbXAaXcx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 31 Jan 2007 18:32:53 -0500
Content-Disposition: inline
In-Reply-To: <20061205220710.GA12614@p15091797.pureserver.info>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ulrich Kunitz <kune@deine-taler.de>
Cc: linux-sparse@vger.kernel.org

It has been a while. I find out why during this happen during
I debugging my other interrupt checker.

_spin_unlock_irq() is a macro which will expand to __raw_spin_unlock(),
which inline into a function. But _spin_lock_irq is an external function
which does not inline.

So sparse only sees the unlock, it can't see the locking.

Chris

On Tue, Dec 05, 2006 at 11:07:10PM +0100, Ulrich Kunitz wrote:
> Hi,
> 
> I have tried sparse 0.2 for the zd1211rw WLAN driver, which I
> happen to contribute too.
> 
> I get numerous context imbalance warnings, that I don't
> understand. This is on an SMP (x86-64) build of a vanilla 2.6.19.
> I get the same warning on an SMP build of PPC32.
> 
> A simple example is:
> 
> /home/kunitz/zd1211/rw/zd_usb.c:1167:13: warning: context imbalance in 'disable_read_regs_int' - wrong count at exit
> 
> zd_usb.c
> 1167 static void disable_read_regs_int(struct zd_usb *usb)
> 1168 {
> 1169         struct zd_usb_interrupt *intr = &usb->intr;
> 1170
> 1171         spin_lock_irq(&intr->lock);
> 1172         intr->read_regs_enabled = 0;
> 1173         spin_unlock_irq(&intr->lock);
> 1174 }
> 
> Please set me on CC of the answer I'm not a regular reader of this
> list.
> 
> You will find the driver source in the kernel itself. I tested it
> however against my latest git tree, which is available from
> 
> git-clone http://deine-taler.de/zd1211/zd1211.git
> 
> -- 
> Uli Kunitz
> -
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
