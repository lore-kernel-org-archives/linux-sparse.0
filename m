From: Dan Carpenter <error27@gmail.com>
Subject: Re: segfault in sparse snapshot 2010-02-13
Date: Thu, 25 Mar 2010 13:49:47 +0300
Message-ID: <20100325104947.GC5069@bicker>
References: <20100324104144.0817c22b.rdunlap@xenotime.net> <20100324193622.GC4331@feather> <4BAA6C4C.8010103@xenotime.net> <20100324203427.GA3015@feather>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:56428 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976Ab0CYKt5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 25 Mar 2010 06:49:57 -0400
Received: by bwz1 with SMTP id 1so713804bwz.21
        for <linux-sparse@vger.kernel.org>; Thu, 25 Mar 2010 03:49:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100324203427.GA3015@feather>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-sparse@vger.kernel.org

On Wed, Mar 24, 2010 at 01:34:29PM -0700, Josh Triplett wrote:
> On Wed, Mar 24, 2010 at 12:47:24PM -0700, Randy Dunlap wrote:
> > On 03/24/10 12:36, Josh Triplett wrote:
> > > On Wed, Mar 24, 2010 at 10:41:44AM -0700, Randy Dunlap wrote:
> > >> (snapshot from Dave Jones:
> > >>   http://www.codemonkey.org.uk/projects/git-snapshots/sparse/ )
> > >>
> > >>
> > >> In the linux-next-20100324 or akpm's kernel patchset (mmotm-2010-03-23),
> > >> sparse segfaults when checking net/bridge/br_fdb.c. (does not happen in
> > >> Linus's mainline kernel tree)
> > >>
> > >>
> > >> The last messages are:
> > >>
> > >> net/bridge/br_fdb.c:225:9: error: no member 'hash' in struct net_bridge
> > >> net/bridge/br_fdb.c:225:9: error: incompatible types for operation (+)
> > >> net/bridge/br_fdb.c:225:9:    left side has type bad type
> > >> net/bridge/br_fdb.c:225:9:    right side has type int
> > >> net/bridge/br_fdb.c:225:9: error: cannot dereference this type
> > >> /bin/sh: line 1: 28041 Segmentation fault      sparse -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ -Wbitwise -Wno-return-void -D__x86_64__ -m64 -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/4.4.1/include -Wp,-MD,net/bridge/.br_fdb.o.d -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/4.4.1/include -I/lnx/src/NEXT/linux-next-20100324/arch/x86/include -Iinclude -I/lnx/src/NEXT/linux-next-20100324/include -include include/generated/autoconf.h -I/lnx/src/NEXT/linux-next-20100324/net/bridge -Inet/bridge -D__KERNEL__ -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -O2 -m64 -mtune=generic -mno-red-zone -mcmodel=kernel -funit-at-a-time -maccumulate-outgoin
 g-args -fstack-protector -fno-builtin-memcpy -DCONFIG_AS_CFI=1 -DCONFIG_AS_CFI_SIGNAL_FRAME=1 -pipe -Wno-sign-compare -fno-asynchronous-unwind-tables -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -Wfra
> > me-
> > >>  larger-than=2048 -fno-omit-frame-pointer -fno-optimize-sibling-calls -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fconserve-stack -fprofile-arcs -ftest-coverage -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(br_fdb)" -D"KBUILD_MODNAME=KBUILD_STR(bridge)" -D"DEBUG_HASH=21" -D"DEBUG_HASH2=11" /lnx/src/NEXT/linux-next-20100324/net/bridge/br_fdb.c
> > >> make[3]: *** [net/bridge/br_fdb.o] Error 139
> > > 
> > > Ouch.
> > > 
> > > Can you attach a preprocessed source .i file that reproduces the
> > > problem? "make net/bridge/br_fdb.i" should work.
> > 
> > Sure, attached.
> 
> I tried to reproduce this segfault with this file and current Sparse
> from Git, and couldn't seem to reproduce it.  I tried the posted command
> line and many variations on it.
> 
> I had to explicitly drop -Wall or add -Wno-shadow to get the code to
> pass Sparse, due to a pile of warnings about ______f and ______r.  Apart
> from that, I didn't see any issue.

Those are from the __branch_check__ macro in include/linux/compiler.h.
They get turned off if __CHECKER__ is defined, but doing the
"make net/bridge/br_fdb.i" will not have that.

That change could explain why the preprocessed code doesn't segfault.

regards,
dan carpenter

> 
> - Josh Triplett
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
