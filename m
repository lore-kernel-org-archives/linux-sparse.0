From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 16/37] build: CHECKER_FLAGS=-Wno-vla for all targets
Date: Thu,  9 Nov 2017 07:46:27 +0100
Message-ID: <20171109064648.15379-17-luc.vanoostenryck@gmail.com>
References: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56986 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752493AbdKIGrX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 01:47:23 -0500
Received: by mail-wm0-f65.google.com with SMTP id z3so15288581wme.5
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 22:47:23 -0800 (PST)
In-Reply-To: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Josh Triplett <josh@joshtriplett.org>, Jeff Layton <jlayton@redhat.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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
