From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 2/4] V2 Makefile: add selfcheck target
Date: Mon, 17 Jul 2017 22:54:12 -0400
Message-ID: <CANeU7Q=7mpPhV3LQ7=LBeKQr6TndPH65Q36sXT684B2N0zfsaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35071 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751041AbdGRCyO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 17 Jul 2017 22:54:14 -0400
Received: by mail-pg0-f65.google.com with SMTP id d193so1007695pgc.2
        for <linux-sparse@vger.kernel.org>; Mon, 17 Jul 2017 19:54:13 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

"make selfcheck" will invoke sparse to check its own source code.
It is different than the "make C=1" in linux kernel because
sparse executable need to be compiled first.

"make <filename>.sc" will invoke the sparse to check specific C source
file <filename>.c

For example: "make parse.sc"

V2:

As pointer out by Ramsay Jones, in cygwin the check need to be
invoked by cgcc to have some platform specific macro defined.

Change the checker program to control by $(CHECKER)

Add $(PROGRAM)_EXTRA_DEPS into selfcheck

Signed-off-By: Christopher Li <sparse@chrisli.org>
---
 Makefile | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 9f62c61..9e9c939 100644
--- a/Makefile
+++ b/Makefile
@@ -18,6 +18,7 @@ LDFLAGS += -g
 LD = gcc
 AR = ar
 PKG_CONFIG = pkg-config
+CHECKER = ./cgcc -no-compile

 ALL_CFLAGS = $(CFLAGS) $(BASIC_CFLAGS)
 #
@@ -73,7 +74,8 @@ GTK2_LIBS := $(shell $(PKG_CONFIG) --libs gtk+-2.0)
 PROGRAMS += test-inspect
 INST_PROGRAMS += test-inspect
 test-inspect_EXTRA_DEPS := ast-model.o ast-view.o ast-inspect.o
-test-inspect.o $(test-inspect_EXTRA_DEPS): BASIC_CFLAGS += $(GTK2_CFLAGS)
+test-inspect_OBJS := test-inspect.o $(test-inspect_EXTRA_DEPS)
+$(test-inspect_OBJS) $(test-inspect_OBJS:.o=.sc): CFLAGS += $(GTK2_CFLAGS)
 test-inspect_EXTRA_OBJS := $(GTK2_LIBS)
 else
 $(warning Your system does not have libgtk2, disabling test-inspect)
@@ -127,6 +129,7 @@ LIBS=$(LIB_FILE)
 V      = @
 Q      = $(V:1=)
 QUIET_CC      = $(Q:@=@echo    '     CC       '$@;)
+QUIET_CHECK   = $(Q:@=@echo    '     CHECK    '$<;)
 QUIET_AR      = $(Q:@=@echo    '     AR       '$@;)
 QUIET_GEN     = $(Q:@=@echo    '     GEN      '$@;)
 QUIET_LINK    = $(Q:@=@echo    '     LINK     '$@;)
@@ -193,11 +196,18 @@ ifneq ($(DEP_FILES),)
 include $(DEP_FILES)
 endif

-c2xml.o: CFLAGS += $(LIBXML_CFLAGS)
+c2xml.o c2xml.sc: CFLAGS += $(LIBXML_CFLAGS)

 %.o: %.c $(LIB_H)
  $(QUIET_CC)$(CC) -o $@ -c $(ALL_CFLAGS) $<

+%.sc: %.c sparse
+ $(QUIET_CHECK) $(CHECKER) -c $(ALL_CFLAGS) $<
+
+ALL_OBJS :=  $(LIB_OBJS) $(foreach p,$(PROGRAMS),$(p).o $($(p)_EXTRA_DEPS))
+selfcheck: $(ALL_OBJS:.o=.sc)
+
+
 clean: clean-check
  rm -f *.[oa] .*.d *.so $(PROGRAMS) $(SLIB_FILE) pre-process.h sparse.pc

-- 
2.9.4
