From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Subject: [PATCH] compiler: Correct macro parameter expansion problem
Date: Mon,  3 Nov 2014 06:34:13 -0800
Message-ID: <1415025253-15976-1-git-send-email-jeffrey.t.kirsher@intel.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:25688 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751991AbaKCOeR (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 3 Nov 2014 09:34:17 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: Mark Rustad <mark.d.rustad@intel.com>, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org, Jeff Kirsher <jeffrey.t.kirsher@intel.com>

From: Mark Rustad <mark.d.rustad@intel.com>

The macro __compiletime_error_fallback has an error in that it
lacks parens around the expansion of an expression. It also
lacks a conversion to a boolean value. The first problem can
result in a mis-evaluation. The second problem can also result
in an error if the value comes out negative. That would thwart
the intended error generation. That is, the error being asserted
would not in fact generate an error. Fix both problems by adding
!!() to the expansion.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
 include/linux/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index d5ad7b1..59dc611 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -331,7 +331,7 @@ void ftrace_likely_update(struct ftrace_branch_data *f, int val, int expect);
  */
 # ifndef __CHECKER__
 #  define __compiletime_error_fallback(condition) \
-	do { ((void)sizeof(char[1 - 2 * condition])); } while (0)
+	do { ((void)sizeof(char[1 - 2 * !!(condition)])); } while (0)
 # endif
 #endif
 #ifndef __compiletime_error_fallback
-- 
1.9.3

