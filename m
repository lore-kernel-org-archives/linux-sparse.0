From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] build: clean up $CFLAGS handling in the makefile
Date: Wed, 25 Oct 2017 16:20:10 +0200
Message-ID: <20171025142009.foxh2rblmfpxvm7d@ltop.local>
References: <20171025100222.5983-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:46486 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751732AbdJYOUP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 25 Oct 2017 10:20:15 -0400
Received: by mail-wm0-f66.google.com with SMTP id m72so2250271wmc.1
        for <linux-sparse@vger.kernel.org>; Wed, 25 Oct 2017 07:20:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20171025100222.5983-1-jlayton@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: sparse@chrisli.org, linux-sparse@vger.kernel.org

On Wed, Oct 25, 2017 at 06:02:22AM -0400, Jeff Layton wrote:
> From: Jeff Layton <jlayton@redhat.com>
> 
> The fedora packaging tools want to provide a base set of $CFLAGS when
> building packages, but that fails when building sparse.
> 
> There are a couple of build targets in the makefile that add options to
> $CFLAGS.  When we do a build though, we pass $ALL_CFLAGS to the
> compiler, and that ends up without those extra options, if CFLAGS= was
> passed to the make command.
> 
> This patch changes the code to append the options to $ALL_CFLAGS instead
> of $CFLAGS. At the same time, passing a CFLAGS argument to make ends up
> with the initial CFLAGS assignment being clobbered such that we lose the
> options that are assigned to it internally. Fold the internal usage of
> CFLAGS into BASIC_CFLAGS. They both just end up as part of ALL_CFLAGS
> anyway, so this should be functionally equivalent.
> 
> Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> Signed-off-by: Jeff Layton <jlayton@redhat.com>
> ---
>  Makefile | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> I sent this last week in a reply to a different thread. Re-posting it
> here since it got no replies.
> 

Hi,

I'm fine with this patch but I would prefer to go one step further
and get rid of BASIC_CFLAGS/ALL_CFLAGS while at the same time
being more explicit. I have in mind something like:

From 258efc92cff090bba5ea14a05819514779d7992a Mon Sep 17 00:00:00 2001
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Wed, 25 Oct 2017 14:38:01 +0200
Subject: [PATCH] build: allow to override CFLAGS via the command line

Some distros (fedora) and some developers want to specifiy their
own CFLAGS. OTOH most of CFLAGS's content is automatically
contructed or must not be changed.

This patch, allow to extend CFLAGS via the command line, like:
	make CFLAGS=-some-extra-flags

The patch also get rid of the confusing CFLAGS/BASIC_CFLAGS/ALL_CFLAGS

With this change, target specific CFLAGS can be given either via
	target.o: CFLAGS += -some-specific-flags
or via
	target_CFLAGS = -some-specific-flags

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index d03417641..f53d66d70 100644
--- a/Makefile
+++ b/Makefile
@@ -11,6 +11,11 @@ endif
 OS = linux
 
 
+# This save any CFLAGS given in the command line
+# and let us use 'CFLAGS' here under
+CLI_CFLAGS := $(CFLAGS)
+override undefine CFLAGS
+
 CC = gcc
 CFLAGS = -O2 -finline-functions -fno-strict-aliasing -g
 CFLAGS += -Wall -Wwrite-strings
@@ -21,7 +26,6 @@ PKG_CONFIG = pkg-config
 CHECKER = ./cgcc -no-compile
 CHECKER_FLAGS =
 
-ALL_CFLAGS = $(CFLAGS) $(BASIC_CFLAGS)
 #
 # For debugging, put this in local.mk:
 #
@@ -44,13 +48,13 @@ LLVM_CONFIG:=llvm-config
 HAVE_LLVM:=$(shell $(LLVM_CONFIG) --version >/dev/null 2>&1 && echo 'yes')
 
 GCC_BASE := $(shell $(CC) --print-file-name=)
-BASIC_CFLAGS = -DGCC_BASE=\"$(GCC_BASE)\"
+CFLAGS += -DGCC_BASE=\"$(GCC_BASE)\"
 
 MULTIARCH_TRIPLET := $(shell $(CC) -print-multiarch 2>/dev/null)
-BASIC_CFLAGS += -DMULTIARCH_TRIPLET=\"$(MULTIARCH_TRIPLET)\"
+CFLAGS += -DMULTIARCH_TRIPLET=\"$(MULTIARCH_TRIPLET)\"
 
 ifeq ($(HAVE_GCC_DEP),yes)
-BASIC_CFLAGS += -Wp,-MD,$(@D)/.$(@F).d
+CFLAGS += -Wp,-MD,$(@D)/.$(@F).d
 endif
 
 DESTDIR=
@@ -71,7 +75,7 @@ ifeq ($(HAVE_LIBXML),yes)
 PROGRAMS+=c2xml
 INST_PROGRAMS+=c2xml
 c2xml_EXTRA_OBJS = `$(PKG_CONFIG) --libs libxml-2.0`
-LIBXML_CFLAGS := $(shell $(PKG_CONFIG) --cflags libxml-2.0)
+c2xml_CFLAGS := $(shell $(PKG_CONFIG) --cflags libxml-2.0)
 else
 $(warning Your system does not have libxml, disabling c2xml)
 endif
@@ -101,7 +105,7 @@ LLVM_LIBS := $(shell $(LLVM_CONFIG) --libs)
 LLVM_LIBS += $(shell $(LLVM_CONFIG) --system-libs 2>/dev/null)
 PROGRAMS += $(LLVM_PROGS)
 INST_PROGRAMS += sparse-llvm sparsec
-sparse-llvm.o: BASIC_CFLAGS += $(LLVM_CFLAGS)
+sparse-llvm_CFLAGS := $(LLVM_CFLAGS)
 sparse-llvm_EXTRA_OBJS := $(LLVM_LIBS) $(LLVM_LDFLAGS)
 else
 $(warning LLVM 3.0 or later required. Your system has version $(LLVM_VERSION) installed.)
@@ -127,7 +131,7 @@ LIB_OBJS= target.o parse.o tokenize.o pre-process.o symbol.o lib.o scope.o \
 LIB_FILE= libsparse.a
 SLIB_FILE= libsparse.so
 
-# If you add $(SLIB_FILE) to this, you also need to add -fpic to BASIC_CFLAGS above.
+# If you add $(SLIB_FILE) to this, you also need to add -fpic to CFLAGS above.
 # Doing so incurs a noticeable performance hit, and Sparse does not have a
 # stable shared library interface, so this does not occur by default.  If you
 # really want a shared library, you may want to build Sparse twice: once
@@ -208,15 +212,15 @@ ifneq ($(DEP_FILES),)
 include $(DEP_FILES)
 endif
 
-c2xml.o c2xml.sc: CFLAGS += $(LIBXML_CFLAGS)
