From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 2/4] Install cgcc on "make install", refactor installation code
Date: Fri, 03 Nov 2006 17:17:04 -0500
Message-ID: <20061103221704.7811.17320.stgit@dv.roinet.com>
References: <20061103221659.7811.73832.stgit@dv.roinet.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from static-72-92-88-10.phlapa.fios.verizon.net ([72.92.88.10]:64393
	"EHLO smtp.roinet.com") by vger.kernel.org with ESMTP
	id S1753556AbWKCWRH (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 3 Nov 2006 17:17:07 -0500
Received: from dv.roinet.com (192.168.1.21 [192.168.1.21])
    by smtp.roinet.com with SMTP;
    for linux-sparse@vger.kernel.org;
    Fri, 03 Nov 2006 17:17:06 -0500 (EST)
    (envelope-from proski@gnu.org)
In-Reply-To: <20061103221659.7811.73832.stgit@dv.roinet.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

From: Pavel Roskin <proski@gnu.org>

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 Makefile |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index da4a47a..61c7953 100644
--- a/Makefile
+++ b/Makefile
@@ -22,6 +22,7 @@ CFLAGS += -DDEBUG
 PREFIX=$(HOME)
 BINDIR=$(PREFIX)/bin
 PROGRAMS=test-lexing test-parsing obfuscate compile graph sparse test-linearize example test-unssa test-dissect
+INST_PROGRAMS=sparse cgcc
 
 LIB_H=    token.h parse.h lib.h symbol.h scope.h expression.h target.h \
 	  linearize.h bitmap.h ident-list.h compat.h flow.h allocate.h \
@@ -39,8 +40,10 @@ LIBS=$(LIB_FILE)
 
 all: $(PROGRAMS) $(SLIB_FILE)
 
-install: sparse $(SLIB_FILE) bin-dir
-	if test $< -nt $(BINDIR)/sparse ; then install -v $< $(BINDIR)/sparse ; install -v $(SLIB_FILE) $(BINDIR) ; fi
+install: $(INST_PROGRAMS) $(SLIB_FILE) bin-dir
+	for f in $(INST_PROGRAMS) $(SLIB_FILE); do \
+		install -v $$f $(BINDIR)/$$f || exit 1; \
+	done
 
 bin-dir:
 	@if ! test -d $(BINDIR); then \
