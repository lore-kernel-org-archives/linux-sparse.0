From: alexey.zaytsev@gmail.com
Subject: [PATCH 07/10] Let sparse serialize the symbol table of the checked file
Date: Thu,  4 Sep 2008 01:55:51 +0400
Message-ID: <eb541a9449e5ec380212c85093d3ef206db1db4d.1220475018.git.xl0@xl0.local>
References: <1220478954-22678-1-git-send-email-alexey.zaytsev@gmail.com>
 <20df58606337d58576ba3c10cf8f8c1522f81f91.1220475018.git.xl0@xl0.local>
 <6f37eec18608be0a86356a874836bea516317084.1220475018.git.xl0@xl0.local>
 <2faea660ccc7cae55a2d2cd28f64059b80356a8f.1220475018.git.xl0@xl0.local>
 <c97fb6bb13fb17d09a2d1525cb5b813ecebb804d.1220475018.git.xl0@xl0.local>
 <b0118cf8f9301f77a141af47739aa599ae1e624b.1220475018.git.xl0@xl0.local>
 <ad58a8f48bbd496a896ef370772e8a12101560f5.1220475018.git.xl0@xl0.local>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:41113 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770AbYICVyB (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 3 Sep 2008 17:54:01 -0400
Received: by ug-out-1314.google.com with SMTP id c2so1952952ugf.37
        for <linux-sparse@vger.kernel.org>; Wed, 03 Sep 2008 14:54:00 -0700 (PDT)
In-Reply-To: <ad58a8f48bbd496a896ef370772e8a12101560f5.1220475018.git.xl0@xl0.local>
In-Reply-To: <20df58606337d58576ba3c10cf8f8c1522f81f91.1220475018.git.xl0@xl0.local>
References: <20df58606337d58576ba3c10cf8f8c1522f81f91.1220475018.git.xl0@xl0.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@kernel.org>, Chris Li <christ.li@gmail.com>, Codrin Alexandru Grajdeanu <grcodal@gmail.com>, Alexey Zaytsev <alexey.zaytsev@gmail.com>

From: Alexey Zaytsev <alexey.zaytsev@gmail.com>

Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
---
 sparse.c |  105 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 102 insertions(+), 3 deletions(-)

diff --git a/sparse.c b/sparse.c
index b7a1f8b..1b25d7e 100644
--- a/sparse.c
+++ b/sparse.c
@@ -8,6 +8,8 @@
  *
  *  Licensed under the Open Software License version 1.1
  */
+#define _GNU_SOURCE
+
 #include <stdarg.h>
 #include <stdlib.h>
 #include <stdio.h>
@@ -17,6 +19,7 @@
 #include <fcntl.h>
 
 #include "lib.h"
+#include "link.h"
 #include "allocate.h"
 #include "token.h"
 #include "parse.h"
@@ -595,18 +598,114 @@ static void check_symbols(struct symbol_list *list)
 	} END_FOR_EACH_PTR(sym);
 }
 
+/* Yeah, that's how cc1 seems to handle this */
+static char *out_name(const char *file)
+{
+	char *lastdot;
+	char *out_file;
+
+	out_file = strdup(file);
+	lastdot = rindex(out_file, '.');
+
+	if (lastdot && *lastdot+1 == '\0') { /* file.c. */
+		*lastdot = '\0';
+		lastdot = rindex(out_file, '.');
+	}
+	if (!lastdot) /* file */
+		return out_file;
+
+	*lastdot = '\0'; /* Remove everything after the last dot */
+	strcat(out_file, ".o");
+
+	return out_file;
+}
+
+static void accumulate_symbols(struct symbol_list *list, const char *file,
+	char *buildroot, char *cflags, struct sold_symbol_list **sold_list)
+{
+	struct sold_srcfile *src;
+	struct symbol *sym;
+
+	src = __alloc_sold_srcfile(0);
+	src->buildroot = buildroot;
+	src->cflags = cflags;
+	src->source = (char *) file;
+
+	FOR_EACH_PTR(list, sym) {
+		add_sold_sym_list(sold_list, sym, src);
+	} END_FOR_EACH_PTR(sym);
+}
+
+static char *concat_args(int argc, char **argv)
+{
+	int i;
+	int len = 0;
+	char *args;
+	char *pos;
+
+	for (i = 1; i < argc; i++)
+		len += strlen(argv[i]) + 1;
+
+	args = malloc(len + 1);
+	pos = args;
+	for (i = 1; i < argc; i++) {
+		len = strlen(argv[i]);
+		memcpy(pos, argv[i], len);
+		pos += (len);
+		*(pos++) = ' ';
+	}
+	*(pos++) = '\0';
+
+	return args;
+}
+
+
 int main(int argc, char **argv)
 {
 	struct string_list *filelist = NULL;
+	struct sold_symbol_list *sold_symbols = NULL;
+	struct symbol_list *symbols;
+	struct serialization_stream *s;
 	char *file;
+	char *args = concat_args(argc, argv);
+	char *buildroot = get_current_dir_name();
 
 	// Expand, linearize and show it.
 	check_symbols(sparse_initialize(argc, argv, &filelist));
-	if (ptr_list_empty(filelist))
-		check_symbols(sparse("-"));
+	file = first_string(filelist);
+	if (!file || !strcmp(file, "-")) {
+		symbols = sparse("-");
+		check_symbols(symbols);
+		if (emit_code)
+			accumulate_symbols(symbols, "stdin", buildroot,
+				args, &sold_symbols);
+		/* cc1 too doesn't handle "file.c -" well.*/
+	}
+
+	if (!output_file) {
+		if (file && strcmp(file, "-"))
+			output_file = out_name(file);
+		else
+			output_file = "sparsedump";
+	}
 
 	FOR_EACH_PTR_NOTAG(filelist, file) {
-		check_symbols(sparse(file));
+		symbols = sparse(file);
+		check_symbols(symbols);
+		if (emit_code)
+			accumulate_symbols(symbols, file, buildroot,
+				args, &sold_symbols);
 	} END_FOR_EACH_PTR_NOTAG(file);
+
+	if (emit_code) {
+		s = new_serialization_stream(output_file);
+		if (!s) {
+			perror("Failed to open the serialization stream");
+			exit(1);
+		}
+		serialize_sold_symbol_list(s, (struct ptr_list *) sold_symbols, "symbols");
+		fini_serialization_stream(s);
+	}
+
 	return 0;
 }
-- 
1.5.6.3

