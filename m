From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 34/37] build: avoid foreach
Date: Thu,  9 Nov 2017 07:46:45 +0100
Message-ID: <20171109064648.15379-35-luc.vanoostenryck@gmail.com>
References: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:48706 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752498AbdKIGrz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 01:47:55 -0500
Received: by mail-wm0-f65.google.com with SMTP id p75so14806068wmg.3
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 22:47:54 -0800 (PST)
In-Reply-To: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Josh Triplett <josh@joshtriplett.org>, Jeff Layton <jlayton@redhat.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

(g)make foreach can be quite handy but it also make
Makefiles much less declarative and thus harder to read.

Avoid them by adding the few needed assignments & dependencies.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 4c2012977..bb45155af 100644
--- a/Makefile
+++ b/Makefile
@@ -84,6 +84,9 @@ cflags += -DGCC_BASE=\"$(GCC_BASE)\"
 MULTIARCH_TRIPLET := $(shell $(CC) -print-multiarch 2>/dev/null)
 cflags += -DMULTIARCH_TRIPLET=\"$(MULTIARCH_TRIPLET)\"
 
+compile: compile-i386.o
+EXTRA_OBJS += compile-i386.o
+
 # Can we use GCC's generated dependencies?
 HAVE_GCC_DEP:=$(shell touch .gcc-test.c && 				\
 		$(CC) -c -Wp,-MD,.gcc-test.d .gcc-test.c 2>/dev/null && \
@@ -112,13 +115,15 @@ HAVE_GTK:=$(shell $(PKG_CONFIG) --exists gtk+-$(GTK_VERSION) 2>/dev/null && echo
 endif
 ifeq ($(HAVE_GTK),yes)
 GTK_CFLAGS := $(shell $(PKG_CONFIG) --cflags gtk+-$(GTK_VERSION))
-GTK_LIBS := $(shell $(PKG_CONFIG) --libs gtk+-$(GTK_VERSION))
+ast-view_CFLAGS := $(GTK_CFLAGS)
+ast-model_CFLAGS := $(GTK_CFLAGS)
+ast-inspect_CFLAGS := $(GTK_CFLAGS)
+test-inspect_CFLAGS := $(GTK_CFLAGS)
+test-inspect_LDLIBS := $(shell $(PKG_CONFIG) --libs gtk+-$(GTK_VERSION))
+test-inspect: ast-model.o ast-view.o ast-inspect.o
+EXTRA_OBJS += ast-model.o ast-view.o ast-inspect.o
 PROGRAMS += test-inspect
 INST_PROGRAMS += test-inspect
-test-inspect_OBJS := test-inspect.o
-test-inspect_OBJS += ast-model.o ast-view.o ast-inspect.o
-$(foreach p,$(test-inspect_OBJS:.o=),$(eval $(p)_CFLAGS := $(GTK_CFLAGS)))
-test-inspect_LDLIBS := $(GTK_LIBS)
 else
 $(warning Your system does not have gtk3/gtk2, disabling test-inspect)
 endif
@@ -160,13 +165,10 @@ V	      = @
 Q	      = $(V:1=)
 
 
-compile_OBJS := compile-i386.o
