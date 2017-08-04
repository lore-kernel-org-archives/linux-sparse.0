From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/4] ptrlist: adjust ptr_list_size for the new ->rm field
Date: Fri,  4 Aug 2017 22:09:13 +0200
Message-ID: <20170804200915.56738-3-luc.vanoostenryck@gmail.com>
References: <CANeU7QkRWygQB_dsD4o4omB-G_xtZZVLZP4-DgaK3iDMd=HB4w@mail.gmail.com>
 <20170804200915.56738-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33760 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752050AbdHDUJY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 16:09:24 -0400
Received: by mail-wm0-f68.google.com with SMTP id q189so6848542wmd.0
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 13:09:23 -0700 (PDT)
In-Reply-To: <20170804200915.56738-1-luc.vanoostenryck@gmail.com>
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

