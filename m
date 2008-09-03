From: alexey.zaytsev@gmail.com
Subject: [PATCH 06/10] Linker core, serialization and helper functions.
Date: Thu,  4 Sep 2008 01:55:50 +0400
Message-ID: <ad58a8f48bbd496a896ef370772e8a12101560f5.1220475018.git.xl0@xl0.local>
References: <1220478954-22678-1-git-send-email-alexey.zaytsev@gmail.com>
 <20df58606337d58576ba3c10cf8f8c1522f81f91.1220475018.git.xl0@xl0.local>
 <6f37eec18608be0a86356a874836bea516317084.1220475018.git.xl0@xl0.local>
 <2faea660ccc7cae55a2d2cd28f64059b80356a8f.1220475018.git.xl0@xl0.local>
 <c97fb6bb13fb17d09a2d1525cb5b813ecebb804d.1220475018.git.xl0@xl0.local>
 <b0118cf8f9301f77a141af47739aa599ae1e624b.1220475018.git.xl0@xl0.local>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:30220 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770AbYICVyA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 3 Sep 2008 17:54:00 -0400
Received: by mu-out-0910.google.com with SMTP id g7so2911410muf.1
        for <linux-sparse@vger.kernel.org>; Wed, 03 Sep 2008 14:53:58 -0700 (PDT)
In-Reply-To: <b0118cf8f9301f77a141af47739aa599ae1e624b.1220475018.git.xl0@xl0.local>
In-Reply-To: <20df58606337d58576ba3c10cf8f8c1522f81f91.1220475018.git.xl0@xl0.local>
References: <20df58606337d58576ba3c10cf8f8c1522f81f91.1220475018.git.xl0@xl0.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@kernel.org>, Chris Li <christ.li@gmail.com>, Codrin Alexandru Grajdeanu <grcodal@gmail.com>, Alexey Zaytsev <alexey.zaytsev@gmail.com>

From: Alexey Zaytsev <alexey.zaytsev@gmail.com>

Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
---
 Makefile |    6 +++-
 link.c   |   57 ++++++++++++++++++++++++++++++++++++++++
 link.h   |   87 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 148 insertions(+), 2 deletions(-)
 create mode 100644 link.c
 create mode 100644 link.h

diff --git a/Makefile b/Makefile
index 721979e..dd1fe8a 100644
--- a/Makefile
+++ b/Makefile
@@ -40,13 +40,13 @@ endif
 
 LIB_H=    token.h parse.h lib.h symbol.h scope.h expression.h target.h \
 	  linearize.h bitmap.h ident-list.h compat.h flow.h allocate.h \
-	  storage.h ptrlist.h dissect.h serialization.h
+	  storage.h ptrlist.h dissect.h serialization.h link.h
 
 LIB_OBJS= target.o parse.o tokenize.o pre-process.o symbol.o lib.o scope.o \
 	  expression.o show-parse.o evaluate.o expand.o inline.o linearize.o \
 	  sort.o allocate.o compat-$(OS).o ptrlist.o \
 	  flow.o cse.o simplify.o memops.o liveness.o storage.o unssa.o dissect.o \
-	  serialization.o
+	  serialization.o link.o
 
 LIB_FILE= libsparse.a
 SLIB_FILE= libsparse.so
@@ -189,7 +189,9 @@ compat-linux.o: compat/strtold.c compat/mmap-blob.c \
 compat-solaris.o: compat/mmap-blob.c $(LIB_H)
 compat-mingw.o: $(LIB_H)
 compat-cygwin.o: $(LIB_H)
+serialization.o: $(LIB_H)
 serialization-test.o: $(LIB_H)
+link.o: $(LIB_H)
 
 pre-process.h:
 	$(QUIET_GEN)echo "#define GCC_INTERNAL_INCLUDE \"`$(CC) -print-file-name=`\"" > pre-process.h
