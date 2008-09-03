From: alexey.zaytsev@gmail.com
Subject: [PATCH 08/10] Sparse Object Link eDitor
Date: Thu,  4 Sep 2008 01:55:52 +0400
Message-ID: <22963cd6ccaf20f03b680bde72da86355da740b3.1220475018.git.xl0@xl0.local>
References: <1220478954-22678-1-git-send-email-alexey.zaytsev@gmail.com>
 <20df58606337d58576ba3c10cf8f8c1522f81f91.1220475018.git.xl0@xl0.local>
 <6f37eec18608be0a86356a874836bea516317084.1220475018.git.xl0@xl0.local>
 <2faea660ccc7cae55a2d2cd28f64059b80356a8f.1220475018.git.xl0@xl0.local>
 <c97fb6bb13fb17d09a2d1525cb5b813ecebb804d.1220475018.git.xl0@xl0.local>
 <b0118cf8f9301f77a141af47739aa599ae1e624b.1220475018.git.xl0@xl0.local>
 <ad58a8f48bbd496a896ef370772e8a12101560f5.1220475018.git.xl0@xl0.local>
 <eb541a9449e5ec380212c85093d3ef206db1db4d.1220475018.git.xl0@xl0.local>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:48383 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905AbYICVyE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 3 Sep 2008 17:54:04 -0400
Received: by ug-out-1314.google.com with SMTP id c2so1952946ugf.37
        for <linux-sparse@vger.kernel.org>; Wed, 03 Sep 2008 14:54:03 -0700 (PDT)
In-Reply-To: <eb541a9449e5ec380212c85093d3ef206db1db4d.1220475018.git.xl0@xl0.local>
In-Reply-To: <20df58606337d58576ba3c10cf8f8c1522f81f91.1220475018.git.xl0@xl0.local>
References: <20df58606337d58576ba3c10cf8f8c1522f81f91.1220475018.git.xl0@xl0.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@kernel.org>, Chris Li <christ.li@gmail.com>, Codrin Alexandru Grajdeanu <grcodal@gmail.com>, Alexey Zaytsev <alexey.zaytsev@gmail.com>

From: Alexey Zaytsev <alexey.zaytsev@gmail.com>

Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
---
 Makefile |    9 +++-
 sold.c   |  127 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+), 3 deletions(-)
 create mode 100644 sold.c

diff --git a/Makefile b/Makefile
index dd1fe8a..4fa2f82 100644
--- a/Makefile
+++ b/Makefile
@@ -2,7 +2,6 @@ VERSION=0.4.1
 
 OS = linux
 
-
 CC = gcc
 CFLAGS = -O2 -finline-functions -fno-strict-aliasing -g
 CFLAGS += -Wall -Wwrite-strings
@@ -27,10 +26,10 @@ INCLUDEDIR=$(PREFIX)/include
 PKGCONFIGDIR=$(LIBDIR)/pkgconfig
 
 PROGRAMS=test-lexing test-parsing obfuscate compile graph sparse test-linearize example \
-	 test-unssa test-dissect ctags serialization-test
+	 test-unssa test-dissect ctags serialization-test sold
 
 
-INST_PROGRAMS=sparse cgcc
+INST_PROGRAMS=sparse cgcc sold
 INST_MAN1=sparse.1 cgcc.1
 
 ifeq ($(HAVE_LIBXML),yes)
@@ -139,6 +138,9 @@ c2xml: c2xml.o $(LIBS)
 serialization-test: serialization-test.o $(LIBS)
 	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
 
+sold: sold.o $(LIBS)
+	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $< $(LIBS) -ldl
+
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(AR) rcs $@ $(LIB_OBJS)
 
@@ -192,6 +194,7 @@ compat-cygwin.o: $(LIB_H)
 serialization.o: $(LIB_H)
 serialization-test.o: $(LIB_H)
 link.o: $(LIB_H)
+sold.o: $(LIB_H)
 
 pre-process.h:
 	$(QUIET_GEN)echo "#define GCC_INTERNAL_INCLUDE \"`$(CC) -print-file-name=`\"" > pre-process.h
