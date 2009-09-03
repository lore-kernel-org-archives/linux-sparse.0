From: Belisko Marek <marek.belisko@gmail.com>
Subject: sparse: flow.c:804: rewrite_parent_branch: Asparse: flow.c:804:
	rewrite_parent_branch: Assertion `changed' failed.
Date: Thu, 3 Sep 2009 11:49:56 +0200
Message-ID: <e7c6a05e0909030249qb5dac77u35293c4d857bba0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:3279 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754820AbZICJt4 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 3 Sep 2009 05:49:56 -0400
Received: by fg-out-1718.google.com with SMTP id 22so683996fge.1
        for <linux-sparse@vger.kernel.org>; Thu, 03 Sep 2009 02:49:58 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

current linux-next tree compiled with make C=1 all >build.out 2>&1
produce following error.

sparse: flow.c:804: rewrite_parent_branch: Assertion `changed' failed.
/bin/sh: line 1: 19625 Aborted                 sparse -D__linux__
-Dlinux -D__STDC__ -Dunix -D__unix__ -Wbitwise -Wno-return-void
-D__i386_
_ -nostdinc -isystem /usr/lib/gcc/i586-suse-linux/4.3/include
-Wp,-MD,kernel/trace/.ring_buffer_benchmark.o.d -nostdinc -isystem
/usr/lib/g
cc/i586-suse-linux/4.3/include -Iinclude
-I/home/marek.nandra/kernel/linux-next/arch/x86/include -include
include/linux/autoconf.h -D__KERN
EL__ -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs
-fno-strict-aliasing -fno-common -Werror-implicit-function-declaration
-Wno-format-se
curity -fno-delete-null-pointer-checks -Os -m32 -msoft-float
-mregparm=3 -freg-struct-return -mpreferred-stack-boundary=2
-march=i486 -Wa,-
mtune=generic32 -ffreestanding -fstack-protector -fstack-protector-all
-DCONFIG_AS_CFI=1 -DCONFIG_AS_CFI_SIGNAL_FRAME=1 -pipe -Wno-sign-com
pare -fno-asynchronous-unwind-tables -mno-sse -mno-mmx -mno-sse2
-mno-3dnow -fno-omit-frame-pointer -fno-optimize-sibling-calls -g
-Wdeclar
ation-after-statement -Wno-pointer-sign -fno-strict-overflow
-fprofile-arcs -ftest-coverage -DMODULE -D"KBUILD_STR(s)=#s"
-D"KBUILD_BASENAM
E=KBUILD_STR(ring_buffer_benchmark)"
-D"KBUILD_MODNAME=KBUILD_STR(ring_buffer_benchmark)" -D"DEBUG_HASH=55"
-D"DEBUG_HASH2=35" kernel/trace
/ring_buffer_benchmark.c
make[2]: *** [kernel/trace/ring_buffer_benchmark.o] Error 134
make[1]: *** [kernel/trace] Error 2
make: *** [kernel] Error 2


-- 
as simple as primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
icq: 290551086
web: http://open-nandra.com
