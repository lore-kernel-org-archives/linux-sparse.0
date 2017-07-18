From: Michael Stefaniuc <mstefani@mykolab.com>
Subject: Infinite loop with OOM while testing Sparse on Wine code
Date: Tue, 18 Jul 2017 16:47:46 +0200
Message-ID: <a4d23510-5bd4-9d88-f7a8-731882744043@mykolab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx.kolabnow.com ([95.128.36.42]:2130 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751409AbdGROzh (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 18 Jul 2017 10:55:37 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 67A14112A
        for <linux-sparse@vger.kernel.org>; Tue, 18 Jul 2017 16:47:58 +0200 (CEST)
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wz79QoEoloFI for <linux-sparse@vger.kernel.org>;
        Tue, 18 Jul 2017 16:47:57 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id F18D2312
        for <linux-sparse@vger.kernel.org>; Tue, 18 Jul 2017 16:47:56 +0200 (CEST)
Received: from mx05.mykolab.com (unknown [10.20.7.161])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id DE12C1EE4
        for <linux-sparse@vger.kernel.org>; Tue, 18 Jul 2017 16:47:56 +0200 (CEST)
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sparse Mailing-list <linux-sparse@vger.kernel.org>

Hello guys,

I thought I'll test the new sparse on the Wine source code, especially
as I remember to have gotten 1-2 of those famous "Crazy programmer" errors.

But I seem to get an infinite loop with a mem leak: 100% CPU with the
memory utilization increasing until this line triggers
sparse/allocate.c:105:                 die("out of memory");

I'm using sparse v0.5.1-rc4-8-g27f4502 which was the tip of spare-next
as of this morning.
Also this is for the 64bit Wine build as cgcc is not working as is for
the 32bit build.


make[1]: Entering directory '/j/wine/build/sparse64/dlls/user32/tests'
cgcc -c -o menu.o /home/michi/work/wine/dlls/user32/tests/menu.c -I. \
  -I/home/michi/work/wine/dlls/user32/tests -I../../../include
-I/home/michi/work/wine/include \
  -D__WINESRC__ -D_REENTRANT -fPIC -Wall -pipe -fno-strict-aliasing
-Wdeclaration-after-statement \
  -Wempty-body -Wignored-qualifiers -Wshift-overflow=2
-Wstrict-prototypes -Wtype-limits \
  -Wunused-but-set-parameter -Wvla -Wwrite-strings -Wpointer-arith
-Wlogical-op -gdwarf-2 \
  -gstrict-dwarf -g -O2
/home/michi/work/wine/include/winuser.h:1662:22: error: dubious one-bit
signed bitfield
/home/michi/work/wine/include/winuser.h:1663:19: error: dubious one-bit
signed bitfield
out of memory
Makefile:538: recipe for target 'menu.o' failed
make[1]: *** [menu.o] Error 1


To reproduce:
git clone git://source.winehq.org/git/wine.git
cd wine
./configure --enable-win64
make -j`getconf _NPROCESSORS_ONLN` CC=cgcc


Though I'm not sure that this qualifies as a blocker for the 0.5.1
release. The Wine code was pretty tough on sparse previously; it has
been years since I last tried. Crashes and mis-parses were normal back
then as Wine uses language features that are still unimplemented (wide
character string literals). But I do not remember to have encountered an
infinite loop with a mem leak.

thanks
bye
	michael
