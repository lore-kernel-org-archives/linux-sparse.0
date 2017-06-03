From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] rename 'struct warning' to 'struct flag'
Date: Sat,  3 Jun 2017 09:34:14 +0200
Message-ID: <20170603073416.66808-2-luc.vanoostenryck@gmail.com>
References: <20170603073416.66808-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33845 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbdFCHeb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 3 Jun 2017 03:34:31 -0400
Received: by mail-wm0-f65.google.com with SMTP id d127so21985291wmf.1
        for <linux-sparse@vger.kernel.org>; Sat, 03 Jun 2017 00:34:30 -0700 (PDT)
In-Reply-To: <20170603073416.66808-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

'struct warning' can be reused for flags other than warnings.

To avoid future confusion, rename it to something more general:
'struct flag' (which in its context, handling of compiler flags,
is clear enough).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib.c b/lib.c
index e1e6a1cbf..569c00e97 100644
--- a/lib.c
+++ b/lib.c
@@ -488,7 +488,7 @@ static char **handle_switch_o(char *arg, char **next)
 	return next;
 }
 
-static const struct warning {
+static const struct flag {
 	const char *name;
 	int *flag;
 } warnings[] = {
@@ -532,7 +532,7 @@ enum {
 };
 
 
-static char **handle_onoff_switch(char *arg, char **next, const struct warning warnings[], int n)
+static char **handle_onoff_switch(char *arg, char **next, const struct flag warnings[], int n)
 {
 	int flag = WARNING_ON;
 	char *p = arg + 1;
@@ -574,7 +574,7 @@ static char **handle_switch_W(char *arg, char **next)
 	return next;
 }
 
-static struct warning debugs[] = {
+static struct flag debugs[] = {
 	{ "entry", &dbg_entry},
 	{ "dead", &dbg_dead},
 };
@@ -593,7 +593,7 @@ static char **handle_switch_v(char *arg, char **next)
 	return next;
 }
 
-static struct warning dumps[] = {
+static struct flag dumps[] = {
 	{ "D", &dump_macro_defs},
 };
 
@@ -607,7 +607,7 @@ static char **handle_switch_d(char *arg, char **next)
 }
 
 
-static void handle_onoff_switch_finalize(const struct warning warnings[], int n)
+static void handle_onoff_switch_finalize(const struct flag warnings[], int n)
 {
 	unsigned i;
 
-- 
2.13.0

