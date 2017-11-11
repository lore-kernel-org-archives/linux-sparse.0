From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 35/38] build: reorg & add comment
Date: Sat, 11 Nov 2017 15:24:34 +0100
Message-ID: <20171111142437.67359-36-luc.vanoostenryck@gmail.com>
References: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54620 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751124AbdKKOZy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 09:25:54 -0500
Received: by mail-wm0-f65.google.com with SMTP id r68so7599809wmr.3
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 06:25:54 -0800 (PST)
In-Reply-To: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>, Josh Triplett <josh@joshtriplett.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

No functionnal changes here, only shuffling a few lines around,
adding separators and adding a few comments

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index d67f54afe..92bf9e726 100644
--- a/Makefile
+++ b/Makefile
@@ -85,6 +85,9 @@ cflags += -DGCC_BASE=\"$(GCC_BASE)\"
 MULTIARCH_TRIPLET := $(shell $(CC) -print-multiarch 2>/dev/null)
 cflags += -DMULTIARCH_TRIPLET=\"$(MULTIARCH_TRIPLET)\"
 
+########################################################################
+# target specificities
+
 compile: compile-i386.o
 EXTRA_OBJS += compile-i386.o
 
@@ -157,15 +160,15 @@ else
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
 
 ldflags += $($(@)-ldflags) $(LDFLAGS)
@@ -178,11 +181,6 @@ libsparse.a: $(LIB_OBJS)
 	@echo "  AR      $@"
 	$(Q)$(AR) rcs $@ $^
 
-OBJS := $(LIB_OBJS) $(EXTRA_OBJS) $(PROGRAMS:%=%.o)
-DEPS := $(OBJS:%.o=.%.o.d)
-
--include $(DEPS)
