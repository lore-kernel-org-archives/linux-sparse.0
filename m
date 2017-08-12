From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] avoid infinite loop during simplification
Date: Sat, 12 Aug 2017 14:55:25 +0200
Message-ID: <20170812125525.34044-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34074 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750896AbdHLMzg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 12 Aug 2017 08:55:36 -0400
Received: by mail-wm0-f67.google.com with SMTP id x64so9304784wmg.1
        for <linux-sparse@vger.kernel.org>; Sat, 12 Aug 2017 05:55:35 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, sparse can enter in infinite loops.
The effect can be seen is the normal simplification/CSE
loops but the origin of the problem is not there
(it's some interaction between simplify_loads() and
unreachable code, at least for a good part of them).

On the other hand, on normal code, the number of
simplification/CSE cycle is fairly small: even in big,
complex functions, in 80% of cases only 1 or 2 cycles are
needed. The most extreme I found was 12 cycles and that's
an unique case (on a total of 172000+).

So, avoid to let sparse in infinite loop by stopping
the loop if the number of cycles becomes too high: 16.

Note: this solves all the 77 cases of inifinite loop I found.
Note: of course, this patch doesn't change the fact that
      the generated IR is broken and that the root cause(s)
      must be addressed.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---

The patch is also available in the git repository at:
  git://github.com/lucvoo/sparse.git avoid-infinite-loop--max-cse

 cse.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/cse.c b/cse.c
index 17b3da01a..fa136c370 100644
--- a/cse.c
+++ b/cse.c
@@ -356,13 +356,17 @@ static struct instruction * try_to_cse(struct entrypoint *ep, struct instruction
 	return i1;
 }
 
+#define	MAX_CSE_CYCLES	16
 void cleanup_and_cse(struct entrypoint *ep)
 {
+	int max = MAX_CSE_CYCLES;
 	int i;
 
 	simplify_memops(ep);
 repeat:
 	repeat_phase = 0;
+	if (--max == 0)
+		return;
 	clean_up_insns(ep);
 	if (repeat_phase & REPEAT_CFG_CLEANUP)
 		kill_unreachable_bbs(ep);
-- 
2.14.0

