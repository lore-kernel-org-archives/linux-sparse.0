From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 16/38] build: CHECKER_FLAGS=-Wno-vla for all targets
Date: Sat, 11 Nov 2017 15:24:15 +0100
Message-ID: <20171111142437.67359-17-luc.vanoostenryck@gmail.com>
References: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37227 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbdKKOZS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 09:25:18 -0500
Received: by mail-wm0-f66.google.com with SMTP id b14so7476580wme.2
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 06:25:17 -0800 (PST)
In-Reply-To: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>, Josh Triplett <josh@joshtriplett.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 2df5aa2c9..2cbea4278 100644
--- a/Makefile
+++ b/Makefile
@@ -18,7 +18,7 @@ LD = gcc
 AR = ar
 PKG_CONFIG = pkg-config
 CHECKER = ./cgcc -no-compile
-CHECKER_FLAGS =
+CHECKER_FLAGS = -Wno-vla
 
 HAVE_LIBXML:=$(shell $(PKG_CONFIG) --exists libxml-2.0 2>/dev/null && echo 'yes')
 HAVE_GCC_DEP:=$(shell touch .gcc-test.c && 				\
@@ -186,8 +186,6 @@ DEPS := $(OBJS:%.o=.%.o.d)
 -include $(DEPS)
 
 
-pre-process.sc: CHECKER_FLAGS += -Wno-vla
