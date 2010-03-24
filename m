From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: segfault in sparse snapshot 2010-02-13
Date: Wed, 24 Mar 2010 12:36:22 -0700
Message-ID: <20100324193622.GC4331@feather>
References: <20100324104144.0817c22b.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:35759 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932884Ab0CXTg6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Mar 2010 15:36:58 -0400
Received: from relay4-v.mail.gandi.net (relay4-v.mail.gandi.net [217.70.178.78])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id 2910438116
	for <linux-sparse@vger.kernel.org>; Wed, 24 Mar 2010 20:36:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100324104144.0817c22b.rdunlap@xenotime.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: linux-sparse@vger.kernel.org

On Wed, Mar 24, 2010 at 10:41:44AM -0700, Randy Dunlap wrote:
> (snapshot from Dave Jones:
>   http://www.codemonkey.org.uk/projects/git-snapshots/sparse/ )
> 
> 
> In the linux-next-20100324 or akpm's kernel patchset (mmotm-2010-03-23),
> sparse segfaults when checking net/bridge/br_fdb.c. (does not happen in
> Linus's mainline kernel tree)
> 
> 
> The last messages are:
> 
> net/bridge/br_fdb.c:225:9: error: no member 'hash' in struct net_bridge
> net/bridge/br_fdb.c:225:9: error: incompatible types for operation (+)
> net/bridge/br_fdb.c:225:9:    left side has type bad type
> net/bridge/br_fdb.c:225:9:    right side has type int
> net/bridge/br_fdb.c:225:9: error: cannot dereference this type
> /bin/sh: line 1: 28041 Segmentation fault      sparse -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ -Wbitwise -Wno-return-void -D__x86_64__ -m64 -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/4.4.1/include -Wp,-MD,net/bridge/.br_fdb.o.d -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/4.4.1/include -I/lnx/src/NEXT/linux-next-20100324/arch/x86/include -Iinclude -I/lnx/src/NEXT/linux-next-20100324/include -include include/generated/autoconf.h -I/lnx/src/NEXT/linux-next-20100324/net/bridge -Inet/bridge -D__KERNEL__ -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -O2 -m64 -mtune=generic -mno-red-zone -mcmodel=kernel -funit-at-a-time -maccumulate-outgoing-arg
 s -fstack-protector -fno-builtin-memcpy -DCONFIG_AS_CFI=1 -DCONFIG_AS_CFI_SIGNAL_FRAME=1 -pipe -Wno-sign-compare -fno-asynchronous-unwind-tables -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -Wframe-
>  larger-than=2048 -fno-omit-frame-pointer -fno-optimize-sibling-calls -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fconserve-stack -fprofile-arcs -ftest-coverage -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(br_fdb)" -D"KBUILD_MODNAME=KBUILD_STR(bridge)" -D"DEBUG_HASH=21" -D"DEBUG_HASH2=11" /lnx/src/NEXT/linux-next-20100324/net/bridge/br_fdb.c
> make[3]: *** [net/bridge/br_fdb.o] Error 139

Ouch.

Can you attach a preprocessed source .i file that reproduces the
problem? "make net/bridge/br_fdb.i" should work.

- Josh Triplett
