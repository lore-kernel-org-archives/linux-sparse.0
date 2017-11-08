From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 8/9] option: constify match_option()
Date: Wed,  8 Nov 2017 11:10:07 +0100
Message-ID: <20171108101008.43804-9-luc.vanoostenryck@gmail.com>
References: <20171108101008.43804-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53591 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbdKHKKa (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Nov 2017 05:10:30 -0500
Received: by mail-wm0-f65.google.com with SMTP id r196so9561991wmf.2
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 02:10:30 -0800 (PST)
In-Reply-To: <20171108101008.43804-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Until now, match_option() needed a non-const argment and returned
a non-const result. Since it is no more needed, let's use const.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib.c b/lib.c
index 95601b002..3c9618a02 100644
--- a/lib.c
+++ b/lib.c
@@ -475,7 +475,7 @@ static void handle_arch_finalize(void)
 	handle_arch_msize_long_finalize();
 }
 
-char *match_option(char *arg, const char *prefix)
+const char *match_option(const char *arg, const char *prefix)
 {
 	unsigned int n = strlen(prefix);
 	if (strncmp(arg, prefix, n) == 0)
@@ -514,9 +514,9 @@ static int handle_simple_switch(const char *arg, const struct flag *flags)
 #define	OPTNUM_UNLIMITED		2
 
 #define OPT_NUMERIC(NAME, TYPE, FUNCTION)	\
-static int opt_##NAME(char *arg, const char *name, TYPE *ptr, int flag)	\
+static int opt_##NAME(const char *arg, const char *name, TYPE *ptr, int flag)\
 {									\
-	char *opt;							\
+	const char *opt;						\
 	char *end;							\
 	TYPE val;							\
 									\
@@ -728,7 +728,7 @@ static char **handle_switch_O(char *arg, char **next)
 	return next;
 }
 
-static char **handle_switch_ftabstop(char *arg, char **next)
+static char **handle_switch_ftabstop(const char *arg, char **next)
 {
 	char *end;
 	unsigned long val;
@@ -744,7 +744,7 @@ static char **handle_switch_ftabstop(char *arg, char **next)
 	return next;
 }
 
-static char **handle_switch_fdump(char *arg, char **next)
+static char **handle_switch_fdump(const char *arg, char **next)
 {
 	const char *opt;
 
@@ -771,7 +771,7 @@ static struct flag fflags[] = {
 
 static char **handle_switch_f(char *arg, char **next)
 {
-	char *opt;
+	const char *opt;
 	arg++;
 
 	if ((opt = match_option(arg, "tabstop=")))
@@ -805,7 +805,7 @@ static char **handle_switch_a(char *arg, char **next)
 	return next;
 }
 
-static char **handle_switch_s(char *arg, char **next)
+static char **handle_switch_s(const char *arg, char **next)
 {
 	if ((arg = match_option(arg, "std="))) {
 		if (!strcmp (arg, "c89") ||
-- 
2.14.0

