From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 03/29] fix test case kill-phi-ttsb
Date: Wed, 16 Aug 2017 17:34:29 +0200
Message-ID: <20170816153455.97693-4-luc.vanoostenryck@gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33679 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751580AbdHPPfL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 11:35:11 -0400
Received: by mail-wr0-f193.google.com with SMTP id n88so3695907wrb.0
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 08:35:10 -0700 (PDT)
In-Reply-To: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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

