From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/5] testsuite: give a proper name to the 'binary-constant' test
Date: Wed,  2 Nov 2016 22:45:05 +0100
Message-ID: <20161102214509.36571-2-luc.vanoostenryck@gmail.com>
References: <20161102214509.36571-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36539 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752877AbcKBVsW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 2 Nov 2016 17:48:22 -0400
Received: by mail-wm0-f67.google.com with SMTP id c17so5003605wmc.3
        for <linux-sparse@vger.kernel.org>; Wed, 02 Nov 2016 14:48:21 -0700 (PDT)
In-Reply-To: <20161102214509.36571-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The template for this test was visibly copied from another one
and totally irrelevant to what is tested.

Give it another name, briefly describing the subject of the test.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/binary-constant.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/validation/binary-constant.c b/validation/binary-constant.c
index a589403a..c4ae0454 100644
--- a/validation/binary-constant.c
+++ b/validation/binary-constant.c
@@ -3,5 +3,5 @@ extern int x;
 int x = 0b11;
 
 /*
- * check-name: inline compound literals
+ * check-name: binary constant
  */
-- 
2.10.1

