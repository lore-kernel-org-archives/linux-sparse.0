From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 5/5] Add a --version option to sparse
Date: Sat, 18 Jul 2009 22:06:37 +0100
Message-ID: <4A62395D.9000207@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:41502 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751914AbZGRVKJ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 18 Jul 2009 17:10:09 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


In addition to a minimal --version implementation, using
the output of 'git describe', we also output the version
string when -v(erbose) output has been requested.

Also, when cgcc internally sets the $gcc_base_dir, the
compiler invocation is changed to use an explicit gcc
command, rather than $cc. (when --version is part of
$cc, this breaks badly).

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Chris,

This patch actually adds a feature :-)

This is a minimal implementation and doesn't address the issue
of a sparse library version number; should the library define
some version macros like __SPARSE_MAJOR, __SPARSE_MINOR, etc.?
Dunno.

ATB,
Ramsay Jones

 Makefile |    9 +++++++++
 cgcc     |    5 ++++-
 lib.c    |   14 ++++++++++++++
 lib.h    |    1 +
 sparse.c |    8 +++++++-
 5 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 70ccbc9..2dcbc5a 100644
--- a/Makefile
+++ b/Makefile
@@ -19,6 +19,7 @@ HAVE_LIBXML=$(shell pkg-config --exists libxml-2.0 2>/dev/null && echo 'yes')
 HAVE_GCC_DEP=$(shell touch .gcc-test.c && 				\
 		$(CC) -c -Wp,-MD,.gcc-test.d .gcc-test.c 2>/dev/null && \
 		echo 'yes'; rm -f .gcc-test.d .gcc-test.o .gcc-test.c)
+IN_GIT_REPO=$(shell test -d .git && git describe >/dev/null 2>&1 && echo 'yes')
 
 CFLAGS += -DGCC_BASE=\"$(shell $(CC) --print-file-name=)\"
 
@@ -26,6 +27,14 @@ ifeq ($(HAVE_GCC_DEP),yes)
 CFLAGS += -Wp,-MD,$(@D)/.$(@F).d
 endif
 
+BUILD_VERSION=$(VERSION)
+
+ifeq ($(IN_GIT_REPO),yes)
+BUILD_VERSION=$(shell git describe)
+endif
+
+CFLAGS += -DVERSION='"$(BUILD_VERSION)"'
+
 DESTDIR=
 PREFIX=$(HOME)
 BINDIR=$(PREFIX)/bin
diff --git a/cgcc b/cgcc
index fdda6d1..a12d4b1 100755
--- a/cgcc
+++ b/cgcc
@@ -23,6 +23,9 @@ while (@ARGV) {
     # Ditto for stdin.
     $do_check = 1 if $_ eq '-';
 
+    # Check for --version
+    $do_check = 1 if $_ eq '--version';
+
     $m32 = 1 if /^-m32$/;
     $m64 = 1 if /^-m64$/;
     $gendeps = 1 if /^-M$/;
@@ -65,7 +68,7 @@ if ($do_check) {
 	$check .= &add_specs ('host_os_specs');
     }
 
-    $gcc_base_dir = qx($cc -print-file-name=) if !$gcc_base_dir;
+    $gcc_base_dir = qx(gcc -print-file-name=) if !$gcc_base_dir;
     $check .= " -gcc-base-dir " . $gcc_base_dir if $gcc_base_dir;
 
     print "$check\n" if $verbose;
diff --git a/lib.c b/lib.c
index 42affcd..9390c7f 100644
--- a/lib.c
+++ b/lib.c
@@ -43,6 +43,13 @@ int gcc_patchlevel = __GNUC_PATCHLEVEL__;
 
 static const char *gcc_base_dir = GCC_BASE;
 
+static const char *sparse_version_string = VERSION;
+
+const char *sparse_version(void)
+{
+	return sparse_version_string;
+}
+
 struct token *skip_to(struct token *token, int op)
 {
 	while (!match_op(token, op) && !eof_token(token))
@@ -619,6 +626,12 @@ static char **handle_base_dir(char *arg, char **next)
 	return next;
 }
 
+static char **handle_version(char *arg, char **next)
+{
+	printf("sparse version %s\n", sparse_version());
+	exit(0);
+}
+
 struct switches {
 	const char *name;
 	char **(*fn)(char *, char **);
@@ -629,6 +642,7 @@ static char **handle_switch(char *arg, char **next)
 	static struct switches cmd[] = {
 		{ "nostdinc", handle_nostdinc },
 		{ "gcc-base-dir", handle_base_dir},
+		{ "-version", handle_version },
 		{ NULL, NULL }
 	};
 	struct switches *s;
diff --git a/lib.h b/lib.h
index 919b5b1..80f8ec8 100644
--- a/lib.h
+++ b/lib.h
@@ -80,6 +80,7 @@ struct token *expect(struct token *, int, const char *);
 #define NORETURN_ATTR
 #define SENTINEL_ATTR
 #endif
+extern const char *sparse_version(void);
 extern void die(const char *, ...) FORMAT_ATTR(1) NORETURN_ATTR;
 extern void info(struct position, const char *, ...) FORMAT_ATTR(2);
 extern void warning(struct position, const char *, ...) FORMAT_ATTR(2);
diff --git a/sparse.c b/sparse.c
index 4026ba7..2c43e0f 100644
--- a/sparse.c
+++ b/sparse.c
@@ -276,10 +276,16 @@ static void check_symbols(struct symbol_list *list)
 int main(int argc, char **argv)
 {
 	struct string_list *filelist = NULL;
+	struct symbol_list *list;
 	char *file;
 
+	list = sparse_initialize(argc, argv, &filelist);
+
+	if (verbose)
+		fprintf(stderr, "sparse version %s\n", sparse_version());
+
 	// Expand, linearize and show it.
-	check_symbols(sparse_initialize(argc, argv, &filelist));
+	check_symbols(list);
 	FOR_EACH_PTR_NOTAG(filelist, file) {
 		check_symbols(sparse(file));
 	} END_FOR_EACH_PTR_NOTAG(file);
-- 
1.6.3.1


