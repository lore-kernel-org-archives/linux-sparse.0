From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH 1/2] sparse, llvm: Make function declaration
 accessible to backend
Date: Thu, 02 Feb 2012 12:22:04 +1100
Message-ID: <1328145724.28487.95.camel@pasglop>
References: <1328090152-28299-1-git-send-email-penberg@kernel.org>
	 <CANeU7Q=3mA3sjaj+rV=79qZxM_bYxDBUdMV4dECHprpKzey1Lg@mail.gmail.com>
	 <4F29E0E1.3000504@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:60179 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753047Ab2BBBW0 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 1 Feb 2012 20:22:26 -0500
In-Reply-To: <4F29E0E1.3000504@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Christopher Li <sparse@chrisli.org>, Pekka Enberg <penberg@kernel.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Jeff Garzik <jgarzik@redhat.com>

On Wed, 2012-02-01 at 20:03 -0500, Jeff Garzik wrote:
> On 02/01/2012 07:09 PM, Christopher Li wrote:
> > Ok, this patch definitely works. However, I think there is ways to get the
> > type without this patch. The more general question is, how to get type of
> > any given pseudo register.
> 
> 
> That is useful, yes.  But it does not address this specific problem.
> 
> We need the function declaration remembered, rather than what we have 
> now -- a list of arguments with full type information, specific to its 
> callsite.
> 
> You cannot deduce that a function call is/not varargs presently, even 
> with a working pseudo->type setup.
> 
> varargs is just one of those annoying areas where the compiler needs to 
> have rather specific knowledge, in order to properly construct a call

And there could be more. For example specific attributes on the
declaration may affect the ABI for the call (think asmlinkage or good
old pascal calling conventions on old macos :-)

Not something we absolutely need to sort out right now but another
reason why we really need to base the LLVM side definition based on the
declaration.

I'll try to toy a bit more this week-end see if the patches work for all
cases I can think of. We really have two different things (represented
by the two different hunks) which we might try to better factor:

The case of a function call where we are after the declaration, and the
case of creating an llvm type containing a function pointer (which can
happen as part of the first one if an argument is a function pointer)
for which we are looking at the base_type.

We should at least make it a single piece of code that takes a symbol
and shoots out a llvm ref.

Cheers,
Ben.


