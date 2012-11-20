From: danielfsantos@att.net
Subject: [PATCH v6 6/9] bug.h: Prevent double evaulation of in BUILD_BUG_ON
Date: Tue, 20 Nov 2012 15:05:04 -0600
Message-ID: <1353445507-7233-6-git-send-email-daniel.santos@pobox.com>
References: <1353444132-6809-1-git-send-email-daniel.santos@pobox.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1353444132-6809-1-git-send-email-daniel.santos@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Rientjes <rientjes@google.com>, Joe Perches <joe@perches.com>, Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Santos <daniel.santos@pobox.com>
List-Id: linux-sparse@vger.kernel.org

When calling BUILD_BUG_ON in an optimized build using gcc 4.3 and later,
the condition will be evaulated twice, possibily with side-effects.
This patch eliminates that error.

Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
---
 include/linux/bug.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/bug.h b/include/linux/bug.h
index 1b2465d..98bdbb3d 100644
--- a/include/linux/bug.h
+++ b/include/linux/bug.h
@@ -58,8 +58,9 @@ struct pt_regs;
 extern int __build_bug_on_failed;
 #define BUILD_BUG_ON(condition)					\
 	do {							\
-		((void)sizeof(char[1 - 2*!!(condition)]));	\
-		if (condition) __build_bug_on_failed = 1;	\
+		bool __cond = !!(condition);			\
+		((void)sizeof(char[1 - 2 * __cond]));		\
+		if (__cond) __build_bug_on_failed = 1;		\
 	} while(0)
 #endif
 
-- 
1.7.3.4
