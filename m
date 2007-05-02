From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: sparse -Wptr-subtraction-blows: still needed?
Date: Wed, 2 May 2007 13:02:04 +0100
Message-ID: <20070502130204.2cc2fd1a@the-village.bc.nu>
References: <4637AC3D.6000008@freedesktop.org>
	<alpine.LFD.0.98.0705011442320.3808@woody.linux-foundation.org>
	<4637D47D.7040203@freedesktop.org>
	<alpine.LFD.0.98.0705011719520.3808@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50453 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S2993054AbXEBL7P (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 2 May 2007 07:59:15 -0400
In-Reply-To: <alpine.LFD.0.98.0705011719520.3808@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro <viro@ftp.linux.org.uk>

On Tue, 1 May 2007 17:24:54 -0700 (PDT)
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> 
> On Tue, 1 May 2007, Josh Triplett wrote:
> > 
> > Do you know whether the current version of GCC generates poor code for pointer
> > subtraction?
> 
> You _cannot_ generate good code.
> 
> When you subtract two pointers, the C definition means that you first 
> subtract the values (cheap), and then you *divide* the result by the size 
> of the object the pointer points to (expensive!).

Good compilers even in the 1990's would defer the divide and try and
propogate it out as a multiply the other side for constants, and they'll
also use shifts when possible.

Thus they'll turn

	(ptr.element - base.element) < NELEM

into
	(ptr.char - base.char) < (constant) [NELEM *sizeof(element) ]


at least for constant operations. Dunno if gcc is that clever

Alan
