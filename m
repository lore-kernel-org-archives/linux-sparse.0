From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: [PATCH 2/6] build: put comment about local.mk to the place where it is included
Date: Wed,  4 Oct 2017 15:26:01 +0200
Message-ID: <20171004132605.24734-3-uwe@kleine-koenig.org>
References: <20171004132605.24734-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:54538 "EHLO
        arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752350AbdJDN0N (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 4 Oct 2017 09:26:13 -0400
In-Reply-To: <20171004132605.24734-1-uwe@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 Makefile | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index e011df3cc0dc..ddb4c5e3de02 100644
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
2.14.2

