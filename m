From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: [PATCH] cgcc: teach cgcc about GNU/kFreeBSD
Date: Thu, 14 Sep 2017 22:03:27 +0200
Message-ID: <20170914200327.15129-1-uwe@kleine-koenig.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:48635 "EHLO
        arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751277AbdINUDb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 14 Sep 2017 16:03:31 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

---
 cgcc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/cgcc b/cgcc
index a8d7b4f217fe..0ab54f943578 100755
--- a/cgcc
+++ b/cgcc
@@ -235,6 +235,9 @@ sub add_specs {
     } elsif ($spec eq 'linux') {
 	return &add_specs ('unix') .
 	    ' -D__linux__=1 -D__linux=1 -Dlinux=linux';
+    } elsif ($spec eq 'gnu/kfreebsd') {
+	return &add_specs ('unix') .
+	    ' -D__FreeBSD_kernel__=1'
     } elsif ($spec eq 'openbsd') {
 	return &add_specs ('unix') .
 	    ' -D__OpenBSD__=1';
-- 
2.14.1

