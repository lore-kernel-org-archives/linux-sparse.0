From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 2/4] Makefile: make debug version program as debug/<program name>
Date: Sun, 13 Aug 2017 15:09:50 -0400
Message-ID: <CANeU7Qn8wxi1k2aembr_yNTt2xPKyAPFcXN_LroY8DR8R1COOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:38013 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbdHMTJv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 15:09:51 -0400
Received: by mail-yw0-f193.google.com with SMTP id p68so5075066ywg.5
        for <linux-sparse@vger.kernel.org>; Sun, 13 Aug 2017 12:09:51 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Compile the release version of program as <name>
and the debug version as debug/<name>, under the
debug/ directory.

For the programs that are only used by developer,
there is no need to generate the release version
by default.

Sparse is the only program that has both release version
and debug version by default.

Signed-off-by: Christopher Li <sparse@chrisli.org>
---
 Makefile | 105 +++++++++++++++++++++++++++++++++------------------------------
 1 file changed, 55 insertions(+), 50 deletions(-)

diff --git a/Makefile b/Makefile
index 6660220..4c89e4c 100644
--- a/Makefile
+++ b/Makefile
@@ -14,15 +14,18 @@ OS = linux
 CC = gcc
 CFLAGS = -O2 -finline-functions -fno-strict-aliasing -g
 CFLAGS += -Wall -Wwrite-strings
+ALL_CFLAGS = $(CFLAGS) $(BASIC_CFLAGS)
 DBG_CFLAGS = $(ALL_CFLAGS) -DSPARSE_DEBUG
+REL_CFLAGS = $(ALL_CFLAGS)
 LDFLAGS += -g
 LD = gcc
 AR = ar
 PKG_CONFIG = pkg-config
 CHECKER = ./cgcc -no-compile
 CHECKER_FLAGS =
+EXTRA_LIBS = $($(@F)_EXTRA_LIBS)
+EXTRA_OBJS = $($(@F)_EXTRA_OBJS)

-ALL_CFLAGS = $(CFLAGS) $(BASIC_CFLAGS)
 #
 # For debugging, put this in local.mk:
 #
@@ -63,16 +66,34 @@ MAN1DIR=$(MANDIR)/man1
 INCLUDEDIR=$(PREFIX)/include
 PKGCONFIGDIR=$(LIBDIR)/pkgconfig

-PROGRAMS=test-lexing test-parsing obfuscate compile graph sparse \
- test-linearize example test-unssa test-dissect ctags
-INST_PROGRAMS=sparse cgcc
+REL_PROGRAMS := sparse
+PROGRAMS = $(REL_PROGRAMS) test-lexing test-parsing obfuscate compile graph \
+ test-linearize example test-unssa test-dissect ctags
+
+LIB_H=    token.h parse.h lib.h symbol.h scope.h expression.h target.h \
+  linearize.h bitmap.h ident-list.h compat.h flow.h allocate.h \
+  storage.h ptrlist.h dissect.h
+
+LIB_OBJS= target.o parse.o tokenize.o pre-process.o symbol.o lib.o scope.o \
+  expression.o show-parse.o evaluate.o expand.o inline.o linearize.o \
+  char.o sort.o allocate.o compat-$(OS).o ptrlist.o \
+  builtin.o \
+  stats.o \
+  flow.o cse.o simplify.o memops.o liveness.o storage.o unssa.o dissect.o
+
+LIB_FILE= libsparse.a
+SLIB_FILE= libsparse.so
+DBG_LIB_FILE := $(LIB_FILE:.a=-dbg.a)
+DBG_SLIB_FILE := $(SLIB_FILE:.so=-dbg.so)
+
+INST_PROGRAMS := cgcc
 INST_MAN1=sparse.1 cgcc.1

 ifeq ($(HAVE_LIBXML),yes)
-PROGRAMS+=c2xml
-INST_PROGRAMS+=c2xml
-c2xml_EXTRA_OBJS = `$(PKG_CONFIG) --libs libxml-2.0`
+PROGRAMS += c2xml
+c2xml_EXTRA_LIBS = `$(PKG_CONFIG) --libs libxml-2.0`
 LIBXML_CFLAGS := $(shell $(PKG_CONFIG) --cflags libxml-2.0)
