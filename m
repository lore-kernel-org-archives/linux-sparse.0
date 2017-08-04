From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 2/5] ptrlist: adjust ptr_list_size for the new ->rm field
Date: Fri,  4 Aug 2017 23:53:18 +0200
Message-ID: <20170804215321.66392-3-luc.vanoostenryck@gmail.com>
References: <20170804215321.66392-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36396 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752456AbdHDVxb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 17:53:31 -0400
Received: by mail-wr0-f195.google.com with SMTP id y67so3765377wrb.3
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 14:53:30 -0700 (PDT)
In-Reply-To: <20170804215321.66392-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ptrlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ptrlist.c b/ptrlist.c
index 5dc1117c5..8402f8d2b 100644
--- a/ptrlist.c
+++ b/ptrlist.c
@@ -23,7 +23,7 @@ int ptr_list_size(struct ptr_list *head)
 	if (head) {
 		struct ptr_list *list = head;
 		do {
-			nr += list->nr;
+			nr += list->nr - list->rm;
 		} while ((list = list->next) != head);
 	}
 	return nr;
-- 
2.13.2

