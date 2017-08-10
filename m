From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 2/2] test-inspect: Detect gtk3 then gtk2 package
Date: Thu, 10 Aug 2017 17:05:28 -0400
Message-ID: <CANeU7QnD6Dgim5evF+7THhq6rK164q69ktFPs0pX0ieMsbHX-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:38524 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753099AbdHJVF3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Aug 2017 17:05:29 -0400
Received: by mail-yw0-f194.google.com with SMTP id p68so1174886ywg.5
        for <linux-sparse@vger.kernel.org>; Thu, 10 Aug 2017 14:05:29 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This fix a bug that test-inspect crash on Ubuntu 16.04 TLS
updated vesion of gtk2. gtk3 does not seem to have this
problem. Detect and use gtk3 if exists.

Reported-by: Dibyendu Majumdar <mobile@majumdar.org.uk>
Signed-off-by: Christopher Li <sparse@chrisli.org>
---
 Makefile | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index c20ea2c..88d485b 100644
--- a/Makefile
+++ b/Makefile
@@ -32,7 +32,14 @@ HAVE_LIBXML:=$(shell $(PKG_CONFIG) --exists
libxml-2.0 2>/dev/null && echo 'yes'
 HAVE_GCC_DEP:=$(shell touch .gcc-test.c && \
  $(CC) -c -Wp,-MD,.gcc-test.d .gcc-test.c 2>/dev/null && \
  echo 'yes'; rm -f .gcc-test.d .gcc-test.o .gcc-test.c)
-HAVE_GTK2:=$(shell $(PKG_CONFIG) --exists gtk+-2.0 2>/dev/null && echo 'yes')
+
+GTK_VERSION:=3.0
+HAVE_GTK:=$(shell $(PKG_CONFIG) --exists gtk+-$(GTK_VERSION)
2>/dev/null && echo 'yes')
+ifneq ($(HAVE_GTK),yes)
+ GTK_VERSION:=2.0
+ HAVE_GTK:=$(shell $(PKG_CONFIG) --exists gtk+-$(GTK_VERSION)
2>/dev/null && echo 'yes')
+endif
+
 LLVM_CONFIG:=llvm-config
 HAVE_LLVM:=$(shell $(LLVM_CONFIG) --version >/dev/null 2>&1 && echo 'yes')

@@ -69,17 +76,17 @@ else
 $(warning Your system does not have libxml, disabling c2xml)
 endif

-ifeq ($(HAVE_GTK2),yes)
-GTK2_CFLAGS := $(shell $(PKG_CONFIG) --cflags gtk+-2.0)
-GTK2_LIBS := $(shell $(PKG_CONFIG) --libs gtk+-2.0)
+ifeq ($(HAVE_GTK),yes)
+GTK_CFLAGS := $(shell $(PKG_CONFIG) --cflags gtk+-$(GTK_VERSION))
+GTK_LIBS := $(shell $(PKG_CONFIG) --libs gtk+-$(GTK_VERSION))
 PROGRAMS += test-inspect
 INST_PROGRAMS += test-inspect
 test-inspect_EXTRA_DEPS := ast-model.o ast-view.o ast-inspect.o
 test-inspect_OBJS := test-inspect.o $(test-inspect_EXTRA_DEPS)
-$(test-inspect_OBJS) $(test-inspect_OBJS:.o=.sc): CFLAGS += $(GTK2_CFLAGS)
-test-inspect_EXTRA_OBJS := $(GTK2_LIBS)
+$(test-inspect_OBJS) $(test-inspect_OBJS:.o=.sc): CFLAGS += $(GTK_CFLAGS)
+test-inspect_EXTRA_OBJS := $(GTK_LIBS)
 else
-$(warning Your system does not have libgtk2, disabling test-inspect)
+$(warning Your system does not have gtk3/gtk2, disabling test-inspect)
 endif

 ifeq ($(HAVE_LLVM),yes)
-- 
2.13.3
