From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 1/4] Compile sparse executable under it's own name, not as "check"
Date: Fri, 03 Nov 2006 17:16:59 -0500
Message-ID: <20061103221659.7811.73832.stgit@dv.roinet.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from static-72-92-88-10.phlapa.fios.verizon.net ([72.92.88.10]:63881
	"EHLO smtp.roinet.com") by vger.kernel.org with ESMTP
	id S1753545AbWKCWRA (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 3 Nov 2006 17:17:00 -0500
Received: from dv.roinet.com (192.168.1.21 [192.168.1.21])
    by smtp.roinet.com with SMTP;
    for linux-sparse@vger.kernel.org;
    Fri, 03 Nov 2006 17:16:59 -0500 (EST)
    (envelope-from proski@gnu.org)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

From: Pavel Roskin <proski@gnu.org>

No need to confuse everyone.  Besides, it allows to use "make check" for
some something meaningful in the future.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 Makefile |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index ccf9f89..da4a47a 100644
--- a/Makefile
+++ b/Makefile
@@ -21,7 +21,7 @@ CFLAGS += -DDEBUG
 
 PREFIX=$(HOME)
 BINDIR=$(PREFIX)/bin
-PROGRAMS=test-lexing test-parsing obfuscate check compile graph test-linearize example test-unssa test-dissect
+PROGRAMS=test-lexing test-parsing obfuscate compile graph sparse test-linearize example test-unssa test-dissect
 
 LIB_H=    token.h parse.h lib.h symbol.h scope.h expression.h target.h \
 	  linearize.h bitmap.h ident-list.h compat.h flow.h allocate.h \
@@ -39,12 +39,7 @@ LIBS=$(LIB_FILE)
 
 all: $(PROGRAMS) $(SLIB_FILE)
 
-#
-# Install the 'check' binary as 'sparse', just to confuse people.
-#
-#		"The better to keep you on your toes, my dear".
-#
-install: check $(SLIB_FILE) bin-dir
+install: sparse $(SLIB_FILE) bin-dir
 	if test $< -nt $(BINDIR)/sparse ; then install -v $< $(BINDIR)/sparse ; install -v $(SLIB_FILE) $(BINDIR) ; fi
 
 bin-dir:
@@ -74,7 +69,7 @@ compile: compile.o compile-i386.o $(LIBS
 obfuscate: obfuscate.o $(LIBS)
 	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
 
-check: check.o $(LIBS)
+sparse: check.o $(LIBS)
 	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
 
 graph: graph.o $(LIBS)
