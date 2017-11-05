From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 16/36] build: CHECKER_FLAGS=-Wno-vla for all targets
Date: Sun,  5 Nov 2017 17:25:24 +0100
Message-ID: <20171105162544.72960-16-luc.vanoostenryck@gmail.com>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:45272 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbdKEQ0L (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 11:26:11 -0500
Received: by mail-wm0-f67.google.com with SMTP id y80so9494515wmd.0
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 08:26:11 -0800 (PST)
In-Reply-To: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 2d3deec3a..c77a166f8 100644
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
