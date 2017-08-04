From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/4] ptrlist: add a counter for the number of removed elemnets
Date: Fri,  4 Aug 2017 22:09:12 +0200
Message-ID: <20170804200915.56738-2-luc.vanoostenryck@gmail.com>
References: <CANeU7QkRWygQB_dsD4o4omB-G_xtZZVLZP4-DgaK3iDMd=HB4w@mail.gmail.com>
 <20170804200915.56738-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38314 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752050AbdHDUJW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 16:09:22 -0400
Received: by mail-wr0-f194.google.com with SMTP id g32so3632856wrd.5
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 13:09:21 -0700 (PDT)
In-Reply-To: <20170804200915.56738-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ptrlist.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ptrlist.h b/ptrlist.h
index d09be2f51..d8203cf0b 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -25,7 +25,8 @@
 #define LIST_NODE_NR (29)
 
 struct ptr_list {
-	int nr;
+	int nr:8;
+	int rm:8;
 	struct ptr_list *prev;
 	struct ptr_list *next;
 	void *list[LIST_NODE_NR];
-- 
2.13.2

