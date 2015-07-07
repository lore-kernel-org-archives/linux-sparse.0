From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH] include/linux/compiler.h: unconditionally define __pmem sparse attribute
Date: Tue, 07 Jul 2015 17:41:32 +0200
Message-ID: <87fv50c6vn.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:34970 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757510AbbGGPlg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 7 Jul 2015 11:41:36 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org

Commit 61031952f4c8 ("arch, x86: pmem api for ensuring durability of
                      persistent memory updates")
defined __pmem in include/linux/compiler.h only for the case
CONFIG_RCU_SPARSE_POINTER=n, probably by accident.

With CONFIG_RCU_SPARSE_POINTER=y a sparse compile gives the error:
  CHECK   init/main.c
  arch/x86/include/asm/io.h:251:27: error: void declaration
  arch/x86/include/asm/io.h:251:27: error: Expected ; at end of declaration
  arch/x86/include/asm/io.h:251:27: error: got *
  arch/x86/include/asm/io.h:255:1: error: Expected ; at the end of
    type declaration
  arch/x86/include/asm/io.h:255:1: error: got }

This happens because the __pmem in
arch/x86/include/asm/io.h:251:
  static inline void __pmem *arch_memremap_pmem([...])
is undefined.

Define __pmem unconditionally in include/linux/compiler.h.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 include/linux/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 7f8ad95..4f85b58 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -21,8 +21,8 @@
 # define __rcu		__attribute__((noderef, address_space(4)))
 #else
 # define __rcu
-# define __pmem		__attribute__((noderef, address_space(5)))
 #endif
+# define __pmem		__attribute__((noderef, address_space(5)))
 extern void __chk_user_ptr(const volatile void __user *);
 extern void __chk_io_ptr(const volatile void __iomem *);
 #else
-- 
2.4.5

