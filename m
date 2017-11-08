From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 9/9] option: handle switches by table
Date: Wed,  8 Nov 2017 11:10:08 +0100
Message-ID: <20171108101008.43804-10-luc.vanoostenryck@gmail.com>
References: <20171108101008.43804-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53604 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751798AbdKHKKd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Nov 2017 05:10:33 -0500
Received: by mail-wm0-f65.google.com with SMTP id r196so9562284wmf.2
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 02:10:32 -0800 (PST)
In-Reply-To: <20171108101008.43804-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, the parsing of options is often quite ad-hoc and thus:
- need a lot of code
- is not clear at all

Improve this by making this table driven.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 91 +++++++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 48 insertions(+), 43 deletions(-)

diff --git a/lib.c b/lib.c
index 3c9618a02..a03a94d69 100644
--- a/lib.c
+++ b/lib.c
@@ -483,13 +483,18 @@ const char *match_option(const char *arg, const char *prefix)
 	return NULL;
 }
 
+
+#define OPT_INVERSE	1
 struct flag {
 	const char *name;
 	int *flag;
+	int (*fun)(const char *arg, const char *opt, const struct flag *, int options);
+	unsigned long mask;
 };
 
-static int handle_simple_switch(const char *arg, const struct flag *flags)
+static int handle_switches(const char *ori, const char *opt, const struct flag *flags)
 {
+	const char *arg = opt;
 	int val = 1;
 
 	// Prefixe "no-" mean to turn flag off.
@@ -499,7 +504,22 @@ static int handle_simple_switch(const char *arg, const struct flag *flags)
 	}
 
 	for (; flags->name; flags++) {
-		if (strcmp(arg, flags->name) == 0) {
+		const char *opt = match_option(arg, flags->name);
+		int rc;
+
+		if (!opt)
+			continue;
+
+		if (flags->fun) {
+			int options = 0;
+			if (!val)
+				options |= OPT_INVERSE;
+			if ((rc = flags->fun(ori, opt, flags, options)))
+				return rc;
+		}
+
+		// boolean flag
+		if (opt[0] == '\0' && flags->flag) {
 			*flags->flag = val;
 			return 1;
 		}
@@ -514,21 +534,17 @@ static int handle_simple_switch(const char *arg, const struct flag *flags)
 #define	OPTNUM_UNLIMITED		2
 
 #define OPT_NUMERIC(NAME, TYPE, FUNCTION)	\
-static int opt_##NAME(const char *arg, const char *name, TYPE *ptr, int flag)\
+static int opt_##NAME(const char *arg, const char *opt, TYPE *ptr, int flag)	\
 {									\
-	const char *opt;						\
 	char *end;							\
 	TYPE val;							\
 									\
-	if (!(opt = match_option(arg, name+2)))				\
-		return 0;						\
-	opt++; /* opt's last char is '=' */				\
 	val = FUNCTION(opt, &end, 0);					\
 	if (*end != '\0' || end == opt) {				\
 		if ((flag & OPTNUM_UNLIMITED) && !strcmp(opt, "unlimited"))	\
 			val = ~val;					\
 		else							\
-			die("error: missing argument to \"%s\"", name);	\
+			die("error: wrong argument to \'%s\'", arg);	\
 	}								\
 	if ((flag & OPTNUM_ZERO_IS_INF) && val == 0)			\
 		val = ~val;						\
@@ -728,62 +744,51 @@ static char **handle_switch_O(char *arg, char **next)
 	return next;
 }
 
-static char **handle_switch_ftabstop(const char *arg, char **next)
+static int handle_ftabstop(const char *arg, const char *opt, const struct flag *flag, int options)
 {
-	char *end;
 	unsigned long val;
+	char *end;
 
-	if (*arg == '\0')
-		die("error: missing argument to \"-ftabstop=\"");
+	if (*opt == '\0')
+		die("error: missing argument to \"%s\"", arg);
 
 	/* we silently ignore silly values */
-	val = strtoul(arg, &end, 10);
+	val = strtoul(opt, &end, 10);
 	if (*end == '\0' && 1 <= val && val <= 100)
 		tabstop = val;
 
-	return next;
+	return 1;
 }
 
-static char **handle_switch_fdump(const char *arg, char **next)
+static int handle_fdump_ir(const char *arg, const char *opt, const struct flag *flag, int options)
 {
-	const char *opt;
-
-	if ((opt = match_option(arg, "linearize"))) {
-		if (*opt == '\0')
-			fdump_linearize = 1;
-		else if (!strcmp(opt, "=only"))
-			fdump_linearize = 2;
-		else
-			goto err;
-	}
+	if (*opt == '\0')
+		fdump_linearize = 1;
+	else if (!strcmp(opt, "=only"))
+		fdump_linearize = 2;
+	else
+		die("error: wrong option \"%s\"", arg);
 
-	/* ignore others flags */
-	return next;
+	return 1;
+}
 
-err:
-	die("error: unknown flag \"-fdump-%s\"", arg);
+static int handle_fmemcpy_max_count(const char *arg, const char *opt, const struct flag *flag, int options)
+{
+	opt_ullong(arg, opt, &fmemcpy_max_count, OPTNUM_ZERO_IS_INF|OPTNUM_UNLIMITED);
+	return 1;
 }
 
 static struct flag fflags[] = {
-	{ "mem-report",			&fmem_report },
+	{ "dump-linearize",	NULL,	handle_fdump_ir },
+	{ "mem-report",		&fmem_report },
+	{ "memcpy-max-count=",	NULL,	handle_fmemcpy_max_count },
+	{ "tabstop=",		NULL,	handle_ftabstop },
 	{ },
 };
 
 static char **handle_switch_f(char *arg, char **next)
 {
-	const char *opt;
-	arg++;
-
-	if ((opt = match_option(arg, "tabstop=")))
-		return handle_switch_ftabstop(opt, next);
-	if ((opt = match_option(arg, "dump-")))
-		return handle_switch_fdump(opt, next);
-	if (opt_ullong(arg, "-fmemcpy-max-count=", &fmemcpy_max_count,
-				OPTNUM_ZERO_IS_INF|OPTNUM_UNLIMITED))
-		return next;
