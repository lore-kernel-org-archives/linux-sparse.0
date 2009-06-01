From: Samuel Bronson <naesten@gmail.com>
Subject: [PATCH 4/4] Have Makefile import config.mak if it exists.
Date: Mon,  1 Jun 2009 14:37:25 -0400
Message-ID: <1243881445-30069-4-git-send-email-naesten@gmail.com>
References: <1243881445-30069-1-git-send-email-naesten@gmail.com>
 <1243881445-30069-2-git-send-email-naesten@gmail.com>
 <1243881445-30069-3-git-send-email-naesten@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from 170-23.widener.edu ([147.31.170.23]:42792 "EHLO
	naruto.cs.widener.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbZFASaj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 1 Jun 2009 14:30:39 -0400
In-Reply-To: <1243881445-30069-3-git-send-email-naesten@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Samuel Bronson <naesten@gmail.com>

This will allow users to override build settings without dirtying their
trees, making life with `git stash' a bit easier.

Signed-off-by: Samuel Bronson <naesten@gmail.com>
---
 Makefile |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 18cec68..f45a74a 100644
--- a/Makefile
+++ b/Makefile
@@ -10,9 +10,10 @@ LDFLAGS += -g
 AR = ar
 
 #
-# For debugging, uncomment the next one
+# For debugging, put this in config.mak:
+#
+#     CFLAGS += -O0 -DDEBUG -g3 -gdwarf-2
 #
-#CFLAGS += -O0 -DDEBUG -g3 -gdwarf-2
 
 HAVE_LIBXML=$(shell pkg-config --exists libxml-2.0 && echo 'yes')
 
@@ -73,6 +74,11 @@ QUIET_LINK    = $(Q:@=@echo    '     LINK     '$@;)
 QUIET_INST_SH = $(Q:@=echo -n  '     INSTALL  ';)
 QUIET_INST    = $(Q:@=@echo -n '     INSTALL  ';)
 
+
+# Allow users to override build settings without dirtying their trees
+-include config.mak
+
+
 all: $(PROGRAMS) sparse.pc
 
 install: $(INST_PROGRAMS) $(LIBS) $(LIB_H) sparse.pc
-- 
1.6.3.1.169.g33fd.dirty

