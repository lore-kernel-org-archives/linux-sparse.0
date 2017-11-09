From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 27/37] build: use a dot file name instead of local.mk: .sparse.mk
Date: Thu,  9 Nov 2017 07:46:38 +0100
Message-ID: <20171109064648.15379-28-luc.vanoostenryck@gmail.com>
References: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50565 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752465AbdKIGro (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 01:47:44 -0500
Received: by mail-wm0-f66.google.com with SMTP id s66so14661969wmf.5
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 22:47:44 -0800 (PST)
In-Reply-To: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Josh Triplett <josh@joshtriplett.org>, Jeff Layton <jlayton@redhat.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 .gitignore | 2 +-
 Makefile   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.gitignore b/.gitignore
index ab976e76b..35b4d0248 100644
--- a/.gitignore
+++ b/.gitignore
@@ -36,7 +36,7 @@ patches
 series
 
 # local makefile
-local.mk
+.sparse.mk
 
 # cscope and Qt files
 cscope.out
diff --git a/Makefile b/Makefile
index 4f6ab108c..afc1efe98 100644
--- a/Makefile
+++ b/Makefile
@@ -21,11 +21,11 @@ MANDIR=$(PREFIX)/share/man
 MAN1DIR=$(MANDIR)/man1
 
 # Allow users to override build settings without dirtying their trees
-# For debugging, put this in local.mk:
+# For debugging, put this in .sparse.mk:
 #
 #     CFLAGS += -O0 -DDEBUG -g3 -gdwarf-2
 #
--include local.mk
+-include .sparse.mk
 ########################################################################
 
 
-- 
2.14.0

