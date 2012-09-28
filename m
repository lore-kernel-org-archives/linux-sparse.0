From: Daniel Santos <daniel.santos@pobox.com>
Subject: [PATCH 9/10] bug.h: Add BUILD_BUG_ON_NON_CONST macro
Date: Fri, 28 Sep 2012 18:20:10 -0500
Message-ID: <1348874411-28288-10-git-send-email-daniel.santos@pobox.com>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nm23.bullet.mail.ac4.yahoo.com ([98.139.52.220]:23435 "HELO
	nm23.bullet.mail.ac4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S964857Ab2I1XVr (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 28 Sep 2012 19:21:47 -0400
In-Reply-To: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Daniel Santos <daniel.santos@pobox.com>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>

A very common use of __builtin_constant_p is to make sure that a certain
value is a compile time constant and generate a build-time error if it
is not.  However, __builtin_constant_p is broken in a variety of ways in
various situations (on various versions of gcc) and never returns one in
an unoptimized build. This macro provide a mechanism to perform these
build-time checks, but not break unoptimized builds (or modules being
build with -O0), of which there probably aren't many people that care
anyway.

This patch documents all of the relevant quirks I could find in the
"Gory Details" section of the doc-comments.  For almost all cases,
BUILD_BUG_ON_NON_CONST() should never fail on a primitive, non-pointer
type variable declared const.  A subsequent patch provides a separate
macro for performing tests which are known to be broken in older
compilers (pretty much, using __builtin_constant_p on arrays, pointers &
structs as well as testing those values).

Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
---
 include/linux/bug.h |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/include/linux/bug.h b/include/linux/bug.h
index c70b833..e30f600 100644
--- a/include/linux/bug.h
+++ b/include/linux/bug.h
@@ -81,6 +81,54 @@ struct pt_regs;
 		__build_bug_failed();				\
 	} while (0)
 
+/**
+ * BUILD_BUG_ON_NON_CONST - break compile if expression cannot be determined
+ *                          to be a compile-time constant.
+ * @exp: value to test for compile-time constness
+ *
+ * __builtin_constant_p() is a work in progress and is broken in various ways
+ * on various versions of gcc and optimization levels. It can fail, even when
+ * gcc otherwise determines that the expression is compile-time constant when
+ * performing actual optimizations and thus, compile out the value anyway. Do
+ * not use this macro for struct members or dereferenced pointers and arrays,
+ * as these are broken in many versions of gcc -- use BUILD_BUG_ON_NON_CONST42
+ * or another gcc-version-checked macro instead.
+ *
+ * As long as you are passing a variable declared const (and not modified),
+ * this macro should never fail (except for floats).  For information on gcc's
+ * behavior in other cases, see below.
+ *
+ * Gory Details:
+ *
+ * Normal primitive variables
+ * - global non-static non-const values are never compile-time constants (but
+ *   you should already know that)
+ * - all const values (global/local, non/static) should never fail this test
+ *   (3.4+) with one exception (below)
+ * - floats (which we wont use anyway) are broken in various ways until 4.2
+ *   (-O1 broken until 4.4)
+ * - local static non-const broken until 4.2 (-O1 broken until 4.3)
+ * - local non-static non-const broken until 4.0
+ *
+ * Dereferencing pointers & arrays
+ * - all static const derefs broken until 4.4 (except arrays at -O2 or better,
+ *   which are fixed in 4.2)
+ * - global non-static const pointer derefs always fail (<=4.7)
+ * - local non-static const derefs broken until 4.3, except for array derefs
+ *   to a zero value, which works from 4.0+
+ * - local static non-const pointers always fail (<=4.7)
+ * - local static non-const arrays broken until 4.4
+ * - local non-static non-const arrays broken until 4.0 (unless zero deref,
+ *   works in 3.4+)
+
+ */
+#ifdef __OPTIMIZE__
+#define BUILD_BUG_ON_NON_CONST(exp) \
+	BUILD_BUG_ON(!__builtin_constant_p(exp))
+#else
+#define BUILD_BUG_ON_NON_CONST(exp)
+#endif
+
 #endif	/* __CHECKER__ */
 
 #ifdef CONFIG_GENERIC_BUG
-- 
1.7.3.4

