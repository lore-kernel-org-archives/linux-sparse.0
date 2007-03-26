From: "Russ Cox" <rsc@swtch.com>
Subject: [PATCH] Add const to pointer qualifiers for __chk_user_ptr and __chk_io_ptr.
Date: Mon, 26 Mar 2007 11:23:56 -0400
Message-ID: <ee9e417a0703260823k55c6de8ay715be1db11692355@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.247]:59367 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbXCZPX5 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 26 Mar 2007 11:23:57 -0400
Received: by an-out-0708.google.com with SMTP id b33so2356182ana
        for <linux-sparse@vger.kernel.org>; Mon, 26 Mar 2007 08:23:57 -0700 (PDT)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-sparse@vger.kernel.org

Change prototypes for  __chk_user_ptr and __chk_io_ptr
to take const void* instead of void*, so that code can pass
const void* to them.  (Right now sparse does not warn
about passing const void* to void* functions, but that
is a separate bug that I believe Josh is working on,
and once sparse does check this, the changed prototypes
will be necessary.)

Signed-off-by: Russ Cox <rsc@swtch.com>
Signed-off-by: Josh Triplett <josh@freedesktop.org>

---

 include/linux/compiler.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

e5174dfa73190036ae1086110292594a3ffb3752
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index aca6698..3b6949b 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -15,8 +15,8 @@
 # define __acquire(x)	__context__(x,1)
 # define __release(x)	__context__(x,-1)
 # define __cond_lock(x,c)	((c) ? ({ __acquire(x); 1; }) : 0)
-extern void __chk_user_ptr(void __user *);
-extern void __chk_io_ptr(void __iomem *);
+extern void __chk_user_ptr(const void __user *);
+extern void __chk_io_ptr(const void __iomem *);
 #else
 # define __user
 # define __kernel
-- 
1.1.3
