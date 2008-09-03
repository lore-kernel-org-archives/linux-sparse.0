From: alexey.zaytsev@gmail.com
Subject: [PATCH 02/10] Handle -emit_code and the -o file options.
Date: Thu,  4 Sep 2008 01:55:46 +0400
Message-ID: <6f37eec18608be0a86356a874836bea516317084.1220475018.git.xl0@xl0.local>
References: <1220478954-22678-1-git-send-email-alexey.zaytsev@gmail.com>
 <20df58606337d58576ba3c10cf8f8c1522f81f91.1220475018.git.xl0@xl0.local>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:41113 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441AbYICVxv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 3 Sep 2008 17:53:51 -0400
Received: by ug-out-1314.google.com with SMTP id c2so1952952ugf.37
        for <linux-sparse@vger.kernel.org>; Wed, 03 Sep 2008 14:53:49 -0700 (PDT)
In-Reply-To: <20df58606337d58576ba3c10cf8f8c1522f81f91.1220475018.git.xl0@xl0.local>
In-Reply-To: <20df58606337d58576ba3c10cf8f8c1522f81f91.1220475018.git.xl0@xl0.local>
References: <20df58606337d58576ba3c10cf8f8c1522f81f91.1220475018.git.xl0@xl0.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@kernel.org>, Chris Li <christ.li@gmail.com>, Codrin Alexandru Grajdeanu <grcodal@gmail.com>, Alexey Zaytsev <alexey.zaytsev@gmail.com>

From: Alexey Zaytsev <alexey.zaytsev@gmail.com>

Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
---
 lib.c |   19 ++++++++++++++++---
 lib.h |    3 +++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/lib.c b/lib.c
index e274750..edb8ac9 100644
--- a/lib.c
+++ b/lib.c
@@ -214,6 +214,8 @@ int dbg_entry = 0;
 int dbg_dead = 0;
 
 int preprocess_only;
+int emit_code = 0;
+const char *output_file = "a.out";
 
 static enum { STANDARD_C89,
               STANDARD_C94,
@@ -347,11 +349,14 @@ static char **handle_switch_m(char *arg, char **next)
 
 static char **handle_switch_o(char *arg, char **next)
 {
-	if (!strcmp (arg, "o")) {       // "-o foo"
-		if (!*++next)
+	if (!strcmp (arg, "o")) { 	// "-o foo"
+		next++;
+		if (!*next)
 			die("argument to '-o' is missing");
+		output_file = *next;
+	} else { 			// "-ofoo"
+		output_file = ++arg;
 	}
-	// else "-ofoo"
 
 	return next;
 }
@@ -587,6 +592,12 @@ static char **handle_dirafter(char *arg, char **next)
 	return next;
 }
 
+static char **handle_emit_code(char *arg, char **next)
+{
+	emit_code = 1;
+	return next;
+}
+
 struct switches {
 	const char *name;
 	char **(*fn)(char *, char **);
@@ -597,6 +608,7 @@ static char **handle_switch(char *arg, char **next)
 	static struct switches cmd[] = {
 		{ "nostdinc", handle_nostdinc },
 		{ "dirafter", handle_dirafter },
+		{ "emit-code", handle_emit_code },
 		{ NULL, NULL }
 	};
 	struct switches *s;
@@ -849,6 +861,7 @@ struct symbol_list *sparse_initialize(int argc, char **argv, struct string_list
 			continue;
 		}
 		add_ptr_list_notag(filelist, arg);
+
 	}
 	handle_switch_W_finalize();
 	handle_switch_v_finalize();
diff --git a/lib.h b/lib.h
index b22fa93..b74be7c 100644
--- a/lib.h
+++ b/lib.h
@@ -112,6 +112,9 @@ extern int Wdeclarationafterstatement;
 extern int dbg_entry;
 extern int dbg_dead;
 
+extern int emit_code;
+extern const char *output_file;
+
 extern void declare_builtin_functions(void);
 extern void create_builtin_stream(void);
 extern struct symbol_list *sparse_initialize(int argc, char **argv, struct string_list **files);
-- 
1.5.6.3

