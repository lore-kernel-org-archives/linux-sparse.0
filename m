From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 06/16] Rename dirafter to idirafter.
Date: Fri, 19 Dec 2008 00:52:38 +0300
Message-ID: <20081218215238.28136.79472.stgit@zaytsev.su>
References: <20081218181935.28136.60256.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:8093 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187AbYLRVni (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 18 Dec 2008 16:43:38 -0500
Received: by ug-out-1314.google.com with SMTP id 39so508461ugf.37
        for <linux-sparse@vger.kernel.org>; Thu, 18 Dec 2008 13:43:38 -0800 (PST)
In-Reply-To: <20081218181935.28136.60256.stgit@zaytsev.su>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

Dirafter was probably just a mistake.
Gcc uses -idirafter.

Acked-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Alexey zaytsev <alexey.zaytsev@gmail.com>
---
 lib.c         |   15 +++++----------
 pre-process.c |    4 ++--
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/lib.c b/lib.c
index 45a4f39..dc2da14 100644
--- a/lib.c
+++ b/lib.c
@@ -321,6 +321,11 @@ static char **handle_switch_i(char *arg, char **next)
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
@@ -584,15 +589,6 @@ static char **handle_nostdinc(char *arg, char **next)
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
@@ -610,7 +606,6 @@ static char **handle_switch(char *arg, char **next)
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

