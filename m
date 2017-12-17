From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] testcases: add missing return statements
Date: Sun, 17 Dec 2017 16:04:12 +0100
Message-ID: <20171217150412.9316-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35571 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757372AbdLQPGR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 17 Dec 2017 10:06:17 -0500
Received: by mail-wm0-f66.google.com with SMTP id f9so25314119wmh.0
        for <linux-sparse@vger.kernel.org>; Sun, 17 Dec 2017 07:06:16 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In some testcases, some non-void functions are missing
a return statement.  This is undetected because:
- no checks are done and so no warnings can be given
- there are some bugs in the linearization of returns
  (the value returned by the last statement is implicitly used).

Fix the testcases by adding the missing return.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/call-variadic.c | 2 +-
 validation/struct-as.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/validation/call-variadic.c b/validation/call-variadic.c
index a438b43a7..8c9815621 100644
--- a/validation/call-variadic.c
+++ b/validation/call-variadic.c
@@ -4,7 +4,7 @@ extern int print(const char *msg, ...);
 
 int foo(const char *fmt, int a, long l, int *p)
 {
-	print("msg %c: %d %d/%ld %ld/%p %p\n", 'x', a, __LINE__, l, 0L, p, NULL);
+	return print("msg %c: %d %d/%ld %ld/%p %p\n", 'x', a, __LINE__, l, 0L, p, NULL);
 }
 
 /*
diff --git a/validation/struct-as.c b/validation/struct-as.c
index f31f7c966..23bca897d 100644
--- a/validation/struct-as.c
+++ b/validation/struct-as.c
@@ -12,7 +12,7 @@ extern int test(int __user *ip);
 
 static int broken(struct hello __user *sp)
 {
-	test(&sp->a);
+	return test(&sp->a);
 }
 /*
  * check-name: Address space of a struct member
-- 
2.15.0

