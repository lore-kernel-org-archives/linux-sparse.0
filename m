From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/9] add helpers for pseudo's user-list's size
Date: Mon, 12 Feb 2018 23:02:41 +0100
Message-ID: <20180212220246.17750-5-luc.vanoostenryck@gmail.com>
References: <20180212220246.17750-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54742 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932699AbeBLWC7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 12 Feb 2018 17:02:59 -0500
Received: by mail-wm0-f67.google.com with SMTP id i186so12282310wmi.4
        for <linux-sparse@vger.kernel.org>; Mon, 12 Feb 2018 14:02:58 -0800 (PST)
In-Reply-To: <20180212220246.17750-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Add pseudo_user_list_size() instead of having to use
ptr_list_size() with an ugly cast.
Also add has_user(), a wrapper around the above that
can directly be used on a pseudo.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.h | 10 ++++++++++
 simplify.c  |  4 ++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/linearize.h b/linearize.h
index c0c49bdf0..15a6be9c9 100644
--- a/linearize.h
+++ b/linearize.h
@@ -325,6 +325,16 @@ static inline int has_use_list(pseudo_t p)
 	return (p && p->type != PSEUDO_VOID && p->type != PSEUDO_VAL);
 }
 
+static inline int pseudo_user_list_size(struct pseudo_user_list *list)
+{
+	return ptr_list_size((struct ptr_list *)list);
+}
+
+static inline int has_users(pseudo_t p)
+{
+	return pseudo_user_list_size(p->users) != 0;
+}
+
 static inline struct pseudo_user *alloc_pseudo_user(struct instruction *insn, pseudo_t *pp)
 {
 	struct pseudo_user *user = __alloc_pseudo_user(0);
diff --git a/simplify.c b/simplify.c
index 8aac852b4..971f8ca91 100644
--- a/simplify.c
+++ b/simplify.c
@@ -179,7 +179,7 @@ static int delete_pseudo_user_list_entry(struct pseudo_user_list **list, pseudo_
 	} END_FOR_EACH_PTR(pu);
 	assert(count <= 0);
 out:
-	if (ptr_list_size((struct ptr_list *) *list) == 0)
+	if (pseudo_user_list_size(*list) == 0)
 		*list = NULL;
 	return count;
 }
@@ -797,7 +797,7 @@ static int simplify_associative_binop(struct instruction *insn)
 		return 0;
 	if (!simple_pseudo(def->src2))
 		return 0;
-	if (ptr_list_size((struct ptr_list *)def->target->users) != 1)
+	if (pseudo_user_list_size(def->target->users) != 1)
 		return 0;
 	switch_pseudo(def, &def->src1, insn, &insn->src2);
 	return REPEAT_CSE;
-- 
2.16.0

