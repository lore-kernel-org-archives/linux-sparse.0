From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 3/8] reuse nbr_pseudo_users()
Date: Wed,  9 Aug 2017 01:06:29 +0200
Message-ID: <20170808230634.16227-4-luc.vanoostenryck@gmail.com>
References: <20170808230634.16227-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36913 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752495AbdHHXG4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 8 Aug 2017 19:06:56 -0400
Received: by mail-wm0-f66.google.com with SMTP id t138so4898964wmt.4
        for <linux-sparse@vger.kernel.org>; Tue, 08 Aug 2017 16:06:56 -0700 (PDT)
In-Reply-To: <20170808230634.16227-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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