+c2xml.o c2xml.sc debug/c2xml.o debug/c2xml.sc: CFLAGS += $(LIBXML_CFLAGS)
 else
 $(warning Your system does not have libxml, disabling c2xml)
 endif
@@ -81,13 +102,12 @@ ifeq ($(HAVE_GTK),yes)
 GTK_CFLAGS := $(shell $(PKG_CONFIG) --cflags gtk+-$(GTK_VERSION))
 GTK_LIBS := $(shell $(PKG_CONFIG) --libs gtk+-$(GTK_VERSION))
 PROGRAMS += test-inspect
-INST_PROGRAMS += test-inspect
-test-inspect_EXTRA_DEPS := ast-model.o ast-view.o ast-inspect.o
-test-inspect_OBJS := test-inspect.o $(test-inspect_EXTRA_DEPS)
+test-inspect_EXTRA_OBJS := ast-model.o ast-view.o ast-inspect.o
+test-inspect_OBJS := test-inspect.o $(test-inspect_EXTRA_OBJS)

 $(test-inspect_OBJS) $(test-inspect_OBJS:.o=.sc) \
 $(addprefix debug/, $(test-inspect_OBJS) $(test-inspect_OBJS:.o=.sc))
: CFLAGS += $(GTK_CFLAGS)
-test-inspect_EXTRA_OBJS := $(GTK_LIBS)
+test-inspect_EXTRA_LIBS := $(GTK_LIBS)
 else
 $(warning Your system does not have gtk3/gtk2, disabling test-inspect)
 endif
