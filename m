From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 5/5] mark pseudo users as deleted instead of removing them
Date: Fri,  4 Aug 2017 23:53:21 +0200
Message-ID: <20170804215321.66392-6-luc.vanoostenryck@gmail.com>
References: <20170804215321.66392-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33170 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752535AbdHDVxg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 17:53:36 -0400
Received: by mail-wr0-f193.google.com with SMTP id y43so3758075wrd.0
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 14:53:36 -0700 (PDT)
In-Reply-To: <20170804215321.66392-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This will fix the (rare) problems with deletion while doing
nested ptrlist walking that occurs when doing recursive
kill_instruction() - remove_usage() - kill_instruction()

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/simplify.c b/simplify.c
index 03ff9c942..2bc86f53e 100644
--- a/simplify.c
+++ b/simplify.c
@@ -172,14 +172,15 @@ static int delete_pseudo_user_list_entry(struct pseudo_user_list **list, pseudo_
 
 	FOR_EACH_PTR(*list, pu) {
 		if (pu->userp == entry) {
-			DELETE_CURRENT_PTR(pu);
+			MARK_CURRENT_DELETED(pu);
 			if (!--count)
 				goto out;
 		}
 	} END_FOR_EACH_PTR(pu);
 	assert(count <= 0);
 out:
-	pack_ptr_list((struct ptr_list **)list);
+	if (ptr_list_size((struct ptr_list *) *list) == 0)
+		*list = NULL;
 	return count;
 }
 
-- 
2.13.2

