From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 15/48] rename 'struct warning' to 'struct flag'
Date: Wed, 23 Aug 2017 22:15:21 +0200
Message-ID: <20170823201554.90551-16-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38776 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932443AbdHWUQa (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:16:30 -0400
Received: by mail-wm0-f68.google.com with SMTP id a70so623395wmd.5
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:16:30 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

'struct warning' can be reused for flags other than warnings.

To avoid future confusion, rename it to something more general:
'struct flag' (which in its context, handling of compiler flags,
is clear enough).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib.c b/lib.c
index 73e9a2fe6..f847d1aba 100644
--- a/lib.c
+++ b/lib.c
@@ -506,7 +506,7 @@ static char **handle_switch_o(char *arg, char **next)
 	return next;
 }
 
-static const struct warning {
+static const struct flag {
 	const char *name;
 	int *flag;
 } warnings[] = {
@@ -551,7 +551,7 @@ enum {
 };
 
 
-static char **handle_onoff_switch(char *arg, char **next, const struct warning warnings[], int n)
+static char **handle_onoff_switch(char *arg, char **next, const struct flag warnings[], int n)
 {
 	int flag = WARNING_ON;
 	char *p = arg + 1;
@@ -593,7 +593,7 @@ static char **handle_switch_W(char *arg, char **next)
 	return next;
 }
 
-static struct warning debugs[] = {
+static struct flag debugs[] = {
 	{ "entry", &dbg_entry},
 	{ "dead", &dbg_dead},
 };
@@ -612,7 +612,7 @@ static char **handle_switch_v(char *arg, char **next)
 	return next;
 }
 
-static struct warning dumps[] = {
+static struct flag dumps[] = {
 	{ "D", &dump_macro_defs},
 };
 
@@ -626,7 +626,7 @@ static char **handle_switch_d(char *arg, char **next)
 }
 
 
-static void handle_onoff_switch_finalize(const struct warning warnings[], int n)
+static void handle_onoff_switch_finalize(const struct flag warnings[], int n)
 {
 	unsigned i;
 
-- 
2.14.0

