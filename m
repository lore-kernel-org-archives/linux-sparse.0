From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] Re: LLVM and PSEUDO_REG/PSEUDO_PHI
Date: Mon, 29 Aug 2011 09:16:40 -0700
Message-ID: <20110829161640.GA23515@leaf>
References: <alpine.DEB.2.00.1108252046090.6272@localhost6.localdomain6>
 <CA+55aFxRkS4HLeW18-q+4Co7kRdiQBv4wnD=GX5ymAGigXR3MQ@mail.gmail.com>
 <alpine.DEB.2.00.1108252107210.6272@localhost6.localdomain6>
 <4E58731A.7010708@garzik.org>
 <alpine.DEB.2.00.1108271104440.2570@localhost6.localdomain6>
 <4E58AE9E.1090601@garzik.org>
 <4E59478C.9000504@garzik.org>
 <alpine.DEB.2.00.1108280815530.2734@localhost6.localdomain6>
 <4E5A129F.1090801@garzik.org>
 <alpine.DEB.2.00.1108291741350.12047@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:60234 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753973Ab1H2QQs (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 29 Aug 2011 12:16:48 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1108291741350.12047@localhost6.localdomain6>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@linux-foundation.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Mon, Aug 29, 2011 at 05:42:49PM +0300, Pekka Enberg wrote:
> On Sun, 28 Aug 2011, Jeff Garzik wrote:
> >* it will soon be necessary to pay more attention to
> >target-specific details. we need some mechanism for specifying
> >i386, x86-64, etc. so that we may fill in bits_in_pointer and
> >similar values properly.  This may involve some sparse hacking
> >IIRC, because sparse (used to be?) largely hardcoded to use i386
> >target values when checking.  Or maybe this is already done, and I
> >just am ignorant of that area of the code.
> 
> Can you think of anything else except target.c that needs to be
> fixed in sparse?

Take a look at the cgcc script.  Most of what it does to handle
target-specific information should occur in sparse instead.

- Josh Triplett
