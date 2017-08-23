From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 14/48] add remove_use()
Date: Wed, 23 Aug 2017 22:15:20 +0200
Message-ID: <20170823201554.90551-15-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38765 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932443AbdHWUQ1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:16:27 -0400
Received: by mail-wm0-f67.google.com with SMTP id a70so623298wmd.5
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:16:27 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Add an helper to remove the usage of a pseudo, like kill_use()
do but unlike kill_use(), without trying to kill (recursively!)
the defining instruction if the usage drop to zero.

It will be used during SSA construction, when it is not yet safe
to kill instructions. If the usage drop to zero, nothing special
is done, the instruaction becomes dead and will be eliminated
later.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.h     |  1 +
 simplify.c | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/flow.h b/flow.h
index b592ad4d3..3133245e5 100644
--- a/flow.h
+++ b/flow.h
@@ -24,6 +24,7 @@ extern int simplify_instruction(struct instruction *);
 
 extern void kill_bb(struct basic_block *);
 extern void kill_use(pseudo_t *);
+extern void remove_use(pseudo_t *);
 extern void kill_unreachable_bbs(struct entrypoint *ep);
 
 extern void kill_insn(struct instruction *, int force);
diff --git a/simplify.c b/simplify.c
index 766ac451d..cea903a24 100644
--- a/simplify.c
+++ b/simplify.c
@@ -224,6 +224,19 @@ void kill_use(pseudo_t *usep)
 	}
 }
 
+/*
+ * Like kill_use() but do not recursively kill instructions
+ * that become without users.
+ */
+void remove_use(pseudo_t *usep)
+{
+	pseudo_t p = *usep;
+	*usep = VOID;
+	if (has_use_list(p)) {
+		delete_pseudo_user_list_entry(&p->users, usep, 1);
+	}
+}
+
 static void kill_use_list(struct pseudo_list *list)
 {
 	pseudo_t p;
-- 
2.14.0

