From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] fix conditional context test case with void
Date: Sun, 29 Jan 2017 12:34:07 +0100
Message-ID: <20170129113409.9834-2-luc.vanoostenryck@gmail.com>
References: <20170129113409.9834-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33724 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbdA2MIY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 29 Jan 2017 07:08:24 -0500
Received: by mail-wm0-f67.google.com with SMTP id v77so9242122wmv.0
        for <linux-sparse@vger.kernel.org>; Sun, 29 Jan 2017 04:08:23 -0800 (PST)
In-Reply-To: <20170129113409.9834-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The test file for context checking contains a few test cases
with a conditional, mimicking kernels's __cond_lock().
But the macro involved use as condition the return value of
a function, _ca(), which itself returns void ...

Fix the test by giving _ca() a return type of 'int'.

CC: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/validation/context.c b/validation/context.c
index 33b70b84b..b9500dc75 100644
--- a/validation/context.c
+++ b/validation/context.c
@@ -10,7 +10,7 @@ static void r(void) __attribute__((context(1,0)))
 	__context__(-1);
 }
 
-extern void _ca(int fail);
+extern int _ca(int fail);
 #define ca(fail) __cond_lock(_ca(fail))
 
 static void good_paired1(void)
-- 
2.11.0

