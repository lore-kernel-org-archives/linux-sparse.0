From: Damien Lespiau <damien.lespiau@gmail.com>
Subject: [PATCH] Beautify all & install Makefile targets
Date: Sun, 20 May 2007 23:59:45 +0200
Message-ID: <11796983862564-git-send-email-damien.lespiau@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp19.orange.fr ([80.12.242.17]:54138 "EHLO smtp19.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757221AbXETV7s (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 20 May 2007 17:59:48 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Damien Lespiau <damien.lespiau@gmail.com>

Beautify make's output like kbuild or git. The install
target is especially much more readable.
make V=1 (install) to get back to the old behaviour.

Signed-off-by: Damien Lespiau <damien.lespiau@gmail.com>
---
 Makefile |   72 ++++++++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 45 insertions(+), 27 deletions(-)

diff --git a/Makefile b/Makefile
index 77a6877..bacfba0 100644
--- a/Makefile
+++ b/Makefile
@@ -37,68 +37,83 @@ SLIB_FILE= libsparse.so
 
 LIBS=$(LIB_FILE)
 
+#
+# Pretty print
+#
+ifneq ($(findstring $(MAKEFLAGS),s),s)
+ifndef V
+	Q              = @
+	QUIET_CC       = @echo    '   ' CC'      '$@;
+	QUIET_AR       = @echo    '   ' AR'      '$@;
+	QUIET_GEN      = @echo    '   ' GEN'     '$@;
+	QUIET_LD       = @echo    '   ' LD'      '$@;
+	QUIET_INST_SH  = echo -n  '   ' INSTALL '';
+	QUIET_INST     = @echo -n '   ' INSTALL '';
+endif
+endif
+
 all: $(PROGRAMS) sparse.pc
 
 install: $(INST_PROGRAMS) $(LIBS) $(LIB_H) sparse.pc
-	install -d $(DESTDIR)$(BINDIR)
-	install -d $(DESTDIR)$(LIBDIR)
-	install -d $(DESTDIR)$(INCLUDEDIR)/sparse
-	install -d $(DESTDIR)$(PKGCONFIGDIR)
-	for f in $(INST_PROGRAMS); do \
-		install -v $$f $(DESTDIR)$(BINDIR)/$$f || exit 1; \
+	$(Q)install -d $(DESTDIR)$(BINDIR)
+	$(Q)install -d $(DESTDIR)$(LIBDIR)
+	$(Q)install -d $(DESTDIR)$(INCLUDEDIR)/sparse
+	$(Q)install -d $(DESTDIR)$(PKGCONFIGDIR)
+	$(Q)for f in $(INST_PROGRAMS); do \
+		$(QUIET_INST_SH)install -v $$f $(DESTDIR)$(BINDIR)/$$f || exit 1; \
 	done
-	for f in $(LIBS); do \
-		install -m 644 -v $$f $(DESTDIR)$(LIBDIR)/$$f || exit 1; \
+	$(Q)for f in $(LIBS); do \
+		$(QUIET_INST_SH)install -m 644 -v $$f $(DESTDIR)$(LIBDIR)/$$f || exit 1; \
 	done
-	for f in $(LIB_H); do \
-		install -m 644 -v $$f $(DESTDIR)$(INCLUDEDIR)/sparse/$$f || exit 1; \
+	$(Q)for f in $(LIB_H); do \
+		$(QUIET_INST_SH)install -m 644 -v $$f $(DESTDIR)$(INCLUDEDIR)/sparse/$$f || exit 1; \
 	done
-	install -m 644 -v sparse.pc $(DESTDIR)$(PKGCONFIGDIR)/sparse.pc
+	$(QUIET_INST)install -m 644 -v sparse.pc $(DESTDIR)$(PKGCONFIGDIR)/sparse.pc
 
 sparse.pc: sparse.pc.in
-	sed 's|@version@|$(VERSION)|g;s|@prefix@|$(PREFIX)|g;s|@libdir@|$(LIBDIR)|g;s|@includedir@|$(INCLUDEDIR)|g' sparse.pc.in > sparse.pc
+	$(QUIET_GEN)sed 's|@version@|$(VERSION)|g;s|@prefix@|$(PREFIX)|g;s|@libdir@|$(LIBDIR)|g;s|@includedir@|$(INCLUDEDIR)|g' sparse.pc.in > sparse.pc
 
 test-lexing: test-lexing.o $(LIBS)
-	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
+	$(QUIET_LD)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
 
 test-parsing: test-parsing.o $(LIBS)
-	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
+	$(QUIET_LD)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
 
 test-linearize: test-linearize.o $(LIBS)
-	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
+	$(QUIET_LD)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
 
 test-sort: test-sort.o $(LIBS)
-	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
+	$(QUIET_LD)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
 
 compile: compile.o compile-i386.o $(LIBS)
-	$(CC) $(LDFLAGS) -o $@ $< compile-i386.o $(LIBS)
+	$(QUIET_LD)$(CC) $(LDFLAGS) -o $@ $< compile-i386.o $(LIBS)
 
 obfuscate: obfuscate.o $(LIBS)
-	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
+	$(QUIET_LD)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
 
 sparse: sparse.o $(LIBS)
-	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
+	$(QUIET_LD)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
 
 graph: graph.o $(LIBS)
-	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
+	$(QUIET_LD)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
 
 example: example.o $(LIBS)
-	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
+	$(QUIET_LD)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
 
 test-unssa: test-unssa.o $(LIBS)
-	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
+	$(QUIET_LD)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
 
 test-dissect: test-dissect.o $(LIBS)
-	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
+	$(QUIET_LD)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
 
 ctags: ctags.o $(LIBS)
-	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
+	$(QUIET_LD)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
 
 $(LIB_FILE): $(LIB_OBJS)
-	$(AR) rcs $@ $(LIB_OBJS)
+	$(QUIET_AR)$(AR) rcs $@ $(LIB_OBJS)
 
 $(SLIB_FILE): $(LIB_OBJS)
-	$(CC) -shared -o $@ $(LIB_OBJS)
+	$(QUIET_LD)$(CC) -shared -o $@ $(LIB_OBJS)
 
 evaluate.o: $(LIB_H)
 expression.o: $(LIB_H)
@@ -141,7 +156,10 @@ compat-mingw.o: $(LIB_H)
 compat-cygwin.o: $(LIB_H)
 
 pre-process.h:
-	echo "#define GCC_INTERNAL_INCLUDE \"`$(CC) -print-file-name=include`\"" > pre-process.h
+	$(QUIET_GEN)echo "#define GCC_INTERNAL_INCLUDE \"`$(CC) -print-file-name=include`\"" > pre-process.h
+
+%.o: %.c
+	$(QUIET_CC)$(CC) -o $*.o -c $(CFLAGS) $<
 
 clean:
 	rm -f *.[oasi] core core.[0-9]* $(PROGRAMS) $(SLIB_FILE) pre-process.h sparse.pc
-- 
1.5.2.rc3.87.g404fd
