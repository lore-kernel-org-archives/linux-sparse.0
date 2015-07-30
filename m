From: Tony Camuso <tcamuso@redhat.com>
Subject: [PATCH 3/3] Add NOWARN and NOERR compile conditions
Date: Wed, 29 Jul 2015 20:26:41 -0400
Message-ID: <1438216001-8862-4-git-send-email-tcamuso@redhat.com>
References: <1438216001-8862-1-git-send-email-tcamuso@redhat.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47193 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752544AbbG3A0z (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 29 Jul 2015 20:26:55 -0400
In-Reply-To: <1438216001-8862-1-git-send-email-tcamuso@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org, linux-sparse@vger.kernel.org
Cc: tcamuso@redhat.com

Allows building sparse to avert reporting semantic problems, e.g.
using sparse as a tokenizer to create a graph of KABI symbols and
their dependencies.

Signed-off-by: Tony Camuso <tcamuso@redhat.com>
---
 lib.c   | 21 +++++++++++++++++++++
 parse.c | 12 ++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/lib.c b/lib.c
index 8dc5bcf..cb10bce 100644
--- a/lib.c
+++ b/lib.c
@@ -48,6 +48,13 @@
 int verbose, optimize, optimize_size, preprocessing;
 int die_if_error = 0;
 
+#ifdef NOWARN
+#pragma message "Built with NOWARN"
+#endif
+#ifdef NOERR
+#pragma message "Built with NOERR"
+#endif
+
 #ifndef __GNUC__
 # define __GNUC__ 2
 # define __GNUC_MINOR__ 95
@@ -103,6 +110,9 @@ unsigned int hexval(unsigned int c)
 
 static void do_warn(const char *type, struct position pos, const char * fmt, va_list args)
 {
+#ifdef NOWARN
+	return;
+#else
 	static char buffer[512];
 	const char *name;
 
@@ -111,9 +121,12 @@ static void do_warn(const char *type, struct position pos, const char * fmt, va_
 		
 	fprintf(stderr, "%s:%d:%d: %s%s\n",
 		name, pos.line, pos.pos, type, buffer);
+#endif
 }
 
+#ifndef NOWARN
 static int max_warnings = 100;
+#endif
 static int show_info = 1;
 
 void info(struct position pos, const char * fmt, ...)
@@ -129,6 +142,9 @@ void info(struct position pos, const char * fmt, ...)
 
 static void do_error(struct position pos, const char * fmt, va_list args)
 {
+#ifdef NOERR
+	return;
+#else
 	static int errors = 0;
         die_if_error = 1;
 	show_info = 1;
@@ -145,10 +161,14 @@ static void do_error(struct position pos, const char * fmt, va_list args)
 
 	do_warn("error: ", pos, fmt, args);
 	errors++;
+#endif
 }	
 
 void warning(struct position pos, const char * fmt, ...)
 {
+#ifdef NOWARN
+	return;
+#else
 	va_list args;
 
 	if (Wsparse_error) {
@@ -171,6 +191,7 @@ void warning(struct position pos, const char * fmt, ...)
 	va_start(args, fmt);
 	do_warn("warning: ", pos, fmt, args);
 	va_end(args);
+#endif
 }
 
 void sparse_error(struct position pos, const char * fmt, ...)
diff --git a/parse.c b/parse.c
index 02275d8..f773fe8 100644
--- a/parse.c
+++ b/parse.c
@@ -44,6 +44,13 @@
 #include "expression.h"
 #include "target.h"
 
+#ifdef NOWARN
+#pragma message "Built with NOWARN"
+#endif
+#ifdef NOERR
+#pragma message "Built with NOERR"
+#endif
+
 static struct symbol_list **function_symbol_list;
 struct symbol_list *function_computed_target_list;
 struct statement_list *function_computed_goto_list;
@@ -2746,8 +2753,13 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 
 	/* Just a type declaration? */
 	if (!ident) {
+
+#if defined NOWARN || defined NOERR
+		return token->next;
+#else
 		warning(token->pos, "missing identifier in declaration");
 		return expect(token, ';', "at the end of type declaration");
+#endif
 	}
 
 	/* type define declaration? */
-- 
2.4.3

