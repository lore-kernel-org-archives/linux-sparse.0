From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/9] option: add helper to parse/match command line options
Date: Fri, 15 Sep 2017 09:32:15 +0200
Message-ID: <20170915073223.7568-2-luc.vanoostenryck@gmail.com>
References: <20170915073223.7568-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35505 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbdIOHca (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:32:30 -0400
Received: by mail-wm0-f66.google.com with SMTP id e64so2003722wmi.2
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:32:30 -0700 (PDT)
In-Reply-To: <20170915073223.7568-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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
