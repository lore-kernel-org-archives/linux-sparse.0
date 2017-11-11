From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 27/38] build: allow the name 'local.mk' to be configurable via the environment
Date: Sat, 11 Nov 2017 15:24:26 +0100
Message-ID: <20171111142437.67359-28-luc.vanoostenryck@gmail.com>
References: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33722 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbdKKOZh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 09:25:37 -0500
Received: by mail-wm0-f66.google.com with SMTP id r68so8900220wmr.0
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 06:25:37 -0800 (PST)
In-Reply-To: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>, Josh Triplett <josh@joshtriplett.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

So people who like this file to be a hidden one or to be an
out-of-tree file or simply who don't like the name, can choose
whatever suits them the best.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 .gitignore | 1 +
 Makefile   | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index ab976e76b..bc00736d7 100644
--- a/.gitignore
+++ b/.gitignore
@@ -37,6 +37,7 @@ series
 
 # local makefile
 local.mk
+.*.mk
 
 # cscope and Qt files
 cscope.out
diff --git a/Makefile b/Makefile
index 7f136e87e..e4efefa1e 100644
--- a/Makefile
+++ b/Makefile
@@ -25,7 +25,8 @@ MAN1DIR=$(MANDIR)/man1
 #
 #     CFLAGS += -O0 -DDEBUG -g3 -gdwarf-2
 #
--include local.mk
+SPARSE_LOCAL_CONFIG ?= local.mk
+-include ${SPARSE_LOCAL_CONFIG}
 ########################################################################
 
 
-- 
2.14.0

