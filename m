From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] fix test case kill-phi-ttsb
Date: Mon, 18 Sep 2017 16:10:55 +0200
Message-ID: <20170918141057.69745-2-luc.vanoostenryck@gmail.com>
References: <20170918141057.69745-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35039 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752946AbdIROLH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 Sep 2017 10:11:07 -0400
Received: by mail-wm0-f67.google.com with SMTP id e64so1027822wmi.2
        for <linux-sparse@vger.kernel.org>; Mon, 18 Sep 2017 07:11:06 -0700 (PDT)
In-Reply-To: <20170918141057.69745-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The function used in te test case has a return type of 'int'
but has nothing to return.

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

