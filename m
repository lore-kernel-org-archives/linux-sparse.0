From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 24/36] build: remove rule for shared lib, it's unused
Date: Sun,  5 Nov 2017 17:25:32 +0100
Message-ID: <20171105162544.72960-24-luc.vanoostenryck@gmail.com>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52236 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750782AbdKEQ01 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 11:26:27 -0500
Received: by mail-wm0-f66.google.com with SMTP id t139so9835252wmt.1
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 08:26:27 -0800 (PST)
In-Reply-To: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/Makefile b/Makefile
index 8132142af..0f69b479f 100644
--- a/Makefile
+++ b/Makefile
@@ -116,16 +116,7 @@ else
 $(warning Your system does not have llvm, disabling sparse-llvm)
 endif
 
-LIB_FILE= libsparse.a
-SLIB_FILE= libsparse.so
-
-# If you add $(SLIB_FILE) to this, you also need to add -fpic to CFLAGS above.
-# Doing so incurs a noticeable performance hit, and Sparse does not have a
-# stable shared library interface, so this does not occur by default.  If you
-# really want a shared library, you may want to build Sparse twice: once
-# without -fpic to get all the Sparse tools, and again with -fpic to get the
-# shared library.
-LIBS=$(LIB_FILE)
+LIBS := libsparse.a
 
 #
 # Pretty print
@@ -172,12 +163,9 @@ $(foreach p,$(PROGRAMS),$(eval $(p): $($(p)_OBJS)))
 $(PROGRAMS): % : %.o $(LIBS)
 	$(QUIET_LINK)$(LD) $(ldflags) -o $@ $^ $(ldlibs)
 
-$(LIB_FILE): $(LIB_OBJS)
+libsparse.a: $(LIB_OBJS)
 	$(QUIET_AR)$(AR) rcs $@ $(LIB_OBJS)
 
-$(SLIB_FILE): $(LIB_OBJS)
-	$(QUIET_LINK)$(CC) $(LDFLAGS) -Wl,-soname,$@ -shared -o $@ $(LIB_OBJS)
