From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 16/48] let handle_simple_switch() handle an array of flags
Date: Wed, 23 Aug 2017 22:15:22 +0200
Message-ID: <20170823201554.90551-17-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35911 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932443AbdHWUQb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:16:31 -0400
Received: by mail-wm0-f66.google.com with SMTP id f127so640254wmf.3
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:16:31 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
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
 lib.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/lib.c b/lib.c
index f847d1aba..c46798d0f 100644
--- a/lib.c
+++ b/lib.c
@@ -476,7 +476,12 @@ static void handle_arch_finalize(void)
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
 
@@ -486,9 +491,11 @@ static int handle_simple_switch(const char *arg, const char *name, int *flag)
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
@@ -506,10 +513,7 @@ static char **handle_switch_o(char *arg, char **next)
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
@@ -737,10 +741,18 @@ err:
 	die("error: unknown flag \"-fdump-%s\"", arg);
 }
 
+static struct flag fflags[] = {
+	{ "mem-report",			&fmem_report },
+	{ },
+};
+
 static char **handle_switch_f(char *arg, char **next)
 {
 	arg++;
 
+	if (handle_simple_switch(arg, fflags))
+		return next;
+
 	if (!strncmp(arg, "tabstop=", 8))
 		return handle_switch_ftabstop(arg+8, next);
 	if (!strncmp(arg, "dump-", 5))
@@ -748,10 +760,6 @@ static char **handle_switch_f(char *arg, char **next)
 	if (!strncmp(arg, "memcpy-max-count=", 17))
 		return handle_switch_fmemcpy_max_count(arg+17, next);
 
-	/* handle switches w/ arguments above, boolean and only boolean below */
-	if (handle_simple_switch(arg, "mem-report", &fmem_report))
-		return next;
