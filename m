From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 7] Allow more than one command line include file.
Date: Tue, 16 Jan 2007 18:40:05 -0800
Message-ID: <20070117024005.GG962@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sccrmhc15.comcast.net ([204.127.200.85]:54721 "EHLO
	sccrmhc15.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbXAQDDE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 16 Jan 2007 22:03:04 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@freedesktop.org>


Signed-off-by: Christopher Li<sparse@chrisli.org>

Index: sparse/pre-process.c
===================================================================
Index: sparse/lib.c
===================================================================
--- sparse.orig/lib.c	2006-12-05 16:17:39.000000000 -0800
+++ sparse/lib.c	2006-12-22 01:51:00.000000000 -0800
@@ -192,7 +192,10 @@ int Wdo_while = 1;
 int Wuninitialized = 1;
 int preprocess_only;
 char *include;
-int include_fd = -1;
+
+#define CMDLINE_INCLUDE 20
+int cmdline_include_nr = 0;
+struct cmdline_include cmdline_include[CMDLINE_INCLUDE];
 
 
 void add_pre_buffer(const char *fmt, ...)
@@ -262,26 +265,26 @@ static char **handle_switch_I(char *arg,
 	return next;
 }
 
-static char **handle_switch_i(char *arg, char **next)
+static void add_cmdline_include(char *filename)
 {
-	if (*next && !strcmp(arg, "include")) {
-		char *name = *++next;
-		int fd = open(name, O_RDONLY);
-
-		include_fd = fd;
-		include = name;
-		if (fd < 0)
-			perror(name);
-	}
-	if (*next && !strcmp(arg, "imacros")) {
-		char *name = *++next;
-		int fd = open(name, O_RDONLY);
+	int fd = open(filename, O_RDONLY);
+	if (fd < 0) {
+		perror(filename);
+		return;
+	}
+	if (cmdline_include_nr >= CMDLINE_INCLUDE)
+		die("too many include files for %s\n", filename);
+	cmdline_include[cmdline_include_nr].filename = filename;
+	cmdline_include[cmdline_include_nr].fd = fd;
+	cmdline_include_nr++;
+}
 
-		include_fd = fd;
-		include = name;
-		if (fd < 0)
-			perror(name);
-	}
+static char **handle_switch_i(char *arg, char **next)
+{
+	if (*next && !strcmp(arg, "include"))
+		add_cmdline_include(*++next);
+	else if (*next && !strcmp(arg, "imacros"))
+		add_cmdline_include(*++next);
 	else if (*next && !strcmp(arg, "isystem")) {
 		char *path = *++next;
 		if (!path)
@@ -623,12 +626,14 @@ static struct symbol_list *sparse_file(c
 static struct symbol_list *sparse_initial(void)
 {
 	struct token *token;
+	int i;
 
 	// Prepend any "include" file to the stream.
 	// We're in global scope, it will affect all files!
 	token = NULL;
-	if (include_fd >= 0)
-		token = tokenize(include, include_fd, NULL, includepath);
+	for (i = cmdline_include_nr - 1; i >= 0; i--)
+		token = tokenize(cmdline_include[i].filename, cmdline_include[i].fd,
+				 token, includepath);
 
 	// Prepend the initial built-in stream
 	token = tokenize_buffer(pre_buffer, pre_buffer_size, token);
Index: sparse/token.h
===================================================================
Index: sparse/lib.h
===================================================================
--- sparse.orig/lib.h	2006-12-22 01:25:52.000000000 -0800
+++ sparse/lib.h	2006-12-22 01:42:32.000000000 -0800
@@ -33,6 +33,15 @@ struct position {
 		     noexpand:1;
 };
 
+struct cmdline_include {
+	char *filename;
+	int fd;
+};
+
+extern struct cmdline_include cmdline_include[];
+extern int cmdline_include_nr;
+
+
 struct ident;
 struct token;
 struct symbol;
