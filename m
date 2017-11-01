From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] build: clean up $CFLAGS handling in the makefile
Date: Tue, 31 Oct 2017 20:56:47 -0400
Message-ID: <CANeU7Qm8YHpYLLW8O=y=m9m6kRAD_5MiTnS79N5ffCk-PVcxFQ@mail.gmail.com>
References: <20171025100222.5983-1-jlayton@kernel.org> <20171025142009.foxh2rblmfpxvm7d@ltop.local>
 <CANeU7Qnvvezdc62s-cAWNonw2cKOJPWH2xSdgTdAL4M4skSnJw@mail.gmail.com>
 <1509019885.29077.6.camel@kernel.org> <CANeU7QmOACXKv2T2ovg7mxEDdpjUrwRgyYUsp2benDWh9R-2iw@mail.gmail.com>
 <1509476260.4553.45.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:49770 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbdKAA4s (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 31 Oct 2017 20:56:48 -0400
Received: by mail-yw0-f196.google.com with SMTP id z195so639066ywz.6
        for <linux-sparse@vger.kernel.org>; Tue, 31 Oct 2017 17:56:48 -0700 (PDT)
In-Reply-To: <1509476260.4553.45.camel@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Oct 31, 2017 at 2:57 PM, Jeff Layton <jlayton@kernel.org> wrote:
> As Luc and Josh pointed out, I think we want $(CFLAGS) last here. That
> allows you to pass in options that can supersede what the makefile puts
> in there.
> ...other than that, I'm fine with this. Assuming you fix that, you can
> add:

I update the patch here and git url:
https://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git/log/?h=cflags-v2

Chris

From 55496234238e127c05807550fb432e1125a85710 Mon Sep 17 00:00:00 2001
From: Christopher Li <sparse@chrisli.org>
Date: Sun, 29 Oct 2017 19:16:44 +0800
Subject: [PATCH] Makefile: provide CFLAGS for command line override.

Avoid assign to CFLAGS in Makefile.
Rename BASIC_CFLAGS to COMMON_CFLAGS.
Use PKG_CFLAGS to store external package related cflags.

Signed-off-by: Christopher Li <sparse@chrisli.org>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 Makefile | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index d0341764..66cb1ae1 100644
--- a/Makefile
+++ b/Makefile
@@ -12,8 +12,8 @@ OS = linux


 CC = gcc
-CFLAGS = -O2 -finline-functions -fno-strict-aliasing -g
-CFLAGS += -Wall -Wwrite-strings
+COMMON_CFLAGS = -O2 -finline-functions -fno-strict-aliasing -g
+COMMON_CFLAGS += -Wall -Wwrite-strings
 LDFLAGS += -g
 LD = gcc
 AR = ar
@@ -21,7 +21,7 @@ PKG_CONFIG = pkg-config
 CHECKER = ./cgcc -no-compile
 CHECKER_FLAGS =

-ALL_CFLAGS = $(CFLAGS) $(BASIC_CFLAGS)
+ALL_CFLAGS = $(COMMON_CFLAGS) $(PKG_CFLAGS) $(CFLAGS)
 #
 # For debugging, put this in local.mk:
 #
@@ -44,13 +44,13 @@ LLVM_CONFIG:=llvm-config
 HAVE_LLVM:=$(shell $(LLVM_CONFIG) --version >/dev/null 2>&1 && echo 'yes')

 GCC_BASE := $(shell $(CC) --print-file-name=)
-BASIC_CFLAGS = -DGCC_BASE=\"$(GCC_BASE)\"
+COMMON_CFLAGS += -DGCC_BASE=\"$(GCC_BASE)\"

 MULTIARCH_TRIPLET := $(shell $(CC) -print-multiarch 2>/dev/null)
-BASIC_CFLAGS += -DMULTIARCH_TRIPLET=\"$(MULTIARCH_TRIPLET)\"
+COMMON_CFLAGS += -DMULTIARCH_TRIPLET=\"$(MULTIARCH_TRIPLET)\"

 ifeq ($(HAVE_GCC_DEP),yes)
-BASIC_CFLAGS += -Wp,-MD,$(@D)/.$(@F).d
+COMMON_CFLAGS += -Wp,-MD,$(@D)/.$(@F).d
 endif

 DESTDIR=
@@ -83,7 +83,7 @@ PROGRAMS += test-inspect
 INST_PROGRAMS += test-inspect
 test-inspect_EXTRA_DEPS := ast-model.o ast-view.o ast-inspect.o
 test-inspect_OBJS := test-inspect.o $(test-inspect_EXTRA_DEPS)
-$(test-inspect_OBJS) $(test-inspect_OBJS:.o=.sc): CFLAGS += $(GTK_CFLAGS)
+$(test-inspect_OBJS) $(test-inspect_OBJS:.o=.sc): PKG_CFLAGS += $(GTK_CFLAGS)
 test-inspect_EXTRA_OBJS := $(GTK_LIBS)
 else
 $(warning Your system does not have gtk3/gtk2, disabling test-inspect)
@@ -101,7 +101,7 @@ LLVM_LIBS := $(shell $(LLVM_CONFIG) --libs)
 LLVM_LIBS += $(shell $(LLVM_CONFIG) --system-libs 2>/dev/null)
 PROGRAMS += $(LLVM_PROGS)
 INST_PROGRAMS += sparse-llvm sparsec
-sparse-llvm.o: BASIC_CFLAGS += $(LLVM_CFLAGS)
+sparse-llvm.o: PKG_CFLAGS += $(LLVM_CFLAGS)
 sparse-llvm_EXTRA_OBJS := $(LLVM_LIBS) $(LLVM_LDFLAGS)
 else
 $(warning LLVM 3.0 or later required. Your system has version
$(LLVM_VERSION) installed.)
-- 
2.13.6
