From: danielfsantos@att.net
Subject: [PATCH v4 8/9] bug.h: Add BUILD_BUG_ON_MSG & _BUILD_BUG_INTERNAL
Date: Sun, 28 Oct 2012 15:57:14 -0500
Message-ID: <1351457835-7553-8-git-send-email-daniel.santos@pobox.com>
References: <1351457648-7453-1-git-send-email-daniel.santos@pobox.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1351457648-7453-1-git-send-email-daniel.santos@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Daniel Santos <daniel.santos@pobox.com>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Josh Triplett <josh@joshtriplett.org>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <bp@alien8.de>, David Rientjes <rientjes@google.com>
List-Id: linux-sparse@vger.kernel.org

Add BUILD_BUG_ON_MSG which behaves like BUILD_BUG_ON (with optimizations
enabled), except that it allows you to specify the error message you
want emitted as the third parameter.  Under the hood, this relies on
_BUILD_BUG_INTERNAL, which does the actual work and is pretty-much
identical to BUILD_BUG_ON.

Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
---
 include/linux/bug.h |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/include/linux/bug.h b/include/linux/bug.h
index 6c38988..3bc1ddf 100644
--- a/include/linux/bug.h
+++ b/include/linux/bug.h
@@ -16,6 +16,7 @@ struct pt_regs;
 #define BUILD_BUG_ON_NOT_POWER_OF_2(n)
 #define BUILD_BUG_ON_ZERO(e) (0)
 #define BUILD_BUG_ON_NULL(e) ((void*)0)
+#define BUILD_BUG_ON_MSG(cond, msg) (0)
 #define BUILD_BUG_ON(condition) (0)
 #define BUILD_BUG() (0)
 #else /* __CHECKER__ */
@@ -38,6 +39,27 @@ struct pt_regs;
  */
 #define BUILD_BUG_ON_INVALID(e) ((void)(sizeof((__force long)(e))))
 
+#define __BUILD_BUG_INTERNAL(condition, msg, line)		\
+	do {							\
+		extern void __build_bug_on_failed_ ## line	\
+			(void) __compiletime_error(msg);	\
+		__compiletime_error_fallback(condition);	\
+		if (condition)					\
+			__build_bug_on_failed_ ## line();	\
+	} while (0)
+
+#define _BUILD_BUG_INTERNAL(condition, msg, line) \
+	__BUILD_BUG_INTERNAL(condition, msg, line)
+
+/**
+ * BUILD_BUG_ON_MSG - break compile if a condition is true & emit supplied
+ * 		      error message.
+ * @condition: the condition which the compiler should know is false.
+ *
+ * See BUILD_BUG_ON for description.
+ */
+#define BUILD_BUG_ON_MSG(cond, msg) _BUILD_BUG_INTERNAL(cond, msg, __LINE__)
+
 /**
  * BUILD_BUG_ON - break compile if a condition is true.
  * @condition: the condition which the compiler should know is false.
-- 
1.7.3.4
