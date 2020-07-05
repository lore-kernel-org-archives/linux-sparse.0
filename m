From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 01/15] options: let handle_onoff_switch() use null terminated arrays
Date: Sun,  5 Jul 2020 15:02:06 +0200
Message-ID: <20200705130220.26230-2-luc.vanoostenryck@gmail.com>
References: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgGENCa (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 09:02:30 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DA9C08C5DE
        for <linux-sparse@vger.kernel.org>; Sun,  5 Jul 2020 06:02:30 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id z17so32200812edr.9
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 06:02:29 -0700 (PDT)
In-Reply-To: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This makes things slightly easier to use.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/lib.c b/lib.c
index e56788260cb7..709dd5176112 100644
--- a/lib.c
+++ b/lib.c
@@ -529,14 +529,14 @@ enum {
 	WARNING_FORCE_OFF
 };
 
-static char **handle_onoff_switch(char *arg, char **next, const struct flag warnings[], int n)
+static char **handle_onoff_switch(char *arg, char **next, const struct flag warnings[])
 {
 	int flag = WARNING_ON;
 	char *p = arg + 1;
 	unsigned i;
 
 	if (!strcmp(p, "sparse-all")) {
-		for (i = 0; i < n; i++) {
+		for (i = 0; warnings[i].name; i++) {
 			if (*warnings[i].flag != WARNING_FORCE_OFF && warnings[i].flag != &Wsparse_error)
 				*warnings[i].flag = WARNING_ON;
 		}
@@ -551,7 +551,7 @@ static char **handle_onoff_switch(char *arg, char **next, const struct flag warn
 		flag = WARNING_FORCE_OFF;
 	}
 
-	for (i = 0; i < n; i++) {
+	for (i = 0; warnings[i].name; i++) {
 		if (!strcmp(p,warnings[i].name)) {
 			*warnings[i].flag = flag;
 			return next;
@@ -789,11 +789,12 @@ static const struct flag warnings[] = {
 	{ "universal-initializer", &Wuniversal_initializer },
 	{ "unknown-attribute", &Wunknown_attribute },
 	{ "vla", &Wvla },
+	{ }
 };
 
 static char **handle_switch_W(char *arg, char **next)
 {
-	char ** ret = handle_onoff_switch(arg, next, warnings, ARRAY_SIZE(warnings));
+	char ** ret = handle_onoff_switch(arg, next, warnings);
 	if (ret)
 		return ret;
 
@@ -808,12 +809,13 @@ static struct flag debugs[] = {
 	{ "entry", &dbg_entry},
 	{ "ir", &dbg_ir},
 	{ "postorder", &dbg_postorder},
+	{ }
 };
 
 
 static char **handle_switch_v(char *arg, char **next)
 {
-	char ** ret = handle_onoff_switch(arg, next, debugs, ARRAY_SIZE(debugs));
+	char ** ret = handle_onoff_switch(arg, next, debugs);
 	if (ret)
 		return ret;
 
@@ -856,11 +858,11 @@ static char **handle_switch_d(char *arg, char **next)
 }
 
 
-static void handle_onoff_switch_finalize(const struct flag warnings[], int n)
+static void handle_onoff_switch_finalize(const struct flag warnings[])
 {
 	unsigned i;
 
-	for (i = 0; i < n; i++) {
+	for (i = 0; warnings[i].name; i++) {
 		if (*warnings[i].flag == WARNING_FORCE_OFF)
 			*warnings[i].flag = WARNING_OFF;
 	}
@@ -868,7 +870,7 @@ static void handle_onoff_switch_finalize(const struct flag warnings[], int n)
 
 static void handle_switch_W_finalize(void)
 {
-	handle_onoff_switch_finalize(warnings, ARRAY_SIZE(warnings));
+	handle_onoff_switch_finalize(warnings);
 
 	/* default Wdeclarationafterstatement based on the C dialect */
 	if (-1 == Wdeclarationafterstatement) {
@@ -886,7 +888,7 @@ static void handle_switch_W_finalize(void)
 
 static void handle_switch_v_finalize(void)
 {
-	handle_onoff_switch_finalize(debugs, ARRAY_SIZE(debugs));
+	handle_onoff_switch_finalize(debugs);
 }
 
 static char **handle_switch_U(char *arg, char **next)
-- 
2.27.0
