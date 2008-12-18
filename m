From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 03/16] Set gcc include path at runtime.
Date: Fri, 19 Dec 2008 00:52:00 +0300
Message-ID: <20081218215200.28136.35503.stgit@zaytsev.su>
References: <20081218181935.28136.60256.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:8093 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154AbYLRVmx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 18 Dec 2008 16:42:53 -0500
Received: by ug-out-1314.google.com with SMTP id 39so508461ugf.37
        for <linux-sparse@vger.kernel.org>; Thu, 18 Dec 2008 13:42:51 -0800 (PST)
In-Reply-To: <20081218181935.28136.60256.stgit@zaytsev.su>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

You can now tell sparse where to look for the compiler
headers with -gcc-base-dir <dir>. Otherwise sparse will
look for headers used to build it.

Also adds $GCC_BASE/include-fixed used by newer gcc
versions.

Signed-off-by: Alexey zaytsev <alexey.zaytsev@gmail.com>
---
 Makefile      |    7 ++--
 lib.c         |   23 ++++++++++++--
 pre-process.c |   96 +++++++++++++++++++++++++++++++++++++++++++++------------
 3 files changed, 99 insertions(+), 27 deletions(-)

diff --git a/Makefile b/Makefile
index ca33218..18cec68 100644
--- a/Makefile
+++ b/Makefile
@@ -17,6 +17,8 @@ AR = ar
 HAVE_LIBXML=$(shell pkg-config --exists libxml-2.0 && echo 'yes')
 
 
+CFLAGS += -DGCC_BASE=\"$(shell $(CC) --print-file-name=)\"
+
 DESTDIR=
 PREFIX=$(HOME)
 BINDIR=$(PREFIX)/bin
@@ -147,7 +149,7 @@ lib.o: $(LIB_H)
 allocate.o: $(LIB_H)
 ptrlist.o: $(LIB_H)
 parse.o: $(LIB_H)
-pre-process.o: $(LIB_H) pre-process.h
+pre-process.o: $(LIB_H)
 scope.o: $(LIB_H)
 show-parse.o: $(LIB_H)
 symbol.o: $(LIB_H)
@@ -186,9 +188,6 @@ compat-solaris.o: compat/mmap-blob.c $(LIB_H)
 compat-mingw.o: $(LIB_H)
 compat-cygwin.o: $(LIB_H)
 
-pre-process.h:
-	$(QUIET_GEN)echo "#define GCC_INTERNAL_INCLUDE \"`$(CC) -print-file-name=include`\"" > pre-process.h
-
 .c.o:
 	$(QUIET_CC)$(CC) -o $@ -c $(CFLAGS) $<
 
diff --git a/lib.c b/lib.c
index 8dadfa9..45a4f39 100644
--- a/lib.c
+++ b/lib.c
@@ -41,6 +41,8 @@ int gcc_major = __GNUC__;
 int gcc_minor = __GNUC_MINOR__;
 int gcc_patchlevel = __GNUC_PATCHLEVEL__;
 
+static const char *gcc_base_dir = GCC_BASE;
+
 struct token *skip_to(struct token *token, int op)
 {
 	while (!match_op(token, op) && !eof_token(token))
@@ -591,6 +593,14 @@ static char **handle_dirafter(char *arg, char **next)
 	return next;
 }
 
