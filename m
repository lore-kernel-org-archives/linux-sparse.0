From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/5] testsuite: make tests known to fail effectively fail
Date: Wed,  2 Nov 2016 22:45:06 +0100
Message-ID: <20161102214509.36571-3-luc.vanoostenryck@gmail.com>
References: <20161102214509.36571-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34133 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756732AbcKBVsW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 2 Nov 2016 17:48:22 -0400
Received: by mail-wm0-f67.google.com with SMTP id p190so5037898wmp.1
        for <linux-sparse@vger.kernel.org>; Wed, 02 Nov 2016 14:48:22 -0700 (PDT)
In-Reply-To: <20161102214509.36571-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

These tests must fail because some errors which should
be detected are not.
But the test suite lack to see that because those tests
don't have the check-error-start/end section.

Add such a section (with madeup error message) so that the
testsuite now properly see and report the failure.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/badtype1.c   | 4 ++++
 validation/struct-ns2.c | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/validation/badtype1.c b/validation/badtype1.c
index ced7f9f1..b15cb50e 100644
--- a/validation/badtype1.c
+++ b/validation/badtype1.c
@@ -3,4 +3,8 @@ static void foo(enum bar baz);
 /*
  * check-name: enum not in scope
  * check-known-to-fail
+ *
+ * check-error-start
+badtype1.c:1:22: warning: bad scope for 'enum bar'
+ * check-error-end
  */
diff --git a/validation/struct-ns2.c b/validation/struct-ns2.c
index 4dd2c3bf..c5afbb71 100644
--- a/validation/struct-ns2.c
+++ b/validation/struct-ns2.c
@@ -16,4 +16,10 @@ h (void)
 /*
  * check-name: struct not in scope
  * check-known-to-fail
+ *
+ * check-error-start
+struct-ns2.c:2:11: warning: bad scope for 'struct Bar'
+struct-ns2.c:12:14: error: incomplete type/unknown size for 'y'
+struct-ns2.c:13:5: error: using member 'i' in incomplete 'struct Bar'
+ * check-error-end
  */
-- 
2.10.1

