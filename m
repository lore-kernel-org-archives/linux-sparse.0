From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 35/36] build: reorg & add comment
Date: Sun,  5 Nov 2017 17:25:43 +0100
Message-ID: <20171105162544.72960-35-luc.vanoostenryck@gmail.com>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52269 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbdKEQ0q (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 11:26:46 -0500
Received: by mail-wm0-f66.google.com with SMTP id t139so9835976wmt.1
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 08:26:46 -0800 (PST)
In-Reply-To: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

No functionnal changes here, only shuffling a few lines around,
adding separators and adding a few comments

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 82ca2fe06..5ce359492 100644
--- a/Makefile
+++ b/Makefile
@@ -84,6 +84,9 @@ cflags += -DGCC_BASE=\"$(GCC_BASE)\"
 MULTIARCH_TRIPLET := $(shell $(CC) -print-multiarch 2>/dev/null)
 cflags += -DMULTIARCH_TRIPLET=\"$(MULTIARCH_TRIPLET)\"
 
+########################################################################
+# target specificities
+
 compile: compile-i386.o
 EXTRA_OBJS += compile-i386.o
 
@@ -156,15 +159,15 @@ else
 $(warning Your system does not have llvm, disabling sparse-llvm)
 endif
 
+########################################################################
 LIBS := libsparse.a
+OBJS := $(LIB_OBJS) $(EXTRA_OBJS) $(PROGRAMS:%=%.o)
 
-#
 # Pretty print
-#
 V	      = @
 Q	      = $(V:1=)
 
-
+########################################################################
 all: $(PROGRAMS)
 
 ldflags += $($(@)_LDFLAGS) $(LDFLAGS)
@@ -177,11 +180,6 @@ libsparse.a: $(LIB_OBJS)
 	@echo "  AR      $@"
 	$(Q)$(AR) rcs $@ $^
 
-OBJS := $(LIB_OBJS) $(EXTRA_OBJS) $(PROGRAMS:%=%.o)
-DEPS := $(OBJS:%.o=.%.o.d)
-
--include $(DEPS)
