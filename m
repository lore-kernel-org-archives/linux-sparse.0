From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] sparse: Increase pre_buffer[] and check overflow
Date: Thu, 10 Jul 2008 18:39:45 +0100
Message-ID: <20080710173945.GE28946@ZenIV.linux.org.uk>
References: <20080709.002805.128619748.anemo@mba.ocn.ne.jp> <20080708204547.GA16742@uranus.ravnborg.org> <20080710.011818.26096759.anemo@mba.ocn.ne.jp> <20080709163212.GA1227@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:43188 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887AbYGJRjt (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 10 Jul 2008 13:39:49 -0400
Content-Disposition: inline
In-Reply-To: <20080709163212.GA1227@uranus.ravnborg.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-sparse@vger.kernel.org, linux-mips@linux-mips.org

On Wed, Jul 09, 2008 at 06:32:12PM +0200, Sam Ravnborg wrote:
> So the expalnation seems that gcc for mips define much more
> than the usual gcc does.
> My gcc define 76 symbols for i386.
> 
> And we use this stuff in the kernel.

How much of it do we really use?  Let's see - on i386 gcc-4.1.2 I see
79 symbols.  64 simply never occur in the tree.  At all.  Out of remaining
15, we have

__GNUC__, __GNUC_MAJOR__, __GNUC_PATCHLEVEL__ - provided by sparse.
__STDC__: few users, provided by sparse.
__SIZE_TYPE__: one odd user, defined by sparse anyway
__PTRDIFF_TYPE__: one odd user, defined by sparse anyway

__linux__ - few users, explicitly added in top-level Makefile
linux - 3 users.  Defined in top-level Makefile.
unix - no real users (some instances, of course, but none outside of comments,
#include pathnames and string constants).  Defined in top-level Makefile,
anyway.

__USER_LABEL_PREFIX__, __REGISTER_PREFIX__ - arch/m68knommu/lib/*.S; not
a sparse fodder anyway *and* defaults are given in files themselves.

__ELF__: arch/alpha/boot/tools/objstrip.c (userland helper, actually, *and*
misplaced there; it's used as a proxy for type of kernel image)

__i386__: a bunch
__i386: one user, redundant (__i386__ *and* i386 in the same #if)
i386: 3 users besides the aforementioned one.

So...  Only 3 symbols out of the entire bunch are arch-dependent *and* not
provided by sparse itself.  Absolute majority of the rest is never ever
used in the tree.

I very much doubt that mips situation is seriously different...
