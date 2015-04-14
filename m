From: =?windows-1252?Q?Martin_Li=9Aka?= <mliska@suse.cz>
Subject: [PATCH 1/2] compiler/gcc5: Remove quirk for asm_volatile_goto()
Date: Tue, 14 Apr 2015 11:25:04 +0200
Message-ID: <552CDCF0.3050401@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40324 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752081AbbDNJZG (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 14 Apr 2015 05:25:06 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: sparse@chrisli.org

Remove comments related to GCC 4.x branch and workaround for
asm_volatile_goto which is fixed in GCC 5 release.

Signed-off-by: Martin Liska  <mliska@suse.cz>
---
  include/linux/compiler-gcc5.h | 16 ++--------------
  1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/include/linux/compiler-gcc5.h b/include/linux/compiler-gcc5.h
index efee493..1ded0a0 100644
--- a/include/linux/compiler-gcc5.h
+++ b/include/linux/compiler-gcc5.h
@@ -12,10 +12,6 @@
     like BUG(), printk(), panic() etc. [but let's keep them for now for
     older compilers]
  
-   Early snapshots of gcc 4.3 don't support this and we can't detect this
-   in the preprocessor, but we can live with this because they're unreleased.
-   Maketime probing would be overkill here.
-
     gcc also has a __attribute__((__hot__)) to move hot functions into
     a special section, but I don't see any sense in this right now in
     the kernel context */
@@ -32,10 +28,6 @@
   * Mark a position in code as unreachable.  This can be used to
   * suppress control flow warnings after asm blocks that transfer
   * control elsewhere.
- *
- * Early snapshots of gcc 4.5 don't support this and we can't detect
- * this in the preprocessor, but we can live with this because they're
- * unreleased.  Really, we need to have autoconf for the kernel.
   */
  #define unreachable() __builtin_unreachable()
  
@@ -48,15 +40,11 @@
  #define __visible __attribute__((externally_visible))
  
  /*
- * GCC 'asm goto' miscompiles certain code sequences:
+ * 'asm goto' miscompilation is fixed in GCC 5.x version:
   *
   *   http://gcc.gnu.org/bugzilla/show_bug.cgi?id=58670
- *
- * Work it around via a compiler barrier quirk suggested by Jakub Jelinek.
- *
- * (asm goto is automatically volatile - the naming reflects this.)
   */
-#define asm_volatile_goto(x...)	do { asm goto(x); asm (""); } while (0)
+#define asm_volatile_goto(x...)	do { asm goto(x); } while (0)
  
  #ifdef CONFIG_ARCH_USE_BUILTIN_BSWAP
  #define __HAVE_BUILTIN_BSWAP32__
-- 
2.1.4


