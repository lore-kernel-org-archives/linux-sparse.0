From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/7] diet: remove unused struct scope::token
Date: Thu, 29 Jun 2017 07:16:42 +0200
Message-ID: <20170629051646.35988-4-luc.vanoostenryck@gmail.com>
References: <20170629051646.35988-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33116 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbdF2FTB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 29 Jun 2017 01:19:01 -0400
Received: by mail-wm0-f67.google.com with SMTP id j85so351633wmj.0
        for <linux-sparse@vger.kernel.org>; Wed, 28 Jun 2017 22:19:01 -0700 (PDT)
In-Reply-To: <20170629051646.35988-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 scope.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scope.h b/scope.h
index 9bbb6757b..d9a14aa34 100644
--- a/scope.h
+++ b/scope.h
@@ -28,7 +28,6 @@
 struct symbol;
 
 struct scope {
-	struct token *token;		/* Scope start information */
 	struct symbol_list *symbols;	/* List of symbols in this scope */
 	struct scope *next;
 };
-- 
2.13.0

