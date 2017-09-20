From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: [PATCH v2] cgcc: teach cgcc about GNU/kFreeBSD
Date: Wed, 20 Sep 2017 17:10:49 +0200
Message-ID: <20170920151049.19939-1-uwe@kleine-koenig.org>
References: <20170914200327.15129-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:51670 "EHLO
        arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751507AbdITPKx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 20 Sep 2017 11:10:53 -0400
In-Reply-To: <20170914200327.15129-1-uwe@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
Changes in v2:
 - add a Sob line
 - add a missing ;

 cgcc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/cgcc b/cgcc
index a8d7b4f217fe..95d70efc11c5 100755
--- a/cgcc
+++ b/cgcc
@@ -235,6 +235,9 @@ sub add_specs {
     } elsif ($spec eq 'linux') {
 	return &add_specs ('unix') .
 	    ' -D__linux__=1 -D__linux=1 -Dlinux=linux';
+    } elsif ($spec eq 'gnu/kfreebsd') {
+	return &add_specs ('unix') .
+	    ' -D__FreeBSD_kernel__=1';
     } elsif ($spec eq 'openbsd') {
 	return &add_specs ('unix') .
 	    ' -D__OpenBSD__=1';
-- 
2.14.1

