From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: linux kernel warnings/errors
Date: Tue, 23 Feb 2010 12:59:42 -0800
Message-ID: <20100223205942.GA32491@feather>
References: <20100223114906.61d4e001.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:50659 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753874Ab0BWVWv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 23 Feb 2010 16:22:51 -0500
Received: from relay2-v.mail.gandi.net (relay2-v.mail.gandi.net [217.70.178.76])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id A9B5C3B9D4
	for <linux-sparse@vger.kernel.org>; Tue, 23 Feb 2010 22:00:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100223114906.61d4e001.rdunlap@xenotime.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: linux-sparse@vger.kernel.org

On Tue, Feb 23, 2010 at 11:49:06AM -0800, Randy Dunlap wrote:
> Hi,
> 
> You probably know that sparse produces a ton of errors & warnings when
> run on the Linux kernel tree (a little over 1 MB in my latest 'make C=1'
> on x86_64 arch.).
> 
> I'm wondering if all of these are valid.
> 
> Examples:
> 
> 
> 1.  Use of the BUILD_BUG_ON() macro causes this error from sparse:
> 
> arch/x86/kernel/paravirt.c:101:9: error: invalid bitfield width, -1.
> 
> include/linux/kernel.h:
> 
> /* Force a compilation error if condition is true */
> #define BUILD_BUG_ON(condition) ((void)BUILD_BUG_ON_ZERO(condition))
> 
> /* Force a compilation error if condition is true, but also produce a
>    result (of value 0 and type size_t), so the expression can be used
>    e.g. in a structure initializer (or where-ever else comma expressions
>    aren't permitted). */
> #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))

In theory that should only happen if the BUILD_BUG_ON_ZERO actually
triggers, and thus sparse fails to build just as GCC would.  If sparse
has this problem and GCC doesn't, could you please provide a minimal
test case?

> 2.  drivers/block/drbd/drbd_int.h uses __protected_by(var);
> this seems to be unknown to sparse.
> 
> #ifdef __CHECKER__
> # define __protected_by(x)       __attribute__((require_context(x,1,999,"rdwr")))
> 
> sparse says many times:
> 
> drivers/block/drbd/drbd_int.h:887:39: error: attribute 'require_context': unknown attribute

That looks broken.  A few patches went around for new Sparse
context-tracking features, one of which got reverted before the 0.4.2
release, but I don't think any of them would have allowed *that*.

- Josh Triplett