diff --git a/sold.c b/sold.c
new file mode 100644
index 0000000..3da0cad
--- /dev/null
+++ b/sold.c
@@ -0,0 +1,127 @@
+
+#include <stdio.h>
+#include <limits.h>
+#include <dlfcn.h>
+#include <stdlib.h>
+
+#include "lib.h"
+#include "link.h"
+#include "ptrlist.h"
+
+static const char *output = NULL;
+
+static char **handle_switch(char *arg, char **next)
+{
+	switch(*arg) {
+	case 'o':
+		if (!strcmp (arg, "o")) { 	// "-o foo"
+			next++;
+			if (!*next)
+				die("argument to '-o' is missing");
+			output = *next;
+		} else { 			// "-ofoo"
+			output = ++arg;
+		}
+		break;
+	case 'm':
+		if (!strcmp (arg, "m")) { 	// "-m foo"
+			next++;
+			if (!*next)
+				die("argument to '-m' is missing");
+		}
+		break;
+	case 'T':
+		if (!strcmp (arg, "m")) { 	// "-T foo"
+			next++;
+			if (!*next)
+				die("argument to '-T' is missing");
+		}
+		break;
+	}
+
+	return next;
+}
+
+char *input_name(const char *file)
+{
+	static char buf[PATH_MAX+1];
+	snprintf(buf, PATH_MAX, "./%s.sparse.so", file);
+	return buf;
+}
+
+int main(int argc, char **argv)
+{
+	char **args;
+	const char sym_type_tbl[] = {'F', 'D', 'O'}; /* Func, Data, Other */
+	struct string_list *file_list = NULL;
+	struct sold_symbol_list *out_symbols = NULL;
+	struct sold_symbol *sym;
+	struct serialization_stream *s;
+	char *file;
+	char *input_file;
+
+
+	args = argv;
+	for (;;) {
+		char *arg = *++args;
+		if (!arg)
+			break;
+
+		if (arg[0] == '-') {
+			if (arg[1])
+				args = handle_switch(arg+1, args);
+			continue;
+		}
+		add_ptr_list_notag(&file_list, arg);
+	}
+
+	output = output ? output : "a.out";
+
+	printf("output_file = %s\n", output);
+
+	FOR_EACH_PTR_NOTAG(file_list, file) {
+		void *handle;
+		struct sold_symbol_list **symbols;
+
+		printf("Input file: %s\n", file);
+		input_file = input_name(file);
+		printf("Sparse object: %s\n", input_file);
+
+		handle = dlopen(input_file, RTLD_NOW);
+		if (!handle) {
+			fprintf(stderr, "%s: Can't open input file %s. Ignoring it.\n",
+				argv[0], input_file);
+			continue;
+		}
+		symbols = dlsym(handle, "symbols");
+		if (!symbols) {
+			fprintf(stderr, "%s: %s: this input file does not "
+				"look like a sparse object file. Ignoring it.\n",
+				argv[0], input_file);
+			continue;
+		}
+
+		FOR_EACH_PTR(*symbols, sym) {
+			printf ("%c %s from %s\n", sym_type_tbl[sym->type],
+				sym->name, sym->source->source);
+		} END_FOR_EACH_PTR (sym);
+
+		concat_sold_sym_list(*symbols, &out_symbols);
+	} END_FOR_EACH_PTR_NOTAG(file);
+
+	printf("Resulting object file (%s):\n", output);
+	FOR_EACH_PTR (out_symbols, sym) {
+		printf ("%c %s from %s\n", sym_type_tbl[sym->type],
+			sym->name, sym->source->source);
+	} END_FOR_EACH_PTR (sym);
+
+	s = new_serialization_stream(output);
+	if (!s) {
+		perror("Failed to open the serialization stream");
+		exit(1);
+	}
+	serialize_sold_symbol_list(s, (struct ptr_list *) out_symbols, "symbols");
+	fini_serialization_stream(s);
+
+	return 0;
+}
-- 
1.5.6.3

