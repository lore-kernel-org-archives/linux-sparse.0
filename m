From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] fix dead dominator
Date: Sat, 10 Feb 2018 14:29:45 +0100
Message-ID: <20180210132945.92758-3-luc.vanoostenryck@gmail.com>
References: <20180210132945.92758-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39885 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750968AbeBJNcD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 10 Feb 2018 08:32:03 -0500
Received: by mail-wm0-f67.google.com with SMTP id b21so2210708wme.4
        for <linux-sparse@vger.kernel.org>; Sat, 10 Feb 2018 05:32:02 -0800 (PST)
In-Reply-To: <20180210132945.92758-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

During simplify_one_symbol(), if possible, loads are replaced by
an OP_PHI and the corresponding OP_PHISOURCE. To simplify things
firther, If all the phisrcs correspond to an unique pseudo (often
because there is only a single phisrc), then it's useless to
create the OP_PHI: the created OP_PHISOURCEs can be removed and
the initial load can be converted to the unique pseudo.

However, if the unique pseudo was never used, the removal of
the OP_PHISOURCEs, done *before* the load conversion, will
kill the defining load (at this point the only user of the
pseudo was the OP_PHISOURCEs) which will then erroneously make
a VOID from the pseudo.

Fix this by doing the load conversion before removing the
unneeded OP_PHISOURCEs.
---
 flow.c                         | 2 +-
 validation/mem2reg/load-dead.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/flow.c b/flow.c
index d553df128..e4c881d56 100644
--- a/flow.c
+++ b/flow.c
@@ -453,10 +453,10 @@ void rewrite_load_instruction(struct instruction *insn, struct pseudo_list *domi
 	 * and convert the load into a LNOP and replace the
 	 * pseudo.
 	 */
+	convert_load_instruction(insn, new);
 	FOR_EACH_PTR(dominators, phi) {
 		kill_instruction(phi->def);
 	} END_FOR_EACH_PTR(phi);
-	convert_load_instruction(insn, new);
 	return;
 
 complex_phi:
diff --git a/validation/mem2reg/load-dead.c b/validation/mem2reg/load-dead.c
index 19ac4e5e4..1165fa1ea 100644
--- a/validation/mem2reg/load-dead.c
+++ b/validation/mem2reg/load-dead.c
@@ -12,7 +12,6 @@ static void foo(int a)
 /*
  * check-name: load-dead
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-excludes: VOID
-- 
2.16.0

