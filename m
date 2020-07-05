From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] predef: simplify add_pre_buffer()
Date: Sun,  5 Jul 2020 12:29:10 +0200
Message-ID: <20200705102910.12851-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgGEK3Q (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 06:29:16 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51261C061794
        for <linux-sparse@vger.kernel.org>; Sun,  5 Jul 2020 03:29:16 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id n2so22998687edr.5
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 03:29:16 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

pre_buffer_begin & pre_buffer_end are the head and the tail of
a singly chained list. As such, it's slightly easier to not
keep a pointer on the last element but a pointer where the
next element should be written.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/lib.c b/lib.c
index e56788260cb7..863900b54c3c 100644
--- a/lib.c
+++ b/lib.c
@@ -248,7 +248,7 @@ void die(const char *fmt, ...)
 }
 
 static struct token *pre_buffer_begin = NULL;
-static struct token *pre_buffer_end = NULL;
+static struct token **pre_buffer_next = &pre_buffer_begin;
 
 int Waddress = 0;
 int Waddress_space = 1;
@@ -348,11 +348,8 @@ void add_pre_buffer(const char *fmt, ...)
 	size = vsnprintf(buffer, sizeof(buffer), fmt, args);
 	va_end(args);
 	begin = tokenize_buffer(buffer, size, &end);
-	if (!pre_buffer_begin)
-		pre_buffer_begin = begin;
-	if (pre_buffer_end)
-		pre_buffer_end->next = begin;
-	pre_buffer_end = end;
+	*pre_buffer_next = begin;
+	pre_buffer_next = &end->next;
 }
 
 ////////////////////////////////////////////////////////////////////////////////
-- 
2.27.0
