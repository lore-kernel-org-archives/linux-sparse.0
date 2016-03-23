From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 1/2] compiler.h: add support for malloc attribute
Date: Thu, 24 Mar 2016 00:42:31 +0100
Message-ID: <1458776553-9033-1-git-send-email-linux@rasmusvillemoes.dk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37972 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbcCWXmt (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 23 Mar 2016 19:42:49 -0400
Received: by mail-wm0-f44.google.com with SMTP id l68so44084616wml.1
        for <linux-sparse@vger.kernel.org>; Wed, 23 Mar 2016 16:42:48 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>
Cc: Andi Kleen <ak@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org

gcc as far back as at least 3.04 documents the function attribute
__malloc__. Add a shorthand for attaching that to a function
declaration. This was also suggested by Andi Kleen way back in 2002
[1], but didn't get applied, perhaps because gcc at that time
generated the exact same code with and without this attribute.

This attribute tells the compiler that the return value (if non-NULL)
can be assumed not to alias any other valid pointers at the time of
the call.

Please note that the documentation for a range of gcc versions
(starting from around 4.7) contained a somewhat confusing and
self-contradicting text:

  The malloc attribute is used to tell the compiler that a function
  may be treated as if any non-NULL pointer it returns cannot alias
  any other pointer valid when the function returns and *that the
  memory has undefined content*. [...] Standard functions with this
  property include malloc and *calloc*.

(emphasis mine). The intended meaning has later been clarified [2]:

  This tells the compiler that a function is malloc-like, i.e., that
  the pointer P returned by the function cannot alias any other
  pointer valid when the function returns, and moreover no pointers to
  valid objects occur in any storage addressed by P.

What this means is that we can apply the attribute to kmalloc and
friends, and it is ok for the returned memory to have well-defined
contents (__GFP_ZERO). But it is not ok to apply it to kmemdup(), nor
to other functions which both allocate and possibly initialize the
memory with existing pointers. So unless someone is doing something
pretty perverted kstrdup() should also be a fine candidate.

[1] http://thread.gmane.org/gmane.linux.kernel/57172
[2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=56955

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/compiler-gcc.h | 1 +
 include/linux/compiler.h     | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 22ab246feed3..9004f153c5ab 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -142,6 +142,7 @@
 
 #if GCC_VERSION >= 30400
 #define __must_check		__attribute__((warn_unused_result))
+#define __malloc		__attribute__((__malloc__))
 #endif
 
 #if GCC_VERSION >= 40000
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index b5ff9881bef8..793c0829e3a3 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -357,6 +357,10 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
 #define __deprecated_for_modules
 #endif
 
+#ifndef __malloc
+#define __malloc
+#endif
+
 /*
  * Allow us to avoid 'defined but not used' warnings on functions and data,
  * as well as force them to be emitted to the assembly file.
-- 
2.1.4

