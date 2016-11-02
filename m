From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/5] testsuite: simplify the ioc-typecheck case
Date: Wed,  2 Nov 2016 22:45:08 +0100
Message-ID: <20161102214509.36571-5-luc.vanoostenryck@gmail.com>
References: <20161102214509.36571-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33285 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757340AbcKBVsY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 2 Nov 2016 17:48:24 -0400
Received: by mail-wm0-f65.google.com with SMTP id u144so5032657wmu.0
        for <linux-sparse@vger.kernel.org>; Wed, 02 Nov 2016 14:48:24 -0700 (PDT)
In-Reply-To: <20161102214509.36571-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Hans Verkuil <hans.verkuil@cisco.com>

The test was relatively convoluted and it wasn't very clear what
was the problem and waht was tested.

The real problem is simply a problem about a non-constant
expression in an array designator.

Simplify the test to clearly show that.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
CC: Hans Verkuil <hans.verkuil@cisco.com>
---
 validation/ioc-typecheck.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/validation/ioc-typecheck.c b/validation/ioc-typecheck.c
index aa060f7b..34b37d31 100644
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
