From: alexey.zaytsev@gmail.com
Subject: [PATCH 01/10] Serialization engine
Date: Thu,  4 Sep 2008 01:55:45 +0400
Message-ID: <20df58606337d58576ba3c10cf8f8c1522f81f91.1220475018.git.xl0@xl0.local>
References: <1220478954-22678-1-git-send-email-alexey.zaytsev@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:48383 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbYICVxt (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 3 Sep 2008 17:53:49 -0400
Received: by ug-out-1314.google.com with SMTP id c2so1952946ugf.37
        for <linux-sparse@vger.kernel.org>; Wed, 03 Sep 2008 14:53:47 -0700 (PDT)
In-Reply-To: <1220478954-22678-1-git-send-email-alexey.zaytsev@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@kernel.org>, Chris Li <christ.li@gmail.com>, Codrin Alexandru Grajdeanu <grcodal@gmail.com>, Alexey Zaytsev <alexey.zaytsev@gmail.com>

From: Alexey Zaytsev <alexey.zaytsev@gmail.com>

Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
---
 Makefile             |   11 ++-
 serialization-test.c |  120 +++++++++++++++++++++++++
 serialization-test.h |   32 +++++++
 serialization.c      |   99 +++++++++++++++++++++
 serialization.h      |  240 ++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 499 insertions(+), 3 deletions(-)
 create mode 100644 serialization-test.c
 create mode 100644 serialization-test.h
 create mode 100644 serialization.c
 create mode 100644 serialization.h

diff --git a/Makefile b/Makefile
index 077003c..721979e 100644
--- a/Makefile
+++ b/Makefile
@@ -27,7 +27,7 @@ INCLUDEDIR=$(PREFIX)/include
 PKGCONFIGDIR=$(LIBDIR)/pkgconfig
 
 PROGRAMS=test-lexing test-parsing obfuscate compile graph sparse test-linearize example \
-	 test-unssa test-dissect ctags
+	 test-unssa test-dissect ctags serialization-test
 
 
 INST_PROGRAMS=sparse cgcc
@@ -40,12 +40,13 @@ endif
 
 LIB_H=    token.h parse.h lib.h symbol.h scope.h expression.h target.h \
 	  linearize.h bitmap.h ident-list.h compat.h flow.h allocate.h \
-	  storage.h ptrlist.h dissect.h
+	  storage.h ptrlist.h dissect.h serialization.h
 
 LIB_OBJS= target.o parse.o tokenize.o pre-process.o symbol.o lib.o scope.o \
 	  expression.o show-parse.o evaluate.o expand.o inline.o linearize.o \
 	  sort.o allocate.o compat-$(OS).o ptrlist.o \
-	  flow.o cse.o simplify.o memops.o liveness.o storage.o unssa.o dissect.o
+	  flow.o cse.o simplify.o memops.o liveness.o storage.o unssa.o dissect.o \
+	  serialization.o
 
 LIB_FILE= libsparse.a
 SLIB_FILE= libsparse.so
@@ -135,6 +136,9 @@ ctags: ctags.o $(LIBS)
 c2xml: c2xml.o $(LIBS)
 	$(QUIET_LINK)$(CC) $(LDFLAGS)  -o $@ $< $(LIBS) `pkg-config --libs libxml-2.0`
 
+serialization-test: serialization-test.o $(LIBS)
+	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
+
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(AR) rcs $@ $(LIB_OBJS)
 
@@ -185,6 +189,7 @@ compat-linux.o: compat/strtold.c compat/mmap-blob.c \
 compat-solaris.o: compat/mmap-blob.c $(LIB_H)
 compat-mingw.o: $(LIB_H)
 compat-cygwin.o: $(LIB_H)
+serialization-test.o: $(LIB_H)
 
 pre-process.h:
 	$(QUIET_GEN)echo "#define GCC_INTERNAL_INCLUDE \"`$(CC) -print-file-name=`\"" > pre-process.h
diff --git a/serialization-test.c b/serialization-test.c
new file mode 100644
index 0000000..f9bb3d4
--- /dev/null
+++ b/serialization-test.c
@@ -0,0 +1,120 @@
+/*
+ * Copyright (C) 2008 Alexey Zaytsev
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Alternatively, this program may be distributed under the
+ * Open Software License version 1.1.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <assert.h>
+#include <string.h>
+
+
+#include "serialization-test.h"
+
+static struct a *__alloc_a_core(int n)
+{
+	return malloc(sizeof(struct a) + n);
+}
+
+static struct b *__alloc_b_core(int n)
+{
+	return malloc(sizeof(struct b) + n);
+}
+
+
+void __free_a_core(struct a *t)
+{
+
+}
+
+void __free_b_core(struct b *t)
+{
+
+}
+
+int dump_a(struct serialization_stream *s, struct a *w)
+{
+	emit_int(s, w, d);
+	emit_ptr(s, w, b, b_ptr);
+
+	return 0;
+}
+
+int dump_b(struct serialization_stream *s, struct b *w)
+{
+	emit_int(s, w, k);
+	emit_ptr(s, w, a, a_ptr);
+
+	return 0;
+}
+
+WRAP(a, "serialization-test.h", dump_a);
+WRAP(b, "serialization-test.h", dump_b);
+
+int main(int argc, char **argv)
+{
+	struct serialization_stream *s;
+
+	struct a *a1 = __alloc_a(0);
+	struct a *a2 = __alloc_a(0);
+	struct a *a3 = __alloc_a(0);
+	struct a *a4 = __alloc_a(0);
+
+	struct b *b1 = __alloc_b(0);
+	struct b *b2 = __alloc_b(0);
+	struct b *b3 = __alloc_b(0);
+	struct b *b4 = __alloc_b(0);
+	struct b *b5 = __alloc_b(0);
+
+	a1->d = 1;
+	a2->d = 2;
+	a3->d = 3;
+	a4->d = 4;
+
+	a1->b_ptr = b1;
+	a2->b_ptr = b2;
+	a3->b_ptr = b3;
+	a4->b_ptr = b4;
+
+
+	b1->k = 11;
+	b2->k = 12;
+	b3->k = 13;
+	b4->k = 14;
+	b5->k = 15;
+
+	b1->a_ptr = a2;
+	b2->a_ptr = a3;
+	b3->a_ptr = a1;
+	b4->a_ptr = a2;
+	b5->a_ptr = a1;
+
+	s = new_serialization_stream("test");
+	if (!s) {
+		perror("Failed to open serialization stream");
+		exit(1);
+	}
+
+	printf("Dumping:\n");
+
+	printf("a1 = %p\n", a1);
+	serialize_a(s, a1, "a1_entry");
+	/* Note that we serializaed only one object, a1.
+	 * All the other objects appering in the generated file
+	 * were serializaed as it's dependencies. If you try to
+	 * serialize any of them again, only the global pointer
+	 * will be added. */
+
+	fini_serialization_stream(s);
+
+	return 0;
+
+}
+
diff --git a/serialization-test.h b/serialization-test.h
new file mode 100644
index 0000000..a1980e7
--- /dev/null
+++ b/serialization-test.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright (C) 2008 Alexey Zaytsev
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Alternatively, this program may be distributed under the
+ * Open Software License version 1.1.
+ */
+
+#ifndef SERIALIZATION_TEST_H
+#define SERIALIZATION_TEST_H
+
+#include "serialization.h"
+
+struct a {
+	int d;
+	struct b *b_ptr;
+};
+
+struct b {
+	int k;
+	char c;
+	struct a *a_ptr;
+};
+
+DECLARE_WRAPPER(a);
+DECLARE_WRAPPER(b);
+
+#endif
diff --git a/serialization.c b/serialization.c
new file mode 100644
index 0000000..79d4fda
--- /dev/null
+++ b/serialization.c
@@ -0,0 +1,99 @@
+/*
+ * Copyright (C) 2008 Alexey Zaytsev
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Alternatively, this program may be distributed under the
+ * Open Software License version 1.1.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <limits.h>
+#include <libgen.h>
+#include "serialization.h"
+
+
+int serialization_stream_enqueue(struct serialization_stream *s, void *unit,
+	int (*serializer) (struct serialization_stream *s, void *unit))
+{
+	struct serialization_sched_work *w;
+
+	w = malloc(sizeof(w[0]));
+	if (!w)
+		return -ENOMEM;
+
+	w->stream = s;
+	w->unit = unit;
+	w->serializer = serializer;
+	w->next = s->queue;
+	s->queue = w;
+
+	return 0;
+}
+
+int process_serialization_queue(struct serialization_stream *s)
+{
+	int ret = 0;
+	struct serialization_sched_work *w;
+
+	while (s->queue) {
+		w = s->queue;
+		s->queue = s->queue->next;
+		ret = w->serializer(s, w->unit);
+		free(w);
+	}
+	return ret;
+}
+
+struct serialization_stream *new_serialization_stream(const char *file)
+{
+	struct serialization_stream *s;
+	char tmp[PATH_MAX+1];
+
+	s = malloc(sizeof(s[0]));
+	s->queue = NULL;
+
+	strncpy(tmp, file, PATH_MAX);
+	s->definition_f = fopen(strncat(tmp, ".sparse.c", PATH_MAX), "w+");
+	if (!s->definition_f)
+		goto out_definitions;
+
+	strncpy(tmp, file, PATH_MAX);
+	s->declaration_f = fopen(strncat(tmp, ".sparse_declarations.c", PATH_MAX), "w+");
+	if (!s->declaration_f)
+		goto out_declarations;
+
+	fprintf(s->definition_f, "#include \"%s\"\n\n", basename(tmp));
+	fprintf(s->definition_f, "#define NULL ((void *)0)\n");
+
+	return s;
+
+out_declarations:
+	fclose(s->definition_f);
+out_definitions:
+	free(s);
+
+	return NULL;
+}
+
+void fini_serialization_stream(struct serialization_stream *s)
+{
+
+	/* Just in case something was left over */
+	process_serialization_queue(s);
+
+	fprintf(s->declaration_f, "\n");
+	fprintf(s->definition_f, "\n");
+
+	fclose(s->definition_f);
+	fclose(s->declaration_f);
+
+	free(s);
+}
+
diff --git a/serialization.h b/serialization.h
new file mode 100644
index 0000000..7805f50
--- /dev/null
+++ b/serialization.h
@@ -0,0 +1,240 @@
+/*
+ * Copyright (C) 2008 Alexey Zaytsev
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Alternatively, this program may be distributed under the
+ * Open Software License version 1.1.
+ */
+
+#ifndef SERIALIZATION_H
+#define SERIALIZATION_H
+
+#include <stdio.h>
+#include <stddef.h>
+#include <ctype.h>
+
+#define wrapper_overhead(w) (sizeof(w[0]) - sizeof(w->payload))
+#define container(ptr, type, member) \
+	(type *)((void *)(ptr) - offsetof(type, member))
+
+/*
+ * This structure is prepended to every object of serializable
+ * type. Do not bloat.
+ */
+struct serialization_mdata {
+	unsigned int index:30;
+	unsigned int declared:1;
+	unsigned int defined:1;
+};
+
+struct serialization_stream {
+	FILE *declaration_f;
+	FILE *definition_f;
+	struct serialization_sched_work *queue;
+};
+struct serialization_sched_work {
+	struct serialization_stream *stream;
+	void *unit;
+	int (*serializer) (struct serialization_stream *s,
+		void *unit);
+	struct serialization_sched_work *next;
+};
+
+
+int serialization_stream_enqueue(struct serialization_stream *s, void *unit,
+	int (serializaer) (struct serialization_stream *s, void *unit));
+int process_serialization_queue(struct serialization_stream *s);
+struct serialization_stream *new_serialization_stream(const char *file);
+void fini_serialization_stream(struct serialization_stream *s);
+
+
+#define DO_WRAP(type, type_name, type_header, allocator, allocator_name,	\
+		deallocator, deallocator_name, serializer)			\
+	static int type_name##_index = 0;					\
+	type *allocator_name(int n)						\
+	{									\
+		struct type_name##_wrapper *w;					\
+		w = (struct type_name##_wrapper *)				\
+			allocator(n + wrapper_overhead(w)); 			\
+		if (!w)								\
+			return NULL;						\
+		return &w->payload;						\
+	}									\
+	void deallocator_name(type *t)						\
+	{									\
+		struct type_name##_wrapper *w;					\
+		w = container(t, struct type_name##_wrapper, payload);		\
+		deallocator((type *)w);						\
+	}									\
+	static int do_serialize_##type_name(struct serialization_stream *s,	\
+		void *unit)							\
+	{									\
+		struct type_name##_wrapper *w = unit;				\
+		int ret;							\
+		fprintf(s->definition_f, "static struct " #type_name "_wrapper "\
+			"__" #type_name "_%d = {\n\t.payload = {\n",		\
+			w->meta.index);						\
+		ret = serializer(s, &w->payload);				\
+		fprintf(s->definition_f, "\t},\n};\n");				\
+		if (ret)							\
+			fprintf(stderr, "Warning: Failed to serialize a " #type	\
+			": %d\n", ret);						\
+		return ret;							\
+	}									\
+	int schedule_##type_name##_serialization(struct serialization_stream *s,\
+		type *t)							\
+	{									\
+		struct type_name##_wrapper *w;					\
+		if (!t)								\
+			return 0; /* Tried to serialize a NULL pointer */	\
+		w = container(t, struct type_name##_wrapper, payload);		\
+		if (w->meta.declared)						\
+			return 0;	/* Either already serialized or waiting	\
+					 * in the queue */			\
+		if (!type_name##_index)						\
+			fprintf(s->declaration_f,				\
+				"\n#include %s\n", #type_header);		\
+										\
+		w->meta.index = type_name##_index++;				\
+		fprintf(s->declaration_f,					\
+			"static struct " #type_name "_wrapper "			\
+			"__" #type_name "_%d;\n",				\
+			w->meta.index);						\
+		w->meta.declared = 1;						\
+		return serialization_stream_enqueue(s, w,			\
+			do_serialize_##type_name);				\
+	}									\
+	int serialize_##type_name(struct serialization_stream *s,		\
+		type *t, const char *name)					\
+	{									\
+		int ret;							\
+		schedule_##type_name##_serialization(s, t);			\
+		ret = process_serialization_queue(s);				\
+		if (!ret && name)						\
+			ret = label_##type_name##_entry(s, t, name);		\
+		return ret; 							\
+	}									\
+	int label_##type_name##_entry(struct serialization_stream *s, type *t,	\
+		const char *name)						\
+	{									\
+		struct type_name##_wrapper *w;					\
+		if (!t) { 							\
+			fprintf(s->definition_f, #type " *%s = NULL;", name);	\
+			return 0;						\
+		}								\
+		w = container(t, struct type_name##_wrapper, payload);		\
+		if (!w->meta.declared) {					\
+			fprintf(stderr, "Warning: Trying to label an undefined"	\
+				" '" #type "'\n");				\
+			return -1;						\
+		}								\
+		fprintf(s->definition_f, #type " *%s = &"			\
+			"__" #type_name "_%d.payload;\n", name, w->meta.index);	\
+		return 0;							\
+	}
+
+
+#define WRAP(type_name, type_header, serializer)				\
+	DO_WRAP(struct type_name, type_name, type_header,			\
+		__alloc_##type_name##_core, __alloc_##type_name,		\
+		__free_##type_name##_core, __free_##type_name, serializer)
+
+#define emit_int(struam, parent, field)						\
+	do {									\
+		int __i = parent->field;					\
+		fprintf(s->definition_f, "\t\t." #field " = %d,\n", __i);	\
+	} while (0)
+
+#define emit_cstring(stream, parent, field)					\
+	do {									\
+		char *__tmp = parent->field;					\
+		if (!__tmp) {							\
+			fprintf(stream->definition_f,				\
+				"\t\t." #field " = NULL,\n");			\
+			break;							\
+		}								\
+		fprintf(stream->definition_f, "\t\t." #field " = \"");		\
+		while (*__tmp) {						\
+			if (isprint(*__tmp))	 				\
+				fputc(*__tmp, stream->definition_f);		\
+			else							\
+				fprintf(stream->definition_f, "\\x%2x",		\
+					*__tmp);				\
+			__tmp++;						\
+		}								\
+		fprintf(stream->definition_f, "\",\n");				\
+	} while (0);
+
+#define do_emit_ptr(stream, parent, type, type_name, field) 			\
+	do {									\
+		struct type_name##_wrapper *__w;				\
+		void *__ptr = parent->field;					\
+		if (!__ptr) {							\
+			fprintf(stream->definition_f,				\
+				"\t\t." #field " = NULL,\n");			\
+			break;							\
+		}								\
+		schedule_##type_name##_serialization(stream, __ptr);		\
+		__w = container(__ptr, struct type_name##_wrapper, payload);	\
+		fprintf(stream->definition_f, "\t\t." #field " = &"		\
+			"__" #type_name	"_%d.payload,\n", __w->meta.index);	\
+	} while (0)
+
+#define emit_ptr(stream, parent, type_name, field)				\
+	do_emit_ptr(stream, parent, struct type_name, type_name,		\
+		field)
+
+#define emit_ptr_array(stream, parent, type, type_name, field, nr)		\
+	do {									\
+		struct type_name##_wrapper *__w;				\
+		void *__ptr = parent->field;					\
+		int __i ;							\
+		fprintf(stream->definition_f, "\t\t." #field " = {\n");		\
+		for (__i = 0; __i < nr; __i++) {				\
+			__ptr = parent->field[__i];				\
+			if (__ptr) {						\
+				__w = container(__ptr,				\
+					struct type_name##_wrapper, payload);	\
+				schedule_##type_name##_serialization(s, __ptr);	\
+				fprintf(stream->definition_f,			\
+					"\t\t\t&" "__" #type_name		\
+					"_%d.payload,\n", __w->meta.index);	\
+			}							\
+		}								\
+		fprintf(stream->definition_f, "\t\t},\n");			\
+	} while (0)
+
+#define DO_DECLARE_WRAPPER(type, type_name, allocator_name, deallocator_name)	\
+	struct type_name##_wrapper {						\
+		struct serialization_mdata meta;				\
+		type payload;							\
+	};									\
+	type *allocator_name(int x);						\
+	void deallocator_name(type *t);						\
+	int schedule_##type_name##_serialization(struct serialization_stream *s,\
+		type *ptr);							\
+	int serialize_##type_name(struct serialization_stream *s,		\
+		type *t, const char *name);					\
+	int emit_##type_name##_ptr(struct serialization_stream *s,		\
+	 	type *t);							\
+	int label_##type_name##_entry(struct serialization_stream *s,		\
+		type *t, const char *name);
+
+#define DECLARE_WRAPPER(type_name)						\
+		DO_DECLARE_WRAPPER(struct type_name, type_name,			\
+			__alloc_##type_name, __free_##type_name)
+
+/* If you need to serialize statically-allocated data, use these. */
+#define DO_DECLARE_SERIALIZABLE(type, type_name, name)				\
+	struct type_name##_wrapper __##name_wrapped;				\
+	type *name = &__##wrapped.payload;
+
+#define DECLARE_SERIALIZABLE(type, name)					\
+	DO_DECLARE_SERIALIZABLE(struct type, type, name)
+
+#endif
+
-- 
1.5.6.3

