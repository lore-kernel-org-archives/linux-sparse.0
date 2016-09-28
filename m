From: Lance Richardson <lrichard@redhat.com>
Subject: [PATCH v2] sparse: ignore __assume_aligned__ attribute
Date: Wed, 28 Sep 2016 14:41:05 -0400
Message-ID: <1475088065-31142-1-git-send-email-lrichard@redhat.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51432 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754017AbcI1SlH (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 28 Sep 2016 14:41:07 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E5C458E684
        for <linux-sparse@vger.kernel.org>; Wed, 28 Sep 2016 18:41:06 +0000 (UTC)
Received: from thinkcentre.nc.rr.com (vpn-53-113.rdu2.redhat.com [10.10.53.113])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u8SIf6lv029245
        for <linux-sparse@vger.kernel.org>; Wed, 28 Sep 2016 14:41:06 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

The __assume_aligned__ attribute can be safely ignored, add it
to the list of ignored attributes and add a test to verify that
this attribute is ignored.

Signed-off-by: Lance Richardson <lrichard@redhat.com>
---
v2: Added test case.

 parse.c                   | 2 ++
 validation/attr_aligned.c | 5 +++++
 2 files changed, 7 insertions(+)
 create mode 100644 validation/attr_aligned.c

diff --git a/parse.c b/parse.c
index 4e38f3f..634f109 100644
--- a/parse.c
+++ b/parse.c
@@ -510,6 +510,8 @@ const char *ignored_attributes[] = {
 	"__always_inline__",
 	"artificial",
 	"__artificial__",
+	"assume_aligned",
+	"__assume_aligned__",
 	"bounded",
 	"__bounded__",
 	"cdecl",
diff --git a/validation/attr_aligned.c b/validation/attr_aligned.c
new file mode 100644
index 0000000..af2c363
--- /dev/null
+++ b/validation/attr_aligned.c
@@ -0,0 +1,5 @@
+void *foo(void) __attribute__((__assume_aligned__(4096)));
+/*
+ * check-name: attribute assume_aligned
+ */
+
-- 
2.5.5

