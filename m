From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/3] let handle_simple_switch() handle an array of flags
Date: Sat,  3 Jun 2017 09:34:15 +0200
Message-ID: <20170603073416.66808-3-luc.vanoostenryck@gmail.com>
References: <20170603073416.66808-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33859 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbdFCHec (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 3 Jun 2017 03:34:32 -0400
Received: by mail-wm0-f65.google.com with SMTP id d127so21985357wmf.1
        for <linux-sparse@vger.kernel.org>; Sat, 03 Jun 2017 00:34:31 -0700 (PDT)
In-Reply-To: <20170603073416.66808-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This was used to handle a single flag but we need something
more compact when we need to handle several flags.

So, adapt this helper so that it now takes an array of flags
instead of a single flag.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/lib.c b/lib.c
index 569c00e97..a38a6f622 100644
--- a/lib.c
+++ b/lib.c
@@ -458,7 +458,12 @@ static void handle_arch_finalize(void)
 }
 
 
-static int handle_simple_switch(const char *arg, const char *name, int *flag)
+struct flag {
+	const char *name;
+	int *flag;
+};
+
+static int handle_simple_switch(const char *arg, const struct flag *flags, unsigned int n)
 {
 	int val = 1;
 
@@ -468,9 +473,11 @@ static int handle_simple_switch(const char *arg, const char *name, int *flag)
 		val = 0;
 	}
 
-	if (strcmp(arg, name) == 0) {
-		*flag = val;
-		return 1;
+	for (; n--; flags++) {
+		if (strcmp(arg, flags->name) == 0) {
+			*flags->flag = val;
+			return 1;
+		}
 	}
 
 	// not handled
@@ -488,10 +495,7 @@ static char **handle_switch_o(char *arg, char **next)
 	return next;
 }
 
-static const struct flag {
-	const char *name;
-	int *flag;
-} warnings[] = {
+static const struct flag warnings[] = {
 	{ "address", &Waddress },
 	{ "address-space", &Waddress_space },
 	{ "bitwise", &Wbitwise },
@@ -703,19 +707,21 @@ err:
 	die("error: unknown flag \"-fdump-%s\"", arg);
 }
 
+static struct flag fflags[] = {
+	{ "mem-report", &fmem_report },
+};
+
 static char **handle_switch_f(char *arg, char **next)
 {
 	arg++;
 
+	if (handle_simple_switch(arg, fflags, ARRAY_SIZE(fflags)))
+		return next;
+
 	if (!strncmp(arg, "tabstop=", 8))
 		return handle_switch_ftabstop(arg+8, next);
 	if (!strncmp(arg, "dump-", 5))
 		return handle_switch_fdump(arg+5, next);
-
-	/* handle switches w/ arguments above, boolean and only boolean below */
-	if (handle_simple_switch(arg, "mem-report", &fmem_report))
-		return next;
