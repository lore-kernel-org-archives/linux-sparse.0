From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 04/16] fix killing of OP_PHIs
Date: Thu, 16 Feb 2017 05:56:56 +0100
Message-ID: <20170216045708.50661-5-luc.vanoostenryck@gmail.com>
References: <20170216045708.50661-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33112 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753021AbdBPE5T (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 15 Feb 2017 23:57:19 -0500
Received: by mail-wr0-f196.google.com with SMTP id i10so641663wrb.0
        for <linux-sparse@vger.kernel.org>; Wed, 15 Feb 2017 20:57:19 -0800 (PST)
In-Reply-To: <20170216045708.50661-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

OP_PHIs were killed by calling clear_phi() but this function
only replaces the phi node's sources by VOID without adjusting
the usage of these sources.

Fix this by instead calling kill_use() on each of the sources
via the newly created helper kill_use_list().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                 | 2 +-
 validation/kill-phi-node.c | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index d4e730894..17f1e2b61 100644
--- a/simplify.c
+++ b/simplify.c
@@ -218,7 +218,7 @@ void kill_instruction(struct instruction *insn)
 		break;
 
 	case OP_PHI:
-		clear_phi(insn);
+		kill_use_list(insn->phi_list);
 		break;
 	case OP_PHISOURCE:
 		kill_use(&insn->phi_src);
diff --git a/validation/kill-phi-node.c b/validation/kill-phi-node.c
index 88de9f962..cff62b649 100644
--- a/validation/kill-phi-node.c
+++ b/validation/kill-phi-node.c
@@ -9,6 +9,15 @@ void foo(int a, int *b, unsigned int g)
 		d = 8;
 }
 
+int bar(void);
+int bar(void)
+{
+	int i;
+	for (i = 0; i; i--)
+		;
+	return 0;
+}
+
 /*
  * check-name: kill-phi-node
  * check-command: test-linearize $file
-- 
2.11.0

