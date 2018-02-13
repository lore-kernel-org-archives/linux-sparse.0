From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 03/10] fix killing of converted loads
Date: Tue, 13 Feb 2018 22:58:05 +0100
Message-ID: <20180213215812.18735-4-luc.vanoostenryck@gmail.com>
References: <20180213215812.18735-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50342 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965960AbeBMWAX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Feb 2018 17:00:23 -0500
Received: by mail-wm0-f65.google.com with SMTP id k87so1017338wmi.0
        for <linux-sparse@vger.kernel.org>; Tue, 13 Feb 2018 14:00:22 -0800 (PST)
In-Reply-To: <20180213215812.18735-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Converted loads are dead and can be removed but that
also means that the address usage need to be adjusted
which wasn't done.

Fix this by directly using kill_instruction().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c                            | 4 +---
 validation/optim/load-converted.c | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/flow.c b/flow.c
index 62658b920..c614a11d9 100644
--- a/flow.c
+++ b/flow.c
@@ -305,9 +305,7 @@ void convert_instruction_target(struct instruction *insn, pseudo_t src)
 void convert_load_instruction(struct instruction *insn, pseudo_t src)
 {
 	convert_instruction_target(insn, src);
-	/* Turn the load into a no-op */
-	insn->opcode = OP_LNOP;
-	insn->bb = NULL;
+	kill_instruction(insn);
 }
 
 static int overlapping_memop(struct instruction *a, struct instruction *b)
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

