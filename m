From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/6] teach sparse how to handle -dD flag
Date: Tue,  4 Apr 2017 23:49:52 +0200
Message-ID: <20170404214955.47926-4-luc.vanoostenryck@gmail.com>
References: <20170404214955.47926-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36299 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754617AbdDDVuN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 4 Apr 2017 17:50:13 -0400
Received: by mail-wm0-f67.google.com with SMTP id x124so8042581wmf.3
        for <linux-sparse@vger.kernel.org>; Tue, 04 Apr 2017 14:50:12 -0700 (PDT)
In-Reply-To: <20170404214955.47926-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 16 ++++++++++++++++
 lib.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/lib.c b/lib.c
index 272d2c88a..991ead9bd 100644
--- a/lib.c
+++ b/lib.c
@@ -250,6 +250,8 @@ int Wvla = 1;
 int dbg_entry = 0;
 int dbg_dead = 0;
 
+int dump_macro_defs = 0;
+
 int preprocess_only;
 
 static enum { STANDARD_C89,
@@ -567,6 +569,19 @@ static char **handle_switch_v(char *arg, char **next)
 	return next;
 }
 
+static struct warning dumps[] = {
+	{ "D", &dump_macro_defs},
+};
+
+static char **handle_switch_d(char *arg, char **next)
+{
+	char ** ret = handle_onoff_switch(arg, next, dumps, ARRAY_SIZE(dumps));
+	if (ret)
+		return ret;
+
+	return next;
+}
+
 
 static void handle_onoff_switch_finalize(const struct warning warnings[], int n)
 {
@@ -800,6 +815,7 @@ static char **handle_switch(char *arg, char **next)
 	switch (*arg) {
 	case 'a': return handle_switch_a(arg, next);
 	case 'D': return handle_switch_D(arg, next);
+	case 'd': return handle_switch_d(arg, next);
 	case 'E': return handle_switch_E(arg, next);
 	case 'f': return handle_switch_f(arg, next);
 	case 'g': return handle_switch_g(arg, next);
diff --git a/lib.h b/lib.h
index f2df4aa1d..1b21de0c2 100644
--- a/lib.h
+++ b/lib.h
@@ -137,6 +137,8 @@ extern int Wvla;
 extern int dbg_entry;
 extern int dbg_dead;
 
+extern int dump_macro_defs;
+
 extern int arch_m64;
 
 extern void declare_builtin_functions(void);
-- 
2.12.0

