From: kosaki.motohiro@gmail.com
Subject: [PATCH][RFC] handle -I and -include combination
Date: Mon, 18 Jun 2012 08:40:58 -0400
Message-ID: <1340023258-7069-1-git-send-email-kosaki.motohiro@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:46034 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016Ab2FRMlI (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 18 Jun 2012 08:41:08 -0400
Received: by qafi31 with SMTP id i31so1557207qaf.1
        for <linux-sparse@vger.kernel.org>; Mon, 18 Jun 2012 05:41:07 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: KOSAKI Motohiro <kosaki.motohiro@gmail.com>

From: KOSAKI Motohiro <kosaki.motohiro@gmail.com>

Currently, "-include" behavior is far different between sparse
and gcc. gcc can compile following testcase. but sparse can't.

This patch fixes it.

===================================================
Makefile
--------------
bar:
    $(CC) -I./include-for-foo -include foo.h main.c -o bar

main.c
------------------
 #include <stdio.h>
int main(void)
{
    printf("foo = %d\n", FOO);
    return 0;
}

include-for-foo/foo.h
----------------------
 #define FOO 42
===================================================

Signed-off-by: KOSAKI Motohiro <kosaki.motohiro@gmail.com>
---
 lib.c |   53 +++++++++++++++++++++++++----------------------------
 1 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/lib.c b/lib.c
index 396e9f1..958f65e 100644
--- a/lib.c
+++ b/lib.c
@@ -189,6 +189,8 @@ void die(const char *fmt, ...)
 
 static struct token *pre_buffer_begin = NULL;
 static struct token *pre_buffer_end = NULL;
+static struct token *pre_buffer_begin2 = NULL;
+static struct token *pre_buffer_end2 = NULL;
 
 int Waddress_space = 1;
 int Wbitwise = 0;
@@ -224,11 +226,6 @@ static enum { STANDARD_C89,
               STANDARD_GNU89,
               STANDARD_GNU99, } standard = STANDARD_GNU89;
 
-#define CMDLINE_INCLUDE 20
-int cmdline_include_nr = 0;
-struct cmdline_include cmdline_include[CMDLINE_INCLUDE];
-
-
 void add_pre_buffer(const char *fmt, ...)
 {
 	va_list args;
@@ -247,6 +244,25 @@ void add_pre_buffer(const char *fmt, ...)
 	pre_buffer_end = end;
 }
 
+void add_pre_buffer2(const char *fmt, ...)
+{
+	va_list args;
+	unsigned int size;
+	struct token *begin, *end;
+	char buffer[4096];
+
+	va_start(args, fmt);
+	size = vsnprintf(buffer, sizeof(buffer), fmt, args);
+	va_end(args);
+	begin = tokenize_buffer(buffer, size, &end);
+	if (!pre_buffer_begin2)
+		pre_buffer_begin2 = begin;
+	if (pre_buffer_end2)
+		pre_buffer_end2->next = begin;
+	pre_buffer_end2 = end;
+}
+
+
 static char **handle_switch_D(char *arg, char **next)
 {
 	const char *name = arg + 1;
@@ -299,16 +315,7 @@ static char **handle_switch_I(char *arg, char **next)
 
 static void add_cmdline_include(char *filename)
 {
-	int fd = open(filename, O_RDONLY);
-	if (fd < 0) {
-		perror(filename);
-		return;
-	}
-	if (cmdline_include_nr >= CMDLINE_INCLUDE)
-		die("too many include files for %s\n", filename);
-	cmdline_include[cmdline_include_nr].filename = filename;
-	cmdline_include[cmdline_include_nr].fd = fd;
-	cmdline_include_nr++;
+	add_pre_buffer2("#include \"%s\"\n", filename);
 }
 
 static char **handle_switch_i(char *arg, char **next)
@@ -892,19 +899,9 @@ static struct symbol_list *sparse_file(const char *filename)
  */
 static struct symbol_list *sparse_initial(void)
 {
-	struct token *token;
-	int i;
-
-	// Prepend any "include" file to the stream.
-	// We're in global scope, it will affect all files!
-	token = NULL;
-	for (i = cmdline_include_nr - 1; i >= 0; i--)
-		token = tokenize(cmdline_include[i].filename, cmdline_include[i].fd,
-				 token, includepath);
