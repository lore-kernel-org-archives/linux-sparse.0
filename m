From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/7] diet: use smaller LIST_NODE_NR (29 -> 13)
Date: Thu, 29 Jun 2017 07:16:41 +0200
Message-ID: <20170629051646.35988-3-luc.vanoostenryck@gmail.com>
References: <20170629051646.35988-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33112 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbdF2FTA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 29 Jun 2017 01:19:00 -0400
Received: by mail-wm0-f67.google.com with SMTP id j85so351609wmj.0
        for <linux-sparse@vger.kernel.org>; Wed, 28 Jun 2017 22:19:00 -0700 (PDT)
In-Reply-To: <20170629051646.35988-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently the size of the array used for ptrlist is 29.
However, some inspection shows that the mean size of ptrlists
is much smaller: around 2.5 - 5 only. This means that most memory
allocated for ptrlists are never used.

Change this by changing the size to the conservative value of 13.
With this value, on some test programs, memory used for ptrlists
is only 43% - 48% smaller or 24% - 28% for the total memory.
This difference in memory consumption allow also to win some time:
5 - 7% in the conditions used for the test but YMMV.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ptrlist.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ptrlist.h b/ptrlist.h
index d09be2f51..b605bb858 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -22,7 +22,7 @@
  */
 #define MKTYPE(head,expr)		({ (TYPEOF(head))(expr); })
 
-#define LIST_NODE_NR (29)
+#define LIST_NODE_NR (13)
 
 struct ptr_list {
 	int nr;
-- 
2.13.0

