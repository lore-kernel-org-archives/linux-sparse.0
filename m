From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 11/17] scope: make function scope the same as the body block scope
Date: Mon, 13 Apr 2020 18:15:59 +0200
Message-ID: <20200413161605.95900-12-luc.vanoostenryck@gmail.com>
References: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731401AbgDMQQX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Apr 2020 12:16:23 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD8CC0A3BE2
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 09:16:23 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x4so9821316wmj.1
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 09:16:23 -0700 (PDT)
In-Reply-To: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, the function scope (only used for labels) and
the block scope of the function's body are distinct scopes,
none being a child from the other.

This is fine as these scopes are currently unrelated but:
* it's unneeded and somehow unintuitive
* checking that gotos doesn't jump inside and expression
  statement is easier if these scopes are properly nested.

So, make the function scope and the body's block scope one
single scope.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 scope.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scope.c b/scope.c
index 0e4fb3b42150..175d72c23762 100644
--- a/scope.c
+++ b/scope.c
@@ -91,8 +91,8 @@ void start_symbol_scope(void)
 
 void start_function_scope(void)
 {
-	start_scope(&function_scope);
 	start_scope(&block_scope);
+	function_scope = block_scope;
 }
 
 static void remove_symbol_scope(struct symbol *sym)
@@ -137,7 +137,7 @@ void end_symbol_scope(void)
 void end_function_scope(void)
 {
 	end_scope(&block_scope);
-	end_scope(&function_scope);
+	function_scope = block_scope;
 }
 
 int is_outer_scope(struct scope *scope)
-- 
2.26.0
