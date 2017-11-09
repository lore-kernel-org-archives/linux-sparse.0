From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 20/37] build: remove references to unexisting pre-process.h
Date: Thu,  9 Nov 2017 07:46:31 +0100
Message-ID: <20171109064648.15379-21-luc.vanoostenryck@gmail.com>
References: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51977 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752493AbdKIGra (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 01:47:30 -0500
Received: by mail-wm0-f67.google.com with SMTP id b9so15332317wmh.0
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 22:47:29 -0800 (PST)
In-Reply-To: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Josh Triplett <josh@joshtriplett.org>, Jeff Layton <jlayton@redhat.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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
index f150b9eb9..a8578c305 100644
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

