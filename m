From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 08/15] options: avoid spaces between function name and arguments list
Date: Sun,  5 Jul 2020 15:02:13 +0200
Message-ID: <20200705130220.26230-9-luc.vanoostenryck@gmail.com>
References: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgGENCg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 09:02:36 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A431C08C5DE
        for <linux-sparse@vger.kernel.org>; Sun,  5 Jul 2020 06:02:36 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id by13so22328544edb.11
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 06:02:36 -0700 (PDT)
In-Reply-To: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

It's a stylistic detail but a lot of the strcmp() calls used for
the processing of the options are written 'strcmp (...)'. Two
other functions calls are also in the case.

Reformat them to the usual style for function calls: without
the space between the function name and the arguments.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/lib.c b/lib.c
index 5f4e6b2d76c8..b3bacb180cac 100644
--- a/lib.c
+++ b/lib.c
@@ -570,7 +570,7 @@ OPT_NUMERIC(uint, unsigned int, strtoul)
 
 static char **handle_switch_a(char *arg, char **next)
 {
-	if (!strcmp (arg, "ansi"))
+	if (!strcmp(arg, "ansi"))
 		standard = STANDARD_C89;
 
 	return next;
@@ -759,7 +759,7 @@ static char **handle_switch_f(char *arg, char **next)
 
 static char **handle_switch_G(char *arg, char **next)
 {
-	if (!strcmp (arg, "G") && *next)
+	if (!strcmp(arg, "G") && *next)
 		return next + 1; // "-G 0"
 	else
 		return next;     // "-G0" or (bogus) terminal "-G"
@@ -775,7 +775,7 @@ static char **handle_base_dir(char *arg, char **next)
 
 static char **handle_switch_g(char *arg, char **next)
 {
-	if (!strcmp (arg, "gcc-base-dir"))
+	if (!strcmp(arg, "gcc-base-dir"))
 		return handle_base_dir(arg, next);
 
 	return next;
@@ -907,7 +907,7 @@ static char **handle_nostdinc(char *arg, char **next)
 
 static char **handle_switch_n(char *arg, char **next)
 {
-	if (!strcmp (arg, "nostdinc"))
+	if (!strcmp(arg, "nostdinc"))
 		return handle_nostdinc(arg, next);
 
 	return next;
@@ -925,7 +925,7 @@ static char **handle_switch_O(char *arg, char **next)
 
 static char **handle_switch_o(char *arg, char **next)
 {
-	if (!strcmp (arg, "o")) {       // "-o foo"
+	if (!strcmp(arg, "o")) {	// "-o foo"
 		if (!*++next)
 			die("argument to '-o' is missing");
 		outfile = *next;
@@ -949,23 +949,23 @@ static char **handle_switch_p(char *arg, char **next)
 static char **handle_switch_s(const char *arg, char **next)
 {
 	if ((arg = match_option(arg, "std="))) {
-		if (!strcmp (arg, "c89") ||
-		    !strcmp (arg, "iso9899:1990"))
+		if (!strcmp(arg, "c89") ||
+		    !strcmp(arg, "iso9899:1990"))
 			standard = STANDARD_C89;
 
-		else if (!strcmp (arg, "iso9899:199409"))
+		else if (!strcmp(arg, "iso9899:199409"))
 			standard = STANDARD_C94;
 
-		else if (!strcmp (arg, "c99") ||
-			 !strcmp (arg, "c9x") ||
-			 !strcmp (arg, "iso9899:1999") ||
-			 !strcmp (arg, "iso9899:199x"))
+		else if (!strcmp(arg, "c99") ||
+			 !strcmp(arg, "c9x") ||
+			 !strcmp(arg, "iso9899:1999") ||
+			 !strcmp(arg, "iso9899:199x"))
 			standard = STANDARD_C99;
 
-		else if (!strcmp (arg, "gnu89"))
+		else if (!strcmp(arg, "gnu89"))
 			standard = STANDARD_GNU89;
 
-		else if (!strcmp (arg, "gnu99") || !strcmp (arg, "gnu9x"))
+		else if (!strcmp(arg, "gnu99") || !strcmp(arg, "gnu9x"))
 			standard = STANDARD_GNU99;
 
 		else if (!strcmp(arg, "c11") ||
@@ -986,7 +986,7 @@ static char **handle_switch_s(const char *arg, char **next)
 			standard = STANDARD_GNU17;
 
 		else
-			die ("Unsupported C dialect");
+			die("Unsupported C dialect");
 	}
 
 	return next;
@@ -995,7 +995,7 @@ static char **handle_switch_s(const char *arg, char **next)
 static char **handle_switch_U(char *arg, char **next)
 {
 	const char *name = arg + 1;
-	add_pre_buffer ("#undef %s\n", name);
+	add_pre_buffer("#undef %s\n", name);
 	return next;
 }
 
@@ -1516,7 +1516,7 @@ static struct symbol_list *sparse_file(const char *filename)
 	int fd;
 	struct token *token;
 
-	if (strcmp (filename, "-") == 0) {
+	if (strcmp(filename, "-") == 0) {
 		fd = 0;
 	} else {
 		fd = open(filename, O_RDONLY);
-- 
2.27.0
