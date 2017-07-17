From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 2/3] Makefile: add selfcheck target
Date: Sun, 16 Jul 2017 23:59:18 -0400
Message-ID: <CANeU7Q=DzoQqdBebjFh6H3WLQOA2R0mKnd9iR4aeEGYCOCxyDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34219 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751253AbdGQD7T (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 16 Jul 2017 23:59:19 -0400
Received: by mail-pf0-f196.google.com with SMTP id c24so18125408pfe.1
        for <linux-sparse@vger.kernel.org>; Sun, 16 Jul 2017 20:59:19 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

"make selfcheck" will invoke sparse to check its own source code.
It is different than the "make C=1" in linux kernel because
sparse executable need to be compiled first.

"make <filename>.sc" will invoke the sparse to check specific C source
file <filename>.c

For example: "make parse.sc"

Signed-of-By: Christopher Li <sparse@chrisli.org>
---
 Makefile | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 0706d8d..ae81586 100644
--- a/Makefile
+++ b/Makefile
@@ -72,7 +72,8 @@ GTK2_LIBS := $(shell $(PKG_CONFIG) --libs gtk+-2.0)
 PROGRAMS += test-inspect
 INST_PROGRAMS += test-inspect
 test-inspect_EXTRA_DEPS := ast-model.o ast-view.o ast-inspect.o
-test-inspect.o $(test-inspect_EXTRA_DEPS): BASIC_CFLAGS += $(GTK2_CFLAGS)
+test-inspect_OBJS := test-inspect.o $(test-inspect_EXTRA_DEPS)
+$(test-inspect_OBJS) $(test-inspect_OBJS:.o=.sc): CFLAGS += $(GTK2_CFLAGS)
 test-inspect_EXTRA_OBJS := $(GTK2_LIBS)
 else
 $(warning Your system does not have libgtk2, disabling test-inspect)
@@ -126,6 +127,7 @@ LIBS=$(LIB_FILE)
 V      = @
 Q      = $(V:1=)
 QUIET_CC      = $(Q:@=@echo    '     CC       '$@;)
+QUIET_CHECK   = $(Q:@=@echo    '     CHECK    '$<;)
 QUIET_AR      = $(Q:@=@echo    '     AR       '$@;)
 QUIET_GEN     = $(Q:@=@echo    '     GEN      '$@;)
 QUIET_LINK    = $(Q:@=@echo    '     LINK     '$@;)
@@ -193,11 +195,17 @@ include $(DEP_FILES)
 endif

 LIBXML_CFLAGS := $(shell $(PKG_CONFIG) --cflags libxml-2.0)
-c2xml.o: CFLAGS += $(LIBXML_CFLAGS)
+c2xml.o c2xml.sc: CFLAGS += $(LIBXML_CFLAGS)

 %.o: %.c $(LIB_H)
  $(QUIET_CC)$(CC) -o $@ -c $(ALL_CFLAGS) $<

+%.sc: %.c sparse
+ $(QUIET_CHECK) ./sparse -c $(ALL_CFLAGS) $<
+
+selfcheck: $(LIB_OBJS:.o=.sc) $(addsuffix .sc, $(PROGRAMS))
+
+
 clean: clean-check
  rm -f *.[oa] .*.d *.so $(PROGRAMS) $(SLIB_FILE) pre-process.h sparse.pc

-- 
2.9.4
