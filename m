From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC PATCH] Handling multiple -include directives
Date: Fri, 22 Dec 2006 01:47:48 -0800
Message-ID: <20061222094748.GA32376@chrisli.org>
References: <1166771189.18955.10.camel@dv> <1166773008.21614.4.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from alnrmhc14.comcast.net ([204.127.225.94]:40392 "EHLO
	alnrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946002AbWLVKEm (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 22 Dec 2006 05:04:42 -0500
Content-Disposition: inline
In-Reply-To: <1166773008.21614.4.camel@dv>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org

On Fri, Dec 22, 2006 at 02:36:48AM -0500, Pavel Roskin wrote:
> On Fri, 2006-12-22 at 02:06 -0500, Pavel Roskin wrote:
> > It seems to me that the existing add_pre_buffer() mechanism can be used
> > instead.  I'm just a bit worried why it wasn't done like this in the
> > first place.

I believe the reason it is not in the pre buffer is that it should first
search the current directory instead of the source file directory. The command
line -include has some subtle differences with #include "filename"

> 
> There was a reason to worry.  Now create_builtin_stream() is run after
> the includes have been processed, so that e.g. the Linux compiler.h
> tells me that my compiler is too old (because it was included from the
> command line before __GNUC__ was defined).

That is the other reason as well :-)

Can you please try this patch and see if it works for you?

Chris

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
