From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 2/3] add memory asm constraint for PPC
Date: Sat, 4 Jul 2020 21:32:48 +0200
Message-ID: <20200704193248.simtaedrt7gbiepy@ltop.local>
References: <20200704135747.87752-1-luc.vanoostenryck@gmail.com>
 <20200704135747.87752-3-luc.vanoostenryck@gmail.com>
 <693a3fa0-5202-3695-54cf-aa1cc1f514fd@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgGDTcv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 4 Jul 2020 15:32:51 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1B3C061794
        for <linux-sparse@vger.kernel.org>; Sat,  4 Jul 2020 12:32:51 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id d18so25130456edv.6
        for <linux-sparse@vger.kernel.org>; Sat, 04 Jul 2020 12:32:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <693a3fa0-5202-3695-54cf-aa1cc1f514fd@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: linux-sparse@vger.kernel.org

On Sat, Jul 04, 2020 at 06:44:53PM +0100, Ramsay Jones wrote:
> 
> Hi Luc,
> 
> All of the patches in this series look good to me! ;-)
> 
> (I have been following all patches on the list, I just
> haven't had anything to say about them - which is a good thing!)

Hi,

Yes, indeed. Thank you!
 
> On 04/07/2020 14:57, Luc Van Oostenryck wrote:
> > The 'Z' asm constraint is used for doing IO accessors on PPC but
> > isn't part of the 'common constraints'. It's responsible for
> > more than half of all warnings (with defconfig + allyesconfig).
> 
> Not a problem, but this made me think 'half of which warnings'. :-D
> I assume, but it's just a guess, this means 'half of all asm-constraints
> warnings on the kernel PPC build'.
> 
> How many warnings is that? What percentage is that of _all_ sparse
> warnings on a typical kernel build?

It's literally more than half of all warnings issued by sparse when doing
a build of the kernel with 'defconfig' and another one with 'allyesconfig'
(all my tests on kernel builds are done like so) on a ppc64 machine:
	$ grep ': \(error\|warning\):' log-master-master | wc -l
	138581
	$ grep ': \(error\|warning\):' log-arch-asm-mem | wc -l
	50006
So, this series eliminates about 64% of all warnings, a nice
improvement of the S/N ratio.
Now, most of these warnings are exactly the same, again and again:
	$ diff -U1 log-master-master log-arch-asm-mem
	--- log-master-master   2020-07-04 14:40:56.733110303 +0200
	+++ log-arch-asm-mem    2020-07-04 15:46:47.972595182 +0200
	@@ -1 +1 @@
	-SPARSE=fa1539620
	+SPARSE=69fedae3e
	@@ -24,8 +23,0 @@
	-./arch/powerpc/include/asm/io.h:143:1: warning: dereference of noderef expression
	-./arch/powerpc/include/asm/io.h:144:1: warning: dereference of noderef expression
	-./arch/powerpc/include/asm/io.h:148:1: warning: dereference of noderef expression
	-./arch/powerpc/include/asm/io.h:149:1: warning: dereference of noderef expression
	-./arch/powerpc/include/asm/io.h:143:1: warning: dereference of noderef expression
	-./arch/powerpc/include/asm/io.h:144:1: warning: dereference of noderef expression
	-./arch/powerpc/include/asm/io.h:148:1: warning: dereference of noderef expression
	-./arch/powerpc/include/asm/io.h:149:1: warning: dereference of noderef expression
	@@ -41 +32,0 @@
	-./arch/powerpc/include/asm/io.h:144:1: warning: dereference of noderef expression
	@@ -56,4 +46,0 @@
	-./arch/powerpc/include/asm/io.h:143:1: warning: dereference of noderef expression
	-./arch/powerpc/include/asm/io.h:144:1: warning: dereference of noderef expression
	-./arch/powerpc/include/asm/io.h:148:1: warning: dereference of noderef expression
	-./arch/powerpc/include/asm/io.h:149:1: warning: dereference of noderef expression
	 ...

If you count only unique warnings, the result is quite different:
	@gcc203:~/dev $ grep ': \(error\|warning\):' log-master-master | sort -u | wc -l
	19071
	@gcc203:~/dev $ grep ': \(error\|warning\):' log-arch-asm-mem | sort -u | wc -l
	19067
Only 4 unique warnings are eliminated.

For comparison, on x86_64 the warnings are:
	$ grep ': \(error\|warning\):' log-master-master | wc -l
	29806
	$ grep ': \(error\|warning\):' log-master-master | sort -u | wc -l
	19234

> Thanks!
> 
> [BTW, I also noticed the (long running) 'luc/options' branch, which
> looks like it could prove to be a nice cleanup - I've only read the
> commit messages, not the actual commits.]

Yes, I think it's a nice cleanup because this code is quite messy but,
OTOH, moving around all this code break all its history (via 'git blame'
or 'git log -L') is is guaranteed to create really nasty conflicts with
anything touching the code for the options. This is really a downside.
 
Best regards,
-- Luc
