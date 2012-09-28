From: Daniel Santos <daniel.santos@pobox.com>
Subject: [PATCH 10/10] bug.h: Add gcc 4.2+ versions of BUILD_BUG_ON_* macros
Date: Fri, 28 Sep 2012 18:20:11 -0500
Message-ID: <1348874411-28288-11-git-send-email-daniel.santos@pobox.com>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Daniel Santos <daniel.santos@pobox.com>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-sparse@vger.kernel.org

BUILD_BUG_ON42(arg)
BUILD_BUG_ON_CONST42(arg)

Prior to gcc 4.2, the optimizer was unable to determine that many
constant values stored in structs were indeed compile-time constants and
optimize them out.  Sometimes, it will find an intergral value to be a
compile-time constant, but fail to perform a bit-wise AND at
compile-time.  These two macros provide a mechanism to perform these
build-time checks, but not break on older compilers where we already
know they can't be checked at compile time.

For specific details, consult the doc comments for BUILD_BUG_ON_CONST.
These macros are used in the generic rbtree code.

Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
---
 include/linux/bug.h |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/include/linux/bug.h b/include/linux/bug.h
index e30f600..d14c23c 100644
--- a/include/linux/bug.h
+++ b/include/linux/bug.h
@@ -2,6 +2,7 @@
 #define _LINUX_BUG_H
 
 #include <asm/bug.h>
+#include <linux/compiler.h>
 
 enum bug_trap_type {
 	BUG_TRAP_TYPE_NONE = 0,
@@ -129,6 +130,41 @@ struct pt_regs;
 #define BUILD_BUG_ON_NON_CONST(exp)
 #endif
 
+
+#if GCC_VERSION >= 40200
+/**
+ * BUILD_BUG_ON_NON_CONST42 - break compile if expression cannot be determined
+ *                            to be a compile-time constant (disabled prior to
+ *                            gcc 4.2)
+ * @exp: value to test for compile-time constness
+ *
+ * Use this macro instead of BUILD_BUG_ON_NON_CONST when testing struct
+ * members or dereferenced arrays and pointers.  Note that the version checks
+ * for this macro are not perfect.  BUILD_BUG_ON_NON_CONST42 expands to nothing
+ * prior to gcc-4.2, after which it is the same as BUILD_BUG_ON_NON_CONST.
+ * However, there are still many checks that will break with this macro (see
+ * the Gory Details section of BUILD_BUG_ON_NON_CONST for more info).
+ *
+ * See also BUILD_BUG_ON_NON_CONST()
+ */
+# define BUILD_BUG_ON_NON_CONST42(exp) BUILD_BUG_ON_NON_CONST(exp)
+
+/**
+ * BUILD_BUG_ON42 - break compile if expression cannot be determined
+ *                   (disabled prior to gcc 4.2)
+ *
+ * This gcc-version check is necessary due to breakages in testing struct
+ * members prior to gcc 4.2.
+ *
+ * See also BUILD_BUG_ON()
+ */
+# define BUILD_BUG_ON42(arg) BUILD_BUG_ON(arg)
+#else
+# define BUILD_BUG_ON_NON_CONST42(exp)
+# define BUILD_BUG_ON42(arg)
+#endif /* GCC_VERSION >= 40200 */
+
+
 #endif	/* __CHECKER__ */
 
 #ifdef CONFIG_GENERIC_BUG
-- 
1.7.3.4
