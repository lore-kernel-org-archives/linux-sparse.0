From: Daniel Santos <daniel.santos@pobox.com>
Subject: [PATCH 1/10] compiler-gcc4.h: correct verion check for __compiletime_error
Date: Fri, 28 Sep 2012 18:20:02 -0500
Message-ID: <1348874411-28288-2-git-send-email-daniel.santos@pobox.com>
References: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1348874411-28288-1-git-send-email-daniel.santos@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Daniel Santos <daniel.santos@pobox.com>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>
Cc: Michal Marek <mmarek@suse.cz>
List-Id: linux-sparse@vger.kernel.org

NOTE: this is has already been comitted to -mm

__attribute__((error(msg))) was introduced in gcc 4.3 (not 4.4) and as I
was unable to find any gcc bugs pertaining to it, I'm presuming that it
has functioned as advertised since 4.3.0.

Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
Cc: Michal Marek <mmarek@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/compiler-gcc4.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/compiler-gcc4.h b/include/linux/compiler-gcc4.h
index 997fd8a..8721704 100644
--- a/include/linux/compiler-gcc4.h
+++ b/include/linux/compiler-gcc4.h
@@ -59,7 +59,7 @@
 #if __GNUC_MINOR__ > 0
 #define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
 #endif
-#if __GNUC_MINOR__ >= 4 && !defined(__CHECKER__)
+#if __GNUC_MINOR__ >= 3 && !defined(__CHECKER__)
 #define __compiletime_warning(message) __attribute__((warning(message)))
 #define __compiletime_error(message) __attribute__((error(message)))
 #endif
-- 
1.7.3.4
