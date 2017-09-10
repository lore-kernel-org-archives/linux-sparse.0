From: Martin Kepplinger <martink@posteo.de>
Subject: [PATCH] compile-i386.c: fix a memory leak in sort_array()
Date: Sun, 10 Sep 2017 14:02:02 +0200
Message-ID: <20170910120202.29853-1-martink@posteo.de>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mout02.posteo.de ([185.67.36.66]:59690 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751441AbdIJMCL (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 10 Sep 2017 08:02:11 -0400
Received: from submission (posteo.de [89.146.220.130])
        by mout02.posteo.de (Postfix) with ESMTPS id F3B9120A60
        for <linux-sparse@vger.kernel.org>; Sun, 10 Sep 2017 14:02:09 +0200 (CEST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org, jgarzik@pobox.com
Cc: linux-sparse@vger.kernel.org, Martin Kepplinger <martink@posteo.de>

sort_array() locally allocates a list it. Let's free it before returning
in order to avoid memory to leak.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
 compile-i386.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/compile-i386.c b/compile-i386.c
index 44b72ec..e4d3f27 100644
--- a/compile-i386.c
+++ b/compile-i386.c
@@ -1048,6 +1048,7 @@ static void sort_array(struct expression *expr)
 			*THIS_ADDRESS(entry) = list[i++];
 	} END_FOR_EACH_PTR(entry);
 
+	free(list);
 }
 
 static void emit_array(struct symbol *sym)
-- 
2.11.0

