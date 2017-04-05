From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/9] finer control over error vs. warnings
Date: Wed,  5 Apr 2017 23:09:21 +0200
Message-ID: <20170405210927.27948-4-luc.vanoostenryck@gmail.com>
References: <20170405210927.27948-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36613 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934250AbdDEVJn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 5 Apr 2017 17:09:43 -0400
Received: by mail-wr0-f194.google.com with SMTP id o21so946581wrb.3
        for <linux-sparse@vger.kernel.org>; Wed, 05 Apr 2017 14:09:42 -0700 (PDT)
In-Reply-To: <20170405210927.27948-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Until now once an error is emitted, warnings are no more emitted,
only others errors are.

While it make some sense as once an error is encountered, things
can be left in an incoherent state and could cause lots of useless
warninsg because of this incoherence.
However, it's also quite annoying as even unrelated warnings are
so silenced.

Fix this by:
- use a specific flag for this: 'has_error'
- make the distinction between the current phase and some previous
  phases (but for now we only care about parsing vs evaluation)
- if an error have been emitted in a previous phase (at parsing)
  warning are suppressed for the current phase and all future
  phases
- if an error is emitted in the current phase (evaluation) the
  flag is reset after each functions/symbols

So, for example, a type error in function a() won't suppress
warnings for function b(), while a parsing error still inhibit
all further warnings.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 1 +
 lib.c      | 7 +++++--
 lib.h      | 4 ++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 47eeaef2e..2cc4b1eeb 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3214,6 +3214,7 @@ void evaluate_symbol_list(struct symbol_list *list)
 	struct symbol *sym;
 
 	FOR_EACH_PTR(list, sym) {
+		has_error &= ~ERROR_CURR_PHASE;
 		evaluate_symbol(sym);
 		check_duplicates(sym);
 	} END_FOR_EACH_PTR(sym);
diff --git a/lib.c b/lib.c
index 272d2c88a..d6c893e71 100644
--- a/lib.c
+++ b/lib.c
@@ -47,6 +47,7 @@
 
 int verbose, optimize, optimize_size, preprocessing;
 int die_if_error = 0;
+int has_error = 0;
 
 #ifndef __GNUC__
 # define __GNUC__ 2
@@ -133,7 +134,7 @@ static void do_error(struct position pos, const char * fmt, va_list args)
         die_if_error = 1;
 	show_info = 1;
 	/* Shut up warnings after an error */
-	max_warnings = 0;
+	has_error |= ERROR_CURR_PHASE;
 	if (errors > 100) {
 		static int once = 0;
 		show_info = 0;
@@ -158,7 +159,7 @@ void warning(struct position pos, const char * fmt, ...)
 		return;
 	}
 
-	if (!max_warnings) {
+	if (!max_warnings || has_error) {
 		show_info = 0;
 		return;
 	}
@@ -1208,6 +1209,8 @@ struct symbol_list * sparse(char *filename)
 {
 	struct symbol_list *res = __sparse(filename);
 
+	if (has_error & ERROR_CURR_PHASE)
+		has_error = ERROR_PREV_PHASE;
 	/* Evaluate the complete symbol list */
 	evaluate_symbol_list(res);
 
diff --git a/lib.h b/lib.h
index 134e56040..7ed889c60 100644
--- a/lib.h
+++ b/lib.h
@@ -97,6 +97,10 @@ extern void sparse_error(struct position, const char *, ...) FORMAT_ATTR(2);
 extern void error_die(struct position, const char *, ...) FORMAT_ATTR(2) NORETURN_ATTR;
 extern void expression_error(struct expression *, const char *, ...) FORMAT_ATTR(2);
 
+#define	ERROR_CURR_PHASE	(1 << 0)
+#define	ERROR_PREV_PHASE	(1 << 1)
+extern int has_error;
+
 extern void add_pre_buffer(const char *fmt, ...) FORMAT_ATTR(1);
 
 extern int preprocess_only;
-- 
2.12.0

