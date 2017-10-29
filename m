From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] build: clean up $CFLAGS handling in the makefile
Date: Sun, 29 Oct 2017 19:32:39 +0800
Message-ID: <CANeU7QmOACXKv2T2ovg7mxEDdpjUrwRgyYUsp2benDWh9R-2iw@mail.gmail.com>
References: <20171025100222.5983-1-jlayton@kernel.org> <20171025142009.foxh2rblmfpxvm7d@ltop.local>
 <CANeU7Qnvvezdc62s-cAWNonw2cKOJPWH2xSdgTdAL4M4skSnJw@mail.gmail.com> <1509019885.29077.6.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:43905 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751310AbdJ2Lcl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 29 Oct 2017 07:32:41 -0400
Received: by mail-yw0-f193.google.com with SMTP id y75so9231767ywg.0
        for <linux-sparse@vger.kernel.org>; Sun, 29 Oct 2017 04:32:41 -0700 (PDT)
In-Reply-To: <1509019885.29077.6.camel@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Oct 26, 2017 at 8:11 PM, Jeff Layton <jlayton@kernel.org> wrote:
>
> Perhaps instead of describing it, you could roll up an alternative patch
> that shows what you would prefer to see here?

Here it is the patch.

I push it on https://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git/log/?h=cflags

Chris

From 9fc170ec5e5814ae858922496dea668bb80dbf34 Mon Sep 17 00:00:00 2001
From: Christopher Li <sparse@chrisli.org>
Date: Sun, 29 Oct 2017 19:16:44 +0800
Subject: [PATCH] Makefile: provide CFLAGS for command line override.

Avoid assign to CFLAGS in Makefile.
Rename BASIC_CFLAGS to COMMON_CFLAGS.
Use PKG_CFLAGS to store external package related cflags.

Signed-off-by: Christopher Li <sparse@chrisli.org>
---
 Makefile | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 76902b7..ef47358 100644
--- a/Makefile
+++ b/Makefile
@@ -12,14 +12,14 @@ OS = linux


 CC = gcc
-CFLAGS = -O2 -finline-functions -fno-strict-aliasing -g
-CFLAGS += -Wall -Wwrite-strings
+COMMON_CFLAGS = -O2 -finline-functions -fno-strict-aliasing -g
+COMMON_CFLAGS += -Wall -Wwrite-strings
 LDFLAGS += -g
 LD = gcc
 AR = ar
 PKG_CONFIG = pkg-config

-ALL_CFLAGS = $(CFLAGS) $(BASIC_CFLAGS)
+ALL_CFLAGS = $(CFLAGS) $(COMMON_CFLAGS) $(PKG_CFLAGS)
 #
 # For debugging, put this in local.mk:
 #
@@ -35,13 +35,13 @@ LLVM_CONFIG:=llvm-config
 HAVE_LLVM:=$(shell $(LLVM_CONFIG) --version >/dev/null 2>&1 && echo 'yes')

 GCC_BASE = $(shell $(CC) --print-file-name=)
-BASIC_CFLAGS = -DGCC_BASE=\"$(GCC_BASE)\"
+COMMON_CFLAGS += -DGCC_BASE=\"$(GCC_BASE)\"

 MULTIARCH_TRIPLET = $(shell $(CC) -print-multiarch 2>/dev/null)
-BASIC_CFLAGS += -DMULTIARCH_TRIPLET=\"$(MULTIARCH_TRIPLET)\"
+COMMON_CFLAGS += -DMULTIARCH_TRIPLET=\"$(MULTIARCH_TRIPLET)\"

 ifeq ($(HAVE_GCC_DEP),yes)
-BASIC_CFLAGS += -Wp,-MD,$(@D)/.$(@F).d
+COMMON_CFLAGS += -Wp,-MD,$(@D)/.$(@F).d
 endif

 DESTDIR=
@@ -72,7 +72,7 @@ GTK2_LIBS := $(shell $(PKG_CONFIG) --libs gtk+-2.0)
 PROGRAMS += test-inspect
 INST_PROGRAMS += test-inspect
 test-inspect_EXTRA_DEPS := ast-model.o ast-view.o ast-inspect.o
-test-inspect.o $(test-inspect_EXTRA_DEPS): BASIC_CFLAGS += $(GTK2_CFLAGS)
+test-inspect.o $(test-inspect_EXTRA_DEPS): PKG_CFLAGS += $(GTK2_CFLAGS)
 test-inspect_EXTRA_OBJS := $(GTK2_LIBS)
 else
 $(warning Your system does not have libgtk2, disabling test-inspect)
@@ -89,7 +89,7 @@ LLVM_LIBS := $(shell $(LLVM_CONFIG) --libs)
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
