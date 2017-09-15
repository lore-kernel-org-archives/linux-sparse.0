From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/9] option: extract OPTION_NUMERIC() from handle_switch_fmemcpy_max_count()
Date: Fri, 15 Sep 2017 09:32:18 +0200
Message-ID: <20170915073223.7568-5-luc.vanoostenryck@gmail.com>
References: <20170915073223.7568-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36950 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751415AbdIOHcd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:32:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id f4so1990107wmh.4
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:32:33 -0700 (PDT)
In-Reply-To: <20170915073223.7568-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/lib.c b/lib.c
index 992fdb49a..5fda4b029 100644
--- a/lib.c
+++ b/lib.c
@@ -509,6 +509,25 @@ static int handle_simple_switch(const char *arg, const struct flag *flags)
 	return 0;
 }
 
+#define OPT_NUMERIC(NAME, TYPE, FUNCTION)	\
+static int opt_##NAME(char *arg, const char *name, TYPE *ptr)	\
+{									\
+	char *opt;							\
+	char *end;							\
+	TYPE val;							\
+									\
+	if (!(opt = match_option(arg, name+2)))				\
+		return 0;						\
+	opt++; /* opt's last char is '=' */				\
+	val = FUNCTION(opt, &end, 0);					\
+	if (*end != '\0' || end == opt) {				\
+			die("error: missing argument to \"%s\"", name);	\
+	}								\
+	*ptr = val;							\
+	return 1;							\
+}
+
+
 static char **handle_switch_o(char *arg, char **next)
 {
 	if (!strcmp (arg, "o")) {       // "-o foo"
-- 
2.14.0

