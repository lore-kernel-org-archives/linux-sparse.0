From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 22/28] testsuite: 'quiet' must be initialized earlier
Date: Fri, 15 Sep 2017 09:13:52 +0200
Message-ID: <20170915071358.7312-23-luc.vanoostenryck@gmail.com>
References: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33839 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbdIOHQ3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:16:29 -0400
Received: by mail-wm0-f67.google.com with SMTP id i131so1975102wma.1
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:16:28 -0700 (PDT)
In-Reply-To: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

as it can, for example, be needed via arg_file() -> error()

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 1 +
 1 file changed, 1 insertion(+)

diff --git a/validation/test-suite b/validation/test-suite
index 96eb90581..1ef18f288 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -39,6 +39,7 @@ known_ko_tests=0
 # defaults to not verbose
 [ -z "$V" ] && V=0
 vquiet=""
+quiet=0
 abort=0
 
 ##
-- 
2.14.0