diff --git a/link.c b/link.c
new file mode 100644
index 0000000..8d2eadf
--- /dev/null
+++ b/link.c
@@ -0,0 +1,57 @@
+
+#define _GNU_SOURCE
+#include <string.h>
+
+#include "lib.h"
+#include "link.h"
+
+__ALLOCATOR(struct sold_srcfile, "sold_srcfile", sold_srcfile_core);
+__ALLOCATOR(struct sold_symbol, "sold_smbol", sold_symbol_core);
+
+int sold_srcfile_serialize(struct serialization_stream *s,
+	struct sold_srcfile *w);
+
+int sold_symbol_serialize(struct serialization_stream *s,
+	struct sold_symbol *w);
+
+int sold_symbol_list_serialize(struct serialization_stream *s,
+	struct ptr_list *w);
+
+WRAP(sold_srcfile, <sparse/link.h>, sold_srcfile_serialize);
+WRAP(sold_symbol, <sparse/link.h>, sold_symbol_serialize);
+DO_WRAP(struct ptr_list, sold_symbol_list, <sparse/link.h>,
+	fail_ptrlist_allocation, __alloc_sold_symbol_list,
+	fail_ptrlist_free, __free_sold_symbol_list,
+	sold_symbol_list_serialize);
+
+int sold_srcfile_serialize(struct serialization_stream *s,
+	struct sold_srcfile *w)
+{
+	emit_cstring(s, w, source);
+	emit_cstring(s, w, buildroot);
+	emit_cstring(s, w, cflags);
+
+	return 0;
+}
+
+int sold_symbol_serialize(struct serialization_stream *s,
+	struct sold_symbol *w)
+{
+	emit_cstring(s, w, name);
+	emit_ptr(s, w, sold_srcfile, source);
+	emit_int(s, w, type);
+
+	return 0;
+}
+
+int sold_symbol_list_serialize(struct serialization_stream *s,
+	struct ptr_list *w)
+{
+	emit_int(s, w, nr);
+	emit_ptr(s, w, sold_symbol_list, prev);
+	emit_ptr(s, w, sold_symbol_list, next);
+	emit_ptr_array(s, w, struct sold_symbol, sold_symbol, list, w->nr);
+	return 0;
+}
+
+
diff --git a/link.h b/link.h
new file mode 100644
index 0000000..eed83ff
--- /dev/null
+++ b/link.h
@@ -0,0 +1,87 @@
+
+#ifndef LINK_H
+#define LINK_H
+
+#include <string.h>
+#include <errno.h>
+
+
+#include "ptrlist.h"
+#include "allocate.h"
+#include "symbol.h"
+#include "serialization.h"
+
+
+struct sold_srcfile {
+	char *source;
+	char *buildroot;
+	char *cflags;
+};
+
+enum sold_sym_type {
+	SOLD_SYM_FUNCTION,
+	SOLD_SYM_DATA,
+	SOLD_SYM_OTHER,
+};
+
+struct sold_symbol {
+	struct sold_srcfile *source;
+	enum sold_sym_type type;
+	char *name;
+};
+
+
+__DECLARE_ALLOCATOR(struct sold_srcfile, sold_srcfile_core);
+__DECLARE_ALLOCATOR(struct sold_symbol, sold_symbol_core);
+
+DECLARE_PTR_LIST(sold_symbol_list, struct sold_symbol);
+
+DO_DECLARE_WRAPPER(struct sold_srcfile, sold_srcfile,
+	__alloc_sold_srcfile, __free_sold_srcfile);
+DO_DECLARE_WRAPPER(struct sold_symbol, sold_symbol,
+	__alloc_sold_symbol, __free_sold_symbol);
+DO_DECLARE_WRAPPER(struct ptr_list, sold_symbol_list,
+	__alloc_sold_symbol_list, __free_sold_symbol_list);
+
+static inline void do_add_sold_sym_list(struct sold_symbol_list **list,
+	struct sold_symbol *sym)
+{
+	add_ptr_list(list, sym);
+}
+
+static inline int add_sold_sym_list(struct sold_symbol_list **list,
+	struct symbol *sym, struct sold_srcfile *file)
+{
+	struct sold_symbol *sold_sym;
+
+	if (!sym->ident)
+		error_die(sym->pos, "Trying to serialize non-bound symbol");
+
+	sold_sym = __alloc_sold_symbol(0);
+	if (!sold_sym)
+		return -ENOMEM;
+
+	sold_sym->name = sym->ident->name;
+	sold_sym->source = file;
+	sold_sym->type = SOLD_SYM_OTHER;
+	if (sym->type == SYM_NODE) {
+		if (sym->ctype.base_type->type == SYM_FN)
+			sold_sym->type = SOLD_SYM_FUNCTION;
+		else
+			sold_sym->type = SOLD_SYM_DATA;
+	}
+
+	do_add_sold_sym_list(list, sold_sym);
+
+	return 0;
+}
+
+static inline void concat_sold_sym_list(struct sold_symbol_list *from,
+	struct sold_symbol_list **to)
+{
+	concat_ptr_list((struct ptr_list *)from, (struct ptr_list **)to);
+}
+
+#endif
+
+
-- 
1.5.6.3

