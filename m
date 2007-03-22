From: Dave Jones <davej@redhat.com>
Subject: Re: sparse segfault on ppc64.
Date: Thu, 22 Mar 2007 13:11:18 -0400
Message-ID: <20070322171118.GL15364@redhat.com>
References: <20070322063600.GD15364@redhat.com> <20070322073344.GU4095@ftp.linux.org.uk> <20070322070354.GA22151@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:58613 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934143AbXCVRRy (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 22 Mar 2007 13:17:54 -0400
Content-Disposition: inline
In-Reply-To: <20070322070354.GA22151@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-sparse@vger.kernel.org

On Thu, Mar 22, 2007 at 12:03:54AM -0700, Christopher Li wrote:
 > On Thu, Mar 22, 2007 at 07:33:44AM +0000, Al Viro wrote:
 > > Segfault is new (which version?); the fscking mess in altivec is not, but
 > > it (a) doesn't depend on host sparse is ran on; (b) shouldn't lead to
 > > segfaults.  Altivec extensions are undocumented and fortunately used only
 > > in one place in the tree.  You should get sparse errors, but it shouldn't
 > > die on those.
 > 
 > I think the segfault is likely to cause by my recent change in the parser.
 > 
 > Dave, can you get a backtrace of the segfault? Even better if you can
 > give me a small test case which I can reproduce it on x86.
 > 
 > My guess it is cause by the bad_ctype related changes.

So the good news is that this only seems to affect 0.2
Current git doesn't segfault, but still emits lots of spew.

	Dave

make -f scripts/Makefile.build obj=drivers/md drivers/md/raid6altivec1.o
  sparse -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ -Wbitwise  -m64 -D__powerpc__ -D__powerpc64__  -nostdinc -isystem /usr/lib/gcc/powerpc64-linux/4.0.1/include -Wp,-MD,drivers/md/.raid6altivec1.o.d  -nostdinc -isystem /usr/lib/gcc/powerpc64-linux/4.0.1/include -D__KERNEL__ -Iinclude  -include include/linux/autoconf.h  -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wextra -Wno-unused-parameter -Wno-missing-field-initializers -Os -msoft-float -pipe -mminimal-toc -mtraceback=none  -mcall-aixdesc -mtune=power4 -mno-altivec -funit-at-a-time -mstring -Wa,-maltivec -fomit-frame-pointer -g  -Wdeclaration-after-statement -Wno-pointer-sign  -maltivec -mabi=altivec -DMODULE -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(raid6altivec1)"  -D"KBUILD_MODNAME=KBUILD_STR(raid456)" drivers/md/raid6altivec1.c ;
/usr/lib/gcc/powerpc64-linux/4.0.1/include/altivec.h:36:2: error: Use the "-maltivec" flag to enable PowerPC AltiVec support
drivers/md/raid6altivec1.c:41:16: error: Expected ; at end of declaration
drivers/md/raid6altivec1.c:41:16: error: got signed
drivers/md/raid6altivec1.c:50:45: error: Expected ; at end of declaration
drivers/md/raid6altivec1.c:50:45: error: got SHLBYTE
drivers/md/raid6altivec1.c:53:1: error: Expected ; end of type declaration
drivers/md/raid6altivec1.c:53:1: error: got }
drivers/md/raid6altivec1.c:64:2: error: Trying to use reserved word 'return' as identifier
drivers/md/raid6altivec1.c:64:20: error: Expected ; at end of declaration
drivers/md/raid6altivec1.c:64:20: error: got __builtin_choose_expr
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
drivers/md/raid6altivec1.c:86:22: error: got >=
drivers/md/raid6altivec1.c:86:30: error: Expected ; at end of declaration
drivers/md/raid6altivec1.c:86:30: error: got --
drivers/md/raid6altivec1.c:88:10: error: Expected , in __builtin_types_compatible_p
drivers/md/raid6altivec1.c:88:10: error: got float
drivers/md/raid6altivec1.c:91:10: error: Expected , in __builtin_types_compatible_p
drivers/md/raid6altivec1.c:91:10: error: got float
drivers/md/raid6altivec1.c:92:10: error: Expected , in __builtin_types_compatible_p
drivers/md/raid6altivec1.c:92:10: error: got float
drivers/md/raid6altivec1.c:93:10: error: Expected , in __builtin_types_compatible_p
drivers/md/raid6altivec1.c:93:10: error: got float
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
drivers/md/raid6altivec1.c:80:2: error: symbol 'z0' redeclared with different type (originally declared at drivers/md/raid6altivec1.c:75) - different signedness
drivers/md/raid6altivec1.c:81:6: error: undefined identifier 'dptr'
drivers/md/raid6altivec1.c:81:2: error: symbol 'p' redeclared with different type (originally declared at drivers/md/raid6altivec1.c:74) - different base types
drivers/md/raid6altivec1.c:82:6: error: undefined identifier 'dptr'
drivers/md/raid6altivec1.c:82:2: error: symbol 'q' redeclared with different type (originally declared at drivers/md/raid6altivec1.c:74) - different base types
drivers/md/raid6altivec1.c:84:16: error: symbol 'd' redeclared with different type (originally declared at drivers/md/raid6altivec1.c:75) - different signedness
drivers/md/raid6altivec1.c:84:28: error: symbol 'd' redeclared with different type (originally declared at drivers/md/raid6altivec1.c:75) - different signedness
drivers/md/raid6altivec1.c:86:20: error: symbol 'z' redeclared with different type (originally declared at drivers/md/raid6altivec1.c:75) - different signedness
drivers/md/raid6altivec1.c:86:29: error: symbol 'z' redeclared with different type (originally declared at drivers/md/raid6altivec1.c:75) - different signedness
drivers/md/raid6altivec1.c:89:10: error: undefined identifier 'MASK'
drivers/md/raid6altivec1.c:90:10: error: undefined identifier 'SHLBYTE'
drivers/md/raid6altivec1.c:96:3: error: symbol 'unative_t' redeclared with different type (originally declared at drivers/md/raid6altivec1.c:78) - different base types
drivers/md/raid6altivec1.c:124:2: error: undefined identifier 'raid6_altivec1_gen_syndrome'

-- 
http://www.codemonkey.org.uk
