From: Tejun Heo <tj@kernel.org>
Subject: [PATCH] percpu: fix spurious sparse warnings from DEFINE_PER_CPU()
Date: Thu, 5 Dec 2013 13:01:17 -0500
Message-ID: <20131205180117.GA25939@mtj.dyndns.org>
References: <5294175F.2080407@cn.fujitsu.com>
 <20131203222543.GQ8277@htj.dyndns.org>
 <529EA0F4.5070205@cn.fujitsu.com>
 <20131204151240.GO3158@htj.dyndns.org>
 <529FC670.2080308@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yh0-f47.google.com ([209.85.213.47]:38842 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757220Ab3LESBW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 5 Dec 2013 13:01:22 -0500
Received: by mail-yh0-f47.google.com with SMTP id 29so12937159yhl.34
        for <linux-sparse@vger.kernel.org>; Thu, 05 Dec 2013 10:01:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <529FC670.2080308@cn.fujitsu.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: josh@kernel.org, linux-sparse@vger.kernel.org, Wu Fengguang <fengguang.wu@intel.com>, kbuild-all@01.org, Rusty Russell <rusty@rustcorp.com.au>, Christoph Lameter <cl@linux-foundation.org>

Applied the following to percpu/for-3.13-fixes.

Thanks!
------ 8< ------
From b1a0fbfdde65dffd83c84c006f84fa12041907c5 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Wed, 4 Dec 2013 10:12:40 -0500

When CONFIG_DEBUG_FORCE_WEAK_PER_CPU or CONFIG_ARCH_NEEDS_WEAK_PER_CPU
is set, DEFINE_PER_CPU() explodes into cryptic series of definitions
to still allow using "static" for percpu variables while keeping all
per-cpu symbols unique in the kernel image which is required for weak
symbols.  This ultimately converts the actual symbol to global whether
DEFINE_PER_CPU() is prefixed with static or not.

Unfortunately, the macro forgot to add explicit extern declartion of
the actual symbol ending up defining global symbol without preceding
declaration for static definitions which naturally don't have matching
DECLARE_PER_CPU().  The only ill effect is triggering of the following
warnings.

 fs/inode.c:74:8: warning: symbol 'nr_inodes' was not declared. Should it be static?
 fs/inode.c:75:8: warning: symbol 'nr_unused' was not declared. Should it be static?

Fix it by adding extern declaration in the DEFINE_PER_CPU() macro.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Tested-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 include/linux/percpu-defs.h | 1 +
 1 file changed, 1 insertion(+)

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
-- 
1.8.4.2

