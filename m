From: Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH] kernel: Emphasize the return value of READ_ONCE() is honored
Date: Sun,  3 Sep 2017 08:43:33 +0800
Message-ID: <20170903004334.18364-1-boqun.feng@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>, Akira Yokosawa <akiyks@gmail.com>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

READ_ONCE() is used around in kernel to provide a control dependency,
and to make the control dependency valid, we must 1) make the load of
READ_ONCE() actually happen and 2) make sure compilers take the return
value of READ_ONCE() serious. 1) is already done and commented,
and in current implementation, 2) is also considered done in the
same way as 1): a 'volatile' load.

Whereas, during a recent discussion brought up by Akira Yokosawa on
memory-barriers.txt:

	https://marc.info/?l=linux-kernel&m=150052964519882&w=2

, a problem is discovered, which would be triggered if 2) is not
achieved. Moreover, according to Paul Mckenney, using volatile might not
actually give us what we want for 2) depending on compiler writers'
definition of 'volatile'. Therefore it's necessary to emphasize 2) as a
part of the semantics of READ_ONCE(), this not only fits the conceptual
semantics we have been using, but also makes the implementation
requirement more accurate.

In the future, we can either make compiler writers accept our use of
'volatile', or(if that fails) find another way to provide this
guarantee.

Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/compiler.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index eca8ad75e28b..b386dbf8c65c 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -305,6 +305,32 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
  * mutilate accesses that either do not require ordering or that interact
  * with an explicit memory barrier or atomic instruction that provides the
  * required ordering.
+ *
+ * The return value of READ_ONCE() should be honored by compilers, IOW,
+ * compilers must treat the return value of READ_ONCE() as an unknown value at
+ * compile time, i.e. no optimization should be done based on the value of a
+ * READ_ONCE(). For example, the following code snippet:
+ *
+ * 	int a = 0;
+ * 	int x = 0;
+ *
+ * 	void some_func() {
+ * 		int t = READ_ONCE(a);
+ * 		if (!t)
+ * 			WRITE_ONCE(x, 1);
+ * 	}
+ *
+ * , should never be optimized as:
+ *
+ * 	void some_func() {
+ * 		int t = READ_ONCE(a);
+ * 		WRITE_ONCE(x, 1);
+ * 	}
+ *
+ * because the compiler is 'smart' enough to think the value of 'a' is never
+ * changed.
+ *
+ * We provide this guarantee by making READ_ONCE() a *volatile* load.
  */
 
 #define __READ_ONCE(x, check)						\
-- 
2.14.1
