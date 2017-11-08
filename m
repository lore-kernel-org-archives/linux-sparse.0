From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/9] option: rename 'struct warning' to 'struct flag'
Date: Wed,  8 Nov 2017 11:10:01 +0100
Message-ID: <20171108101008.43804-3-luc.vanoostenryck@gmail.com>
References: <20171108101008.43804-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:46546 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbdKHKKX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Nov 2017 05:10:23 -0500
Received: by mail-wm0-f67.google.com with SMTP id r68so9277055wmr.1
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 02:10:22 -0800 (PST)
In-Reply-To: <20171108101008.43804-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

'struct warning' can be reused for flags other than warnings.

To avoid future confusion, rename it to something more general:
'struct flag' (which in its context, handling of compiler flags,
is clear enough).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib.c b/lib.c
index 351da6f48..04f9de5a8 100644
--- a/lib.c
+++ b/lib.c
@@ -513,7 +513,7 @@ static char **handle_switch_o(char *arg, char **next)
 	return next;
 }
 
-static const struct warning {
+static const struct flag {
 	const char *name;
 	int *flag;
 } warnings[] = {
@@ -558,7 +558,7 @@ enum {
 };
 
 
-static char **handle_onoff_switch(char *arg, char **next, const struct warning warnings[], int n)
+static char **handle_onoff_switch(char *arg, char **next, const struct flag warnings[], int n)
 {
 	int flag = WARNING_ON;
 	char *p = arg + 1;
@@ -600,7 +600,7 @@ static char **handle_switch_W(char *arg, char **next)
 	return next;
 }
 
-static struct warning debugs[] = {
+static struct flag debugs[] = {
 	{ "entry", &dbg_entry},
 	{ "dead", &dbg_dead},
 };
@@ -619,7 +619,7 @@ static char **handle_switch_v(char *arg, char **next)
 	return next;
 }
 
-static struct warning dumps[] = {
+static struct flag dumps[] = {
 	{ "D", &dump_macro_defs},
 };
 
@@ -633,7 +633,7 @@ static char **handle_switch_d(char *arg, char **next)
 }
 
 
-static void handle_onoff_switch_finalize(const struct warning warnings[], int n)
+static void handle_onoff_switch_finalize(const struct flag warnings[], int n)
 {
 	unsigned i;
 
-- 
2.14.0

