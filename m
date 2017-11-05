From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 02/36] build: put comment about local.mk to the place where it is included
Date: Sun,  5 Nov 2017 17:25:10 +0100
Message-ID: <20171105162544.72960-2-luc.vanoostenryck@gmail.com>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:49502 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbdKEQZy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 11:25:54 -0500
Received: by mail-wm0-f66.google.com with SMTP id b189so9452448wmd.4
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 08:25:54 -0800 (PST)
In-Reply-To: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

From: Uwe Kleine-König <uwe@kleine-koenig.org>

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index e011df3cc..ddb4c5e3d 100644
--- a/Makefile
+++ b/Makefile
@@ -22,11 +22,6 @@ CHECKER = ./cgcc -no-compile
 CHECKER_FLAGS =
 
 ALL_CFLAGS = $(CFLAGS) $(BASIC_CFLAGS)
-#
-# For debugging, put this in local.mk:
-#
-#     CFLAGS += -O0 -DDEBUG -g3 -gdwarf-2
-#
 
 HAVE_LIBXML:=$(shell $(PKG_CONFIG) --exists libxml-2.0 2>/dev/null && echo 'yes')
 HAVE_GCC_DEP:=$(shell touch .gcc-test.c && 				\
@@ -167,6 +162,10 @@ SED_PC_CMD = 's|@version@|$(VERSION)|g;		\
 
 
 # Allow users to override build settings without dirtying their trees
+# For debugging, put this in local.mk:
+#
+#     CFLAGS += -O0 -DDEBUG -g3 -gdwarf-2
+#
 -include local.mk
 
 
-- 
2.14.0

