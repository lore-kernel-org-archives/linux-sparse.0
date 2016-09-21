From: Lance Richardson <lrichard@redhat.com>
Subject: [PATCH] sparse: ignore __assume_aligned__ attribute
Date: Wed, 21 Sep 2016 10:44:48 -0400
Message-ID: <1474469088-25429-1-git-send-email-lrichard@redhat.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41546 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932639AbcIUOot (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 21 Sep 2016 10:44:49 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3DE0E4E4E6
        for <linux-sparse@vger.kernel.org>; Wed, 21 Sep 2016 14:44:49 +0000 (UTC)
Received: from thinkcentre.nc.rr.com (vpn-54-57.rdu2.redhat.com [10.10.54.57])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u8LEim0d002519
        for <linux-sparse@vger.kernel.org>; Wed, 21 Sep 2016 10:44:48 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

The __assume_aligned__ attribute can be safely ignored, add it
to the list of ignored attributes.

Signed-off-by: Lance Richardson <lrichard@redhat.com>
---
 parse.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/parse.c b/parse.c
index 98a31dc..2a1b57e 100644
--- a/parse.c
+++ b/parse.c
@@ -526,6 +526,8 @@ const char *ignored_attributes[] = {
 	"__always_inline__",
 	"artificial",
 	"__artificial__",
+	"assume_aligned",
+	"__assume_aligned__",
 	"bounded",
 	"__bounded__",
 	"cdecl",
-- 
2.5.5

