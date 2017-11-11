From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] flush stdout when warning
Date: Sat, 11 Nov 2017 17:31:22 +0100
Message-ID: <20171111163122.69604-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52704 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751517AbdKKQd3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 11:33:29 -0500
Received: by mail-wm0-f65.google.com with SMTP id t139so7954731wmt.1
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 08:33:29 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This is much needed for tools like test-linearize
which output on stderr & stdout and without this patch
error messages and normal output are out-of-sync.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib.c b/lib.c
index 73e9a2fe6..ac2e8e0ec 100644
--- a/lib.c
+++ b/lib.c
@@ -110,6 +110,7 @@ static void do_warn(const char *type, struct position pos, const char * fmt, va_
 	vsprintf(buffer, fmt, args);	
 	name = stream_name(pos.stream);
 		
+	fflush(stdout);
 	fprintf(stderr, "%s:%d:%d: %s%s\n",
 		name, pos.line, pos.pos, type, buffer);
 }
-- 
2.14.0

