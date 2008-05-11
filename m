From: David Brownell <david-b@pacbell.net>
Subject: Re: sparse context warning problem ...
Date: Sat, 10 May 2008 20:18:13 -0700
Message-ID: <200805102018.13358.david-b@pacbell.net>
References: <200805101724.04014.david-b@pacbell.net> <1210466447.3646.3.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:27510 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752724AbYEKDSP (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 10 May 2008 23:18:15 -0400
In-Reply-To: <1210466447.3646.3.camel@johannes.berg>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-sparse@vger.kernel.org

On Saturday 10 May 2008, Johannes Berg wrote:
> This is probably my mistake.
> 
> However, I took __releases and __acquires to mean that this function
> *changed* the context, doing both doesn't really make much sense. I
> think the function should actually be declared
> 
> static void
> finish_urb(...)
> __requires(ohci->lock)
> {...}
> 
> where __requires is (for sparse) defined as
> 
> #define __requires(x) __attribute__((context(x,1,1)))

ISTR suggesting special syntax for this to Linus (this was way
back when "sparse" was just starting) and he wanted to just do
it by having those two attributes.

So at this point, I'd want to see the regression fixed (and the
tests updated to avoid this in the future) before exploring any
alternative syntax for kernel annotations.


On the plus side, having syntax *IS* more general.  It can serve
as an annotation that the function requires particular locking
context, whether or not that context is explicitly accessed.

- Dave



> It's probably possible to merge the __acquires and __releases into one
> though.


