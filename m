From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 01/14] testsuite: give a proper name to the 'binary-constant' test
Date: Mon, 13 Feb 2017 00:28:51 +0100
Message-ID: <20170212232904.49647-2-luc.vanoostenryck@gmail.com>
References: <20170208222805.c77ilwchxpg2vnx4@macpro.local>
 <20170212232904.49647-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36031 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbdBLX3M (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Feb 2017 18:29:12 -0500
Received: by mail-wm0-f67.google.com with SMTP id r18so16525745wmd.3
        for <linux-sparse@vger.kernel.org>; Sun, 12 Feb 2017 15:29:11 -0800 (PST)
In-Reply-To: <20170212232904.49647-1-luc.vanoostenryck@gmail.com>
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
index a589403a9..c4ae04546 100644
--- a/validation/binary-constant.c
+++ b/validation/binary-constant.c
@@ -3,5 +3,5 @@ extern int x;
 int x = 0b11;
 
 /*
- * check-name: inline compound literals
+ * check-name: binary constant
  */
-- 
2.11.0

