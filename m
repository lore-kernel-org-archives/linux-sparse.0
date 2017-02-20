From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 3/5] add test cases for storage of c99 for-loop declarations
Date: Mon, 20 Feb 2017 08:20:50 +0100
Message-ID: <20170220072052.2429-4-luc.vanoostenryck@gmail.com>
References: <1ebf742e-5680-4160-6dc5-808fcfb5cc44@ramsayjones.plus.com>
 <20170220072052.2429-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35884 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbdBTHak (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Feb 2017 02:30:40 -0500
Received: by mail-wr0-f195.google.com with SMTP id z61so10178145wrc.3
        for <linux-sparse@vger.kernel.org>; Sun, 19 Feb 2017 23:30:39 -0800 (PST)
In-Reply-To: <20170220072052.2429-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Variable declared inside a C99 for-loop must have register
or automatic storage; static & extern storage are invalid.
These test cases verify that we warns if it is not the case.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/c99-for-loop-decl.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/validation/c99-for-loop-decl.c b/validation/c99-for-loop-decl.c
index c2ceaab99..b9db8c9c6 100644
--- a/validation/c99-for-loop-decl.c
+++ b/validation/c99-for-loop-decl.c
@@ -9,10 +9,33 @@ static int bad_scope(void)
 	return i;			/* check-should-fail */
 }
 
+static int c99(void)
+{
+	int r = 0;
+
+	for (         int i = 0; i < 10; i++)	/* check-should-pass */
+		r = i;
+	for (    auto int j = 0; j < 10; j++)	/* check-should-pass */
+		r = j;
+	for (register int k = 0; k < 10; k++)	/* check-should-pass */
+		r = k;
+	for (  extern int l = 0; l < 10; l++)	/* check-should-fail */
+		r = l;
+	for (  extern int m;     m < 10; m++)	/* check-should-fail */
+		r = m;
+	for (  static int n = 0; n < 10; n++)	/* check-should-fail */
+		r = n;
+	return r;
+}
+
 /*
  * check-name: C99 for-loop declarations
+ * check-known-to-fail
  *
  * check-error-start
+c99-for-loop-decl.c:22:27: warning: symbol with external linkage has initializer
+c99-for-loop-decl.c:24:27: error: non-local var 'm' in for-loop initializer
+c99-for-loop-decl.c:26:27: error: non-local var 'n' in for-loop initializer
 c99-for-loop-decl.c:9:16: error: undefined identifier 'i'
  * check-error-end
  */
-- 
2.11.0