+static char **handle_base_dir(char *arg, char **next)
+{
+	gcc_base_dir = *++next;
+	if (!gcc_base_dir)
+		die("missing argument for -gcc-base-dir option");
+	return next;
+}
+
 struct switches {
 	const char *name;
 	char **(*fn)(char *, char **);
@@ -601,6 +611,7 @@ static char **handle_switch(char *arg, char **next)
 	static struct switches cmd[] = {
 		{ "nostdinc", handle_nostdinc },
 		{ "dirafter", handle_dirafter },
+		{ "gcc-base-dir", handle_base_dir},
 		{ NULL, NULL }
 	};
 	struct switches *s;
@@ -644,8 +655,8 @@ void declare_builtin_functions(void)
 	/* Gaah. gcc knows tons of builtin <string.h> functions */
 	add_pre_buffer("extern void *__builtin_memcpy(void *, const void *, __SIZE_TYPE__);\n");
 	add_pre_buffer("extern void *__builtin_mempcpy(void *, const void *, __SIZE_TYPE__);\n");
-	add_pre_buffer("extern void *__builtin_memset(void *, int, __SIZE_TYPE__);\n");	
-	add_pre_buffer("extern int __builtin_memcmp(const void *, const void *, __SIZE_TYPE__);\n");	
+	add_pre_buffer("extern void *__builtin_memset(void *, int, __SIZE_TYPE__);\n");
+	add_pre_buffer("extern int __builtin_memcmp(const void *, const void *, __SIZE_TYPE__);\n");
 	add_pre_buffer("extern char *__builtin_strcat(char *, const char *);\n");
 	add_pre_buffer("extern char *__builtin_strncat(char *, const char *, __SIZE_TYPE__);\n");
 	add_pre_buffer("extern int __builtin_strcmp(const char *, const char *);\n");
@@ -698,6 +709,12 @@ void create_builtin_stream(void)
 	add_pre_buffer("#weak_define __GNUC__ %d\n", gcc_major);
 	add_pre_buffer("#weak_define __GNUC_MINOR__ %d\n", gcc_minor);
 	add_pre_buffer("#weak_define __GNUC_PATCHLEVEL__ %d\n", gcc_patchlevel);
+
+	/* We add compiler headers path here because we have to parse
+	 * the arguments to get it, falling back to default. */
+	add_pre_buffer("#add_system \"%s/include\"\n", gcc_base_dir);
+	add_pre_buffer("#add_system \"%s/include-fixed\"\n", gcc_base_dir);
+
 	add_pre_buffer("#define __extension__\n");
 	add_pre_buffer("#define __pragma__\n");
 
@@ -780,7 +797,7 @@ static struct symbol_list *sparse_tokenstream(struct token *token)
 		putchar('\n');
 
 		return NULL;
-	} 
+	}
 
 	// Parse the resulting C code
 	while (!eof_token(token))
diff --git a/pre-process.c b/pre-process.c
index ca1d8ef..9c6ef5b 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -20,7 +20,6 @@
 #include <limits.h>
 #include <time.h>
 
-#include "pre-process.h"
 #include "lib.h"
 #include "allocate.h"
 #include "parse.h"
@@ -36,13 +35,14 @@ const char *includepath[INCLUDEPATHS+1] = {
 	"",
 	"/usr/include",
 	"/usr/local/include",
-	GCC_INTERNAL_INCLUDE,
 	NULL
 };
 
 static const char **quote_includepath = includepath;
 static const char **angle_includepath = includepath + 1;
+static const char **isys_includepath   = includepath + 1;
 static const char **sys_includepath   = includepath + 1;
