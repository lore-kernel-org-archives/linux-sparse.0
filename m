From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 03/14] testsuite: simplify the ioc-typecheck case
Date: Mon, 13 Feb 2017 00:28:53 +0100
Message-ID: <20170212232904.49647-4-luc.vanoostenryck@gmail.com>
References: <20170208222805.c77ilwchxpg2vnx4@macpro.local>
 <20170212232904.49647-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34472 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbdBLX3N (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Feb 2017 18:29:13 -0500
Received: by mail-wm0-f67.google.com with SMTP id c85so16482037wmi.1
        for <linux-sparse@vger.kernel.org>; Sun, 12 Feb 2017 15:29:13 -0800 (PST)
In-Reply-To: <20170212232904.49647-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The test was relatively convoluted and it wasn't very clear what
was the problem and waht was tested.

The real problem is simply a problem about a non-constant
expression in an array designator.

Simplify the test to clearly show that.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/ioc-typecheck.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/validation/ioc-typecheck.c b/validation/ioc-typecheck.c
index aa060f7be..34b37d310 100644
--- a/validation/ioc-typecheck.c
+++ b/validation/ioc-typecheck.c
@@ -1,16 +1,10 @@
 extern unsigned int __invalid_size_argument_for_IOC;
-#define _IOC_TYPECHECK(t) \
-                ((sizeof(t) == sizeof(t[1]) && \
-                    sizeof(t) < (1 << 14)) ? \
-                   sizeof(t) : __invalid_size_argument_for_IOC)
-
-#define TEST_IOCTL (50 | (_IOC_TYPECHECK(unsigned) << 8))
