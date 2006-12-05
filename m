From: Ulrich Kunitz <kune@deine-taler.de>
Subject: sparse 0.2 - incomprehensible context warnings
Date: Tue, 5 Dec 2006 23:07:10 +0100
Message-ID: <20061205220710.GA12614@p15091797.pureserver.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from deine-taler.de ([217.160.107.63]:57900 "EHLO
	p15091797.pureserver.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760184AbWLEWHM (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 5 Dec 2006 17:07:12 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

I have tried sparse 0.2 for the zd1211rw WLAN driver, which I
happen to contribute too.

I get numerous context imbalance warnings, that I don't
understand. This is on an SMP (x86-64) build of a vanilla 2.6.19.
I get the same warning on an SMP build of PPC32.

A simple example is:

/home/kunitz/zd1211/rw/zd_usb.c:1167:13: warning: context imbalance in 'disable_read_regs_int' - wrong count at exit

zd_usb.c
1167 static void disable_read_regs_int(struct zd_usb *usb)
1168 {
1169         struct zd_usb_interrupt *intr = &usb->intr;
1170
1171         spin_lock_irq(&intr->lock);
1172         intr->read_regs_enabled = 0;
1173         spin_unlock_irq(&intr->lock);
1174 }

Please set me on CC of the answer I'm not a regular reader of this
list.

You will find the driver source in the kernel itself. I tested it
however against my latest git tree, which is available from

git-clone http://deine-taler.de/zd1211/zd1211.git

-- 
Uli Kunitz