+static const char **dirafter_includepath = includepath + 3;
 
 #define dirty_stream(stream)				\
 	do {						\
@@ -653,8 +653,14 @@ static int already_tokenized(const char *path)
  *
  * Three set of include paths are known:
  * quote_includepath:	Path to search when using #include "file.h"
- * angle_includepath:	Path to search when using #include <file.h>
- * sys_includepath:	Built-in include paths
+ * angle_includepath:	Paths to search when using #include <file.h>
+ * isys_includepath:	Paths specified with -isystem, come before the
+ *			built-in system include paths. Gcc would suppress
+ *			warnings from system headers. Here we separate
+ *			them from the angle_ ones to keep search ordering.
+ *
+ * sys_includepath:	Built-in include paths.
+ * dirafter_includepath Paths added with -dirafter.
  *
  * The above is implemented as one array with pointers
  *                         +--------------+
@@ -664,21 +670,23 @@ static int already_tokenized(const char *path)
  *                         +--------------+
  * angle_includepath --->  |              |
  *                         +--------------+
+ * isys_includepath  --->  |              |
+ *                         +--------------+
  * sys_includepath   --->  |              |
  *                         +--------------+
- *                         |              |
+ * dirafter_includepath -> |              |
  *                         +--------------+
  *
- * -I dir insert dir just before sys_includepath and move the rest
+ * -I dir insert dir just before isys_includepath and move the rest
  * -I- makes all dirs specified with -I before to quote dirs only and
- *   angle_includepath is set equal to sys_includepath.
- * -nostdinc removes all sys dirs be storing NULL in entry pointed
- *   to by * sys_includepath. Note this will reset all dirs built-in and added
- *   before -nostdinc by -isystem and -dirafter
- * -isystem dir adds dir where sys_includepath points adding this dir as
+ *   angle_includepath is set equal to isys_includepath.
+ * -nostdinc removes all sys dirs by storing NULL in entry pointed
+ *   to by * sys_includepath. Note that this will reset all dirs built-in
+ *   and added before -nostdinc by -isystem and -dirafter.
+ * -isystem dir adds dir where isys_includepath points adding this dir as
  *   first systemdir
  * -dirafter dir adds dir to the end of the list
- **/
+ */
 
 static void set_stream_include_path(struct stream *stream)
 {
@@ -1449,7 +1457,41 @@ static int handle_nostdinc(struct stream *stream, struct token **line, struct to
 	return 1;
 }
 
-static void add_path_entry(struct token *token, const char *path, const char ***where, const char **new_path)
+static inline void update_inc_ptrs(const char ***where)
+{
+
+	if (*where <= dirafter_includepath) {
+		dirafter_includepath++;
+		/* If this was the entry that we prepend, don't
+		 * rise the lower entries, even if they are at
+		 * the same level. */
+		if (where == &dirafter_includepath)
+			return;
+	}
+	if (*where <= sys_includepath) {
+		sys_includepath++;
+		if (where == &sys_includepath)
+			return;
+	}
+	if (*where <= isys_includepath) {
+		isys_includepath++;
+		if (where == &isys_includepath)
+			return;
+	}
+
+	/* angle_includepath is actually never updated, since we
+	 * don't suppport -iquote rught now. May change some day. */
+	if (*where <= angle_includepath) {
+		angle_includepath++;
+		if (where == &angle_includepath)
+			return;
+	}
+}
+
+/* Add a path before 'where' and update the pointers associated with the
+ * includepath array */
+static void add_path_entry(struct token *token, const char *path,
+	const char ***where)
 {
 	const char **dst;
 	const char *next;
@@ -1467,20 +1509,19 @@ static void add_path_entry(struct token *token, const char *path, const char ***
 	}
 	next = path;
 	dst = *where;
-	*where = new_path;
+
+	update_inc_ptrs(where);
 
 	/*
 	 * Move them all up starting at dst,
 	 * insert the new entry..
 	 */
-	for (;;) {
+	do {
 		const char *tmp = *dst;
 		*dst = next;
-		if (!next)
-			break;
 		next = tmp;
 		dst++;
-	}
+	} while (next);
 }
 
 static int handle_add_include(struct stream *stream, struct token **line, struct token *token)
@@ -1493,7 +1534,7 @@ static int handle_add_include(struct stream *stream, struct token **line, struct
 			warning(token->pos, "expected path string");
 			return 1;
 		}
-		add_path_entry(token, token->string->data, &sys_includepath, sys_includepath + 1);
+		add_path_entry(token, token->string->data, &isys_includepath);
 	}
 }
 
@@ -1507,7 +1548,21 @@ static int handle_add_isystem(struct stream *stream, struct token **line, struct
 			sparse_error(token->pos, "expected path string");
 			return 1;
 		}
-		add_path_entry(token, token->string->data, &sys_includepath, sys_includepath);
+		add_path_entry(token, token->string->data, &sys_includepath);
+	}
+}
+
+static int handle_add_system(struct stream *stream, struct token **line, struct token *token)
+{
+	for (;;) {
+		token = token->next;
+		if (eof_token(token))
+			return 1;
+		if (token_type(token) != TOKEN_STRING) {
+			sparse_error(token->pos, "expected path string");
+			return 1;
+		}
+		add_path_entry(token, token->string->data, &dirafter_includepath);
 	}
 }
 
@@ -1625,6 +1680,7 @@ static void init_preprocessor(void)
 		{ "nostdinc",	   handle_nostdinc },
 		{ "add_include",   handle_add_include },
 		{ "add_isystem",   handle_add_isystem },
+		{ "add_system",    handle_add_system },
 		{ "add_dirafter",  handle_add_dirafter },
 		{ "split_include", handle_split_include },
 	}, special[] = {

