Return-Path: <SRS0=rEfk=C2=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D427C433E2
	for <linux-sparse@archiver.kernel.org>; Thu, 17 Sep 2020 11:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B29221D7F
	for <linux-sparse@archiver.kernel.org>; Thu, 17 Sep 2020 11:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgIQLmz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 17 Sep 2020 07:42:55 -0400
Received: from mailout02.rmx.de ([62.245.148.41]:51806 "EHLO mailout02.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbgIQLmr (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Sep 2020 07:42:47 -0400
X-Greylist: delayed 2019 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 07:42:44 EDT
Received: from kdin02.retarus.com (kdin02.dmz1.retloc [172.19.17.49])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout02.rmx.de (Postfix) with ESMTPS id 4BsZ3H4mTgzNr2s
        for <linux-sparse@vger.kernel.org>; Thu, 17 Sep 2020 13:08:59 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin02.retarus.com (Postfix) with ESMTPS id 4BsZ3H0fpXz2TTLj
        for <linux-sparse@vger.kernel.org>; Thu, 17 Sep 2020 13:08:59 +0200 (CEST)
Received: from n95hx1g2.localnet (192.168.54.80) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 17 Sep
 2020 13:08:59 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-sparse@vger.kernel.org>
CC:     Christian Eggers <ceggers@arri.de>
Subject: Segmentation fault when running sparse with current linux master
Date:   Thu, 17 Sep 2020 13:08:57 +0200
Message-ID: <1832426.vqaiCtIcaR@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.80]
X-RMX-ID: 20200917-130859-4BsZ3H0fpXz2TTLj-0@kdin02
X-RMX-SOURCE: 217.111.95.66
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Build of the current linux kernel breaks on my system due to segmentation fault when running sparse.

Sparse version: 0.6.2 (built by openSUSE build service)

Command line:
sparse -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ -Wbitwise -Wno-return-void -Wno-unknown-attribute -D__ARMEL__ -D__arm__ --arch=arm -mlittle-endian -m32 -Wp,-MMD,kernel/time/.timekeeping.o.d -nostdinc -isystem /opt/orbiter-tiny/3.1.1/sysroots/x86_64-pokysdk-linux/usr/lib/arm-poky-linux-gnueabi/gcc/arm-poky-linux-gnueabi/9.3.0/include -I/home/eggers/Projekte/jupiter/linux/linux-stable-rt/arch/arm/include -I./arch/arm/include/generated -I/home/eggers/Projekte/jupiter/linux/linux-stable-rt/include -I./include -I/home/eggers/Projekte/jupiter/linux/linux-stable-rt/arch/arm/include/uapi -I./arch/arm/include/generated/uapi -I/home/eggers/Projekte/jupiter/linux/linux-stable-rt/include/uapi -I./include/generated/uapi -include /home/eggers/Projekte/jupiter/linux/linux-stable-rt/include/linux/kconfig.h -include /home/eggers/Projekte/jupiter/linux/linux-stable-rt/include/linux/compiler_types.h -D__KERNEL__ -mlittle-endian -DKBUILD_EXTRA_WARN1 -Wall -Wundef -Werror=strict-prototypes -Wno-t
 rigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=implicit-function-declaration -Werror=implicit-int -Wno-format-security -std=gnu89 -fno-dwarf2-cfi-asm -fno-ipa-sra -mabi=aapcs-linux -mfpu=vfp -funwind-tables -mthumb -Wa,-mimplicit-it=always -Wa,-mno-warn-deprecated -D__LINUX_ARM_ARCH__=7 -march=armv7-a -msoft-float -Uarm -fno-delete-null-pointer-checks -Wno-frame-address -Wno-format-truncation -Wno-format-overflow -Wno-address-of-packed-member -Os --param=allow-store-data-races=0 -Wframe-larger-than=1024 -fno-stack-protector -Wno-unused-but-set-variable -Wimplicit-fallthrough -Wno-unused-const-variable -fomit-frame-pointer -fno-var-tracking-assignments -g -gdwarf-4 -Wdeclaration-after-statement -Wvla -Wno-pointer-sign -Wno-stringop-truncation -Wno-array-bounds -Wno-stringop-overflow -Wno-restrict -Wno-maybe-uninitialized -fno-strict-overflow -fno-merge-all-constants -fmerge-constants -fno-stack-check -fconserve-stack -Werror=date-time -Werror=incompatible-po
 inter-types -Werror=designated-init -fmacro-prefix-map=/home/eggers/Projekte/jupiter/linux/linux-stable-rt/= -Wno-packed-not-aligned -Wextra -Wunused -Wno-unused-parameter -Wmissing-declarations -Wmissing-format-attribute -Wmissing-prototypes -Wold-style-definition -Wmissing-include-dirs -Wunused-but-set-variable -Wunused-const-variable -Wpacked-not-aligned -Wstringop-truncation -Wno-missing-field-initializers -Wno-sign-compare -Wno-type-limits --sysroot=/opt/orbiter-tiny/3.1.1/sysroots/cortexa7t2hf-neon-vfpv4-poky-linux-musleabi -W -I /home/eggers/Projekte/jupiter/linux/linux-stable-rt/kernel/time -I ./kernel/time -DKBUILD_MODFILE='"kernel/time/timekeeping"' -DKBUILD_BASENAME='"timekeeping"' -DKBUILD_MODNAME='"timekeeping"' /home/eggers/Projekte/jupiter/linux/linux-stable-rt/kernel/time/timekeeping.c

(gdb) backtrace 
#0  sset_test (idx=110, s=0x55a4fb42e440) at sset.h:43
#1  sset_testset (idx=110, s=0x55a4fb42e440) at sset.h:50
#2  ssa_convert_one_var (var=0x7f6cb181b548, ep=0x0) at ssa.c:210
#3  ssa_convert (ep=ep@entry=0x7f6cb1ca81d0) at ssa.c:395
#4  0x000055a4f9e93b61 in optimize (ep=ep@entry=0x7f6cb1ca81d0) at optimize.c:64
#5  0x000055a4f9e939f6 in linearize_fn (base_type=<optimized out>, sym=<optimized out>) at linearize.c:2516
#6  linearize_symbol (sym=<optimized out>) at linearize.c:2531
#7  0x000055a4f9e86f70 in check_symbols (list=0x7f6cb08e9890) at sparse.c:317
#8  0x000055a4f9e86a5d in main (argc=<optimized out>, argv=<optimized out>) at sparse.c:343

(gdb) print *s
$1 = {nbr = 0, off = 137, size = 30, sets = 0x55a4fb42e44c}

(gdb) info locals 
__idx = 4294967269
n = <optimized out>
__idx = <optimized out>
n = <optimized out>

So it looks like the sset is accessed with an invalid index.

regards
Christian



