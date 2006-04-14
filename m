From: Judith Lebzelter <judith@osdl.org>
Subject: 'old compiler' warning in sparse output
Date: Fri, 14 Apr 2006 11:16:47 -0700
Message-ID: <20060414181647.GD1021@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:20420 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751379AbWDNSQz (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 14 Apr 2006 14:16:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3EIGltH021748
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-sparse@vger.kernel.org>; Fri, 14 Apr 2006 11:16:50 -0700
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: bryce@osdl.org

Hello, 

I am trying to run sparse on the linux kernel build using a compiler 
that is not my default compiler, but am having problems with it using 
the default(old) include files.

I set the environment up as I would for compiling the kernel:
export ARCH=i386
export CROSS_COMPILE=i686-unknown-linux-gnu-
export PATH=$PATH:/var/crosstool/gcc-3.4.4-glibc-2.3.5/i686-unknown-linux-gnu/bin

Then I run the make:
make C=2 all 2>&1

But it gives warnings which show (by the path) that the sparse is looking at 
the wrong include files:
/usr/lib/gcc-lib/i586-suse-linux/3.3.4/include/stdarg.h:53:34: warning: undefined preprocessor identifier '__STDC_VERSION__'
include/linux/compiler.h:46:3: warning: Sorry, your compiler is too old/not recognized.

Yet, when I see the sparse command actually running, it appears as though it 
should be looking at the correct compiler, gcc-3.4.4:

plm@plm-000:~/scratch/5> ps -ef 
plm      28340 28339  0 10:35 pts/0    00:00:00  sparse -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ -Wbitwise -D__i386__ -nostdinc -isystem /var/crosstool/gcc-3.4.4-glibc-2.3.5/i686-unknown-linux-gnu/bin/../lib/gcc/i686-unknown-linux-gnu/3.4.4/include -Wp,-MD,arch/i386/kernel/cpu/.cyrix.o.d -nostdinc -isystem /var/crosstool/gcc-3.4.4-glibc-2.3.5/i686-unknown-linux-gnu/bin/../lib/gcc/i686-unknown-linux-gnu/3.4.4/include -D__KERNEL__ -Iinclude -include include/linux/autoconf.h -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestanding -O2 -fomit-frame-pointer -pipe -msoft-float -mpreferred-stack-boundary=2 -fno-unit-at-a-time -march=i686 -Iinclude/asm-i386/mach-default -Wdeclaration-after-statement -DKBUILD_STR(s) #s -DKBUILD_BASENAME KBUILD_STR(cyrix) -DKBUILD_MODNAME KBUILD_STR(cyrix) arch/i386/kernel/cpu/cyrix.c

I am using sparse git-snapshot-20051028.  

Do I need to set some other setting or options to get it to look in the 
desired include directory?

Thanks,
Judith