@@ -102,9 +122,9 @@ LLVM_CFLAGS := $(shell $(LLVM_CONFIG) --cflags |
sed -e "s/-DNDEBUG//g" | sed -e
 LLVM_LIBS := $(shell $(LLVM_CONFIG) --libs)
 LLVM_LIBS += $(shell $(LLVM_CONFIG) --system-libs 2>/dev/null)
 PROGRAMS += $(LLVM_PROGS)
-INST_PROGRAMS += sparse-llvm sparsec
+INST_PROGRAMS += sparsec
 sparse-llvm.o: BASIC_CFLAGS += $(LLVM_CFLAGS)
-sparse-llvm_EXTRA_OBJS := $(LLVM_LIBS) $(LLVM_LDFLAGS)
+sparse-llvm_EXTRA_LIBS := $(LLVM_LIBS) $(LLVM_LDFLAGS)
 else
 $(warning LLVM 3.0 or later required. Your system has version
$(LLVM_VERSION) installed.)
 endif
@@ -112,20 +132,6 @@ else
 $(warning Your system does not have llvm, disabling sparse-llvm)
 endif

-LIB_H=    token.h parse.h lib.h symbol.h scope.h expression.h target.h \
-  linearize.h bitmap.h ident-list.h compat.h flow.h allocate.h \
-  storage.h ptrlist.h dissect.h
-
-LIB_OBJS= target.o parse.o tokenize.o pre-process.o symbol.o lib.o scope.o \
-  expression.o show-parse.o evaluate.o expand.o inline.o linearize.o \
-  char.o sort.o allocate.o compat-$(OS).o ptrlist.o \
-  builtin.o \
-  stats.o \
-  flow.o cse.o simplify.o memops.o liveness.o storage.o unssa.o dissect.o
-
-LIB_FILE= libsparse.a
-SLIB_FILE= libsparse.so
-
 # If you add $(SLIB_FILE) to this, you also need to add -fpic to
BASIC_CFLAGS above.
 # Doing so incurs a noticeable performance hit, and Sparse does not have a
 # stable shared library interface, so this does not occur by default.  If you
@@ -168,13 +174,16 @@ SED_PC_CMD = 's|@version@|$(VERSION)|g; \
 # Allow users to override build settings without dirtying their trees
 -include local.mk

-DBG_PROGRAMS := $(addprefix debug/, $(addsuffix -dbg, $(PROGRAMS)))
-DBG_LIB_FILE := $(addprefix debug/, $(LIB_FILE))
+DBG_PROGRAMS := $(addprefix debug/, $(PROGRAMS))
 DBG_LIB_OBJS := $(addprefix debug/, $(LIB_OBJS))
-DBG_SLIB_FILE := $(addprefix debug/, $(SLIB_FILE))
-DBG_LIBS := $(addprefix debug/, $(LIBS))
+DBG_LIBS := $(DBG_LIB_FILE)
+REL_OBJS :=  $(LIB_OBJS) $(foreach @F,$(PROGRAMS),$(@F).o $(EXTRA_OBJS))
+DBG_OBJS :=  $(DBG_LIB_OBJS) $(foreach @F,$(PROGRAMS),debug/$(@F).o
$(EXTRA_OBJS))
+ALL_OBJS := $(REL_OBJS) $(DBG_OBJS)
+INST_PROGRAMS += $(PROGRAMS) $(DBG_PROGRAMS)

-all: $(PROGRAMS) $(DBG_PROGRAMS) sparse.pc
+
+all: $(REL_PROGRAMS) $(DBG_PROGRAMS) sparse.pc

 all-installable: $(INST_PROGRAMS) $(LIBS) $(LIB_H) sparse.pc

@@ -194,17 +203,16 @@ sparse.pc: sparse.pc.in
  $(QUIET_GEN)sed $(SED_PC_CMD) sparse.pc.in > sparse.pc


-compile_EXTRA_DEPS = compile-i386.o
+compile_EXTRA_OBJS = compile-i386.o

-$(foreach p,$(PROGRAMS),$(eval $(p): $($(p)_EXTRA_DEPS) $(LIBS)))
-$(foreach p,$(PROGRAMS),$(eval debug/$(p)-dbg: $(addprefix debug/,
$($(p)_EXTRA_DEPS)) $(DBG_LIBS)))
+$(foreach @F,$(PROGRAMS),$(eval $(@F): $(EXTRA_OBJS) $(LIBS)))
+$(foreach @F,$(PROGRAMS),$(eval debug/$(@F): $(addprefix debug/,
$(EXTRA_OBJS)) $(DBG_LIBS)))


-$(PROGRAMS): % : %.o
- $(QUIET_LINK)$(LD) $(LDFLAGS) -o $@ $^ $($@_EXTRA_OBJS)
-$(DBG_PROGRAMS): debug/%-dbg : debug/%.o
- $(eval EXTRA := $($(@F:-dbg=)_EXTRA_OBJS))
- $(QUIET_LINK)$(LD) $(LDFLAGS) -o $@ $^ $(EXTRA)
+$(PROGRAMS): % : %.o
+ $(QUIET_LINK)$(LD) $(LDFLAGS) -o $@ $^ $(EXTRA_LIBS)
+$(DBG_PROGRAMS): debug/% : debug/%.o
+ $(QUIET_LINK)$(LD) $(LDFLAGS) -o $@ $^ $(EXTRA_LIBS)

 $(LIB_FILE): $(LIB_OBJS)
  $(QUIET_AR)$(AR) rcs $@ $(LIB_OBJS)
@@ -216,14 +224,12 @@ $(SLIB_FILE): $(LIB_OBJS)
 $(DBG_SLIB_FILE): $(DBG_LIB_OBJS)
  $(QUIET_LINK)$(CC) $(LDFLAGS) -Wl,-soname,$@ -shared -o $@ $(DBG_LIB_OBJS)

-DEP_FILES := $(wildcard .*.o.d)
+DEP_FILES := $(wildcard $(addprefix ., $(ALL_OBJ:.o=.o.d)))

 ifneq ($(DEP_FILES),)
 include $(DEP_FILES)
 endif

-c2xml.o c2xml.sc debug/c2xml.o debug/c2xml.sc: CFLAGS += $(LIBXML_CFLAGS)
-
 pre-process.sc debug/pre-process.sc: CHECKER_FLAGS += -Wno-vla

 debug:
@@ -232,17 +238,16 @@ debug:
 debug/%.o: %.c $(LIB_H) | debug
  $(QUIET_CC)$(CC) -o $@ -c $(DBG_CFLAGS) $<
 %.o: %.c $(LIB_H)
- $(QUIET_CC)$(CC) -o $@ -c $(ALL_CFLAGS) $<
+ $(QUIET_CC)$(CC) -o $@ -c $(REL_CFLAGS) $<

-debug/%.sc: %.c sparse
+debug/%.sc: %.c debug/sparse
  $(QUIET_CHECK) $(CHECKER) $(CHECKER_FLAGS) -c $(DBG_CFLAGS) $<
 %.sc: %.c sparse
- $(QUIET_CHECK) $(CHECKER) $(CHECKER_FLAGS) -c $(ALL_CFLAGS) $<
