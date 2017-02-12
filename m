From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 02/14] testsuite: make tests known to fail effectively fail
Date: Mon, 13 Feb 2017 00:28:52 +0100
Message-ID: <20170212232904.49647-3-luc.vanoostenryck@gmail.com>
References: <20170208222805.c77ilwchxpg2vnx4@macpro.local>
 <20170212232904.49647-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34465 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbdBLX3M (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Feb 2017 18:29:12 -0500
Received: by mail-wm0-f66.google.com with SMTP id c85so16481970wmi.1
        for <linux-sparse@vger.kernel.org>; Sun, 12 Feb 2017 15:29:12 -0800 (PST)
In-Reply-To: <20170212232904.49647-1-luc.vanoostenryck@gmail.com>
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
index ced7f9f16..b15cb50e8 100644
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
index 4dd2c3bf0..c5afbb71a 100644
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
2.11.0

