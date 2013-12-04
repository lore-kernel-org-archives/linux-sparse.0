From: Tejun Heo <tj@kernel.org>
Subject: Re: [BUG report]sparse warnings on DEFINE_PER_CPU() symbols
 non-static
Date: Wed, 4 Dec 2013 10:12:40 -0500
Message-ID: <20131204151240.GO3158@htj.dyndns.org>
References: <5294175F.2080407@cn.fujitsu.com>
 <20131203222543.GQ8277@htj.dyndns.org>
 <529EA0F4.5070205@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qe0-f53.google.com ([209.85.128.53]:52594 "EHLO
	mail-qe0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932178Ab3LDPMp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 4 Dec 2013 10:12:45 -0500
Received: by mail-qe0-f53.google.com with SMTP id nc12so14379635qeb.40
        for <linux-sparse@vger.kernel.org>; Wed, 04 Dec 2013 07:12:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <529EA0F4.5070205@cn.fujitsu.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: josh@kernel.org, linux-sparse@vger.kernel.org, Wu Fengguang <fengguang.wu@intel.com>, kbuild-all@01.org, Rusty Russell <rusty@rustcorp.com.au>, Christoph Lameter <cl@linux-foundation.org>

On Wed, Dec 04, 2013 at 11:26:44AM +0800, Wanlong Gao wrote:
> Goes away but comes new error:
> 
> /git/linux/fs/inode.c:74:8: error: symbol 'nr_inodes' redeclared with different type (originally declared at /git/linux/fs/inode.c:74) - different address spaces
> /git/linux/fs/inode.c:75:8: error: symbol 'nr_unused' redeclared with different type (originally declared at /git/linux/fs/inode.c:75) - different address spaces
> /git/linux/fs/inode.c:835:8: error: symbol 'last_ino' redeclared with different type (originally declared at /git/linux/fs/inode.c:835) - different address spaces

Oops, my bad.  How about the following?

diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index 57e890a..a5fc7d0 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -69,6 +69,7 @@
 	__PCPU_DUMMY_ATTRS char __pcpu_scope_##name;			\
 	extern __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;		\
 	__PCPU_DUMMY_ATTRS char __pcpu_unique_##name;			\
+	extern __PCPU_ATTRS(sec) __typeof__(type) name;			\
 	__PCPU_ATTRS(sec) PER_CPU_DEF_ATTRIBUTES __weak			\
 	__typeof__(type) name
 #else
