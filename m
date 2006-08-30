From: Josh Triplett <josht@us.ibm.com>
Subject: [PATCH RESEND] Add backend to graph basic blocks
Date: Tue, 29 Aug 2006 17:45:20 -0700
Message-ID: <1156898720.5203.9.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:15079 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751475AbWH3ApO
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 29 Aug 2006 20:45:14 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k7U0jEsL016867
	for <linux-sparse@vger.kernel.org>; Tue, 29 Aug 2006 20:45:14 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k7U0jDFg272424
	for <linux-sparse@vger.kernel.org>; Tue, 29 Aug 2006 18:45:13 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k7U0jDFg020930
	for <linux-sparse@vger.kernel.org>; Tue, 29 Aug 2006 18:45:13 -0600
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>

Add a new backend program which parses the input files, processes them =
through
the linearization pass, and outputs a graphviz graph of the resulting b=
asic
blocks.  Each entrypoint gets labelled by name, but for now the basic b=
locks
just get labelled with the address of the basic_block structure.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 .gitignore |    1 +
 Makefile   |    6 +++++-
 graph.c    |   63 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 69 insertions(+), 1 deletions(-)

diff --git a/.gitignore b/.gitignore
index 32d6e70..3e12ce7 100644
--- a/.gitignore
+++ b/.gitignore
@@ -13,6 +13,7 @@ test-parsing
 obfuscate
 check
 compile
+graph
 test-dissect
 test-linearize
 example
diff --git a/Makefile b/Makefile
index 378ee72..e71f360 100644
--- a/Makefile
+++ b/Makefile
@@ -21,7 +21,7 @@ # LDFLAGS +=3D -Wl,-rpath,$(BINDIR)
=20
 PREFIX=3D$(HOME)
 BINDIR=3D$(PREFIX)/bin
-PROGRAMS=3Dtest-lexing test-parsing obfuscate check compile test-linea=
rize example test-unssa test-dissect
+PROGRAMS=3Dtest-lexing test-parsing obfuscate check compile graph test=
-linearize example test-unssa test-dissect
=20
 LIB_H=3D    token.h parse.h lib.h symbol.h scope.h expression.h target=
=2Eh \
 	  linearize.h bitmap.h ident-list.h compat.h flow.h allocate.h \
@@ -77,6 +77,9 @@ obfuscate: obfuscate.o $(LIBS)
 check: check.o $(LIBS)
 	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
=20
+graph: graph.o $(LIBS)
+	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
+
 example: example.o $(LIBS)
 	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
=20
@@ -123,6 +126,7 @@ obfuscate.o: $(LIB_H)
 example.o: $(LIB_H)
 storage.o: $(LIB_H) storage.h
 dissect.o: $(LIB_H) dissect.h
+graph.o: $(LIB_H)
=20
 compat-linux.o: compat/strtold.c compat/mmap-blob.c \
 	$(LIB_H)
diff --git a/graph.c b/graph.c
new file mode 100644
index 0000000..db940ae
--- /dev/null
+++ b/graph.c
@@ -0,0 +1,63 @@
+/* Copyright =C2=A9 International Business Machines Corp., 2006
+ *
+ * Author: Josh Triplett <josh@freedesktop.org>
+ *
+ * Licensed under the Open Software License version 1.1
+ */
+#include <stdarg.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <ctype.h>
+#include <unistd.h>
+#include <fcntl.h>
+
+#include "lib.h"
+#include "allocate.h"
+#include "token.h"
+#include "parse.h"
+#include "symbol.h"
+#include "expression.h"
+#include "linearize.h"
+
+static void graph_ep(struct entrypoint *ep)
+{
+	struct basic_block *bb;
+
+	printf("ep%p [label=3D\"%s\",shape=3Dellipse];\n",
+	       ep, show_ident(ep->name->ident));
+	FOR_EACH_PTR(ep->bbs, bb) {
+		printf("bb%p [shape=3Drecord,label=3D\"bb at %p\"]\n", bb, bb);
+	} END_FOR_EACH_PTR(bb);
+	FOR_EACH_PTR(ep->bbs, bb) {
+		struct basic_block *child;
+		FOR_EACH_PTR(bb->children, child) {
+			printf("bb%p -> bb%p;\n", bb, child);
+		} END_FOR_EACH_PTR(child);
+	} END_FOR_EACH_PTR(bb);
+	printf("ep%p -> bb%p;\n", ep, ep->entry->bb);
+}
+
+static void graph_symbols(struct symbol_list *list)
+{
+	struct symbol *sym;
+
+	FOR_EACH_PTR(list, sym) {
+		struct entrypoint *ep;
+
+		expand_symbol(sym);
+		ep =3D linearize_symbol(sym);
+		if (ep)
+			graph_ep(ep);
+	} END_FOR_EACH_PTR(sym);
+}
+
+int main(int argc, char **argv)
+{
+	printf("digraph control_flow {\n");
+	graph_symbols(sparse_initialize(argc, argv));
+	while (*argv)
+		graph_symbols(sparse(argv));
+	printf("}\n");
+	return 0;
+}
--=20
1.4.1.1
