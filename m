From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/6] use a shorter name for function-pointer-modifier-inheritance.c
Date: Thu, 24 Nov 2016 18:09:44 +0100
Message-ID: <20161124170947.14379-4-luc.vanoostenryck@gmail.com>
References: <20161124170947.14379-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f194.google.com ([209.85.210.194]:34064 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756864AbcKXRKD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 24 Nov 2016 12:10:03 -0500
Received: by mail-wj0-f194.google.com with SMTP id xy5so3662975wjc.1
        for <linux-sparse@vger.kernel.org>; Thu, 24 Nov 2016 09:10:02 -0800 (PST)
In-Reply-To: <20161124170947.14379-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The test file name is a bit longish which is annoying in test reports.
Rename it to simply 'function-pointer-inheritance.c'

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ...on-pointer-modifier-inheritance.c => function-pointer-inheritance.c} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename validation/{function-pointer-modifier-inheritance.c => function-pointer-inheritance.c} (63%)

diff --git a/validation/function-pointer-modifier-inheritance.c b/validation/function-pointer-inheritance.c
similarity index 63%
rename from validation/function-pointer-modifier-inheritance.c
rename to validation/function-pointer-inheritance.c
index 13df6ff7..0b24e458 100644
--- a/validation/function-pointer-modifier-inheritance.c
+++ b/validation/function-pointer-inheritance.c
@@ -5,5 +5,5 @@ int foo(int (*f)(int, void *))
     return 0;
 }
 /*
- * check-name: Function pointer modifier inheritance
+ * check-name: Function pointer inheritance
  */
-- 
2.10.2

