From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/9] option: add support for options with 'zero is infinity'
Date: Wed,  8 Nov 2017 11:10:04 +0100
Message-ID: <20171108101008.43804-6-luc.vanoostenryck@gmail.com>
References: <20171108101008.43804-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46036 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751802AbdKHKK0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Nov 2017 05:10:26 -0500
Received: by mail-wr0-f196.google.com with SMTP id y9so1910735wrb.2
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 02:10:25 -0800 (PST)
In-Reply-To: <20171108101008.43804-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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

