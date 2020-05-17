From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/3] doc: fix the warnings when building the doc
Date: Mon, 18 May 2020 01:27:18 +0200
Message-ID: <20200517232719.1789-3-luc.vanoostenryck@gmail.com>
References: <20200517232719.1789-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgEQX10 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 17 May 2020 19:27:26 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9089EC061A0C
        for <linux-sparse@vger.kernel.org>; Sun, 17 May 2020 16:27:26 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id h4so7494332wmb.4
        for <linux-sparse@vger.kernel.org>; Sun, 17 May 2020 16:27:26 -0700 (PDT)
In-Reply-To: <20200517232719.1789-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

It seems that Markdown is now parsed slightly differently and
now generate some warnings.

So tweak the .md files to shut up the warnings.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/TODO.md              |  6 +++++-
 Documentation/nocast-vs-bitwise.md | 34 ++++++++++++++++--------------
 2 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/Documentation/TODO.md b/Documentation/TODO.md
index cbda1c397e46..31826df33aae 100644
--- a/Documentation/TODO.md
+++ b/Documentation/TODO.md
@@ -32,7 +32,7 @@ Core
   ```
 
 Testsuite
---------
+---------
 * there are more than 50 failing tests. They should be fixed
   (but most are non-trivial to fix).
 
@@ -84,9 +84,13 @@ Longer term/to investigate
 * should support "-Werror=..." ?
 * All warning messages should include the option how to disable it.
   For example:
+
   	"warning: Variable length array is used."
+
   should be something like:
+
 	"warning: Variable length array is used. (-Wno-vla)"
+
 * ptrlists must have elements be removed while being iterated but this
   is hard to insure it is not done.
 * having 'struct symbol' used to represent symbols *and* types is
diff --git a/Documentation/nocast-vs-bitwise.md b/Documentation/nocast-vs-bitwise.md
index b649abcd5947..9ba5a789fc26 100644
--- a/Documentation/nocast-vs-bitwise.md
+++ b/Documentation/nocast-vs-bitwise.md
@@ -1,4 +1,5 @@
-# __nocast vs __bitwise
+__nocast vs __bitwise
+=====================
 
 `__nocast` warns about explicit or implicit casting to different types.
 HOWEVER, it doesn't consider two 32-bit integers to be different
@@ -16,25 +17,26 @@ harder to lose the type by mistake.
 
 So the basic rule is:
 
- - `__nocast` on its own tends to be more useful for *big* integers
-that still need to act like integers, but you want to make it much
-less likely that they get truncated by mistake. So a 64-bit integer
-that you don't want to mistakenly/silently be returned as `int`, for
-example. But they mix well with random integer types, so you can add
-to them etc without using anything special. However, that mixing also
-means that the `__nocast` really gets lost fairly easily.
-
- - `__bitwise` is for *unique types* that cannot be mixed with other
-types, and that you'd never want to just use as a random integer (the
-integer `0` is special, though, and gets silently accepted - it's
-kind of like `NULL` for pointers). So `gfp_t` or the `safe endianness`
-types would be `__bitwise`: you can only operate on them by doing
-specific operations that know about *that* particular type.
+- `__nocast` on its own tends to be more useful for *big* integers
+  that still need to act like integers, but you want to make it much
+  less likely that they get truncated by mistake. So a 64-bit integer
+  that you don't want to mistakenly/silently be returned as `int`, for
+  example. But they mix well with random integer types, so you can add
+  to them etc without using anything special. However, that mixing also
+  means that the `__nocast` really gets lost fairly easily.
+
+- `__bitwise` is for *unique types* that cannot be mixed with other
+  types, and that you'd never want to just use as a random integer (the
+  integer `0` is special, though, and gets silently accepted - it's
+  kind of like `NULL` for pointers). So `gfp_t` or the `safe endianness`
+  types would be `__bitwise`: you can only operate on them by doing
+  specific operations that know about *that* particular type.
 
 Generally, you want `__bitwise` if you are looking for type safety.
 `__nocast` really is pretty weak.
 
-## Reference:
+Reference:
+----------
 
 * Linus' e-mail about `__nocast` vs `__bitwise`:
 
-- 
2.26.2
