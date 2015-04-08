From: Michael Stefaniuc <mstefani@redhat.com>
Subject: [PATCH] Add tests for the builtin INF and nan() functions.
Date: Wed, 8 Apr 2015 23:48:39 +0200
Message-ID: <20150408214839.GA24502@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41850 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753363AbbDHVsl (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 8 Apr 2015 17:48:41 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id EEDCD8E686
	for <linux-sparse@vger.kernel.org>; Wed,  8 Apr 2015 21:48:40 +0000 (UTC)
Received: from brasov.str.redhat.com (brasov.str.redhat.com [10.33.193.1])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t38Lmeds014245
	for <linux-sparse@vger.kernel.org>; Wed, 8 Apr 2015 17:48:40 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Test file cross checked with
gcc -c -Wall -Werror -Wno-unused-variable validation/builtin_inf.c

Signed-off-by: Michael Stefaniuc <mstefani@redhat.com>
---
Sorry for the delay.


 validation/builtin_inf.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 validation/builtin_inf.c

diff --git a/validation/builtin_inf.c b/validation/builtin_inf.c
new file mode 100644
index 0000000..48546e4
--- /dev/null
+++ b/validation/builtin_inf.c
@@ -0,0 +1,13 @@
+static double d = __builtin_huge_val();
+static float f = __builtin_huge_valf();
+static long double l = __builtin_huge_vall();
+static double di = __builtin_inf();
+static float fi = __builtin_inff();
+static long double li = __builtin_infl();
+static double dn = __builtin_nan("");
+static float fn = __builtin_nanf("");
+static long double ln = __builtin_nanl("");
+
+/*
+ * check-name: __builtin INFINITY / nan()
+ */
-- 
2.1.0
