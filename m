From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] fix: volatile stores must not be simplified
Date: Sat, 11 Nov 2017 17:25:00 +0100
Message-ID: <20171111162500.69476-3-luc.vanoostenryck@gmail.com>
References: <20171111162500.69476-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35646 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751390AbdKKQ1M (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 11:27:12 -0500
Received: by mail-wm0-f66.google.com with SMTP id y80so7753444wmd.0
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 08:27:12 -0800 (PST)
In-Reply-To: <20171111162500.69476-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

kill_dominated_stores() simplify away redundant stores.
Nice but volatile stores are never redundant and must
never be simplified away.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 memops.c                     | 6 +++++-
 validation/memops-volatile.c | 1 -
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/memops.c b/memops.c
index aeacdf566..1c845a5f9 100644
--- a/memops.c
+++ b/memops.c
@@ -158,8 +158,12 @@ static void kill_dominated_stores(struct basic_block *bb)
 		if (insn->opcode == OP_STORE) {
 			struct instruction *dom;
 			pseudo_t pseudo = insn->src;
-			int local = local_pseudo(pseudo);
+			int local;
+
+			if (insn->type->ctype.modifiers & MOD_VOLATILE)
+				continue;
 
+			local = local_pseudo(pseudo);
 			RECURSE_PTR_REVERSE(insn, dom) {
 				int dominance;
 				if (!dom->bb)
diff --git a/validation/memops-volatile.c b/validation/memops-volatile.c
index 71299f49d..15314e1ce 100644
--- a/validation/memops-volatile.c
+++ b/validation/memops-volatile.c
@@ -9,7 +9,6 @@ static int foo(volatile int *a, int v)
  * check-name: memops-volatile
  * check-command: test-linearize $file
  *
- * check-known-to-fail
  * check-output-ignore
  * check-output-contains: store\\..*%arg2 -> 0\\[%arg1]
  * check-output-contains: store\\..*\\$0 -> 0\\[%arg1]
-- 
2.14.0

