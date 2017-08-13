From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 1/4] Makefile: adding debug version of sparse
Date: Sun, 13 Aug 2017 15:08:38 -0400
Message-ID: <CANeU7Q=HyZNGXRFydfuxD5KRRwQ-gjMyH4u4OHcmnrttKtFe8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33260 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbdHMTIj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 15:08:39 -0400
Received: by mail-yw0-f194.google.com with SMTP id u207so5088132ywc.0
        for <linux-sparse@vger.kernel.org>; Sun, 13 Aug 2017 12:08:39 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The debug version has the -DSPARSE_DEBUG enabled.
It is intended to include more verification in the
debug version. For now the debug version remain
the same as the release version.

Because the debug version has different compile flags,
all *.o file need to be recompile under the debug flag.
These debug version object file is stored in  debug/
directory.

<name>-dbg is the finial debug version of the
program <name>.

Full compile time is doubled because every thing
needs to compile twice. One for release version.
One for debug version.

Signed-off-by: Christopher Li <sparse@chrisli.org>
---
 Makefile | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 48e1f50..6660220 100644
--- a/Makefile
+++ b/Makefile
@@ -14,6 +14,7 @@ OS = linux
 CC = gcc
 CFLAGS = -O2 -finline-functions -fno-strict-aliasing -g
 CFLAGS += -Wall -Wwrite-strings
+DBG_CFLAGS = $(ALL_CFLAGS) -DSPARSE_DEBUG
 LDFLAGS += -g
 LD = gcc
 AR = ar
@@ -83,7 +84,9 @@ PROGRAMS += test-inspect
 INST_PROGRAMS += test-inspect
 test-inspect_EXTRA_DEPS := ast-model.o ast-view.o ast-inspect.o
 test-inspect_OBJS := test-inspect.o $(test-inspect_EXTRA_DEPS)
-$(test-inspect_OBJS) $(test-inspect_OBJS:.o=.sc): CFLAGS += $(GTK_CFLAGS)
+
+$(test-inspect_OBJS) $(test-inspect_OBJS:.o=.sc) \
+$(addprefix debug/, $(test-inspect_OBJS) $(test-inspect_OBJS:.o=.sc))
: CFLAGS += $(GTK_CFLAGS)
 test-inspect_EXTRA_OBJS := $(GTK_LIBS)
 else
 $(warning Your system does not have gtk3/gtk2, disabling test-inspect)
@@ -165,8 +168,13 @@ SED_PC_CMD = 's|@version@|$(VERSION)|g; \
 # Allow users to override build settings without dirtying their trees
 -include local.mk

+DBG_PROGRAMS := $(addprefix debug/, $(addsuffix -dbg, $(PROGRAMS)))
+DBG_LIB_FILE := $(addprefix debug/, $(LIB_FILE))
+DBG_LIB_OBJS := $(addprefix debug/, $(LIB_OBJS))
+DBG_SLIB_FILE := $(addprefix debug/, $(SLIB_FILE))
+DBG_LIBS := $(addprefix debug/, $(LIBS))

-all: $(PROGRAMS) sparse.pc
+all: $(PROGRAMS) $(DBG_PROGRAMS) sparse.pc

 all-installable: $(INST_PROGRAMS) $(LIBS) $(LIB_H) sparse.pc

@@ -189,14 +197,24 @@ sparse.pc: sparse.pc.in
 compile_EXTRA_DEPS = compile-i386.o

 $(foreach p,$(PROGRAMS),$(eval $(p): $($(p)_EXTRA_DEPS) $(LIBS)))
+$(foreach p,$(PROGRAMS),$(eval debug/$(p)-dbg: $(addprefix debug/,
$($(p)_EXTRA_DEPS)) $(DBG_LIBS)))
+
+
 $(PROGRAMS): % : %.o
  $(QUIET_LINK)$(LD) $(LDFLAGS) -o $@ $^ $($@_EXTRA_OBJS)
+$(DBG_PROGRAMS): debug/%-dbg : debug/%.o
+ $(eval EXTRA := $($(@F:-dbg=)_EXTRA_OBJS))
+ $(QUIET_LINK)$(LD) $(LDFLAGS) -o $@ $^ $(EXTRA)

 $(LIB_FILE): $(LIB_OBJS)
  $(QUIET_AR)$(AR) rcs $@ $(LIB_OBJS)
+$(DBG_LIB_FILE): $(DBG_LIB_OBJS)
+ $(QUIET_AR)$(AR) rcs $@ $(DBG_LIB_OBJS)

 $(SLIB_FILE): $(LIB_OBJS)
  $(QUIET_LINK)$(CC) $(LDFLAGS) -Wl,-soname,$@ -shared -o $@ $(LIB_OBJS)
+$(DBG_SLIB_FILE): $(DBG_LIB_OBJS)
+ $(QUIET_LINK)$(CC) $(LDFLAGS) -Wl,-soname,$@ -shared -o $@ $(DBG_LIB_OBJS)

 DEP_FILES := $(wildcard .*.o.d)

@@ -204,21 +222,31 @@ ifneq ($(DEP_FILES),)
 include $(DEP_FILES)
 endif

-c2xml.o c2xml.sc: CFLAGS += $(LIBXML_CFLAGS)
+c2xml.o c2xml.sc debug/c2xml.o debug/c2xml.sc: CFLAGS += $(LIBXML_CFLAGS)

-pre-process.sc: CHECKER_FLAGS += -Wno-vla
+pre-process.sc debug/pre-process.sc: CHECKER_FLAGS += -Wno-vla

+debug:
+ @mkdir debug
+
+debug/%.o: %.c $(LIB_H) | debug
+ $(QUIET_CC)$(CC) -o $@ -c $(DBG_CFLAGS) $<
 %.o: %.c $(LIB_H)
  $(QUIET_CC)$(CC) -o $@ -c $(ALL_CFLAGS) $<

+debug/%.sc: %.c sparse
+ $(QUIET_CHECK) $(CHECKER) $(CHECKER_FLAGS) -c $(DBG_CFLAGS) $<
 %.sc: %.c sparse
  $(QUIET_CHECK) $(CHECKER) $(CHECKER_FLAGS) -c $(ALL_CFLAGS) $<

-ALL_OBJS :=  $(LIB_OBJS) $(foreach p,$(PROGRAMS),$(p).o $($(p)_EXTRA_DEPS))
+ALL_OBJS :=  $(LIB_OBJS) $(DBG_LIB_OBJS) \
+ $(foreach p,$(PROGRAMS),$(p).o debug/$(p).o $($(p)_EXTRA_DEPS)
debug/$($(p)_EXTRA_DEPS))
+
 selfcheck: $(ALL_OBJS:.o=.sc)


 clean: clean-check
+ rm -rf debug
  rm -f *.[oa] .*.d *.so $(PROGRAMS) $(SLIB_FILE) pre-process.h sparse.pc

 dist:
-- 
2.13.4
