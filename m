From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 1/3] Makefile: clean up and simplify
Date: Sun, 16 Jul 2017 22:02:34 -0400
Message-ID: <CANeU7QnpmpEe+5QHnPRiOAw8SYMyBB1Hz_iw7Ug3QgDeFUEh8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36746 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbdGQCCf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 16 Jul 2017 22:02:35 -0400
Received: by mail-pf0-f195.google.com with SMTP id a11so1526745pfj.3
        for <linux-sparse@vger.kernel.org>; Sun, 16 Jul 2017 19:02:35 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

- For invoke shell command, use immediate evaluation to avoid
  invoke more than once.
- Adding header file dependency to all object files. Remove the
  hand specify header file dependency.
- Change c2xml to target specific CFLAGS, this allow c2xml using
  the common pattern rules.

Signed-of-By: Christopher Li <sparse@chrisli.org>
---
 Makefile | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 4d5df1a..0706d8d 100644
--- a/Makefile
+++ b/Makefile
@@ -34,10 +34,10 @@ HAVE_GTK2:=$(shell $(PKG_CONFIG) --exists gtk+-2.0
2>/dev/null && echo 'yes')
 LLVM_CONFIG:=llvm-config
 HAVE_LLVM:=$(shell $(LLVM_CONFIG) --version >/dev/null 2>&1 && echo 'yes')

-GCC_BASE = $(shell $(CC) --print-file-name=)
+GCC_BASE := $(shell $(CC) --print-file-name=)
 BASIC_CFLAGS = -DGCC_BASE=\"$(GCC_BASE)\"

-MULTIARCH_TRIPLET = $(shell $(CC) -print-multiarch 2>/dev/null)
+MULTIARCH_TRIPLET := $(shell $(CC) -print-multiarch 2>/dev/null)
 BASIC_CFLAGS += -DMULTIARCH_TRIPLET=\"$(MULTIARCH_TRIPLET)\"

 ifeq ($(HAVE_GCC_DEP),yes)
@@ -187,17 +187,15 @@ $(SLIB_FILE): $(LIB_OBJS)
  $(QUIET_LINK)$(CC) $(LDFLAGS) -Wl,-soname,$@ -shared -o $@ $(LIB_OBJS)

 DEP_FILES := $(wildcard .*.o.d)
-$(if $(DEP_FILES),$(eval include $(DEP_FILES)))

-c2xml.o: c2xml.c $(LIB_H)
- $(QUIET_CC)$(CC) `$(PKG_CONFIG) --cflags libxml-2.0` -o $@ -c $(ALL_CFLAGS) $<
+ifneq ($(DEP_FILES),)
+include $(DEP_FILES)
+endif

-compat-linux.o: compat/strtold.c compat/mmap-blob.c $(LIB_H)
-compat-solaris.o: compat/mmap-blob.c $(LIB_H)
-compat-mingw.o: $(LIB_H)
-compat-cygwin.o: $(LIB_H)
+LIBXML_CFLAGS := $(shell $(PKG_CONFIG) --cflags libxml-2.0)
+c2xml.o: CFLAGS += $(LIBXML_CFLAGS)

-%.o: %.c
+%.o: %.c $(LIB_H)
  $(QUIET_CC)$(CC) -o $@ -c $(ALL_CFLAGS) $<

 clean: clean-check
-- 
2.9.4
