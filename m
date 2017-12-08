From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 03/16] testsuite: convert to the new pattern syntax
Date: Fri,  8 Dec 2017 14:14:42 +0100
Message-ID: <20171208131455.7786-4-luc.vanoostenryck@gmail.com>
References: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:46813 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753274AbdLHNPN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 8 Dec 2017 08:15:13 -0500
Received: by mail-wm0-f65.google.com with SMTP id r78so3253767wme.5
        for <linux-sparse@vger.kernel.org>; Fri, 08 Dec 2017 05:15:13 -0800 (PST)
In-Reply-To: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The old one is too ugly and has to die.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/fp2i-cast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/validation/fp2i-cast.c b/validation/fp2i-cast.c
index 08f8c9252..98d7453e5 100644
--- a/validation/fp2i-cast.c
+++ b/validation/fp2i-cast.c
@@ -26,5 +26,5 @@ ul d2ul(double a) { return a; }
  * check-command: test-linearize -Wno-decl $file
  *
  * check-output-ignore
- * check-output-pattern-8-times: cast\\.
+ * check-output-pattern(8): cast\\.
  */
-- 
2.15.0

