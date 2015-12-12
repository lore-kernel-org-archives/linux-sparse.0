From: Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC 1/3] sparse: Add __private to privatize members of structs
Date: Sat, 12 Dec 2015 10:56:00 +0800
Message-ID: <1449888962-29348-2-git-send-email-boqun.feng@gmail.com>
References: <1449888962-29348-1-git-send-email-boqun.feng@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:35785 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754275AbbLLC4r (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 11 Dec 2015 21:56:47 -0500
In-Reply-To: <1449888962-29348-1-git-send-email-boqun.feng@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Marc Zyngier <marc.zyngier@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Brian Norris <computersforpeace@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>

In C programming language, we don't have a easy way to privatize a
member of a structure. However in kernel, sometimes there is a need to
privatize a member in case of potential bugs or misuses.

Fortunately, the noderef attribute of sparse is a way to privatize a
member, as by defining a member as noderef, the address-of operator on
the member will produce a noderef pointer to that member, and if anyone
wants to dereference that kind of pointers to read or modify the member,
sparse will yell.

Based on this, __private modifier and related operation ACCESS_PRIVATE()
are introduced, which could help detect undesigned public uses of
private members of structs. Here is an example of sparse's output if it
detect an undersigned public use:

| kernel/rcu/tree.c:4453:25: warning: incorrect type in argument 1 (different modifiers)
| kernel/rcu/tree.c:4453:25:    expected struct raw_spinlock [usertype] *lock
| kernel/rcu/tree.c:4453:25:    got struct raw_spinlock [noderef] *<noident>

Also, this patch improves compiler.h a little bit by adding comments for
"#else" and "#endif".

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/compiler.h | 12 ++++++++----
 scripts/checkpatch.pl    |  3 ++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 4dac103..e4a4fb1 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -20,12 +20,14 @@
 # define __pmem		__attribute__((noderef, address_space(5)))
 #ifdef CONFIG_SPARSE_RCU_POINTER
 # define __rcu		__attribute__((noderef, address_space(4)))
-#else
+#else /* CONFIG_SPARSE_RCU_POINTER */
 # define __rcu
-#endif
+#endif /* CONFIG_SPARSE_RCU_POINTER */
+# define __private	__attribute__((noderef))
 extern void __chk_user_ptr(const volatile void __user *);
 extern void __chk_io_ptr(const volatile void __iomem *);
-#else
+# define ACCESS_PRIVATE(p, member) (*((typeof((p)->member) __force *) &(p)->member))
+#else /* __CHECKER__ */
 # define __user
 # define __kernel
 # define __safe
@@ -44,7 +46,9 @@ extern void __chk_io_ptr(const volatile void __iomem *);
 # define __percpu
 # define __rcu
 # define __pmem
-#endif
+# define __private
+# define ACCESS_PRIVATE(p, member) ((p)->member)
+#endif /* __CHECKER__ */
 
 /* Indirect macros required for expanded argument pasting, eg. __LINE__. */
 #define ___PASTE(a,b) a##b
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2b3c228..fda1c61 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -269,7 +269,8 @@ our $Sparse	= qr{
 			__init_refok|
 			__kprobes|
 			__ref|
-			__rcu
+			__rcu|
+			__private
 		}x;
 our $InitAttributePrefix = qr{__(?:mem|cpu|dev|net_|)};
 our $InitAttributeData = qr{$InitAttributePrefix(?:initdata\b)};
-- 
2.6.4

