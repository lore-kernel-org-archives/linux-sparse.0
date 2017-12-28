From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] teach sparse about '-fmax-warnings'
Date: Fri, 29 Dec 2017 00:23:57 +0100
Message-ID: <20171228232357.40309-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33498 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752029AbdL1XYQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 28 Dec 2017 18:24:16 -0500
Received: by mail-wm0-f66.google.com with SMTP id g130so3497514wme.0
        for <linux-sparse@vger.kernel.org>; Thu, 28 Dec 2017 15:24:15 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, sparse stops to emit warnings after the 100th.
This is, of course, to avoid to throw lots of warnings if the
source file has lots of problems but sometimes we want to see
all warnings & errors.

It's, for example, useful when checking a new version of
sparse on the kernel since it has a few files with more
than 100 warnings (and so a change will be undetected if
it affects one of the warnings after the 100th).

Let parse the '-fmax-warnings=N' option and limit the
number of warnings accordingly.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c    | 14 +++++++++++---
 lib.h    |  1 +
 sparse.1 |  6 ++++++
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/lib.c b/lib.c
index e4bb639e5..91908aab3 100644
--- a/lib.c
+++ b/lib.c
@@ -115,7 +115,7 @@ static void do_warn(const char *type, struct position pos, const char * fmt, va_
 		name, pos.line, pos.pos, type, buffer);
 }
 
-static int max_warnings = 100;
+unsigned long fmax_warnings = 100;
 static int show_info = 1;
 
 void info(struct position pos, const char * fmt, ...)
@@ -160,12 +160,12 @@ void warning(struct position pos, const char * fmt, ...)
 		return;
 	}
 
-	if (!max_warnings || has_error) {
+	if (!fmax_warnings || has_error) {
 		show_info = 0;
 		return;
 	}
 
-	if (!--max_warnings) {
+	if (!--fmax_warnings) {
 		show_info = 0;
 		fmt = "too many warnings";
 	}
@@ -611,6 +611,7 @@ static int opt_##NAME(const char *arg, const char *opt, TYPE *ptr, int flag)	\
 }
 
 OPT_NUMERIC(ullong, unsigned long long, strtoull)
+OPT_NUMERIC(ulong, unsigned long, strtoul)
 
 
 static char **handle_switch_o(char *arg, char **next)
@@ -869,8 +870,15 @@ static int handle_fmemcpy_max_count(const char *arg, const char *opt, const stru
 	return 1;
 }
 
+static int handle_fmax_warnings(const char *arg, const char *opt, const struct flag *flag, int options)
+{
+	opt_ulong(arg, opt, &fmax_warnings, OPTNUM_UNLIMITED);
+	return 1;
+}
+
 static struct flag fflags[] = {
 	{ "dump-ir",		NULL,	handle_fdump_ir },
+	{ "max-warnings=",	NULL,	handle_fmax_warnings },
 	{ "mem-report",		&fmem_report },
 	{ "memcpy-max-count=",	NULL,	handle_fmemcpy_max_count },
 	{ "tabstop=",		NULL,	handle_ftabstop },
diff --git a/lib.h b/lib.h
index b0f342658..c282d966d 100644
--- a/lib.h
+++ b/lib.h
@@ -167,6 +167,7 @@ extern int dump_macro_defs;
 extern int dbg_entry;
 extern int dbg_dead;
 
+extern unsigned long fmax_warnings;
 extern int fmem_report;
 extern unsigned long fdump_ir;
 extern unsigned long long fmemcpy_max_count;
diff --git a/sparse.1 b/sparse.1
index 5b2bcd9c2..2d3011a1f 100644
--- a/sparse.1
+++ b/sparse.1
@@ -20,6 +20,12 @@ off those warnings, pass the negation of the associated warning option,
 .
 .SH WARNING OPTIONS
 .TP
+.B \-fmax-warnings=COUNT
+Set the maximum number of displayed warnings to COUNT, which should be
+a numerical value or 'unlimited'.
+The default limit is 100.
+.
+.TP
 .B \-Wsparse\-all
 Turn on all sparse warnings, except for those explicitly disabled via
 \fB\-Wno\-something\fR.
-- 
2.15.0

