From: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Subject: [PATCH] compiler.h: Fix sparse check errors
Date: Tue,  7 Jul 2015 10:43:05 -0300
Message-ID: <607087dd3321926ddf4f67762be67656501bfa25.1436276428.git.mchehab@osg.samsung.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:54691 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754347AbbGGNoQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 7 Jul 2015 09:44:16 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, Dan Carpenter <dan.carpenter@oracle.com>

The #define __pmem was put at the wrong place, inside a
__rcu check. The way it is, if CONFIG_SPARSE_RCU_POINTER is
not defined, it will produce thousands of errors like:

./arch/x86/include/asm/io.h:251:27: error: void declaration
./arch/x86/include/asm/io.h:251:27: error: Expected ; at end of declaration
./arch/x86/include/asm/io.h:251:27: error: got *

making sparse pretty much useless, due to the excess of noise.

So, move the define out of the sparse RCU pointer check.

Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 7f8ad9593da7..4f85b58b7285 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -21,8 +21,8 @@
 # define __rcu		__attribute__((noderef, address_space(4)))
 #else
 # define __rcu
+#endif
 # define __pmem		__attribute__((noderef, address_space(5)))
-#endif
 extern void __chk_user_ptr(const volatile void __user *);
 extern void __chk_io_ptr(const volatile void __iomem *);
 #else
-- 
2.4.3

