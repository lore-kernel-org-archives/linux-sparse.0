From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/9] option: add helper to parse/match command line options
Date: Wed,  8 Nov 2017 11:10:00 +0100
Message-ID: <20171108101008.43804-2-luc.vanoostenryck@gmail.com>
References: <20171108101008.43804-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:49843 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751749AbdKHKKV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Nov 2017 05:10:21 -0500
Received: by mail-wr0-f193.google.com with SMTP id o88so1888213wrb.6
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 02:10:20 -0800 (PST)
In-Reply-To: <20171108101008.43804-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this helper is:
- to avoid to have to hardoce the length od the substring
- separate the suffix/option part from the whole argument
  which help for error message.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/lib.c b/lib.c
index 73e9a2fe6..351da6f48 100644
--- a/lib.c
+++ b/lib.c
@@ -475,6 +475,13 @@ static void handle_arch_finalize(void)
 	handle_arch_msize_long_finalize();
 }
 
+char *match_option(char *arg, const char *prefix)
+{
+	unsigned int n = strlen(prefix);
+	if (strncmp(arg, prefix, n) == 0)
+		return arg + n;
+	return NULL;
+}
 
 static int handle_simple_switch(const char *arg, const char *name, int *flag)
 {
@@ -720,11 +727,12 @@ static char **handle_switch_ftabstop(char *arg, char **next)
 
 static char **handle_switch_fdump(char *arg, char **next)
 {
-	if (!strncmp(arg, "linearize", 9)) {
-		arg += 9;
-		if (*arg == '\0')
+	const char *opt;
+
+	if ((opt = match_option(arg, "linearize"))) {
+		if (*opt == '\0')
 			fdump_linearize = 1;
-		else if (!strcmp(arg, "=only"))
+		else if (!strcmp(opt, "=only"))
 			fdump_linearize = 2;
 		else
 			goto err;
@@ -739,14 +747,15 @@ err:
 
 static char **handle_switch_f(char *arg, char **next)
 {
+	char *opt;
 	arg++;
 
-	if (!strncmp(arg, "tabstop=", 8))
-		return handle_switch_ftabstop(arg+8, next);
-	if (!strncmp(arg, "dump-", 5))
-		return handle_switch_fdump(arg+5, next);
-	if (!strncmp(arg, "memcpy-max-count=", 17))
-		return handle_switch_fmemcpy_max_count(arg+17, next);
+	if ((opt = match_option(arg, "tabstop=")))
+		return handle_switch_ftabstop(opt, next);
+	if ((opt = match_option(arg, "dump-")))
+		return handle_switch_fdump(opt, next);
+	if ((opt = match_option(arg, "memcpy-max-count=")))
+		return handle_switch_fmemcpy_max_count(opt, next);
 
 	/* handle switches w/ arguments above, boolean and only boolean below */
 	if (handle_simple_switch(arg, "mem-report", &fmem_report))
@@ -773,10 +782,7 @@ static char **handle_switch_a(char *arg, char **next)
 
 static char **handle_switch_s(char *arg, char **next)
 {
-	if (!strncmp (arg, "std=", 4))
-	{
-		arg += 4;
