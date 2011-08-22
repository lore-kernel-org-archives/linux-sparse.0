From: Pekka Enberg <penberg@kernel.org>
Subject: [PATCH 3/5] sparse: Fix __builtin_safe_p for pure and const functions
Date: Mon, 22 Aug 2011 16:57:29 +0300
Message-ID: <1314021451-24808-3-git-send-email-penberg@kernel.org>
References: <1314021451-24808-1-git-send-email-penberg@kernel.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:47281 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab1HVN5f (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Aug 2011 09:57:35 -0400
In-Reply-To: <1314021451-24808-1-git-send-email-penberg@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>

This patch fixes __builtin_safe_p() to work properly for calls to pure
functions.

Cc: Christopher Li <sparse@chrisli.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 expand.c                   |    3 +++
 parse.c                    |   10 +++++-----
 show-parse.c               |    1 +
 symbol.h                   |    1 +
 validation/builtin_safe1.c |    1 -
 5 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/expand.c b/expand.c
index b965dc3..91e14f3 100644
--- a/expand.c
+++ b/expand.c
@@ -785,6 +785,9 @@ static int expand_symbol_call(struct expression *expr, int cost)
 	struct expression *fn = expr->fn;
 	struct symbol *ctype = fn->ctype;
 
+	if (ctype->ctype.modifiers & MOD_PURE)
+		return 0;
+
 	if (fn->type != EXPR_PREOP)
 		return SIDE_EFFECTS;
 
diff --git a/parse.c b/parse.c
index 082c2c4..6d8678e 100644
--- a/parse.c
+++ b/parse.c
@@ -463,6 +463,11 @@ static struct init_keyword {
 	{ "__transparent_union__",	NS_KEYWORD,	.op = &transparent_union_op },
 	{ "noreturn",	NS_KEYWORD,	MOD_NORETURN,	.op = &attr_mod_op },
 	{ "__noreturn__",	NS_KEYWORD,	MOD_NORETURN,	.op = &attr_mod_op },
+	{ "pure",	NS_KEYWORD,	MOD_PURE,	.op = &attr_mod_op },
+	{"__pure__",	NS_KEYWORD,	MOD_PURE,	.op = &attr_mod_op },
+	{"const",	NS_KEYWORD,	MOD_PURE,	.op = &attr_mod_op },
+	{"__const",	NS_KEYWORD,	MOD_PURE,	.op = &attr_mod_op },
+	{"__const__",	NS_KEYWORD,	MOD_PURE,	.op = &attr_mod_op },
 
 	{ "__mode__",	NS_KEYWORD,	.op = &mode_op },
 	{ "QI",		NS_KEYWORD,	MOD_CHAR,	.op = &mode_QI_op },
@@ -494,9 +499,6 @@ const char *ignored_attributes[] = {
 	"__cdecl__",
 	"cold",
 	"__cold__",
-	"const",
-	"__const",
-	"__const__",
 	"constructor",
 	"__constructor__",
 	"deprecated",
@@ -545,8 +547,6 @@ const char *ignored_attributes[] = {
 	"nothrow",
 	"__nothrow",
 	"__nothrow__",
-	"pure",
-	"__pure__",
 	"regparm",
 	"__regparm__",
 	"section",
diff --git a/show-parse.c b/show-parse.c
index a5beafe..1333e30 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -131,6 +131,7 @@ const char *modifier_string(unsigned long mod)
 		{MOD_NORETURN,		"[noreturn]"},
 		{MOD_EXPLICITLY_SIGNED,	"[explicitly-signed]"},
 		{MOD_BITWISE,		"[bitwise]"},
+		{MOD_PURE,		"[pure]"},
 	};
 
 	for (i = 0; i < ARRAY_SIZE(mod_names); i++) {
diff --git a/symbol.h b/symbol.h
index 2b8f20e..1e74579 100644
--- a/symbol.h
+++ b/symbol.h
@@ -198,6 +198,7 @@ struct symbol {
 #define MOD_LONG	0x0400
 #define MOD_LONGLONG	0x0800
 #define MOD_LONGLONGLONG	0x1000
+#define MOD_PURE	0x2000
 
 #define MOD_TYPEDEF	0x10000
 
diff --git a/validation/builtin_safe1.c b/validation/builtin_safe1.c
index 2f6c9d2..eeddcc8 100644
--- a/validation/builtin_safe1.c
+++ b/validation/builtin_safe1.c
@@ -26,7 +26,6 @@ static int foo(int x, int y)
 
 /*
  * check-name: __builtin_safe
- * check-known-to-fail
  * check-error-start
 builtin_safe1.c:13:3: warning: Macro argument with side effects: x++
 builtin_safe1.c:14:3: warning: Macro argument with side effects: x+=1
-- 
1.7.4.1

