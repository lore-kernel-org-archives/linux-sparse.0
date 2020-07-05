From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 06/15] options: move helpers up
Date: Sun,  5 Jul 2020 15:02:11 +0200
Message-ID: <20200705130220.26230-7-luc.vanoostenryck@gmail.com>
References: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgGENCf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 09:02:35 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7D9C061794
        for <linux-sparse@vger.kernel.org>; Sun,  5 Jul 2020 06:02:34 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id w16so39593499ejj.5
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 06:02:34 -0700 (PDT)
In-Reply-To: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The helpers for parsing the options are often situated just above the
first function using them. As result, these helpers can be found a bit
everywhere in the code, it's messy and doesn't help to reuse these helpers.

So, move all these helpers to the top.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 87 ++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 44 insertions(+), 43 deletions(-)

diff --git a/lib.c b/lib.c
index c27773097127..4868154fa3de 100644
--- a/lib.c
+++ b/lib.c
@@ -364,6 +364,15 @@ void add_pre_buffer(const char *fmt, ...)
 ////////////////////////////////////////////////////////////////////////////////
 // Helpers for option parsing
 
+static const char *match_option(const char *arg, const char *prefix)
+{
+	unsigned int n = strlen(prefix);
+	if (strncmp(arg, prefix, n) == 0)
+		return arg + n;
+	return NULL;
+}
+
+
 struct val_map {
 	const char *name;
 	int val;
@@ -438,14 +447,6 @@ end:
 }
 
 
-static const char *match_option(const char *arg, const char *prefix)
-{
-	unsigned int n = strlen(prefix);
-	if (strncmp(arg, prefix, n) == 0)
-		return arg + n;
-	return NULL;
-}
-
 #define OPT_INVERSE	1
 #define OPT_VAL		2
 struct flag {
@@ -497,6 +498,41 @@ static int handle_switches(const char *ori, const char *opt, const struct flag *
 	return 0;
 }
 
+static char **handle_onoff_switch(char *arg, char **next, const struct flag flags[])
+{
+	int flag = FLAG_ON;
+	char *p = arg + 1;
+	unsigned i;
+
+	// Prefixes "no" and "no-" mean to turn warning off.
+	if (p[0] == 'n' && p[1] == 'o') {
+		p += 2;
+		if (p[0] == '-')
+			p++;
+		flag = FLAG_FORCE_OFF;
+	}
+
+	for (i = 0; flags[i].name; i++) {
+		if (!strcmp(p,flags[i].name)) {
+			*flags[i].flag = flag;
+			return next;
+		}
+	}
+
+	// Unknown.
+	return NULL;
+}
+
+static void handle_onoff_switch_finalize(const struct flag flags[])
+{
+	unsigned i;
+
+	for (i = 0; flags[i].name; i++) {
+		if (*flags[i].flag == FLAG_FORCE_OFF)
+			*flags[i].flag = FLAG_OFF;
+	}
+}
+
 static int handle_switch_setval(const char *arg, const char *opt, const struct flag *flag, int options)
 {
 	*(flag->flag) = flag->mask;
@@ -529,31 +565,6 @@ static int opt_##NAME(const char *arg, const char *opt, TYPE *ptr, int flag)	\
 OPT_NUMERIC(ullong, unsigned long long, strtoull)
 OPT_NUMERIC(uint, unsigned int, strtoul)
 
-static char **handle_onoff_switch(char *arg, char **next, const struct flag flags[])
-{
-	int flag = FLAG_ON;
-	char *p = arg + 1;
-	unsigned i;
-
-	// Prefixes "no" and "no-" mean to turn warning off.
-	if (p[0] == 'n' && p[1] == 'o') {
-		p += 2;
-		if (p[0] == '-')
-			p++;
-		flag = FLAG_FORCE_OFF;
-	}
-
-	for (i = 0; flags[i].name; i++) {
-		if (!strcmp(p,flags[i].name)) {
-			*flags[i].flag = flag;
-			return next;
-		}
-	}
-
-	// Unknown.
-	return NULL;
-}
-
 ////////////////////////////////////////////////////////////////////////////////
 // Option parsing
 
@@ -858,16 +869,6 @@ static char **handle_switch_d(char *arg, char **next)
 }
 
 
-static void handle_onoff_switch_finalize(const struct flag flags[])
-{
-	unsigned i;
-
-	for (i = 0; flags[i].name; i++) {
-		if (*flags[i].flag == FLAG_FORCE_OFF)
-			*flags[i].flag = FLAG_OFF;
-	}
-}
