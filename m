From: Joe Perches <joe@perches.com>
Subject: [PATCH] - add --version to command line
Date: Wed, 30 Apr 2008 10:07:29 -0700
Message-ID: <1209575249.2064.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from 136-022.dsl.labridge.com ([206.117.136.22]:1308 "EHLO
	mail.perches.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbYD3RPD (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 30 Apr 2008 13:15:03 -0400
Received: from [192.168.1.130] (192-168-1-130.labridge.com [192.168.1.130] (may be forged))
	by mail.perches.com (8.9.3/8.9.3) with ESMTP id KAA29556
	for <linux-sparse@vger.kernel.org>; Wed, 30 Apr 2008 10:11:44 -0700
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

sparse doesn't support --version.
Perhaps a patch like this is acceptable?

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/Makefile b/Makefile
index 3eab17e..dfcb6b7 100644
--- a/Makefile
+++ b/Makefile
@@ -5,6 +5,7 @@ OS ?= linux
 CC ?= gcc
 CFLAGS ?= -O2 -finline-functions -fno-strict-aliasing -g
 CFLAGS += -Wall -Wwrite-strings
+CFLAGS += -DSPARSE_VERSION=$(VERSION)
 LDFLAGS ?= -g
 AR ?= ar
 
diff --git a/lib.c b/lib.c
index 0abcc9a..7f29174 100644
--- a/lib.c
+++ b/lib.c
@@ -823,6 +823,19 @@ static struct symbol_list *sparse_initial(void)
 	return sparse_tokenstream(token);
 }
 
+#define stringize_1(x)	#x
+#define stringize(x)		stringize_1(x)
+
+static void handle_version(char *name)
+{
+	char* exe = strrchr(name, '/');
+	if (exe)
+		exe++;
+	else
+		exe = name;
+	die("%s %s", exe, stringize(SPARSE_VERSION));
+}
+
 struct symbol_list *sparse_initialize(int argc, char **argv, struct string_list **filelist)
 {
 	char **args;
@@ -838,7 +851,11 @@ struct symbol_list *sparse_initialize(int argc, char **argv, struct string_list
 			break;
 
 		if (arg[0] == '-' && arg[1]) {
-			args = handle_switch(arg+1, args);
+			if (!strcmp("-version", &arg[1])) {
+				handle_version(argv[0]);
+			} else {
+				args = handle_switch(arg+1, args);
+			}
 			continue;
 		}
 		add_ptr_list_notag(filelist, arg);


