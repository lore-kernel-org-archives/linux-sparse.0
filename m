From: "Christopher Li" <sparse@chrisli.org>
Subject: [PATCH]: Makefile automatic header dependency
Date: Wed, 24 Dec 2008 20:04:31 -0800
Message-ID: <70318cbf0812242004v30a91d73x844eca15c2733b20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:11343 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbYLYEEd (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Dec 2008 23:04:33 -0500
Received: by rv-out-0506.google.com with SMTP id k40so3098309rvb.1
        for <linux-sparse@vger.kernel.org>; Wed, 24 Dec 2008 20:04:31 -0800 (PST)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>, Josh Triplett <josh@freedesktop.org>, Alexey Zaytsev <alexey.zaytsev@gmail.com>

Hi,

Can some one help me test the c2xml build? I don't
have libxml-2.0 to verify it.

Chris

Makefile automatic header dependency

It use the gcc generated dependency file to track
header file changes.

Use pattern rules to build programs.
Makefile is much shorter now. Easier to add
new objs or new programs.

Singed-Off-By: Christopher Li<sparse@chrisli.org>

Index: sparse.chrisl/Makefile
===================================================================
--- sparse.chrisl.orig/Makefile
+++ sparse.chrisl/Makefile
@@ -8,6 +8,7 @@ CFLAGS = -O2 -finline-functions -fno-str
 CFLAGS += -Wall -Wwrite-strings
 LDFLAGS += -g
 AR = ar
+PROG_LINK_CMD = $(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $^  $($@_EXTRA_OBJS)

 #
 # For debugging, uncomment the next one
@@ -18,6 +19,7 @@ HAVE_LIBXML=$(shell pkg-config --exists


 CFLAGS += -DGCC_BASE=\"$(shell $(CC) --print-file-name=)\"
+CFLAGS += -Wp,-MD,$(@D)/.$(@F).d

 DESTDIR=
 PREFIX=$(HOME)
@@ -28,16 +30,15 @@ MAN1DIR=$(MANDIR)/man1
 INCLUDEDIR=$(PREFIX)/include
 PKGCONFIGDIR=$(LIBDIR)/pkgconfig

-PROGRAMS=test-lexing test-parsing obfuscate compile graph sparse
test-linearize example \
-	 test-unssa test-dissect ctags
-
-
+PROGRAMS=test-lexing test-parsing obfuscate compile graph sparse \
+	 test-linearize example test-unssa test-dissect ctags
 INST_PROGRAMS=sparse cgcc
 INST_MAN1=sparse.1 cgcc.1

 ifeq ($(HAVE_LIBXML),yes)
 PROGRAMS+=c2xml
 INST_PROGRAMS+=c2xml
+c2xml_EXTRA_OBJS = `pkg-config --libs libxml-2.0`
 endif

 LIB_H=    token.h parse.h lib.h symbol.h scope.h expression.h target.h \
@@ -98,44 +99,12 @@ install: $(INST_PROGRAMS) $(LIBS) $(LIB_
 sparse.pc: sparse.pc.in
 	$(QUIET_GEN)sed
's|@version@|$(VERSION)|g;s|@prefix@|$(PREFIX)|g;s|@libdir@|$(LIBDIR)|g;s|@includedir@|$(INCLUDEDIR)|g'
sparse.pc.in > sparse.pc

-test-lexing: test-lexing.o $(LIBS)
-	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
-
-test-parsing: test-parsing.o $(LIBS)
-	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
-
-test-linearize: test-linearize.o $(LIBS)
-	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
-
-test-sort: test-sort.o $(LIBS)
-	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
-
+	
 compile: compile.o compile-i386.o $(LIBS)
-	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $< compile-i386.o $(LIBS)
-
-obfuscate: obfuscate.o $(LIBS)
-	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
-
-sparse: sparse.o $(LIBS)
-	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
-
-graph: graph.o $(LIBS)
-	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
-
-example: example.o $(LIBS)
-	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
-
-test-unssa: test-unssa.o $(LIBS)
-	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
-
-test-dissect: test-dissect.o $(LIBS)
-	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
-
-ctags: ctags.o $(LIBS)
-	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
+	$(PROG_LINK_CMD)

-c2xml: c2xml.o $(LIBS)
-	$(QUIET_LINK)$(CC) $(LDFLAGS)  -o $@ $< $(LIBS) `pkg-config --libs libxml-2.0`
+%: %.o $(LIBS)
+	$(PROG_LINK_CMD)

 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(AR) rcs $@ $(LIB_OBJS)
@@ -143,48 +112,13 @@ $(LIB_FILE): $(LIB_OBJS)
 $(SLIB_FILE): $(LIB_OBJS)
 	$(QUIET_LINK)$(CC) $(LDFLAGS) -Wl,-soname,$@ -shared -o $@ $(LIB_OBJS)

-evaluate.o: $(LIB_H)
-expression.o: $(LIB_H)
-lib.o: $(LIB_H)
-allocate.o: $(LIB_H)
-ptrlist.o: $(LIB_H)
-parse.o: $(LIB_H)
-pre-process.o: $(LIB_H)
-scope.o: $(LIB_H)
-show-parse.o: $(LIB_H)
-symbol.o: $(LIB_H)
-expand.o: $(LIB_H)
-linearize.o: $(LIB_H)
-flow.o: $(LIB_H)
-cse.o: $(LIB_H)
-simplify.o: $(LIB_H)
-memops.o: $(LIB_H)
-liveness.o: $(LIB_H)
-sort.o: $(LIB_H)
-inline.o: $(LIB_H)
-target.o: $(LIB_H)
-test-lexing.o: $(LIB_H)
-test-parsing.o: $(LIB_H)
-test-linearize.o: $(LIB_H)
-test-dissect.o: $(LIB_H)
-test-unssa.o: $(LIB_H)
-ctags.o: $(LIB_H)
-compile.o: $(LIB_H) compile.h
-compile-i386.o: $(LIB_H) compile.h
-tokenize.o: $(LIB_H)
-sparse.o: $(LIB_H)
-obfuscate.o: $(LIB_H)
-example.o: $(LIB_H)
-storage.o: $(LIB_H)
-dissect.o: $(LIB_H)
-graph.o: $(LIB_H)
+include $(wildcard .*.o.d)

 c2xml.o: c2xml.c $(LIB_H)
 	$(QUIET_CC)$(CC) `pkg-config --cflags libxml-2.0` -o $@ -c $(CFLAGS) $<

-compat-linux.o: compat/strtold.c compat/mmap-blob.c \
-	$(LIB_H)
-compat-solaris.o: compat/mmap-blob.c $(LIB_H)
+compat-linux.o: compat/strtold.c compat/mmap-blob.c
+compat-solaris.o: compat/mmap-blob.c
 compat-mingw.o: $(LIB_H)
 compat-cygwin.o: $(LIB_H)

@@ -192,7 +126,7 @@ compat-cygwin.o: $(LIB_H)
 	$(QUIET_CC)$(CC) -o $@ -c $(CFLAGS) $<

 clean: clean-check
-	rm -f *.[oa] *.so $(PROGRAMS) $(SLIB_FILE) pre-process.h sparse.pc
+	rm -f *.[oad] *.so $(PROGRAMS) $(SLIB_FILE) pre-process.h sparse.pc

 dist:
 	@if test "`git describe`" != "$(VERSION)" ; then \
