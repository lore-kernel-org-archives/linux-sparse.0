From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 17/27] llvm: add test cases for arrays passed as argument
Date: Sat, 11 Mar 2017 10:06:56 +0100
Message-ID: <20170311090706.17171-18-luc.vanoostenryck@gmail.com>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32873 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755476AbdCKJHk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 04:07:40 -0500
Received: by mail-wr0-f195.google.com with SMTP id g10so14110924wrg.0
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 01:07:39 -0800 (PST)
In-Reply-To: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/backend/function-ptr.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/validation/backend/function-ptr.c b/validation/backend/function-ptr.c
index e035fe958..e44352312 100644
--- a/validation/backend/function-ptr.c
+++ b/validation/backend/function-ptr.c
@@ -34,11 +34,15 @@ void arg(int a, int *p, int (*fb)(unsigned char), int (*fi)(int), int (*fl)(long
 	fip((void*)0);
 	fip(ipval);
 	fip(&ival);
+	fip(array);
+	fim(matrix);
 
 	fvp(p);
 	fvp((void*)0);
 	fvp(ipval);
 	fvp(&ival);
+	fvp(array);
+	fvp(matrix);
 
 	fvp(fun);
 	fvp(&fun);
@@ -78,11 +82,15 @@ void glb(int a, int *p)
 	fip((void*)0);
 	fip(ipval);
 	fip(&ival);
+	fip(array);
+	fim(matrix);
 
 	fvp(p);
 	fvp((void*)0);
 	fvp(ipval);
 	fvp(&ival);
+	fvp(array);
+	fvp(matrix);
 
 	fvp(fun);
 	fvp(&fun);
@@ -127,11 +135,15 @@ void ops(int a, int *p, struct ops *ops)
 	ops->fip((void*)0);
 	ops->fip(ipval);
 	ops->fip(&ival);
+	ops->fip(array);
+	ops->fim(matrix);
 
 	ops->fvp(p);
 	ops->fvp((void*)0);
 	ops->fvp(ipval);
 	ops->fvp(&ival);
+	ops->fvp(array);
+	ops->fvp(matrix);
 
 	ops->fvp(fun);
 	ops->fvp(&fun);
-- 
2.11.1

