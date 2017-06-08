From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] extract has_users() from dead_insn()
Date: Thu,  8 Jun 2017 09:39:25 +0200
Message-ID: <20170608073927.55218-2-luc.vanoostenryck@gmail.com>
References: <20170608073927.55218-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34397 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751559AbdFHHjj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 8 Jun 2017 03:39:39 -0400
Received: by mail-wm0-f66.google.com with SMTP id 70so5875340wme.1
        for <linux-sparse@vger.kernel.org>; Thu, 08 Jun 2017 00:39:39 -0700 (PDT)
In-Reply-To: <20170608073927.55218-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

so that it can be reused for others uses.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/simplify.c b/simplify.c
index a141ddd43..65114193a 100644
--- a/simplify.c
+++ b/simplify.c
@@ -301,16 +301,23 @@ void kill_insn(struct instruction *insn, int force)
 	return;
 }
 
+static int has_users(pseudo_t p)
+{
+	struct pseudo_user *pu;
+	FOR_EACH_PTR(p->users, pu) {
+		if (*pu->userp != VOID)
+			return 1;
+	} END_FOR_EACH_PTR(pu);
+	return 0;
+}
+
 /*
  * Kill trivially dead instructions
  */
 static int dead_insn(struct instruction *insn, pseudo_t *src1, pseudo_t *src2, pseudo_t *src3)
 {
-	struct pseudo_user *pu;
-	FOR_EACH_PTR(insn->target->users, pu) {
-		if (*pu->userp != VOID)
-			return 0;
-	} END_FOR_EACH_PTR(pu);
+	if (has_users(insn->target))
+		return 0;
 
 	insn->bb = NULL;
 	kill_use(src1);
-- 
2.13.0

