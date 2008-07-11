From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] sparse: Increase pre_buffer[] and check overflow
Date: Sat, 12 Jul 2008 01:07:21 +0900 (JST)
Message-ID: <20080712.010721.18574863.anemo@mba.ocn.ne.jp>
References: <20080710.011818.26096759.anemo@mba.ocn.ne.jp>
	<20080709163212.GA1227@uranus.ravnborg.org>
	<20080710173945.GE28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:54020 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751511AbYGKQFk (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 11 Jul 2008 12:05:40 -0400
In-Reply-To: <20080710173945.GE28946@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: viro@ZenIV.linux.org.uk, ralf@linux-mips.org
Cc: sam@ravnborg.org, linux-sparse@vger.kernel.org, linux-mips@linux-mips.org

On Thu, 10 Jul 2008 18:39:45 +0100, Al Viro <viro@ZenIV.linux.org.uk> wrote:
> So...  Only 3 symbols out of the entire bunch are arch-dependent *and* not
> provided by sparse itself.  Absolute majority of the rest is never ever
> used in the tree.
> 
> I very much doubt that mips situation is seriously different...

Then, how about this?  Ralf, is this filter reasonable?


Subject: [PATCH] mips: reduce symbols passed to CHECKFLAGS

Without this patch, gcc 4.3 will produces so many symbols and causes
pre_buffer[] overflow in sparse.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index d319cd6..6c4eb9f 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -619,7 +619,7 @@ LDFLAGS			+= -m $(ld-emul)
 
 ifdef CONFIG_MIPS
 CHECKFLAGS += $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -xc /dev/null | \
-	egrep -vw '__GNUC_(|MINOR_|PATCHLEVEL_)_' | \
+	egrep '(MIPS|mips|_ABI|_TYPE__)' | \
 	sed -e 's/^\#define /-D/' -e "s/ /='/" -e "s/$$/'/")
 ifdef CONFIG_64BIT
 CHECKFLAGS		+= -m64
