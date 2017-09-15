From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/9] option: add support for options with 'zero is infinity'
Date: Fri, 15 Sep 2017 09:32:19 +0200
Message-ID: <20170915073223.7568-6-luc.vanoostenryck@gmail.com>
References: <20170915073223.7568-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36515 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbdIOHce (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:32:34 -0400
Received: by mail-wm0-f66.google.com with SMTP id r136so1991466wmf.3
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:32:34 -0700 (PDT)
In-Reply-To: <20170915073223.7568-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

For some options with a numerical value, it is sometimes desirable,
to easily specify we want the maximum possible value.

This patch allow to interpret '=0' as meaning the maximum value.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib.c b/lib.c
index 5fda4b029..6352b4e93 100644
--- a/lib.c
+++ b/lib.c
@@ -509,8 +509,11 @@ static int handle_simple_switch(const char *arg, const struct flag *flags)
 	return 0;
 }
 
+
+#define	OPTNUM_ZERO_IS_INF		1
+
 #define OPT_NUMERIC(NAME, TYPE, FUNCTION)	\
-static int opt_##NAME(char *arg, const char *name, TYPE *ptr)	\
+static int opt_##NAME(char *arg, const char *name, TYPE *ptr, int flag)	\
 {									\
 	char *opt;							\
 	char *end;							\
@@ -523,6 +526,8 @@ static int opt_##NAME(char *arg, const char *name, TYPE *ptr)	\
 	if (*end != '\0' || end == opt) {				\
 			die("error: missing argument to \"%s\"", name);	\
 	}								\
+	if ((flag & OPTNUM_ZERO_IS_INF) && val == 0)			\
+		val = ~val;						\
 	*ptr = val;							\
 	return 1;							\
 }
-- 
2.14.0

