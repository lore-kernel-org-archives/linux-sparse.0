From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] fix: missing evaluate with '-include'
Date: Sun, 17 Sep 2017 12:05:52 +0200
Message-ID: <20170917100552.72288-3-luc.vanoostenryck@gmail.com>
References: <CAHmME9o02YNvfqV3RFofJE8FXwRaUACzq03TBADSYc74E02iBg@mail.gmail.com>
 <20170917100552.72288-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34662 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750860AbdIQKGC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 17 Sep 2017 06:06:02 -0400
Received: by mail-wm0-f65.google.com with SMTP id i131so6288934wma.1
        for <linux-sparse@vger.kernel.org>; Sun, 17 Sep 2017 03:06:01 -0700 (PDT)
In-Reply-To: <20170917100552.72288-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Symbols declared or defined in files directly or indirectly
given in the command line and thus processed via sparse()
are always automatically evaluated.
Symbols processed via sparse_initialize(), thus the predefined
ones, are not systematically evaluated, which is normaly fine
as they are just declarations and will be evaluated when needed.

However, if the command line include a file via '-include <file>',
the symbols of this file will also not be evaluated, which is still
fine as long as it's only definitions. But, in the rare and odd cases
where the file should contains a function definition, this function
will not be evaluated and it's expansion and linearization won't happen
as it should have.

Fix this by evaluating the symbols issued from sparse_intialize()
like it is done for sparse().

Reported-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c                     | 14 ++++++++++++++
 validation/include-eval.c |  1 -
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/lib.c b/lib.c
index 4602cf85d..b255fec14 100644
--- a/lib.c
+++ b/lib.c
@@ -1351,6 +1351,20 @@ struct symbol_list *sparse_initialize(int argc, char **argv, struct string_list
 		 */
 		protect_token_alloc();
 	}
+	/*
+	 * Evaluate the complete symbol list
+	 * Note: This is not needed for normal cases.
+	 *	 These symbols should only be predefined defines and
+	 *	 declaratons which will be evaluated later, when needed.
+	 *	 This is also the case when a file is directly included via
+	 *	 '-include <file>' on the command line *AND* the file only
+	 *	 contains defines, declarations and inline definitions.
+	 *	 However, in the rare cases where the given file should
+	 *	 contain some definitions, these will never be evaluated
+	 *	 and thus won't be able to be linearized correctly.
+	 *	 Hence the evaluate_symbol_list() here under.
+	 */
+	evaluate_symbol_list(list);
 	return list;
 }
 
diff --git a/validation/include-eval.c b/validation/include-eval.c
index bf9bf63fe..1a91dab84 100644
--- a/validation/include-eval.c
+++ b/validation/include-eval.c
@@ -3,5 +3,4 @@
 /*
  * check-name: include-eval.c
  * check-command: sparse -include ./include-eval.inc $file
- * check-known-to-fail
  */
-- 
2.14.0

