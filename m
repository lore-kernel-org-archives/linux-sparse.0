From: alexey.zaytsev@gmail.com
Subject: [PATCH 03/10] Check stdin if no input files given, like cc1.
Date: Thu,  4 Sep 2008 01:55:47 +0400
Message-ID: <2faea660ccc7cae55a2d2cd28f64059b80356a8f.1220475018.git.xl0@xl0.local>
References: <1220478954-22678-1-git-send-email-alexey.zaytsev@gmail.com>
 <20df58606337d58576ba3c10cf8f8c1522f81f91.1220475018.git.xl0@xl0.local>
 <6f37eec18608be0a86356a874836bea516317084.1220475018.git.xl0@xl0.local>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:48383 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517AbYICVxw (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 3 Sep 2008 17:53:52 -0400
Received: by ug-out-1314.google.com with SMTP id c2so1952946ugf.37
        for <linux-sparse@vger.kernel.org>; Wed, 03 Sep 2008 14:53:51 -0700 (PDT)
In-Reply-To: <6f37eec18608be0a86356a874836bea516317084.1220475018.git.xl0@xl0.local>
In-Reply-To: <20df58606337d58576ba3c10cf8f8c1522f81f91.1220475018.git.xl0@xl0.local>
References: <20df58606337d58576ba3c10cf8f8c1522f81f91.1220475018.git.xl0@xl0.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@kernel.org>, Chris Li <christ.li@gmail.com>, Codrin Alexandru Grajdeanu <grcodal@gmail.com>, Alexey Zaytsev <alexey.zaytsev@gmail.com>

From: Alexey Zaytsev <alexey.zaytsev@gmail.com>

Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
---
 lib.c    |   42 +++++++++++++++++++++---------------------
 lib.h    |    6 +++---
 sparse.c |    3 +++
 3 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/lib.c b/lib.c
index edb8ac9..0e30424 100644
--- a/lib.c
+++ b/lib.c
@@ -215,7 +215,7 @@ int dbg_dead = 0;
 
 int preprocess_only;
 int emit_code = 0;
-const char *output_file = "a.out";
+const char *output_file = NULL;
 
 static enum { STANDARD_C89,
               STANDARD_C94,
@@ -856,38 +856,38 @@ struct symbol_list *sparse_initialize(int argc, char **argv, struct string_list
 		if (!arg)
 			break;
 
-		if (arg[0] == '-' && arg[1]) {
-			args = handle_switch(arg+1, args);
+		if (arg[0] == '-') {
+			if (arg[1])
+				args = handle_switch(arg+1, args);
 			continue;
 		}
 		add_ptr_list_notag(filelist, arg);
 
 	}
+
 	handle_switch_W_finalize();
 	handle_switch_v_finalize();
 
-	list = NULL;
-	if (!ptr_list_empty(filelist)) {
-		// Initialize type system
-		init_ctype();
+	// Initialize type system
+	init_ctype();
 
-		create_builtin_stream();
-		add_pre_buffer("#define __CHECKER__ 1\n");
-		if (!preprocess_only)
-			declare_builtin_functions();
+	create_builtin_stream();
+	add_pre_buffer("#define __CHECKER__ 1\n");
+	if (!preprocess_only)
+		declare_builtin_functions();
 
-		list = sparse_initial();
+	list = sparse_initial();
+
+	/*
+	 * Protect the initial token allocations, since
+	 * they need to survive all the others
+	 */
+	protect_token_alloc();
 
-		/*
-		 * Protect the initial token allocations, since
-		 * they need to survive all the others
-		 */
-		protect_token_alloc();
-	}
 	return list;
 }
 
-struct symbol_list * sparse_keep_tokens(char *filename)
+struct symbol_list * sparse_keep_tokens(const char *filename)
 {
 	struct symbol_list *res;
 
@@ -902,7 +902,7 @@ struct symbol_list * sparse_keep_tokens(char *filename)
 }
 
 
-struct symbol_list * __sparse(char *filename)
+struct symbol_list * __sparse(const char *filename)
 {
 	struct symbol_list *res;
 
@@ -915,7 +915,7 @@ struct symbol_list * __sparse(char *filename)
 	return res;
 }
 
-struct symbol_list * sparse(char *filename)
+struct symbol_list * sparse(const char *filename)
 {
 	struct symbol_list *res = __sparse(filename);
 
diff --git a/lib.h b/lib.h
index b74be7c..19a724f 100644
--- a/lib.h
+++ b/lib.h
@@ -118,9 +118,9 @@ extern const char *output_file;
 extern void declare_builtin_functions(void);
 extern void create_builtin_stream(void);
 extern struct symbol_list *sparse_initialize(int argc, char **argv, struct string_list **files);
-extern struct symbol_list *__sparse(char *filename);
-extern struct symbol_list *sparse_keep_tokens(char *filename);
-extern struct symbol_list *sparse(char *filename);
+extern struct symbol_list *__sparse(const char *filename);
+extern struct symbol_list *sparse_keep_tokens(const char *filename);
+extern struct symbol_list *sparse(const char *filename);
 
 static inline int symbol_list_size(struct symbol_list *list)
 {
diff --git a/sparse.c b/sparse.c
index 785a6f6..b7a1f8b 100644
--- a/sparse.c
+++ b/sparse.c
@@ -602,6 +602,9 @@ int main(int argc, char **argv)
 
 	// Expand, linearize and show it.
 	check_symbols(sparse_initialize(argc, argv, &filelist));
+	if (ptr_list_empty(filelist))
+		check_symbols(sparse("-"));
+
 	FOR_EACH_PTR_NOTAG(filelist, file) {
 		check_symbols(sparse(file));
 	} END_FOR_EACH_PTR_NOTAG(file);
-- 
1.5.6.3

