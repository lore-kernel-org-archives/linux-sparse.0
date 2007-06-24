From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH 16/16] fix handling of integer constant expressions
Date: Sun, 24 Jun 2007 20:10:07 +0100
Message-ID: <20070624191007.GC21478@ftp.linux.org.uk>
References: <E1I2N6V-0003g9-8H@ZenIV.linux.org.uk> <20070624174732.GZ21478@ftp.linux.org.uk> <200706242007.10585.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:33651 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841AbXFXTKJ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 24 Jun 2007 15:10:09 -0400
Content-Disposition: inline
In-Reply-To: <200706242007.10585.arnd@arndb.de>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org

On Sun, Jun 24, 2007 at 08:07:10PM +0200, Arnd Bergmann wrote:
> One minor issue though:
> While BUILD_BUG_ON and a few other macros in linux/kernel.h are currently
> exported to user space, I would think that they should really be hidden
> in #ifdef __KERNEL__, which means that we also need something like
> 
> #ifdef __KERNEL__
> #define _IOC_TYPECHECK(t) \
>         (sizeof(t) + BUILD_BUG_ON_ZERO(sizeof(t) == sizeof(t[1]) && \
>           sizeof(t) < (1 << _IOC_SIZEBITS)))
> #else
> #define _IOC_TYPECHECK(t) sizeof(t)
> #endif

Point, but then we might want to export the damn thing in properly
named version (i.e. put it into __.... reserved namespace).  It
doesn't depend on anything kernel-specific...

FWIW, the current version suffers from similar problem - it's outside
of __KERNEL__ in userland-exported header and it can lead to breakage
when included in build by something other than gcc...
