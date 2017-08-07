From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 3/8] reuse nbr_pseudo_users()
Date: Mon,  7 Aug 2017 21:12:00 +0200
Message-ID: <20170807191205.86590-4-luc.vanoostenryck@gmail.com>
References: <CACXZuxd30jwczag_GHW3cmqPcBybEi7jfwfku81vW2nHzo_kyA@mail.gmail.com>
 <20170807191205.86590-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35373 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbdHGTMO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 15:12:14 -0400
Received: by mail-wm0-f68.google.com with SMTP id r77so2061035wmd.2
        for <linux-sparse@vger.kernel.org>; Mon, 07 Aug 2017 12:12:14 -0700 (PDT)
In-Reply-To: <20170807191205.86590-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: linux-sparse@vger.kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This small helper was used in unssa.c but is helpfull elsewhere too.

Change it to an inline function and move it to one of the header.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.h | 5 +++++
 simplify.c  | 2 +-
 unssa.c     | 5 -----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/linearize.h b/linearize.h
index bac82d7ff..7f2e976e7 100644
--- a/linearize.h
+++ b/linearize.h
@@ -301,6 +301,11 @@ static inline struct pseudo_user *alloc_pseudo_user(struct instruction *insn, ps
 	return user;
 }
 
+static inline int nbr_pseudo_users(pseudo_t p)
+{
+	return ptr_list_size((struct ptr_list *)p->users);
+}
+
 static inline void use_pseudo(struct instruction *insn, pseudo_t p, pseudo_t *pp)
 {
 	*pp = p;
diff --git a/simplify.c b/simplify.c
index d9528de43..8b63bcaff 100644
--- a/simplify.c
+++ b/simplify.c
@@ -800,7 +800,7 @@ static int simplify_associative_binop(struct instruction *insn)
 		return 0;
 	if (!simple_pseudo(def->src2))
 		return 0;
-	if (ptr_list_size((struct ptr_list *)def->target->users) != 1)
+	if (nbr_pseudo_users(def->target) != 1)
 		return 0;
 	switch_pseudo(def, &def->src1, insn, &insn->src2);
 	return REPEAT_CSE;
diff --git a/unssa.c b/unssa.c
index e7c9154d5..736474b90 100644
--- a/unssa.c
+++ b/unssa.c
@@ -34,11 +34,6 @@
 #include <assert.h>
 
 
-static inline int nbr_pseudo_users(pseudo_t p)
-{
-	return ptr_list_size((struct ptr_list *)p->users);
-}
