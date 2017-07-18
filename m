From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 1/4] V2 Makefile: clean up and simplify
Date: Mon, 17 Jul 2017 22:53:14 -0400
Message-ID: <CANeU7Qk9DevErE96tf0U9K2Cd6CBQ4Mm6iE3yNYBSomZYX7NbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35352 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751041AbdGRCxP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 17 Jul 2017 22:53:15 -0400
Received: by mail-pf0-f194.google.com with SMTP id q85so978156pfq.2
        for <linux-sparse@vger.kernel.org>; Mon, 17 Jul 2017 19:53:15 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

- For invoke shell command, use immediate evaluation to avoid
  invoke more than once.
- Adding header file dependency to all object files. Remove the
  hand specify header file dependency.
- Change c2xml to target specific CFLAGS, this allow c2xml using
  the common pattern rules.
- Ramsay Jones point out that LIBXML_CFLAGS need to be put into
  if HAVE_LIBXML condition. Otherwise make will spew error on
  system that does not have libxml

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-By: Christopher Li <sparse@chrisli.org>
---
 Makefile | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 4d5df1a..9f62c61 100644
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
@@ -62,6 +62,7 @@ ifeq ($(HAVE_LIBXML),yes)
 PROGRAMS+=c2xml
 INST_PROGRAMS+=c2xml
 c2xml_EXTRA_OBJS = `$(PKG_CONFIG) --libs libxml-2.0`
+LIBXML_CFLAGS := $(shell $(PKG_CONFIG) --cflags libxml-2.0)
 else
 $(warning Your system does not have libxml, disabling c2xml)
 endif
@@ -187,17 +188,14 @@ $(SLIB_FILE): $(LIB_OBJS)
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
+c2xml.o: CFLAGS += $(LIBXML_CFLAGS)

-%.o: %.c
+%.o: %.c $(LIB_H)
  $(QUIET_CC)$(CC) -o $@ -c $(ALL_CFLAGS) $<

 clean: clean-check
-- 
2.9.4
