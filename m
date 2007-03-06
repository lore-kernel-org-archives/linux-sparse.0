From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse segfault in kernel -mm tree
Date: Mon, 5 Mar 2007 18:33:51 -0800
Message-ID: <20070306023351.GB31138@chrisli.org>
References: <20070305175322.cbe0bb66.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from alnrmhc14.comcast.net ([206.18.177.54]:50788 "EHLO
	alnrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933890AbXCFDI3 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 5 Mar 2007 22:08:29 -0500
Content-Disposition: inline
In-Reply-To: <20070305175322.cbe0bb66.rdunlap@xenotime.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: linux-sparse@vger.kernel.org

Hmm, It does not happen on tip of git tree even on 64bit boxes.

I can't reproduce it with a script that copy your command line
for mm1 tree either. I need to modify the gcc include path.
But after that it pass fine.

Can you send me your .config file?

If you have other ways to narrow down the bug that will be great.

Sorry I am out of luck to reproduce it.

Chris


On Mon, Mar 05, 2007 at 05:53:22PM -0800, Randy Dunlap wrote:
> Hi,
> 
> sparse (latest git tarball from DaveJones) segfaults when
> checking the 2.6.21-rc2-mm1 tree:
> 
> 
>   CHECK   drivers/net/vioc/vioc_provision.c
> /bin/sh: line 1:  4021 Segmentation fault      sparse -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ -Wbitwise -D__x86_64__ -m64 -nostdinc -isystem /usr/lib64/gcc/x86_64-suse-linux/4.1.0/include -Wp,-MD,drivers/net/vioc/.vioc_provision.o.d -nostdinc -isystem /usr/lib64/gcc/x86_64-suse-linux/4.1.0/include -D__KERNEL__ -Iinclude -include include/linux/autoconf.h -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Os -mtune=generic -m64 -mno-red-zone -mcmodel=kernel -pipe -fno-reorder-blocks -Wno-sign-compare -fno-asynchronous-unwind-tables -funit-at-a-time -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -maccumulate-outgoing-args -DCONFIG_AS_CFI=1 -DCONFIG_AS_CFI_SIGNAL_FRAME=1 -fno-omit-frame-pointer -fno-optimize-sibling-calls -g -fno-stack-protector -Wdeclaration-after-statement -Wno-pointer-sign -DMODULE -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(vioc_
 provision)" -D"KBUILD_MODNAME=KBUILD_STR(vioc)" drivers/net/vioc/vioc_provision.c
> make[3]: *** [drivers/net/vioc/vioc_provision.o] Error 139
> make[2]: *** [drivers/net/vioc] Error 2
> make[1]: *** [drivers/net] Error 2
> make: *** [drivers] Error 2
> 
> sparse[4021]: segfault at 0000000000000050 rip 000000000040fd63 rsp 00007fff6e1cccb0 error 4
> 
> ---
> ~Randy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
