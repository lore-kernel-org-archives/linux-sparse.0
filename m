From: Roel Kluin <12o3l@tiscali.nl>
Subject: assertion failure in flow.c:804 (changed) building kernel/sched.c
Date: Mon, 03 Mar 2008 14:06:00 +0100
Message-ID: <47CBF7B8.5060303@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp-out0.tiscali.nl ([195.241.79.175]:52091 "EHLO
	smtp-out0.tiscali.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298AbYCCNGE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 3 Mar 2008 08:06:04 -0500
Received: from [82.171.187.43] (helo=[192.168.1.2])
	by smtp-out0.tiscali.nl with esmtp (Tiscali http://www.tiscali.nl)
	id 1JWAMj-0007Td-VI
	for <linux-sparse@vger.kernel.org>; Mon, 03 Mar 2008 14:06:02 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Building the linux kernel (git, linus' tree) with sparse enabled I get the
following assertion failure:

...
/home/roel/dnld/src/kernel/git/linux-2.6/kernel/sched.c:6228:25: error: cannot size expression
/home/roel/dnld/src/kernel/git/linux-2.6/kernel/sched.c:8255:43: error: cannot size expression
sparse: flow.c:804: rewrite_parent_branch: Assertion `changed' failed.
/bin/sh: line 1: 13021 Aborted                 sparse -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ -Wbitwise -D__i386__ -nostdinc -isystem /usr/lib/gcc/i486-slackware-linux/4.1.2/include -Wp,-MD,kernel/.sched.o.d -nostdinc -isystem /usr/lib/gcc/i486-slackware-linux/4.1.2/include -D__KERNEL__ -Iinclude -Iinclude2 -I/home/roel/dnld/src/kernel/git/linux-2.6/include -include include/linux/autoconf.h -I/home/roel/dnld/src/kernel/git/linux-2.6/kernel -Ikernel -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Os -fno-stack-protector -m32 -msoft-float -mregparm=3 -freg-struct-return -mpreferred-stack-boundary=2 -march=i686 -mtune=i686 -ffreestanding -DCONFIG_AS_CFI=1 -DCONFIG_AS_CFI_SIGNAL_FRAME=1 -pipe -Wno-sign-compare -f
 no-asynchronous-unwind-tables -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -I/home/roel/dnld/src/kernel/git/linux-2.6/include/asm-x86/mach-default -Iinclude/asm-x86/mach-default -fno-omit-frame-po
inter -fno-optimize-sibling-calls -g -Wdeclaration-after-statement -Wno-pointer-sign -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(sched)" -D"KBUILD_MODNAME=KBUILD_STR(sched)" /home/roel/dnld/src/kernel/git/linux-2.6/kernel/sched.c
make[2]: *** [kernel/sched.o] Error 134
make[1]: *** [kernel] Error 2
make: *** [sub-make] Error 2
