From: alexey.zaytsev@gmail.com
Subject: [PATCH 10/10] A simple demonstrational program that looks up symbols in sparse object files.
Date: Thu,  4 Sep 2008 01:55:54 +0400
Message-ID: <ee1fe6be61d60da3a892f127253582e1620131e5.1220475018.git.xl0@xl0.local>
References: <1220478954-22678-1-git-send-email-alexey.zaytsev@gmail.com>
 <20df58606337d58576ba3c10cf8f8c1522f81f91.1220475018.git.xl0@xl0.local>
 <6f37eec18608be0a86356a874836bea516317084.1220475018.git.xl0@xl0.local>
 <2faea660ccc7cae55a2d2cd28f64059b80356a8f.1220475018.git.xl0@xl0.local>
 <c97fb6bb13fb17d09a2d1525cb5b813ecebb804d.1220475018.git.xl0@xl0.local>
 <b0118cf8f9301f77a141af47739aa599ae1e624b.1220475018.git.xl0@xl0.local>
 <ad58a8f48bbd496a896ef370772e8a12101560f5.1220475018.git.xl0@xl0.local>
 <eb541a9449e5ec380212c85093d3ef206db1db4d.1220475018.git.xl0@xl0.local>
 <22963cd6ccaf20f03b680bde72da86355da740b3.1220475018.git.xl0@xl0.local>
 <5a555e4fe88da659e97a22698d58e6e54ec57f54.1220475018.git.xl0@xl0.local>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:41113 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753144AbYICVyJ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 3 Sep 2008 17:54:09 -0400
Received: by ug-out-1314.google.com with SMTP id c2so1952952ugf.37
        for <linux-sparse@vger.kernel.org>; Wed, 03 Sep 2008 14:54:08 -0700 (PDT)
In-Reply-To: <5a555e4fe88da659e97a22698d58e6e54ec57f54.1220475018.git.xl0@xl0.local>
In-Reply-To: <20df58606337d58576ba3c10cf8f8c1522f81f91.1220475018.git.xl0@xl0.local>
References: <20df58606337d58576ba3c10cf8f8c1522f81f91.1220475018.git.xl0@xl0.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@kernel.org>, Chris Li <christ.li@gmail.com>, Codrin Alexandru Grajdeanu <grcodal@gmail.com>, Alexey Zaytsev <alexey.zaytsev@gmail.com>

From: Alexey Zaytsev <alexey.zaytsev@gmail.com>

Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
---
 Makefile |    6 +++++-
 where.c  |   61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 1 deletions(-)
 create mode 100644 where.c

diff --git a/Makefile b/Makefile
index 877634c..446e053 100644
--- a/Makefile
+++ b/Makefile
@@ -26,7 +26,7 @@ INCLUDEDIR=$(PREFIX)/include
 PKGCONFIGDIR=$(LIBDIR)/pkgconfig
 
 PROGRAMS=test-lexing test-parsing obfuscate compile graph sparse test-linearize example \
-	 test-unssa test-dissect ctags serialization-test sold
+	 test-unssa test-dissect ctags serialization-test sold where
 
 
 INST_PROGRAMS=sparse sold cgcc cld car
@@ -141,6 +141,9 @@ serialization-test: serialization-test.o $(LIBS)
 sold: sold.o $(LIBS)
 	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $< $(LIBS) -ldl
 
+where: where.o $(LIBS)
+	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $< $(LIBS) -ldl
+
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(AR) rcs $@ $(LIB_OBJS)
 
@@ -195,6 +198,7 @@ serialization.o: $(LIB_H)
 serialization-test.o: $(LIB_H)
 link.o: $(LIB_H)
 sold.o: $(LIB_H)
+where: $(LIB_H)
 
 pre-process.h:
 	$(QUIET_GEN)echo "#define GCC_INTERNAL_INCLUDE \"`$(CC) -print-file-name=`\"" > pre-process.h
diff --git a/where.c b/where.c
new file mode 100644
index 0000000..03241f9
--- /dev/null
+++ b/where.c
@@ -0,0 +1,61 @@
+
+#include <stdio.h>
+#include <dlfcn.h>
+#include <stdlib.h>
+#include <limits.h>
+
+#include "lib.h"
+#include "link.h"
+
+int main(int argc, char **argv)
+{
+	void *handle;
+	char *err;
+	struct sold_symbol *sym;
+	struct sold_symbol_list **symbols;
+	const char sym_type_tbl[] = {'F', 'D', 'O'};
+	char input[PATH_MAX];
+
+
+	if (argc < 2) {
+		fprintf(stderr, "usage: %s <sparse_object_file> [symbol_name]\n", argv[0]);
+		exit(1);
+	}
+
+	snprintf(input, PATH_MAX, "./%s", argv[1]);
+
+	dlerror();
+	handle = dlopen(input, RTLD_NOW);
+	if (!handle) {
+		fprintf(stderr, "%s: Can't open input file %s: %s\n",
+			argv[0], input, dlerror());
+		exit(1);
+	}
+
+	symbols = dlsym(handle, "symbols");
+	err = dlerror();
+	if (!symbols) {
+		if (err) {
+			fprintf(stderr, "%s: Can't process the input file %s: %s\n",
+				argv[0], input, err);
+			exit(1);
+		}
+		/* empty symbol list. */
+		exit(0);
+	}
+
+	if (argc > 2) {/* Look up the symbol */
+		FOR_EACH_PTR(*symbols, sym) {
+			if (!strcmp(argv[2], sym->name))
+				printf("%c %s %s\n", sym_type_tbl[sym->type],
+					sym->name, sym->source->source);
+		} END_FOR_EACH_PTR(sym);
+	} else {/* Just list all symbols */
+		FOR_EACH_PTR(*symbols, sym) {
+			printf("%c %s %s\n", sym_type_tbl[sym->type],
+				sym->name, sym->source->source);
+		} END_FOR_EACH_PTR(sym);
+	}
+
+	return 0;
+}
-- 
1.5.6.3

