From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/9] option: let handle_simple_switch() handle an array of flags
Date: Fri, 15 Sep 2017 09:32:17 +0200
Message-ID: <20170915073223.7568-4-luc.vanoostenryck@gmail.com>
References: <20170915073223.7568-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32861 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbdIOHcc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:32:32 -0400
Received: by mail-wm0-f68.google.com with SMTP id 187so2008376wmn.0
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:32:32 -0700 (PDT)
In-Reply-To: <20170915073223.7568-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This was used to handle a single flag but we need something
more compact when we need to handle several flags.

So, adapt this helper so that it now takes an array of flags
instead of a single flag.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/lib.c b/lib.c
index 04f9de5a8..992fdb49a 100644
--- a/lib.c
+++ b/lib.c
@@ -483,7 +483,12 @@ char *match_option(char *arg, const char *prefix)
 	return NULL;
 }
 
-static int handle_simple_switch(const char *arg, const char *name, int *flag)
+struct flag {
+	const char *name;
+	int *flag;
+};
+
+static int handle_simple_switch(const char *arg, const struct flag *flags)
 {
 	int val = 1;
 
@@ -493,9 +498,11 @@ static int handle_simple_switch(const char *arg, const char *name, int *flag)
 		val = 0;
 	}
 
-	if (strcmp(arg, name) == 0) {
-		*flag = val;
-		return 1;
+	for (; flags->name; flags++) {
+		if (strcmp(arg, flags->name) == 0) {
+			*flags->flag = val;
+			return 1;
+		}
 	}
 
 	// not handled
@@ -513,10 +520,7 @@ static char **handle_switch_o(char *arg, char **next)
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
@@ -745,6 +749,11 @@ err:
 	die("error: unknown flag \"-fdump-%s\"", arg);
 }
 
+static struct flag fflags[] = {
+	{ "mem-report",			&fmem_report },
+	{ },
+};
+
 static char **handle_switch_f(char *arg, char **next)
 {
 	char *opt;
@@ -758,7 +767,7 @@ static char **handle_switch_f(char *arg, char **next)
 		return handle_switch_fmemcpy_max_count(opt, next);
 
 	/* handle switches w/ arguments above, boolean and only boolean below */
-	if (handle_simple_switch(arg, "mem-report", &fmem_report))
+	if (handle_simple_switch(arg, fflags))
 		return next;
 
 	return next;
-- 
2.14.0

