From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [SPARSE PATCH 3/5] do not issue a branch to non-existent label
Date: Fri, 10 Apr 2020 20:49:16 +0200
Message-ID: <20200410184918.64692-4-luc.vanoostenryck@gmail.com>
References: <20200410184918.64692-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46188 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgDJSte (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 10 Apr 2020 14:49:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id f13so3228985wrm.13
        for <linux-sparse@vger.kernel.org>; Fri, 10 Apr 2020 11:49:31 -0700 (PDT)
In-Reply-To: <20200410184918.64692-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

If the label doesn't exist, the corresponding BB will never
be created and the CFG will be invalid.

So, do not issue the branch for goto to these labels.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c                         | 13 +++++++++++--
 validation/linear/invalid-labels0.c |  1 -
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/linearize.c b/linearize.c
index b040d345d469..4e9f9b3693e9 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2379,6 +2379,7 @@ static pseudo_t linearize_statement(struct entrypoint *ep, struct statement *stm
 	}
 
 	case STMT_GOTO: {
+		struct symbol *label;
 		struct symbol *sym;
 		struct expression *expr;
 		struct instruction *goto_ins;
@@ -2389,8 +2390,16 @@ static pseudo_t linearize_statement(struct entrypoint *ep, struct statement *stm
 		if (!bb_reachable(active))
 			break;
 
-		if (stmt->goto_label) {
-			add_goto(ep, get_bound_block(ep, stmt->goto_label));
+		label = stmt->goto_label;
+		if (label) {
+			if (!label->stmt) {
+				// do not issue a branch to non-existent labels
+				if (label->namespace == NS_LABEL)
+					break;
+				if (label->namespace == NS_NONE)
+					break;
+			}
+			add_goto(ep, get_bound_block(ep, label));
 			break;
 		}
 
diff --git a/validation/linear/invalid-labels0.c b/validation/linear/invalid-labels0.c
index ae3bf7283fb8..a15e9d434011 100644
--- a/validation/linear/invalid-labels0.c
+++ b/validation/linear/invalid-labels0.c
@@ -11,7 +11,6 @@ void bar(void)
 /*
  * check-name: invalid-labels0
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-excludes: END
-- 
2.26.0
