From: Xi Wang <xi.wang@gmail.com>
Subject: [PATCH] compile-i386: fix use-after-free in func_cleanup()
Date: Fri,  1 Jun 2012 12:22:00 -0400
Message-ID: <1338567720-23595-1-git-send-email-xi.wang@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:54958 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965301Ab2FAQWW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 1 Jun 2012 12:22:22 -0400
Received: by qcro28 with SMTP id o28so1217807qcr.19
        for <linux-sparse@vger.kernel.org>; Fri, 01 Jun 2012 09:22:21 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Xi Wang <xi.wang@gmail.com>

compile-i386 sometimes crashes due a use-after-free error.  Since
f->pseudo_list is freed first, which invalidates some atom->op* in
f->atom_list.  Further checks like `atom->op1->flags & STOR_WANTS_FREE'
will read garbage, which may lead to a double free.

This patch switches the cleanup order and frees f->atom_list first.
Those marked as STOR_WANTS_FREE won't appear in f->pseudo_list.

Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
 compile-i386.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/compile-i386.c b/compile-i386.c
index da3ee49..b470952 100644
--- a/compile-i386.c
+++ b/compile-i386.c
@@ -761,10 +761,6 @@ static void func_cleanup(struct function *f)
 	struct storage *stor;
 	struct atom *atom;
 
-	FOR_EACH_PTR(f->pseudo_list, stor) {
-		free(stor);
-	} END_FOR_EACH_PTR(stor);
