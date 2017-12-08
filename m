From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 01/16] testsuite: make the '%.t' rule depends on PROGRAMS too
Date: Fri,  8 Dec 2017 14:14:40 +0100
Message-ID: <20171208131455.7786-2-luc.vanoostenryck@gmail.com>
References: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37630 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753230AbdLHNPL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 8 Dec 2017 08:15:11 -0500
Received: by mail-wm0-f66.google.com with SMTP id f140so3153079wmd.2
        for <linux-sparse@vger.kernel.org>; Fri, 08 Dec 2017 05:15:11 -0800 (PST)
In-Reply-To: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The testsuite can be run on a specific testcase directly
via the Makefile via a 'validation/%.t' pattern rule but
this rule had no dependency on the programs being tested
and thus could be run on a previous version.

Fix this by adding the needed dependencies.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 1ae0a33f0..dab38aacd 100644
--- a/Makefile
+++ b/Makefile
@@ -214,7 +214,7 @@ version.h: FORCE
 
 check: all
 	$(Q)cd validation && ./test-suite
-validation/%.t: FORCE
+validation/%.t: $(PROGRAMS)
 	@validation/test-suite single $*.c
 
 
-- 
2.15.0

