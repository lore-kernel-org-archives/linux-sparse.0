From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/9] use has_users() in dead_insn() too
Date: Mon, 12 Feb 2018 23:02:42 +0100
Message-ID: <20180212220246.17750-6-luc.vanoostenryck@gmail.com>
References: <20180212220246.17750-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56258 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932670AbeBLWDA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 12 Feb 2018 17:03:00 -0500
Received: by mail-wm0-f66.google.com with SMTP id a84so984602wmi.5
        for <linux-sparse@vger.kernel.org>; Mon, 12 Feb 2018 14:02:59 -0800 (PST)
In-Reply-To: <20180212220246.17750-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The same functionality was open-coded here.
Change this by calling the new helper: has_users().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/simplify.c b/simplify.c
index 971f8ca91..5a90b9c6a 100644
--- a/simplify.c
+++ b/simplify.c
@@ -308,11 +308,8 @@ void kill_insn(struct instruction *insn, int force)
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
2.16.0

