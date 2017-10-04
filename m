From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: [PATCH 5/6] build: pass standard make variables to compiler and linker
Date: Wed,  4 Oct 2017 15:26:04 +0200
Message-ID: <20171004132605.24734-6-uwe@kleine-koenig.org>
References: <20171004132605.24734-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:54541 "EHLO
        arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752620AbdJDN0Q (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 4 Oct 2017 09:26:16 -0400
In-Reply-To: <20171004132605.24734-1-uwe@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Add all variables that make's builtin rules pass to compiler and linker.

I don't know a user of TARGET_ARCH but Debian packages use CPPFLAGS to
pass -D_FORTIFY_SOURCE=2 for hardening.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 39b34f90107d..f6c577c02143 100644
--- a/Makefile
+++ b/Makefile
@@ -190,13 +190,13 @@ compile_EXTRA_DEPS = compile-i386.o
 
 $(foreach p,$(PROGRAMS),$(eval $(p): $($(p)_EXTRA_DEPS) $(LIBS)))
 $(PROGRAMS): % : %.o 
-	$(QUIET_LINK)$(LD) $(LDFLAGS) -o $@ $^ $($@_EXTRA_OBJS)
+	$(QUIET_LINK)$(LD) $(LDFLAGS) $(TARGET_ARCH) $^ $(LOADLIBES) $(LDLIBS) -o $@ $($@_EXTRA_OBJS)
 
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(AR) rcs $@ $(LIB_OBJS)
 
 $(SLIB_FILE): $(LIB_OBJS)
-	$(QUIET_LINK)$(CC) $(LDFLAGS) -Wl,-soname,$@ -shared -o $@ $(LIB_OBJS)
+	$(QUIET_LINK)$(CC) $(LDFLAGS) $(TARGET_ARCH) -Wl,-soname,$@ -shared $^ $(LOADLIBES) $(LDLIBS) -o $@
 
 DEP_FILES := $(wildcard .*.o.d)
 
@@ -209,10 +209,10 @@ c2xml.o c2xml.sc: CFLAGS += $(LIBXML_CFLAGS)
 pre-process.sc: CHECKER_FLAGS += -Wno-vla
 
 %.o: %.c $(LIB_H)
-	$(QUIET_CC)$(CC) -o $@ -c $(CFLAGS) $<
+	$(QUIET_CC)$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c -o $@ $<
 
 %.sc: %.c sparse
-	$(QUIET_CHECK) $(CHECKER) $(CHECKER_FLAGS) -c $(CFLAGS) $<
+	$(QUIET_CHECK) $(CHECKER) $(CHECKER_FLAGS) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $<
 
 ALL_OBJS :=  $(LIB_OBJS) $(foreach p,$(PROGRAMS),$(p).o $($(p)_EXTRA_DEPS))
 selfcheck: $(ALL_OBJS:.o=.sc)
-- 
2.14.2

