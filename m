From: David Brownell <david-b@pacbell.net>
Subject: sparse context warning problem ...
Date: Sat, 10 May 2008 17:24:03 -0700
Message-ID: <200805101724.04014.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:36594 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750968AbYEKAap (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 10 May 2008 20:30:45 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

I just noticed this with some obviously correct code... and verified
that it's a regression in current GIT version of "sparse" since it
now rejects code which previously passed just fine.

The issue is a not-uncommon idiom, where a function must be called
with a lock held, and briefly drops it.  The way this has previously
been addressed, originally suggested by Linus and used in various
places in the kernel (but, I observe, not in the "sparse" internal
validation test cases) is:

  static void
  finish_urb(struct ohci_hcd *ohci, struct urb *urb, int status)
  __releases(ohci->lock)
  __acquires(ohci->lock)
  {
	...
  }

But current versions of "sparse" complain (wrongly):

  drivers/usb/host/ohci-q.c:66:2: warning: context imbalance in 'finish_urb': __context__ statement expected different context
  drivers/usb/host/ohci-q.c:66:2:    context '<noident>': wanted >= 0, got -1

Presumably this is this a known bug ... is a fix on the way?
(Meanwhile, I can just ignore this bogus output.)

- Dave

