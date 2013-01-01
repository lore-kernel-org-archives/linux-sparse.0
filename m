From: danielfsantos@att.net
Subject: [PATCH v7 4/9] compiler{,-gcc4}.h, bug.h: Remove duplicate macros
Date: Tue,  1 Jan 2013 15:09:52 -0600
Message-ID: <1357074597-21722-4-git-send-email-daniel.santos@pobox.com>
References: <1357074491-21669-1-git-send-email-daniel.santos@pobox.com>
 <1357074597-21722-1-git-send-email-daniel.santos@pobox.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nm1-vm0.access.bullet.mail.sp2.yahoo.com ([98.139.44.94]:29551
	"EHLO nm1-vm0.access.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752449Ab3AAVPn (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 1 Jan 2013 16:15:43 -0500
In-Reply-To: <1357074597-21722-1-git-send-email-daniel.santos@pobox.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Rientjes <rientjes@google.com>, Joe Perches <joe@perches.com>, Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Santos <daniel.santos@pobox.com>

__linktime_error() does the same thing as __compiletime_error() and is
only used in bug.h.  Since the macro defines a function attribute that
will cause a failure at compile-time (not link-time), it makes more
sense to keep __compiletime_error(), which is also neatly mated with
__compiletime_warning().

Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
Acked-by: David Rientjes <rientjes@google.com>
Acked-by: Borislav Petkov <bp@alien8.de>
---
 include/linux/bug.h           |    2 +-
 include/linux/compiler-gcc4.h |    2 --
 include/linux/compiler.h      |    3 ---
 3 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/include/linux/bug.h b/include/linux/bug.h
index b1cf40d..2a11774 100644
--- a/include/linux/bug.h
+++ b/include/linux/bug.h
@@ -74,7 +74,7 @@ extern int __build_bug_on_failed;
 #define BUILD_BUG()						\
 	do {							\
 		extern void __build_bug_failed(void)		\
-			__linktime_error("BUILD_BUG failed");	\
+			__compiletime_error("BUILD_BUG failed");\
 		__build_bug_failed();				\
 	} while (0)
 
diff --git a/include/linux/compiler-gcc4.h b/include/linux/compiler-gcc4.h
index a9ffdfe..68b162d 100644
--- a/include/linux/compiler-gcc4.h
+++ b/include/linux/compiler-gcc4.h
@@ -33,8 +33,6 @@
    the kernel context */
 #define __cold			__attribute__((__cold__))
 
-#define __linktime_error(message) __attribute__((__error__(message)))
