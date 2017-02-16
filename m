From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 03/16] add helper kill_use_list()
Date: Thu, 16 Feb 2017 05:56:55 +0100
Message-ID: <20170216045708.50661-4-luc.vanoostenryck@gmail.com>
References: <20170216045708.50661-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33109 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753152AbdBPE5S (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 15 Feb 2017 23:57:18 -0500
Received: by mail-wr0-f195.google.com with SMTP id i10so641625wrb.0
        for <linux-sparse@vger.kernel.org>; Wed, 15 Feb 2017 20:57:18 -0800 (PST)
In-Reply-To: <20170216045708.50661-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/simplify.c b/simplify.c
index ced63bfa3..d4e730894 100644
--- a/simplify.c
+++ b/simplify.c
@@ -182,6 +182,16 @@ void kill_use(pseudo_t *usep)
 	}
 }
 
+static void kill_use_list(struct pseudo_list *list)
+{
+	pseudo_t p;
+	FOR_EACH_PTR(list, p) {
+		if (p == VOID)
+			continue;
+		kill_use(THIS_ADDRESS(p));
+	} END_FOR_EACH_PTR(p);
+}
+
 void kill_instruction(struct instruction *insn)
 {
 	if (!insn || !insn->bb)
-- 
2.11.0

