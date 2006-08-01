From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Support -Wall flag
Date: Tue, 01 Aug 2006 13:50:08 -0400
Message-ID: <20060801175008.11809.99999.stgit@dv.roinet.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:54932 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751739AbWHARuT
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 1 Aug 2006 13:50:19 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1G7yNm-0008CZ-2P
	for linux-sparse@vger.kernel.org; Tue, 01 Aug 2006 13:50:18 -0400
Received: from localhost ([127.0.0.1] helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.62)
	(envelope-from <proski@gnu.org>)
	id 1G7yNe-00034a-02
	for linux-sparse@vger.kernel.org; Tue, 01 Aug 2006 13:50:10 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

From: Pavel Roskin <proski@gnu.org>

If -Wall is specified, enable all warnings except those explicitly
disabled by -Wno-* switches.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 lib.c |   30 +++++++++++++++++++++++++++---
 1 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/lib.c b/lib.c
index feb755a..faafdf8 100644
--- a/lib.c
+++ b/lib.c
@@ -325,24 +325,37 @@ static const struct warning {
 	{ "shadow", &Wshadow },
 };
 
+enum {
+	WARNING_OFF,
+	WARNING_ON,
+	WARNING_FORCE_OFF
+};
+
 
 static char **handle_switch_W(char *arg, char **next)
 {
-	int no = 0;
+	int flag = WARNING_ON;
 	char *p = arg + 1;
 	unsigned i;
 
+	if (!strcmp(p, "all")) {
+		for (i = 0; i < sizeof(warnings) / sizeof(warnings[0]); i++) {
+			if (*warnings[i].flag != WARNING_FORCE_OFF)
+				*warnings[i].flag = WARNING_ON;
+		}
+	}
+
 	// Prefixes "no" and "no-" mean to turn warning off.
 	if (p[0] == 'n' && p[1] == 'o') {
 		p += 2;
 		if (p[0] == '-')
 			p++;
-		no = 1;
+		flag = WARNING_FORCE_OFF;
 	}
 
 	for (i = 0; i < sizeof(warnings) / sizeof(warnings[0]); i++) {
 		if (!strcmp(p,warnings[i].name)) {
-			*warnings[i].flag = !no;
+			*warnings[i].flag = flag;
 			return next;
 		}
 	}
@@ -351,6 +364,16 @@ static char **handle_switch_W(char *arg,
 	return next;
 }
 
+static void handle_switch_W_finalize(void)
+{
+	unsigned i;
+
+	for (i = 0; i < sizeof(warnings) / sizeof(warnings[0]); i++) {
+		if (*warnings[i].flag == WARNING_FORCE_OFF)
+			*warnings[i].flag = WARNING_OFF;
+	}
+}
+
 static char **handle_switch_U(char *arg, char **next)
 {
 	const char *name = arg + 1;
@@ -608,6 +631,7 @@ struct symbol_list *sparse_initialize(in
 		 */
 		argv[files++] = arg;
 	}
+	handle_switch_W_finalize();
 
 	list = NULL;
 	argv[files] = NULL;
