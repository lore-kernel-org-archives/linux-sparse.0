From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 35/37] build: reorg & add comment
Date: Thu,  9 Nov 2017 07:46:46 +0100
Message-ID: <20171109064648.15379-36-luc.vanoostenryck@gmail.com>
References: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:47602 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbdKIGr4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 01:47:56 -0500
Received: by mail-wm0-f66.google.com with SMTP id r196so14828174wmf.2
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 22:47:56 -0800 (PST)
In-Reply-To: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Josh Triplett <josh@joshtriplett.org>, Jeff Layton <jlayton@redhat.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

No functionnal changes here, only shuffling a few lines around,
adding separators and adding a few comments

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index bb45155af..afae2a370 100644
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
