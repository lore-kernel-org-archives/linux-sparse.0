From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH] build: clean up $CFLAGS handling in the makefile
Date: Wed, 25 Oct 2017 06:02:22 -0400
Message-ID: <20171025100222.5983-1-jlayton@kernel.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932162AbdJYKC1 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 25 Oct 2017 06:02:27 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: linux-sparse@vger.kernel.org, luc.vanoostenryck@gmail.com

From: Jeff Layton <jlayton@redhat.com>

The fedora packaging tools want to provide a base set of $CFLAGS when
building packages, but that fails when building sparse.

There are a couple of build targets in the makefile that add options to
$CFLAGS.  When we do a build though, we pass $ALL_CFLAGS to the
compiler, and that ends up without those extra options, if CFLAGS= was
passed to the make command.

This patch changes the code to append the options to $ALL_CFLAGS instead
of $CFLAGS. At the same time, passing a CFLAGS argument to make ends up
with the initial CFLAGS assignment being clobbered such that we lose the
options that are assigned to it internally. Fold the internal usage of
CFLAGS into BASIC_CFLAGS. They both just end up as part of ALL_CFLAGS
anyway, so this should be functionally equivalent.

Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

I sent this last week in a reply to a different thread. Re-posting it
here since it got no replies.

diff --git a/Makefile b/Makefile
index d0341764158e..335dcfff54ce 100644
--- a/Makefile
+++ b/Makefile
@@ -12,8 +12,8 @@ OS = linux
 
 
 CC = gcc
-CFLAGS = -O2 -finline-functions -fno-strict-aliasing -g
-CFLAGS += -Wall -Wwrite-strings
+BASIC_CFLAGS = -O2 -finline-functions -fno-strict-aliasing -g
+BASIC_CFLAGS += -Wall -Wwrite-strings
 LDFLAGS += -g
 LD = gcc
 AR = ar
@@ -21,7 +21,7 @@ PKG_CONFIG = pkg-config
 CHECKER = ./cgcc -no-compile
 CHECKER_FLAGS =
 
-ALL_CFLAGS = $(CFLAGS) $(BASIC_CFLAGS)
+ALL_CFLAGS = $(BASIC_CFLAGS) $(CFLAGS)
 #
 # For debugging, put this in local.mk:
 #
@@ -44,7 +44,7 @@ LLVM_CONFIG:=llvm-config
 HAVE_LLVM:=$(shell $(LLVM_CONFIG) --version >/dev/null 2>&1 && echo 'yes')
 
 GCC_BASE := $(shell $(CC) --print-file-name=)
-BASIC_CFLAGS = -DGCC_BASE=\"$(GCC_BASE)\"
+BASIC_CFLAGS += -DGCC_BASE=\"$(GCC_BASE)\"
 
 MULTIARCH_TRIPLET := $(shell $(CC) -print-multiarch 2>/dev/null)
 BASIC_CFLAGS += -DMULTIARCH_TRIPLET=\"$(MULTIARCH_TRIPLET)\"
@@ -83,7 +83,7 @@ PROGRAMS += test-inspect
 INST_PROGRAMS += test-inspect
 test-inspect_EXTRA_DEPS := ast-model.o ast-view.o ast-inspect.o
 test-inspect_OBJS := test-inspect.o $(test-inspect_EXTRA_DEPS)
-$(test-inspect_OBJS) $(test-inspect_OBJS:.o=.sc): CFLAGS += $(GTK_CFLAGS)
+$(test-inspect_OBJS) $(test-inspect_OBJS:.o=.sc): ALL_CFLAGS += $(GTK_CFLAGS)
 test-inspect_EXTRA_OBJS := $(GTK_LIBS)
 else
 $(warning Your system does not have gtk3/gtk2, disabling test-inspect)
@@ -208,7 +208,7 @@ ifneq ($(DEP_FILES),)
 include $(DEP_FILES)
 endif
 
-c2xml.o c2xml.sc: CFLAGS += $(LIBXML_CFLAGS)
+c2xml.o c2xml.sc: ALL_CFLAGS += $(LIBXML_CFLAGS)
 
 pre-process.sc: CHECKER_FLAGS += -Wno-vla
 
-- 
2.13.6

