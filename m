From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] preprocess: use predefine() also for __%s__TYPE__
Date: Mon, 29 Jun 2020 21:20:47 +0200
Message-ID: <20200629192047.92114-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbgF2TUw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 29 Jun 2020 15:20:52 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6D2C061755
        for <linux-sparse@vger.kernel.org>; Mon, 29 Jun 2020 12:20:52 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id d16so7268264edz.12
        for <linux-sparse@vger.kernel.org>; Mon, 29 Jun 2020 12:20:52 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Most predefined macros are created by predefine() which
avoid the 'write then parse' done with add_pre_buffer() but
those defined by predefined_type() did not.

So, convert predefine_type() to use predefine().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib.c b/lib.c
index e56788260cb7..d8fbe8b1a006 100644
--- a/lib.c
+++ b/lib.c
@@ -1274,7 +1274,10 @@ static void predefined_min(const char *name, struct symbol *type)
 static void predefined_type(const char *name, struct symbol *type)
 {
 	const char *typename = builtin_typename(type);
-	add_pre_buffer("#weak_define __%s_TYPE__ %s\n", name, typename);
+	char buf[32];
+
+	snprintf(buf, sizeof(buf), "__%s_TYPE__", name);
+	predefine(buf, 1, typename);
 }
 
 static void predefined_ctype(const char *name, struct symbol *type, int flags)
-- 
2.27.0
