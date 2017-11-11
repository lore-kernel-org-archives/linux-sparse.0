From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 34/38] build: avoid foreach
Date: Sat, 11 Nov 2017 15:24:33 +0100
Message-ID: <20171111142437.67359-35-luc.vanoostenryck@gmail.com>
References: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54616 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751124AbdKKOZw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 09:25:52 -0500
Received: by mail-wm0-f68.google.com with SMTP id r68so7599703wmr.3
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 06:25:52 -0800 (PST)
In-Reply-To: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>, Josh Triplett <josh@joshtriplett.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

(g)make foreach can be quite handy but it also make
Makefiles much less declarative and thus harder to read.

Avoid them by adding the few needed assignments & dependencies.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index e57934c92..d67f54afe 100644
--- a/Makefile
+++ b/Makefile
@@ -85,6 +85,9 @@ cflags += -DGCC_BASE=\"$(GCC_BASE)\"
 MULTIARCH_TRIPLET := $(shell $(CC) -print-multiarch 2>/dev/null)
 cflags += -DMULTIARCH_TRIPLET=\"$(MULTIARCH_TRIPLET)\"
 
+compile: compile-i386.o
+EXTRA_OBJS += compile-i386.o
+
 # Can we use GCC's generated dependencies?
 HAVE_GCC_DEP:=$(shell touch .gcc-test.c && 				\
 		$(CC) -c -Wp,-MD,.gcc-test.d .gcc-test.c 2>/dev/null && \
@@ -113,13 +116,15 @@ HAVE_GTK:=$(shell $(PKG_CONFIG) --exists gtk+-$(GTK_VERSION) 2>/dev/null && echo
 endif
 ifeq ($(HAVE_GTK),yes)
 GTK_CFLAGS := $(shell $(PKG_CONFIG) --cflags gtk+-$(GTK_VERSION))
-GTK_LIBS := $(shell $(PKG_CONFIG) --libs gtk+-$(GTK_VERSION))
+ast-view-cflags := $(GTK_CFLAGS)
+ast-model-cflags := $(GTK_CFLAGS)
+ast-inspect-cflags := $(GTK_CFLAGS)
+test-inspect-cflags := $(GTK_CFLAGS)
+test-inspect-ldlibs := $(shell $(PKG_CONFIG) --libs gtk+-$(GTK_VERSION))
+test-inspect: ast-model.o ast-view.o ast-inspect.o
+EXTRA_OBJS += ast-model.o ast-view.o ast-inspect.o
 PROGRAMS += test-inspect
 INST_PROGRAMS += test-inspect
-test-inspect-objs := test-inspect.o
-test-inspect-objs += ast-model.o ast-view.o ast-inspect.o
-$(foreach p,$(test-inspect-objs:.o=),$(eval $(p)-cflags := $(GTK_CFLAGS)))
-test-inspect-ldlibs := $(GTK_LIBS)
 else
 $(warning Your system does not have gtk3/gtk2, disabling test-inspect)
 endif
@@ -161,13 +166,10 @@ V	      = @
 Q	      = $(V:1=)
 
 
-compile_OBJS := compile-i386.o
