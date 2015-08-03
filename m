From: Tony Camuso <tcamuso@redhat.com>
Subject: [PATCH 3/3 v4] Add Wall_off switch to disable errors and warnings
Date: Mon,  3 Aug 2015 12:35:59 -0400
Message-ID: <1438619759-14879-1-git-send-email-tcamuso@redhat.com>
References: <1438216001-8862-4-git-send-email-tcamuso@redhat.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35415 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752231AbbHCQgC (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 3 Aug 2015 12:36:02 -0400
In-Reply-To: <1438216001-8862-4-git-send-email-tcamuso@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sam@ravnborg.org, linux-sparse@vger.kernel.org
Cc: josh@joshtriplett.org, sparse@chrisli.org, tcamuso@redhat.com

Disable all error reporting. Useful when semantic parsing checks are
being done elsewhere or all you need is a tokenizer.

Signed-off-by: Tony Camuso <tcamuso@redhat.com>
---
 lib.c | 27 +++++++++++++++++++++++----
 lib.h |  1 +
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/lib.c b/lib.c
index 8dc5bcf..08f6a6b 100644
--- a/lib.c
+++ b/lib.c
@@ -101,21 +101,26 @@ unsigned int hexval(unsigned int c)
 	return retval;
 }
 
+static int max_warnings = 100;
+static int show_info = 1;
+
 static void do_warn(const char *type, struct position pos, const char * fmt, va_list args)
 {
 	static char buffer[512];
 	const char *name;
 
-	vsprintf(buffer, fmt, args);	
+	if (Wall_off) {
+		max_warnings = 0;
+		return;
+	}
+
+	vsprintf(buffer, fmt, args);
 	name = stream_name(pos.stream);
 		
 	fprintf(stderr, "%s:%d:%d: %s%s\n",
 		name, pos.line, pos.pos, type, buffer);
 }
 
-static int max_warnings = 100;
-static int show_info = 1;
-
 void info(struct position pos, const char * fmt, ...)
 {
 	va_list args;
@@ -130,6 +135,12 @@ void info(struct position pos, const char * fmt, ...)
 static void do_error(struct position pos, const char * fmt, va_list args)
 {
 	static int errors = 0;
+
+	if (Wall_off) {
+		max_warnings = 0;
+		return;
+	}
+
         die_if_error = 1;
 	show_info = 1;
 	/* Shut up warnings after an error */
@@ -241,6 +252,7 @@ int Wtypesign = 0;
 int Wundef = 0;
 int Wuninitialized = 1;
 int Wvla = 1;
+int Wall_off = 0;
 
 int dbg_entry = 0;
 int dbg_dead = 0;
@@ -479,6 +491,13 @@ static char **handle_onoff_switch(char *arg, char **next, const struct warning w
 	char *p = arg + 1;
 	unsigned i;
 
+	if (!strcmp(p, "all_off")) {
+		for (i = 0; i < n; i++)
+			*warnings[i].flag = WARNING_FORCE_OFF;
+		Wall_off = 1;
+		return NULL;
+	}
+
 	if (!strcmp(p, "sparse-all")) {
 		for (i = 0; i < n; i++) {
 			if (*warnings[i].flag != WARNING_FORCE_OFF && warnings[i].flag != &Wsparse_error)
diff --git a/lib.h b/lib.h
index 15b69fa..65e4836 100644
--- a/lib.h
+++ b/lib.h
@@ -127,6 +127,7 @@ extern int Wtypesign;
 extern int Wundef;
 extern int Wuninitialized;
 extern int Wvla;
+extern int Wall_off;
 
 extern int dbg_entry;
 extern int dbg_dead;
-- 
2.4.3

