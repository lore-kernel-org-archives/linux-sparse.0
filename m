From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 07/38] build: remove unused support for pkgconfig
Date: Sat, 11 Nov 2017 15:24:06 +0100
Message-ID: <20171111142437.67359-8-luc.vanoostenryck@gmail.com>
References: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35454 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbdKKOZE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 09:25:04 -0500
Received: by mail-wm0-f68.google.com with SMTP id y80so7433461wmd.0
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 06:25:04 -0800 (PST)
In-Reply-To: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>, Josh Triplett <josh@joshtriplett.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

Sparse being a library was installed as such and with support for
pkgconfig.

However, it seems that sparse is only used for its tools and not
as a library (at least not as an external one) and currently
doesn't offer a stable interface.

For now, remove the support for this, it will be easy enough to
restore it if there is a new need.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 .gitignore   |  1 -
 Makefile     | 27 +++------------------------
 sparse.pc.in |  9 ---------
 3 files changed, 3 insertions(+), 34 deletions(-)
 delete mode 100644 sparse.pc.in

diff --git a/.gitignore b/.gitignore
index 44218a2fe..9f996dc87 100644
--- a/.gitignore
+++ b/.gitignore
@@ -7,7 +7,6 @@
 
 # generated
 pre-process.h
-sparse.pc
 version.h
 
 # programs
diff --git a/Makefile b/Makefile
index bc4469410..bd8a08f13 100644
--- a/Makefile
+++ b/Makefile
@@ -48,11 +48,8 @@ endif
 DESTDIR=
 PREFIX ?= $(HOME)
 BINDIR=$(PREFIX)/bin
-LIBDIR=$(PREFIX)/lib
 MANDIR=$(PREFIX)/share/man
 MAN1DIR=$(MANDIR)/man1
-INCLUDEDIR=$(PREFIX)/include
-PKGCONFIGDIR=$(LIBDIR)/pkgconfig
 
 PROGRAMS=test-lexing test-parsing obfuscate compile graph sparse \
 	 test-linearize example test-unssa test-dissect ctags
@@ -105,9 +102,6 @@ else
 $(warning Your system does not have llvm, disabling sparse-llvm)
 endif
 
-LIB_H=    token.h parse.h lib.h symbol.h scope.h expression.h target.h \
-	  linearize.h bitmap.h ident-list.h compat.h flow.h allocate.h \
-	  storage.h ptrlist.h dissect.h
 
 LIB_OBJS= target.o parse.o tokenize.o pre-process.o symbol.o lib.o scope.o \
 	  expression.o show-parse.o evaluate.o expand.o inline.o linearize.o \
@@ -151,12 +145,6 @@ define INSTALL_FILE
 
 endef
 
-SED_PC_CMD = 's|@version@|$(VERSION)|g;		\
-	      s|@prefix@|$(PREFIX)|g;		\
-	      s|@libdir@|$(LIBDIR)|g;		\
-	      s|@includedir@|$(INCLUDEDIR)|g'
-
-
 
 # Allow users to override build settings without dirtying their trees
 # For debugging, put this in local.mk:
@@ -166,24 +154,15 @@ SED_PC_CMD = 's|@version@|$(VERSION)|g;		\
 -include local.mk
 
 
-all: $(PROGRAMS) sparse.pc
+all: $(PROGRAMS)
 
-all-installable: $(INST_PROGRAMS) $(LIBS) $(LIB_H) sparse.pc
+all-installable: $(INST_PROGRAMS)
 
 install: all-installable
 	$(Q)install -d $(DESTDIR)$(BINDIR)
-	$(Q)install -d $(DESTDIR)$(LIBDIR)
 	$(Q)install -d $(DESTDIR)$(MAN1DIR)
-	$(Q)install -d $(DESTDIR)$(INCLUDEDIR)/sparse
-	$(Q)install -d $(DESTDIR)$(PKGCONFIGDIR)
 	$(foreach f,$(INST_PROGRAMS),$(call INSTALL_EXEC,$f,$(BINDIR)))
 	$(foreach f,$(INST_MAN1),$(call INSTALL_FILE,$f,$(MAN1DIR)))
-	$(foreach f,$(LIBS),$(call INSTALL_FILE,$f,$(LIBDIR)))
-	$(foreach f,$(LIB_H),$(call INSTALL_FILE,$f,$(INCLUDEDIR)/sparse))
-	$(call INSTALL_FILE,sparse.pc,$(PKGCONFIGDIR))
-
-sparse.pc: sparse.pc.in
-	$(QUIET_GEN)sed $(SED_PC_CMD) sparse.pc.in > sparse.pc
 
 
 compile_EXTRA_DEPS = compile-i386.o
@@ -219,7 +198,7 @@ selfcheck: $(ALL_OBJS:.o=.sc)
 
 
 clean: clean-check
-	rm -f *.[oa] .*.d *.so $(PROGRAMS) $(SLIB_FILE) pre-process.h sparse.pc version.h
+	rm -f *.[oa] .*.d *.so $(PROGRAMS) $(SLIB_FILE) pre-process.h version.h
 
 dist:
 	@if test "$(SPARSE_VERSION)" != "v$(VERSION)" ; then \
diff --git a/sparse.pc.in b/sparse.pc.in
deleted file mode 100644
index f1281c97a..000000000
--- a/sparse.pc.in
+++ /dev/null
@@ -1,9 +0,0 @@
-prefix=@prefix@
-libdir=@libdir@
-includedir=@includedir@
