From: Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH] use ARRAY_SIZE() when possible
Date: Thu,  9 Dec 2010 20:27:00 +0900
Message-ID: <1291894020-3388-1-git-send-email-namhyung@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:46967 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234Ab0LILcQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 9 Dec 2010 06:32:16 -0500
Received: by pwj3 with SMTP id 3so500017pwj.19
        for <linux-sparse@vger.kernel.org>; Thu, 09 Dec 2010 03:32:16 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

Convert (sizeof arr / sizeof arr[0]) to ARRAY_SIZE(arr).

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 lib.c         |    8 ++++----
 pre-process.c |    4 ++--
 show-parse.c  |    4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib.c b/lib.c
index c4a6f87..1d96129 100644
--- a/lib.c
+++ b/lib.c
@@ -437,7 +437,7 @@ static char **handle_onoff_switch(char *arg, char **next, const struct warning w
 
 static char **handle_switch_W(char *arg, char **next)
 {
-	char ** ret = handle_onoff_switch(arg, next, warnings, sizeof warnings/sizeof warnings[0]);
+	char ** ret = handle_onoff_switch(arg, next, warnings, ARRAY_SIZE(warnings));
 	if (ret)
 		return ret;
 
@@ -453,7 +453,7 @@ static struct warning debugs[] = {
 
 static char **handle_switch_v(char *arg, char **next)
 {
-	char ** ret = handle_onoff_switch(arg, next, debugs, sizeof debugs/sizeof debugs[0]);
+	char ** ret = handle_onoff_switch(arg, next, debugs, ARRAY_SIZE(debugs));
 	if (ret)
 		return ret;
 
@@ -477,7 +477,7 @@ static void handle_onoff_switch_finalize(const struct warning warnings[], int n)
 
 static void handle_switch_W_finalize(void)
 {
-	handle_onoff_switch_finalize(warnings, sizeof(warnings) / sizeof(warnings[0]));
+	handle_onoff_switch_finalize(warnings, ARRAY_SIZE(warnings));
 
 	/* default Wdeclarationafterstatement based on the C dialect */
 	if (-1 == Wdeclarationafterstatement)
@@ -504,7 +504,7 @@ static void handle_switch_W_finalize(void)
 
 static void handle_switch_v_finalize(void)
 {
-	handle_onoff_switch_finalize(debugs, sizeof(debugs) / sizeof(debugs[0]));
+	handle_onoff_switch_finalize(debugs, ARRAY_SIZE(debugs));
 }
 
 static char **handle_switch_U(char *arg, char **next)
diff --git a/pre-process.c b/pre-process.c
index 656acaa..603cc00 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -1718,13 +1718,13 @@ static void init_preprocessor(void)
 		{ "elif",	handle_elif },
 	};
 
-	for (i = 0; i < (sizeof (normal) / sizeof (normal[0])); i++) {
+	for (i = 0; i < ARRAY_SIZE(normal); i++) {
 		struct symbol *sym;
 		sym = create_symbol(stream, normal[i].name, SYM_PREPROCESSOR, NS_PREPROCESSOR);
 		sym->handler = normal[i].handler;
 		sym->normal = 1;
 	}
-	for (i = 0; i < (sizeof (special) / sizeof (special[0])); i++) {
+	for (i = 0; i < ARRAY_SIZE(special); i++) {
 		struct symbol *sym;
 		sym = create_symbol(stream, special[i].name, SYM_PREPROCESSOR, NS_PREPROCESSOR);
 		sym->handler = special[i].handler;
diff --git a/show-parse.c b/show-parse.c
index c97debe..73cc86a 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -239,7 +239,7 @@ const char *builtin_typename(struct symbol *sym)
 {
 	int i;
 
-	for (i = 0; i < sizeof(typenames)/sizeof(typenames[0]); i++)
+	for (i = 0; i < ARRAY_SIZE(typenames); i++)
 		if (typenames[i].sym == sym)
 			return typenames[i].name;
 	return NULL;
@@ -249,7 +249,7 @@ const char *builtin_ctypename(struct ctype *ctype)
 {
 	int i;
 
-	for (i = 0; i < sizeof(typenames)/sizeof(typenames[0]); i++)
+	for (i = 0; i < ARRAY_SIZE(typenames); i++)
 		if (&typenames[i].sym->ctype == ctype)
 			return typenames[i].name;
 	return NULL;
-- 
1.7.2.2

