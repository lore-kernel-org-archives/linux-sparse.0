From: Tejun Heo <tj@kernel.org>
Subject: Re: [BUG report]sparse warnings on DEFINE_PER_CPU() symbols
 non-static
Date: Tue, 3 Dec 2013 17:25:43 -0500
Message-ID: <20131203222543.GQ8277@htj.dyndns.org>
References: <5294175F.2080407@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yh0-f43.google.com ([209.85.213.43]:51725 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754476Ab3LCWZr (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 3 Dec 2013 17:25:47 -0500
Received: by mail-yh0-f43.google.com with SMTP id a41so10125068yho.2
        for <linux-sparse@vger.kernel.org>; Tue, 03 Dec 2013 14:25:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5294175F.2080407@cn.fujitsu.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: josh@kernel.org, linux-sparse@vger.kernel.org, Wu Fengguang <fengguang.wu@intel.com>, kbuild-all@01.org, Rusty Russell <rusty@rustcorp.com.au>, Christoph Lameter <cl@linux-foundation.org>

Hello,

On Tue, Nov 26, 2013 at 11:37:03AM +0800, Wanlong Gao wrote:
> If kernel config CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y, then the sparse will report non-static
> warnings like following:
> 
> > /git/linux/fs/inode.c:74:8: warning: symbol 'nr_inodes' was not declared. Should it be static?
> > /git/linux/fs/inode.c:75:8: warning: symbol 'nr_unused' was not declared. Should it be static?
> >
> > $ vi +74 fs/inode.c
> >   73 
> >   74 static DEFINE_PER_CPU(unsigned long, nr_inodes);
> >   75 static DEFINE_PER_CPU(unsigned long, nr_unused);
> >   76 

Hmmm, so, if FORCE_WEAK_PER_CPU is set or the arch needs WEAK_PER_CPU,
DEFINE_PER_CPU() explodes into mind-bending series of definitions to
ensure that the symbol is globally unique to avoid breaking weak decl
requirements on a few archs.  In the process static is dropped from
the actual declaration and it's apparently missing extern decl in
front of it.

Does the following patch make it go away?

Thanks.

diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index 57e890a..8c490cc 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -69,6 +69,7 @@
 	__PCPU_DUMMY_ATTRS char __pcpu_scope_##name;			\
 	extern __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;		\
 	__PCPU_DUMMY_ATTRS char __pcpu_unique_##name;			\
+	extern __typeof__(type) name;					\
 	__PCPU_ATTRS(sec) PER_CPU_DEF_ATTRIBUTES __weak			\
 	__typeof__(type) name
 #else
