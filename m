From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH 2/2] Simplify (and warn about) right shifts that result
	in zero
Date: Thu, 24 Apr 2008 20:34:30 -0400
Message-ID: <1209083670.12561.68.camel@dv>
References: <20080424193856.14737.16718.stgit@warthog.procyon.org.uk>
	 <alpine.LFD.1.10.0804241248290.2779@woody.linux-foundation.org>
	 <alpine.LFD.1.10.0804241443460.2779@woody.linux-foundation.org>
	 <alpine.LFD.1.10.0804241452250.2779@woody.linux-foundation.org>
	 <1209081131.12561.45.camel@dv>
	 <alpine.LFD.1.10.0804241658520.2779@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:8142 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753008AbYDYAed (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 Apr 2008 20:34:33 -0400
In-Reply-To: <alpine.LFD.1.10.0804241658520.2779@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-sparse@vger.kernel.org, Josh Triplett <josh@freedesktop.org>

On Thu, 2008-04-24 at 17:03 -0700, Linus Torvalds wrote:

> Heh. That does look like somebody is shifting the wrong way, and 
> apparently the new warning was worth something ;)

Yes, definitely.  The patch is on the way to linux-wireless.  Losing 24
bits of entropy in the initialization vector is not good, to put it
mildly.

The only other "shift" warning in the kernel for my configuration
indicates dead code in drivers/serial/serial_core.c:

tmp.port_high = (long) port->iobase >> HIGH_BITS_OFFSET;

HIGH_BITS_OFFSET is 32 bit on 64-bit systems, and port->iobase is always
int.  On 32-bit systems, HIGH_BITS_OFFSET is 0 and the code would not be
executed.  The code predates the dawn of git.  The whole thing needs
some serious cleanup, but apart from that, the warning appears to be
harmless.

There are no more warnings mentioning "shift", and the only two warnings
are useful, or which one may be a serious bug.  That's a pretty good
result!

-- 
Regards,
Pavel Roskin
