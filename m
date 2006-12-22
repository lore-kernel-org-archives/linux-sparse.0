From: Pavel Roskin <proski@gnu.org>
Subject: [RFC PATCH] Handling multiple -include directives
Date: Fri, 22 Dec 2006 02:06:29 -0500
Message-ID: <1166771189.18955.10.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:33557 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423191AbWLVHGb (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 22 Dec 2006 02:06:31 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1GxeU7-0007GD-5I
	for linux-sparse@vger.kernel.org; Fri, 22 Dec 2006 02:06:27 -0500
Received: from proski by gnu.org with local (Exim 4.63)
	(envelope-from <proski@gnu.org>)
	id 1GxeU9-0005O1-8a
	for linux-sparse@vger.kernel.org; Fri, 22 Dec 2006 02:06:29 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hello!

sparse doesn't handle multiple -include directives.  Variables "include"
and "include_fd" have file scope in lib.c.  The file for inclusion is
processed only once in sparse_initial() after the command line has been
processed.

It seems to me that the existing add_pre_buffer() mechanism can be used
instead.  I'm just a bit worried why it wasn't done like this in the
first place.

---
Handle multiple -include directives

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 lib.c |   26 ++++++--------------------
 1 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/lib.c b/lib.c
index 51c415d..3ea3bde 100644
--- a/lib.c
+++ b/lib.c
@@ -191,8 +191,6 @@ int Wenum_mismatch = 1;
 int Wdo_while = 1;
 int Wuninitialized = 1;
 int preprocess_only;
-char *include;
-int include_fd = -1;
 
 
 void add_pre_buffer(const char *fmt, ...)
@@ -266,21 +264,15 @@ static char **handle_switch_i(char *arg, char **next)
 {
 	if (*next && !strcmp(arg, "include")) {
 		char *name = *++next;
-		int fd = open(name, O_RDONLY);
-
-		include_fd = fd;
-		include = name;
-		if (fd < 0)
-			perror(name);
+		if (!name)
+			die("missing argument for -include option");
+		add_pre_buffer("#include \"%s\"\n", name);
 	}
 	if (*next && !strcmp(arg, "imacros")) {
 		char *name = *++next;
-		int fd = open(name, O_RDONLY);
-
-		include_fd = fd;
-		include = name;
-		if (fd < 0)
-			perror(name);
+		if (!name)
+			die("missing argument for -include option");
+		add_pre_buffer("#include \"%s\"\n", name);
 	}
 	else if (*next && !strcmp(arg, "isystem")) {
 		char *path = *++next;
@@ -624,12 +616,6 @@ static struct symbol_list *sparse_initial(void)
 {
 	struct token *token;
 
-	// Prepend any "include" file to the stream.
-	// We're in global scope, it will affect all files!
-	token = NULL;
-	if (include_fd >= 0)
-		token = tokenize(include, include_fd, NULL, includepath);
-
 	// Prepend the initial built-in stream
 	token = tokenize_buffer(pre_buffer, pre_buffer_size, token);
 	return sparse_tokenstream(token);


-- 
Regards,
Pavel Roskin
