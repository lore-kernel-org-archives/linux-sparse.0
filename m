From: Jeff Layton <jlayton@redhat.com>
Subject: [RFC PATCH] bits_in_bool should be 8
Date: Mon, 14 Nov 2016 15:50:43 -0500
Message-ID: <1479156643-28563-1-git-send-email-jlayton@redhat.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34214 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932515AbcKNUup (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 14 Nov 2016 15:50:45 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A0E313F755
        for <linux-sparse@vger.kernel.org>; Mon, 14 Nov 2016 20:50:44 +0000 (UTC)
Received: from tleilax.poochiereds.net (ovpn-116-49.rdu2.redhat.com [10.10.116.49])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id uAEKoiIr029416
        for <linux-sparse@vger.kernel.org>; Mon, 14 Nov 2016 15:50:44 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Given that we're working with byte-addressable machines, each type must
be at least one byte in size or you'd not be able to take a pointer to
it.

Noticed at random when I ran the sample "compile" program in the
sparse source tree vs. a test C program that uses bools. It crashes
without this patch.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 target.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target.c b/target.c
index 17b228ae924c..6a535bc0b2d7 100644
--- a/target.c
+++ b/target.c
@@ -14,7 +14,7 @@ int max_alignment = 16;
 /*
  * Integer data types
  */
-int bits_in_bool = 1;
+int bits_in_bool = 8;
 int bits_in_char = 8;
 int bits_in_short = 16;
 int bits_in_int = 32;
-- 
2.7.4

