From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 7/9] option: use OPTION_NUMERIC() for handle_switch_fmemcpy_max_count()
Date: Wed,  8 Nov 2017 11:10:06 +0100
Message-ID: <20171108101008.43804-8-luc.vanoostenryck@gmail.com>
References: <20171108101008.43804-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:48560 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751738AbdKHKK2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Nov 2017 05:10:28 -0500
Received: by mail-wr0-f194.google.com with SMTP id 15so1897523wrb.5
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 02:10:28 -0800 (PST)
In-Reply-To: <20171108101008.43804-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c    | 22 +++++-----------------
 sparse.1 |  2 +-
 2 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/lib.c b/lib.c
index 4c210d58f..95601b002 100644
--- a/lib.c
+++ b/lib.c
@@ -536,6 +536,8 @@ static int opt_##NAME(char *arg, const char *name, TYPE *ptr, int flag)	\
 	return 1;							\
 }
 
+OPT_NUMERIC(ullong, unsigned long long, strtoull)
+
 
 static char **handle_switch_o(char *arg, char **next)
 {
@@ -726,21 +728,6 @@ static char **handle_switch_O(char *arg, char **next)
 	return next;
 }
 
-static char **handle_switch_fmemcpy_max_count(char *arg, char **next)
-{
-	unsigned long long val;
-	char *end;
-
-	val = strtoull(arg, &end, 0);
-	if (*end != '\0' || end == arg)
-		die("error: missing argument to \"-fmemcpy-max-count=\"");
-
-	if (val == 0)
-		val = ~0ULL;
-	fmemcpy_max_count = val;
-	return next;
-}
-
 static char **handle_switch_ftabstop(char *arg, char **next)
 {
 	char *end;
@@ -791,8 +778,9 @@ static char **handle_switch_f(char *arg, char **next)
 		return handle_switch_ftabstop(opt, next);
 	if ((opt = match_option(arg, "dump-")))
 		return handle_switch_fdump(opt, next);
-	if ((opt = match_option(arg, "memcpy-max-count=")))
-		return handle_switch_fmemcpy_max_count(opt, next);
+	if (opt_ullong(arg, "-fmemcpy-max-count=", &fmemcpy_max_count,
+				OPTNUM_ZERO_IS_INF|OPTNUM_UNLIMITED))
+		return next;
 
 	/* handle switches w/ arguments above, boolean and only boolean below */
 	if (handle_simple_switch(arg, fflags))
diff --git a/sparse.1 b/sparse.1
index b79c58767..bec8d6d73 100644
--- a/sparse.1
+++ b/sparse.1
@@ -369,7 +369,7 @@ Report some statistics about memory allocation used by the tool.
 .TP
 .B \-fmemcpy-max-count=COUNT
 Set the limit for the warnings given by \fB-Wmemcpy-max-count\fR.
-A COUNT of 0, useless in itself, will effectively disable the warning.
+A COUNT of 'unlimited' or '0' will effectively disable the warning.
 The default limit is 100000.
 .
 .TP
-- 
2.14.0

