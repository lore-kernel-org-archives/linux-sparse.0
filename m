From: danielfsantos@att.net
Subject: [PATCH v3 08/10] bug.h: Fix BUILD_BUG_ON macro in __CHECKER__
Date: Wed, 24 Oct 2012 11:33:59 -0500
Message-ID: <1351096441-12388-8-git-send-email-daniel.santos@pobox.com>
References: <1351096132-12244-1-git-send-email-daniel.santos@pobox.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1351096132-12244-1-git-send-email-daniel.santos@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Daniel Santos <daniel.santos@pobox.com>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Josh Triplett <josh@joshtriplett.org>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <bp@alien8.de>, David Rientjes <rientjes@google.com>
List-Id: linux-sparse@vger.kernel.org

When __CHECKER__ is defined, we disable all of the BUILD_BUG.* macros.
However, BUILD_BUG_ON was evaluating to nothing in this case, and we
want (0) since this is a function-like macro that will be followed by a
semicolon.

Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
---
 include/linux/bug.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/bug.h b/include/linux/bug.h
index f8eae31..1b43ea2 100644
--- a/include/linux/bug.h
+++ b/include/linux/bug.h
@@ -16,7 +16,7 @@ struct pt_regs;
 #define BUILD_BUG_ON_NOT_POWER_OF_2(n)
 #define BUILD_BUG_ON_ZERO(e) (0)
 #define BUILD_BUG_ON_NULL(e) ((void*)0)
-#define BUILD_BUG_ON(condition)
+#define BUILD_BUG_ON(condition) (0)
 #define BUILD_BUG() (0)
 #else /* __CHECKER__ */
 
-- 
1.7.3.4
