From: danielfsantos@att.net
Subject: [PATCH v4 9/9] bug.h: Convert BUILD_BUG{,_ON} to use BUILD_BUG_ON_MSG
Date: Sun, 28 Oct 2012 15:57:15 -0500
Message-ID: <1351457835-7553-9-git-send-email-daniel.santos@pobox.com>
References: <1351457648-7453-1-git-send-email-daniel.santos@pobox.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nm2.access.bullet.mail.mud.yahoo.com ([66.94.237.203]:35036
	"EHLO nm2.access.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755775Ab2J1U5V (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 28 Oct 2012 16:57:21 -0400
In-Reply-To: <1351457648-7453-1-git-send-email-daniel.santos@pobox.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Daniel Santos <daniel.santos@pobox.com>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Josh Triplett <josh@joshtriplett.org>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <bp@alien8.de>, David Rientjes <rientjes@google.com>

Remove duplicate code by converting BUILD_BUG and BUILD_BUG_ON to just
call BUILD_BUG_ON_MSG.  This not only reduces source code bloat, but
also prevents the possibility of code being changed for one macro and
not for the other (which was previously the case for BUILD_BUG and
BUILD_BUG_ON).

Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
---
 include/linux/bug.h |   17 +++--------------
 1 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/include/linux/bug.h b/include/linux/bug.h
index 3bc1ddf..b58ba51 100644
--- a/include/linux/bug.h
+++ b/include/linux/bug.h
@@ -81,14 +81,8 @@ struct pt_regs;
 #ifndef __OPTIMIZE__
 #define BUILD_BUG_ON(condition) __compiletime_error_fallback(condition)
 #else
-#define BUILD_BUG_ON(condition)						\
-	do {								\
-		extern void __build_bug_on_failed(void)			\
-			__compiletime_error("BUILD_BUG_ON failed");	\
-		__compiletime_error_fallback(condition);		\
-		if (condition)						\
-			__build_bug_on_failed();			\
-	} while(0)
+#define BUILD_BUG_ON(condition) \
+	BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
 #endif
 
 /**
@@ -98,12 +92,7 @@ struct pt_regs;
  * build time, you should use BUILD_BUG to detect if it is
  * unexpectedly used.
  */
-#define BUILD_BUG()						\
-	do {							\
-		extern void __build_bug_failed(void)		\
-			__compiletime_error("BUILD_BUG failed");\
-		__build_bug_failed();				\
-	} while (0)
+#define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
 
 #endif	/* __CHECKER__ */
 
-- 
1.7.3.4

