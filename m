From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 04/48] fix test case kill-phi-ttsb
Date: Wed, 23 Aug 2017 22:15:10 +0200
Message-ID: <20170823201554.90551-5-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33542 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932443AbdHWUQK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:16:10 -0400
Received: by mail-wm0-f67.google.com with SMTP id b79so660984wmf.0
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:16:10 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The functon used in te test case has a return type of 'int'
but has nothing to return.

This was not diagnosticated.

Fix this by using the correct return type: 'void'

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/kill-phi-ttsbb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/validation/kill-phi-ttsbb.c b/validation/kill-phi-ttsbb.c
index 178a65d19..7fea30bfd 100644
--- a/validation/kill-phi-ttsbb.c
+++ b/validation/kill-phi-ttsbb.c
@@ -1,7 +1,7 @@
 int def(void);
 void use(int);
 
-static int foo(int a, int b)
+static void foo(int a, int b)
 {
 	int c;
 
-- 
2.14.0

