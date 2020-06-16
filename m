From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] testsuite: be less paranoid with timeout
Date: Tue, 16 Jun 2020 23:11:06 +0200
Message-ID: <20200616211106.78251-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgFPVLK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 16 Jun 2020 17:11:10 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A238FC061573
        for <linux-sparse@vger.kernel.org>; Tue, 16 Jun 2020 14:11:10 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id n24so23292545ejd.0
        for <linux-sparse@vger.kernel.org>; Tue, 16 Jun 2020 14:11:10 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

For some testcases, the testsuite use the command 'timeout'
to ensure that the test finish after a reasonable amount of
time. This is mainly used for some testcases which, in the past,
were stuck in an infinite loop. This the command 'timeout' is
used with an extra option (-k 1s) to issue a second kill signal
in case the first one would have been ignored.

However, this extra option is not supported on all implementations
(Alpine) and its use seems a bit paranoid for sparse.

So, remove this extra option.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/validation/test-suite b/validation/test-suite
index 64a3e08fb4dd..a22f70135fb3 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -338,7 +338,7 @@ do_test()
 	# do we want a timeout?
 	pre_cmd=""
 	if [ $check_timeout -ne 0 ]; then
-		pre_cmd="timeout -k 1s $check_timeout"
+		pre_cmd="timeout $check_timeout"
 	fi
 
 	shift
-- 
2.27.0
