From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 09/28] testsuite: saner handling of 'must_fail'
Date: Fri, 15 Sep 2017 09:13:39 +0200
Message-ID: <20170915071358.7312-10-luc.vanoostenryck@gmail.com>
References: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33132 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbdIOHQP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:16:15 -0400
Received: by mail-wm0-f65.google.com with SMTP id 187so1975471wmn.0
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:16:15 -0700 (PDT)
In-Reply-To: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index 256d31550..5dfe9e7f3 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -327,17 +327,19 @@ do_test()
 		fi
 	fi
 
-	[ "$test_failed" -eq "$must_fail" ] || failed=1
