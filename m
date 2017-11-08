From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 6/9] option: add support for '-<some-option>=unlimited'
Date: Wed,  8 Nov 2017 11:10:05 +0100
Message-ID: <20171108101008.43804-7-luc.vanoostenryck@gmail.com>
References: <20171108101008.43804-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:57343 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751839AbdKHKK1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Nov 2017 05:10:27 -0500
Received: by mail-wm0-f67.google.com with SMTP id z3so9535790wme.5
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 02:10:27 -0800 (PST)
In-Reply-To: <20171108101008.43804-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

For some options with a numerical value, it is sometimes desirable,
when the value is used to limits something, to easily specify we
want to remove any limits.

This patch allow to use 'unlimited' for this by interpreting it as
the maximum value.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib.c b/lib.c
index 6352b4e93..4c210d58f 100644
--- a/lib.c
+++ b/lib.c
@@ -511,6 +511,7 @@ static int handle_simple_switch(const char *arg, const struct flag *flags)
 
 
 #define	OPTNUM_ZERO_IS_INF		1
+#define	OPTNUM_UNLIMITED		2
 
 #define OPT_NUMERIC(NAME, TYPE, FUNCTION)	\
 static int opt_##NAME(char *arg, const char *name, TYPE *ptr, int flag)	\
@@ -524,6 +525,9 @@ static int opt_##NAME(char *arg, const char *name, TYPE *ptr, int flag)	\
 	opt++; /* opt's last char is '=' */				\
 	val = FUNCTION(opt, &end, 0);					\
 	if (*end != '\0' || end == opt) {				\
+		if ((flag & OPTNUM_UNLIMITED) && !strcmp(opt, "unlimited"))	\
+			val = ~val;					\
+		else							\
 			die("error: missing argument to \"%s\"", name);	\
 	}								\
 	if ((flag & OPTNUM_ZERO_IS_INF) && val == 0)			\
-- 
2.14.0

