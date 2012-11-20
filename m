From: danielfsantos@att.net
Subject: [PATCH v6 8/9] compiler.h, bug.h: Prevent double error messages with BUILD_BUG{,_ON}
Date: Tue, 20 Nov 2012 15:05:06 -0600
Message-ID: <1353445507-7233-8-git-send-email-daniel.santos@pobox.com>
References: <1353444132-6809-1-git-send-email-daniel.santos@pobox.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nm24-vm0.access.bullet.mail.mud.yahoo.com ([66.94.236.143]:40539
	"EHLO nm24-vm0.access.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752997Ab2KTVFZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 20 Nov 2012 16:05:25 -0500
In-Reply-To: <1353444132-6809-1-git-send-email-daniel.santos@pobox.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Rientjes <rientjes@google.com>, Joe Perches <joe@perches.com>, Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Santos <daniel.santos@pobox.com>

Prior to the introduction of __attribute__((error("msg"))) in gcc 4.3,
creating compile-time errors required a little trickery.
BUILD_BUG{,_ON} uses this attribute when available to generate
compile-time errors, but also uses the negative-sized array trick for
older compilers, resulting in two error messages in some cases.  The
reason it's "some" cases is that as of gcc 4.4, the negative-sized array
will not create an error in some situations, like inline functions.

This patch replaces the negative-sized array code with the new
__compiletime_error_fallback() macro which expands to the same thing
unless the the error attribute is available, in which case it expands to
do{}while(0), resulting in exactly one compile-time error on all
versions of gcc.

Note that we are not changing the negative-sized array code for the
unoptimized version of BUILD_BUG_ON, since it has the potential to catch
problems that would be disabled in later versions of gcc were
__compiletime_error_fallback used.  The reason is that that an
unoptimized build can't always remove calls to an error-attributed
function call (like we are using) that should effectively become dead
code if it were optimized.  However, using a negative-sized array with a
similar value will not result in an false-positive (error). The only
caveat being that it will also fail to catch valid conditions, which we
should be expecting in an unoptimized build anyway.

Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
---
 include/linux/bug.h      |    2 +-
 include/linux/compiler.h |    5 +++++
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/include/linux/bug.h b/include/linux/bug.h
index eb6d715..125e744 100644
--- a/include/linux/bug.h
+++ b/include/linux/bug.h
@@ -66,7 +66,7 @@ struct pt_regs;
 			__compiletime_error("BUILD_BUG_ON failed");	\
 		if (__cond)						\
 			__build_bug_on_failed();			\
-		((void)sizeof(char[1 - 2 * __cond]));			\
+		__compiletime_error_fallback(__cond);			\
 	} while(0)
 #endif
 
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index cbf6d9d..8e5b9d5 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -298,7 +298,12 @@ void ftrace_likely_update(struct ftrace_branch_data *f, int val, int expect);
 #endif
 #ifndef __compiletime_error
 # define __compiletime_error(message)
+# define __compiletime_error_fallback(condition) \
+	do { ((void)sizeof(char[1 - 2*!!(condition)])); } while (0)
+#else
+# define __compiletime_error_fallback(condition) do { } while (0)
 #endif
+
 /*
  * Prevent the compiler from merging or refetching accesses.  The compiler
  * is also forbidden from reordering successive instances of ACCESS_ONCE(),
-- 
1.7.3.4

