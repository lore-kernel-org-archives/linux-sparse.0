From: Davidson Francis <davidsondfgl@gmail.com>
Subject: [PATCH] show-parse: null pointer dereference in do_show_type()
Date: Mon, 11 May 2020 00:06:20 -0300
Message-ID: <20200511030620.10329-1-davidsondfgl@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725830AbgEKDHA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 10 May 2020 23:07:00 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AB0C061A0C
        for <linux-sparse@vger.kernel.org>; Sun, 10 May 2020 20:06:59 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id l1so3321604qtp.6
        for <linux-sparse@vger.kernel.org>; Sun, 10 May 2020 20:06:59 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Davidson Francis <davidsondfgl@gmail.com>

In do_show_type() the first if statement allows passing null
pointers, which can cause a null pointer dereference in some
cases, which I believe is not the desired behavior.

Fix this by changing the first if statement comparison.

Signed-off-by: Davidson Francis <davidsondfgl@gmail.com>
---
 show-parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/show-parse.c b/show-parse.c
index 3aa06e47..11a487bc 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -300,7 +300,7 @@ static void do_show_type(struct symbol *sym, struct type_name *name)
 	int fouled = 0;
 
 deeper:
-	if (!sym || (sym->type != SYM_NODE && sym->type != SYM_ARRAY &&
+	if (sym && (sym->type != SYM_NODE && sym->type != SYM_ARRAY &&
 		     sym->type != SYM_BITFIELD)) {
 		const char *s;
 		size_t len;
-- 
2.11.0
