From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 20/38] build: remove references to unexisting pre-process.h
Date: Sat, 11 Nov 2017 15:24:19 +0100
Message-ID: <20171111142437.67359-21-luc.vanoostenryck@gmail.com>
References: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38451 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbdKKOZY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 09:25:24 -0500
Received: by mail-wm0-f65.google.com with SMTP id p75so7471947wmg.3
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 06:25:24 -0800 (PST)
In-Reply-To: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>, Josh Triplett <josh@joshtriplett.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 .gitignore | 1 -
 Makefile   | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index 9f996dc87..ab976e76b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -6,7 +6,6 @@
 .*.swp
 
 # generated
-pre-process.h
 version.h
 
 # programs
diff --git a/Makefile b/Makefile
index f1f210e27..983b4647d 100644
--- a/Makefile
+++ b/Makefile
@@ -207,7 +207,7 @@ version.h: FORCE
 
 
 clean: clean-check
-	rm -f *.[oa] .*.d *.so $(PROGRAMS) $(SLIB_FILE) pre-process.h version.h
+	rm -f *.[oa] .*.d *.so $(PROGRAMS) $(SLIB_FILE) version.h
 
 dist:
 	@if test "$(SPARSE_VERSION)" != "v$(VERSION)" ; then \
-- 
2.14.0

