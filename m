From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 9/9] div0: add missing tests for floating point div by zero
Date: Wed, 31 May 2017 05:22:07 +0200
Message-ID: <20170531032207.95830-10-luc.vanoostenryck@gmail.com>
References: <20170531032207.95830-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33309 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbdEaDWZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 30 May 2017 23:22:25 -0400
Received: by mail-wr0-f196.google.com with SMTP id v104so307258wrb.0
        for <linux-sparse@vger.kernel.org>; Tue, 30 May 2017 20:22:25 -0700 (PDT)
In-Reply-To: <20170531032207.95830-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/div-by-zero-fp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/validation/div-by-zero-fp.c b/validation/div-by-zero-fp.c
index 787af1636..957bc732c 100644
--- a/validation/div-by-zero-fp.c
+++ b/validation/div-by-zero-fp.c
@@ -3,14 +3,22 @@ double gbad(double a) { return 2.0 / 0.0; }
 double fool(double a) { return a / 0; }
 double ffoo(double a) { return a / 0.0; }
 
+double fbar(double a) { if (a && 0) a / 0.0; return 0; }
+double fbaz(double a) { return a /= 0.0; }
+double fquz(double a) { return a / (a && 0); }
+
 /*
  * check-name: div-by-zero-fp.c
  * check-command: sparse -Wno-decl $file
+ * check-known-to-fail
  *
  * check-error-start
 div-by-zero-fp.c:1:36: warning: division by zero
 div-by-zero-fp.c:2:36: warning: division by zero
 div-by-zero-fp.c:3:34: warning: division by zero
 div-by-zero-fp.c:4:34: warning: division by zero
+div-by-zero-fp.c:6:39: warning: division by zero
+div-by-zero-fp.c:7:34: warning: division by zero
+div-by-zero-fp.c:8:34: warning: division by zero
  * check-error-end
  */
-- 
2.13.0

