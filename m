From: Tony Camuso <tcamuso@redhat.com>
Subject: [PATCH 3/3 V3] Add Wall_off switch to disable errors and warnings
Date: Fri, 31 Jul 2015 15:27:59 -0400
Message-ID: <1438370879-21792-1-git-send-email-tcamuso@redhat.com>
References: <1438216001-8862-4-git-send-email-tcamuso@redhat.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49204 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750827AbbGaT2A (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 31 Jul 2015 15:28:00 -0400
In-Reply-To: <1438216001-8862-4-git-send-email-tcamuso@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: josh@joshtriplett.org, linux-sparse@vger.kernel.org
Cc: tcamuso@redhat.com, sparse@chrisli.org

For using sparse as a tokenizer only. While it still parses semantics,
it doesn't report any semantic errors, which is undesirable for some
tasks like locating the KABI associations in a kernel source file.

Signed-off-by: Tony Camuso <tcamuso@redhat.com>
---
 lib.c   | 20 +++++++++++++++++++-
 lib.h   |  1 +
 parse.c |  4 ++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/lib.c b/lib.c
index 8dc5bcf..ef182ae 100644
--- a/lib.c
+++ b/lib.c
@@ -103,6 +103,9 @@ unsigned int hexval(unsigned int c)
 
 static void do_warn(const char *type, struct position pos, const char * fmt, va_list args)
 {
+	if (Wall_off)
+		return;
+
 	static char buffer[512];
 	const char *name;
 
@@ -120,7 +123,7 @@ void info(struct position pos, const char * fmt, ...)
 {
 	va_list args;
 
-	if (!show_info)
+	if (!show_info || Wall_off)
 		return;
 	va_start(args, fmt);
 	do_warn("", pos, fmt, args);
@@ -129,6 +132,9 @@ void info(struct position pos, const char * fmt, ...)
 
 static void do_error(struct position pos, const char * fmt, va_list args)
 {
+	if (Wall_off)
+		return;
+
 	static int errors = 0;
         die_if_error = 1;
 	show_info = 1;
@@ -151,6 +157,9 @@ void warning(struct position pos, const char * fmt, ...)
 {
 	va_list args;
 
+	if (Wall_off)
+		return;
+
 	if (Wsparse_error) {
 		va_start(args, fmt);
 		do_error(pos, fmt, args);
@@ -241,6 +250,7 @@ int Wtypesign = 0;
 int Wundef = 0;
 int Wuninitialized = 1;
 int Wvla = 1;
+int Wall_off = 0;
 
 int dbg_entry = 0;
 int dbg_dead = 0;
@@ -464,6 +474,7 @@ static const struct warning {
 	{ "undef", &Wundef },
 	{ "uninitialized", &Wuninitialized },
 	{ "vla", &Wvla },
+	{ "all_off", &Wall_off },
 };
 
 enum {
@@ -479,6 +490,13 @@ static char **handle_onoff_switch(char *arg, char **next, const struct warning w
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
diff --git a/parse.c b/parse.c
index 02275d8..d70dffb 100644
--- a/parse.c
+++ b/parse.c
@@ -2746,6 +2746,10 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 
 	/* Just a type declaration? */
 	if (!ident) {
+
+		if (Wall_off)
+			return token->next;
+
 		warning(token->pos, "missing identifier in declaration");
 		return expect(token, ';', "at the end of type declaration");
 	}
-- 
2.4.3

