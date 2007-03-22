From: Dave Jones <davej@redhat.com>
Subject: sparse segfault on ppc64.
Date: Thu, 22 Mar 2007 02:36:00 -0400
Message-ID: <20070322063600.GD15364@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:43692 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751275AbXCVGgC (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 22 Mar 2007 02:36:02 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l2M6a11c017933
	for <linux-sparse@vger.kernel.org>; Thu, 22 Mar 2007 02:36:01 -0400
Received: from gelk.kernelslacker.org (vpn-248-1.boston.redhat.com [10.13.248.1])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l2M6a18E017138
	for <linux-sparse@vger.kernel.org>; Thu, 22 Mar 2007 02:36:01 -0400
Received: from gelk.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by gelk.kernelslacker.org (8.13.8/8.13.8) with ESMTP id l2M6a0Pu018034
	for <linux-sparse@vger.kernel.org>; Thu, 22 Mar 2007 02:36:00 -0400
Received: (from davej@localhost)
	by gelk.kernelslacker.org (8.13.8/8.13.8/Submit) id l2M6a0EH018033
	for linux-sparse@vger.kernel.org; Thu, 22 Mar 2007 02:36:00 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

I thought I'd see what happens if I hooked up sparse
to our daily builds of Linus' tree.
The answer: a segfault on ppc64.

/usr/lib/gcc/ppc64-redhat-linux/4.1.2/include/altivec.h:37:2: error: Use the "-maltivec" flag to enable PowerPC AltiVec support
drivers/md/raid6altivec1.c:41:16: error: Expected ; at end of declaration
drivers/md/raid6altivec1.c:41:16: error: got signed
drivers/md/raid6altivec1.c:50:45: error: Expected ; at end of declaration
drivers/md/raid6altivec1.c:50:45: error: got SHLBYTE
drivers/md/raid6altivec1.c:53:1: error: Expected ; end of type declaration
drivers/md/raid6altivec1.c:53:1: error: got }
drivers/md/raid6altivec1.c:64:2: error: Trying to use reserved word 'return' as identifier
drivers/md/raid6altivec1.c:64:20: error: Expected ; at end of declaration
drivers/md/raid6altivec1.c:64:20: error: got __builtin_vec_cmpgt
drivers/md/raid6altivec1.c:65:1: error: Expected ; end of type declaration
drivers/md/raid6altivec1.c:65:1: error: got }
drivers/md/raid6altivec1.c:77:12: error: Expected ; at end of declaration
drivers/md/raid6altivec1.c:77:12: error: got wd0
drivers/md/raid6altivec1.c:78:12: error: Expected ; at end of declaration
drivers/md/raid6altivec1.c:78:12: error: got x1d
drivers/md/raid6altivec1.c:84:10: error: Expected ) in function declarator
drivers/md/raid6altivec1.c:84:10: error: got =
drivers/md/raid6altivec1.c:84:2: error: Trying to use reserved word 'for' as identifier
drivers/md/raid6altivec1.c:84:18: error: Expected ; at end of declaration
drivers/md/raid6altivec1.c:84:18: error: got <
drivers/md/raid6altivec1.c:84:30: error: Expected ; at end of declaration
drivers/md/raid6altivec1.c:84:30: error: got +=
drivers/md/raid6altivec1.c:86:11: error: Expected ) in function declarator
drivers/md/raid6altivec1.c:86:11: error: got =
drivers/md/raid6altivec1.c:86:3: error: Trying to use reserved word 'for' as identifier
drivers/md/raid6altivec1.c:86:22: error: Expected ; at end of declaration
vers/md/raid6altivec1.c:86:22: error: got >=
drivers/md/raid6altivec1.c:86:30: error: Expected ; at end of declaration
drivers/md/raid6altivec1.c:86:30: error: got --
drivers/md/raid6altivec1.c:94:3: error: Expected ; end of type declaration
drivers/md/raid6altivec1.c:94:3: error: got }
drivers/md/raid6altivec1.c:96:15: error: Expected ) in nested declarator
drivers/md/raid6altivec1.c:96:15: error: got *
drivers/md/raid6altivec1.c:97:2: error: Expected ; end of type declaration
drivers/md/raid6altivec1.c:97:2: error: got }
drivers/md/raid6altivec1.c:107:2: error: Trying to use reserved word 'do' as identifier
drivers/md/raid6altivec1.c:107:2: error: Expected ; at end of declaration
drivers/md/raid6altivec1.c:107:2: error: got {
drivers/md/raid6altivec1.c:108:1: error: Expected ; end of type declaration
drivers/md/raid6altivec1.c:108:1: error: got }
drivers/md/raid6altivec1.c:80:7: error: undefined identifier 'disks'
drivers/md/raid6altivec1.c:80:2: error: symbol 'z0' redeclared with different type (originally declared at drivers/md/raid6altivec1.c:7
5) - different signedness
drivers/md/raid6altivec1.c:81:6: error: undefined identifier 'dptr'
drivers/md/raid6altivec1.c:81:2: error: symbol 'p' redeclared with different type (originally declared at drivers/md/raid6altivec1.c:74
) - different base types
drivers/md/raid6altivec1.c:82:6: error: undefined identifier 'dptr'
drivers/md/raid6altivec1.c:82:2: error: symbol 'q' redeclared with different type (originally declared at drivers/md/raid6altivec1.c:74
) - different base types
drivers/md/raid6altivec1.c:84:16: error: symbol 'd' redeclared with different type (originally declared at drivers/md/raid6altivec1.c:7
5) - different signedness
drivers/md/raid6altivec1.c:84:28: error: symbol 'd' redeclared with different type (originally declared at drivers/md/raid6altivec1.c:7
5) - different signedness
drivers/md/raid6altivec1.c:86:20: error: symbol 'z' redeclared with different type (originally declared at drivers/md/raid6altivec1.c:7
5) - different signedness
drivers/md/raid6altivec1.c:86:29: error: symbol 'z' redeclared with different type (originally declared at drivers/md/raid6altivec1.c:7
5) - different signedness
drivers/md/raid6altivec1.c:88:10: error: undefined identifier '__builtin_vec_xor'
drivers/md/raid6altivec1.c:89:10: error: undefined identifier 'MASK'
drivers/md/raid6altivec1.c:90:10: error: undefined identifier 'SHLBYTE'
drivers/md/raid6altivec1.c:91:10: error: undefined identifier '__builtin_vec_and'
drivers/md/raid6altivec1.c:92:10: error: undefined identifier '__builtin_vec_xor'
drivers/md/raid6altivec1.c:93:10: error: undefined identifier '__builtin_vec_xor'
drivers/md/raid6altivec1.c:96:3: error: symbol 'unative_t' redeclared with different type (originally declared at drivers/md/raid6altiv
ec1.c:78) - different base types
drivers/md/raid6altivec1.c:124:2: error: undefined identifier 'raid6_altivec1_gen_syndrome'
/bin/sh: line 1: 22303 Segmentation fault      sparse-0.2/sparse -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ -Wbitwise -m32 -D__po
werpc__ -D__powerpc32__ -nostdinc -isystem /usr/lib/gcc/ppc64-redhat-linux/4.1.2/include -Wp,-MD,drivers/md/.raid6altivec1.o.d -nostdin
c -isystem /usr/lib/gcc/ppc64-redhat-linux/4.1.2/include -D__KERNEL__ -Iinclude -include include/linux/autoconf.h -Iarch/powerpc -Iarch
/powerpc/include -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaratio
n -Wextra -Wno-unused-parameter -Wno-missing-field-initializers -Os -msoft-float -pipe -Iarch/powerpc -ffixed-r2 -mmultiple -mno-altive
c -funit-at-a-time -mstring -mcpu=powerpc -Wa,-maltivec -fomit-frame-pointer -g -fno-stack-protector -Wdeclaration-after-statement -Wno
-pointer-sign -maltivec -mabi=altivec -DMODULE -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(raid6altivec1)" -D"KBUILD_MODNAME=KBU
ILD_STR(raid456)" drivers/md/raid6altivec1.c
make[2]: *** [drivers/md/raid6altivec1.o] Error 139


Is this something new, or am I the first person dumb enough to try and
run sparse on non-x86 ?

	Dave

-- 
http://www.codemonkey.org.uk
