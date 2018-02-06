From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] fix killing of converted loads
Date: Tue,  6 Feb 2018 20:41:43 +0100
Message-ID: <20180206194143.1285-3-luc.vanoostenryck@gmail.com>
References: <20180206194143.1285-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44966 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752786AbeBFTny (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 6 Feb 2018 14:43:54 -0500
Received: by mail-wr0-f196.google.com with SMTP id v31so3193079wrc.11
        for <linux-sparse@vger.kernel.org>; Tue, 06 Feb 2018 11:43:53 -0800 (PST)
In-Reply-To: <20180206194143.1285-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Converted loads are dead and can be removed but that
laos means that the address' usage need to be adjusted
which wasn't done.

Fix this by adding the missing kill_use().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c                            | 1 +
 validation/optim/load-converted.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/flow.c b/flow.c
index d553df128..12fa62ed1 100644
--- a/flow.c
+++ b/flow.c
@@ -304,6 +304,7 @@ void convert_load_instruction(struct instruction *insn, pseudo_t src)
 {
 	convert_instruction_target(insn, src);
 	/* Turn the load into a no-op */
+	kill_use(&insn->src);
 	insn->opcode = OP_LNOP;
 	insn->bb = NULL;
 }
diff --git a/validation/optim/load-converted.c b/validation/optim/load-converted.c
index 010c6bc7b..7cbb53cf4 100644
--- a/validation/optim/load-converted.c
+++ b/validation/optim/load-converted.c
@@ -8,7 +8,6 @@ static int foo(int *p, int i)
 /*
  * check-name: load-converted
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-excludes: add\.
-- 
2.16.0

