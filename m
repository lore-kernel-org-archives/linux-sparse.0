From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 21/28] testsuite: add a blank line before format
Date: Fri, 15 Sep 2017 09:13:51 +0200
Message-ID: <20170915071358.7312-22-luc.vanoostenryck@gmail.com>
References: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33832 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbdIOHQ2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:16:28 -0400
Received: by mail-wm0-f65.google.com with SMTP id i131so1975068wma.1
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:16:27 -0700 (PDT)
In-Reply-To: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 1 +
 1 file changed, 1 insertion(+)

diff --git a/validation/test-suite b/validation/test-suite
index f2e1c3242..96eb90581 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -433,6 +433,7 @@ do_format()
 	$cmd 1> $file.output.got 2> $file.error.got
 	fexit_value=$?
 	cat <<_EOF
+
 /*
  * check-name: $fname
 _EOF
-- 
2.14.0

