From: Alexey zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 4/4] Rename dirafter to idirafter.
Date: Mon, 08 Dec 2008 12:21:02 +0300
Message-ID: <20081208092102.15890.51534.stgit@xl0.local>
References: <20081208091817.15890.27981.stgit@xl0.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.233]:26734 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301AbYLHJLy (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 8 Dec 2008 04:11:54 -0500
Received: by qb-out-0506.google.com with SMTP id f11so1611560qba.17
        for <linux-sparse@vger.kernel.org>; Mon, 08 Dec 2008 01:11:53 -0800 (PST)
In-Reply-To: <20081208091817.15890.27981.stgit@xl0.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-sparse@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, Josh Triplett <josh@freedesktop.org>

Dirafter was probably just a mistake.
Gcc uses -idirafter.

Signed-off-by: Alexey zaytsev <alexey.zaytsev@gmail.com>
---
 lib.c         |   15 +++++----------
 pre-process.c |    4 ++--
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/lib.c b/lib.c
index b579834..7adff2d 100644
--- a/lib.c
+++ b/lib.c
@@ -313,6 +313,11 @@ static char **handle_switch_i(char *arg, char **next)
 		if (!path)
 			die("missing argument for -isystem option");
 		add_pre_buffer("#add_isystem \"%s/\"\n", path);
+	} else if (*next && !strcmp(arg, "idirafter")) {
+		char *path = *++next;
+		if (!path)
+			die("missing argument for -idirafter option");
+		add_pre_buffer("#add_dirafter \"%s/\"\n", path);
 	}
 	return next;
 }
@@ -573,15 +578,6 @@ static char **handle_nostdinc(char *arg, char **next)
 	return next;
 }
 
-static char **handle_dirafter(char *arg, char **next)
-{
-	char *path = *++next;
-	if (!path)
-		die("missing argument for -dirafter option");
-	add_pre_buffer("#add_dirafter \"%s/\"\n", path);
-	return next;
-}
-
 static char **handle_base_dir(char *arg, char **next)
 {
 	gcc_base_dir = *++next;
@@ -599,7 +595,6 @@ char **handle_switch(char *arg, char **next)
 {
 	static struct switches cmd[] = {
 		{ "nostdinc", handle_nostdinc },
-		{ "dirafter", handle_dirafter },
 		{ "gcc-base-dir", handle_base_dir},
 		{ NULL, NULL }
 	};
diff --git a/pre-process.c b/pre-process.c
index 9c6ef5b..cf53893 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -682,10 +682,10 @@ static int already_tokenized(const char *path)
  *   angle_includepath is set equal to isys_includepath.
  * -nostdinc removes all sys dirs by storing NULL in entry pointed
  *   to by * sys_includepath. Note that this will reset all dirs built-in
- *   and added before -nostdinc by -isystem and -dirafter.
+ *   and added before -nostdinc by -isystem and -idirafter.
  * -isystem dir adds dir where isys_includepath points adding this dir as
  *   first systemdir
- * -dirafter dir adds dir to the end of the list
+ * -idirafter dir adds dir to the end of the list
  */
 
 static void set_stream_include_path(struct stream *stream)

