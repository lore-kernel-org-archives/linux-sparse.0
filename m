From: danielfsantos@att.net
Subject: [PATCH v2 09/10] bug.h: Add BUILD_BUG_ON_MSG & BUILD_BUG_INTERNAL{,2}
Date: Fri,  5 Oct 2012 14:42:48 -0500
Message-ID: <1349466169-20637-9-git-send-email-daniel.santos@pobox.com>
References: <1349465759-20524-1-git-send-email-daniel.santos@pobox.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1349465759-20524-1-git-send-email-daniel.santos@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, David Rientjes <rientjes@google.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, Daniel Santos <daniel.santos@pobox.com>
List-Id: linux-sparse@vger.kernel.org

Add BUILD_BUG_ON_MSG which behaves like BUILD_BUG_ON (with optimizations
turned enabled), except that it allows you to specify the error message
you want emitted as the third parameter.  Under the hood, this relies on
BUILD_BUG_INTERNAL{,2}, which does the actual work and is pretty-much
identical to BUILD_BUG_ON.

Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
---
 include/linux/bug.h |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/include/linux/bug.h b/include/linux/bug.h
index 1b43ea2..91bd9d5 100644
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
@@ -38,6 +39,31 @@ struct pt_regs;
  */
 #define BUILD_BUG_ON_INVALID(e) ((void)(sizeof((__force long)(e))))
 
+#define _CONCAT1(a, b) a##b
+#define CONCAT(a, b) _CONCAT1(a, b)
+#define UNIQUIFY(prefix) CONCAT(prefix, __LINE__)
+
+#define BUILD_BUG_INTERNAL2(condition, msg, fn)			\
+	do {							\
+		extern void fn (void) __compiletime_error(msg);	\
+		__compiletime_error_fallback(condition);	\
+		if (condition)					\
+			fn();					\
+	} while (0)
+
+#define BUILD_BUG_INTERNAL(condition, msg, fn) \
+	BUILD_BUG_INTERNAL2(condition, msg, fn)
+
+/**
+ * BUILD_BUG_ON_MSG - break compile if a condition is true & emit supplied
+ * 		      error message.
+ * @condition: the condition which the compiler should know is false.
+ *
+ * See BUILD_BUG_ON for description.
+ */
+#define BUILD_BUG_ON_MSG(cond, msg) \
+	BUILD_BUG_INTERNAL(cond, msg, UNIQUIFY(__build_bug_on_failed_))
+
 /**
  * BUILD_BUG_ON - break compile if a condition is true.
  * @condition: the condition which the compiler should know is false.
-- 
1.7.3.4
