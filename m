From: danielfsantos@att.net
Subject: [PATCH v8 6/9] bug.h: Prevent double evaulation of in BUILD_BUG_ON
Date: Tue,  1 Jan 2013 16:54:08 -0600
Message-ID: <1357080851-30938-7-git-send-email-daniel.santos@pobox.com>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com>
 <1357080851-30938-1-git-send-email-daniel.santos@pobox.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nm20.access.bullet.mail.mud.yahoo.com ([66.94.237.221]:32215
	"EHLO nm20.access.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752529Ab3AAWy3 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 1 Jan 2013 17:54:29 -0500
In-Reply-To: <1357080851-30938-1-git-send-email-daniel.santos@pobox.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Rientjes <rientjes@google.com>, Joe Perches <joe@perches.com>, Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Santos <daniel.santos@pobox.com>

When calling BUILD_BUG_ON in an optimized build using gcc 4.3 and later,
the condition will be evaulated twice, possibily with side-effects.
This patch eliminates that error.

Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
---
 include/linux/bug.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/bug.h b/include/linux/bug.h
index 27d404f..0d75762 100644
--- a/include/linux/bug.h
+++ b/include/linux/bug.h
@@ -59,8 +59,9 @@ struct pt_regs;
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
1.7.8.6

