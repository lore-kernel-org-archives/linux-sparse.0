From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: sparse failure.
Date: Thu, 18 Oct 2007 13:57:01 +0530
Message-ID: <471718D5.2080204@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from E23SMTP03.au.ibm.com ([202.81.18.172]:59928 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756883AbXJRI1O (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 18 Oct 2007 04:27:14 -0400
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id l9I8R3wx028331
	for <linux-sparse@vger.kernel.org>; Thu, 18 Oct 2007 18:27:03 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l9I8T2lX1130632
	for <linux-sparse@vger.kernel.org>; Thu, 18 Oct 2007 18:29:02 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l9I8R3Ax015988
	for <linux-sparse@vger.kernel.org>; Thu, 18 Oct 2007 18:27:03 +1000
Received: from [9.124.35.28] (skywalker.in.ibm.com [9.124.35.28])
	by d23av02.au.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id l9I8R2x1015962
	for <linux-sparse@vger.kernel.org>; Thu, 18 Oct 2007 18:27:03 +1000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

sparse: flow.c:805: rewrite_parent_branch: Assertion `changed' failed.
/bin/sh: line 1: 24220 Aborted                 sparse -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ -Wbitwise -D__CHECK_ENDIAN__ -D__i386__ -nostdinc -isystem /usr/lib/gcc/i386-redhat-linux/4.1.2/include -Wp,-MD,fs/ext4/.mballoc.o.d -nostdinc -isystem /usr/lib/gcc/i386-redhat-linux/4.1.2/include -D__KERNEL__ -Iinclude -include include/linux/autoconf.h -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Os -pipe -msoft-float -mregparm=3 -freg-struct-return -mpreferred-stack-boundary=2 -march=i686 -mtune=pentium3 -mtune=generic -ffreestanding -maccumulate-outgoing-args -DCONFIG_AS_CFI=1 -DCONFIG_AS_CFI_SIGNAL_FRAME=1 -Iinclude/asm-x86/mach-generic -Iinclude/asm-x86/mach-default -fno-omit-frame-pointer -fno-optimize-sibli
 ng-calls -g -fno-stack-protector -Wdeclaration-after-statement -Wno-pointer-sign -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(mballoc)" -D"KBUILD_MODNAME=KBUILD_STR(ext4dev)" fs/ext4/m
balloc.c
make[1]: *** [fs/ext4/mballoc.o] Error 134
make: *** [fs/ext4/] Error 2
[kvaneesh@llm59 linux-2.6.23-rc8]$ 
