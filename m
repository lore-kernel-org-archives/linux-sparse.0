From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 05/15] options: handle_onoff_switch() can handle any flags, not only warnings
Date: Sun,  5 Jul 2020 15:02:10 +0200
Message-ID: <20200705130220.26230-6-luc.vanoostenryck@gmail.com>
References: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgGENCe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 09:02:34 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3448C061794
        for <linux-sparse@vger.kernel.org>; Sun,  5 Jul 2020 06:02:33 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id d16so25544919edz.12
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 06:02:33 -0700 (PDT)
In-Reply-To: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

So, use 'flag' instead of 'warning' for variable and function names.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/lib.c b/lib.c
index 9acdc60fc416..c27773097127 100644
--- a/lib.c
+++ b/lib.c
@@ -250,10 +250,10 @@ void die(const char *fmt, ...)
 static struct token *pre_buffer_begin = NULL;
 static struct token *pre_buffer_end = NULL;
 
-enum warning_type {
-	WARNING_OFF,
-	WARNING_ON,
-	WARNING_FORCE_OFF
+enum flag_type {
+	FLAG_OFF,
+	FLAG_ON,
+	FLAG_FORCE_OFF
 };
 
 int Waddress = 0;
@@ -295,7 +295,7 @@ int Wshadow = 0;
 int Wshift_count_negative = 1;
 int Wshift_count_overflow = 1;
 int Wsizeof_bool = 0;
-int Wsparse_error = WARNING_FORCE_OFF;
+int Wsparse_error = FLAG_FORCE_OFF;
 int Wstrict_prototypes = 1;
 int Wtautological_compare = 0;
 int Wtransparent_union = 0;
@@ -529,9 +529,9 @@ static int opt_##NAME(const char *arg, const char *opt, TYPE *ptr, int flag)	\
 OPT_NUMERIC(ullong, unsigned long long, strtoull)
 OPT_NUMERIC(uint, unsigned int, strtoul)
 
-static char **handle_onoff_switch(char *arg, char **next, const struct flag warnings[])
+static char **handle_onoff_switch(char *arg, char **next, const struct flag flags[])
 {
-	int flag = WARNING_ON;
+	int flag = FLAG_ON;
 	char *p = arg + 1;
 	unsigned i;
 
@@ -540,12 +540,12 @@ static char **handle_onoff_switch(char *arg, char **next, const struct flag warn
 		p += 2;
 		if (p[0] == '-')
 			p++;
-		flag = WARNING_FORCE_OFF;
+		flag = FLAG_FORCE_OFF;
 	}
 
-	for (i = 0; warnings[i].name; i++) {
-		if (!strcmp(p,warnings[i].name)) {
-			*warnings[i].flag = flag;
+	for (i = 0; flags[i].name; i++) {
+		if (!strcmp(p,flags[i].name)) {
+			*flags[i].flag = flag;
 			return next;
 		}
 	}
@@ -722,7 +722,7 @@ static char **handle_switch_o(char *arg, char **next)
 }
 
 static const struct flag pflags[] = {
-	{ "pedantic", &Wpedantic, NULL, OPT_VAL, WARNING_ON },
+	{ "pedantic", &Wpedantic, NULL, OPT_VAL, FLAG_ON },
 	{ }
 };
 
@@ -793,8 +793,8 @@ static char **handle_switch_W(char *arg, char **next)
 	if (!strcmp(arg, "Wsparse-all")) {
 		int i;
 		for (i = 0; warnings[i].name; i++) {
-			if (*warnings[i].flag != WARNING_FORCE_OFF)
-				*warnings[i].flag = WARNING_ON;
+			if (*warnings[i].flag != FLAG_FORCE_OFF)
+				*warnings[i].flag = FLAG_ON;
 		}
 	}
 
@@ -858,13 +858,13 @@ static char **handle_switch_d(char *arg, char **next)
 }
 
 
-static void handle_onoff_switch_finalize(const struct flag warnings[])
+static void handle_onoff_switch_finalize(const struct flag flags[])
 {
 	unsigned i;
 
-	for (i = 0; warnings[i].name; i++) {
-		if (*warnings[i].flag == WARNING_FORCE_OFF)
-			*warnings[i].flag = WARNING_OFF;
+	for (i = 0; flags[i].name; i++) {
+		if (*flags[i].flag == FLAG_FORCE_OFF)
+			*flags[i].flag = FLAG_OFF;
 	}
 }
 
-- 
2.27.0
