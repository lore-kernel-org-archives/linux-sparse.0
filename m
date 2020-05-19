From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v1 18/28] scope: make function_scope invalid outside functions
Date: Tue, 19 May 2020 02:57:18 +0200
Message-ID: <20200519005728.84594-19-luc.vanoostenryck@gmail.com>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbgESA5w (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 May 2020 20:57:52 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C1BC061A0C
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:52 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id l5so3701797edn.7
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:52 -0700 (PDT)
In-Reply-To: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The scopes are mainly used for symbols corresponding to variables
and functions with this hiearchy:
* builtin
* global
* function
* block

But the function_scope is only used for labels and __func__ and
is meaningless outside a function.

So, mainly in preparation for some incoming changes, let
function_scope's parent be NULL instead of the builtin scope.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 scope.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scope.c b/scope.c
index cc54f1e1760b..83cc34c44bf5 100644
--- a/scope.c
+++ b/scope.c
@@ -36,7 +36,7 @@
 static struct scope builtin_scope = { .next = &builtin_scope };
 
 struct scope	*block_scope = &builtin_scope,		// regular automatic variables etc
-		*function_scope = &builtin_scope,	// labels, arguments etc
+		*function_scope = NULL,			// __fun__, labels
 		*file_scope = &builtin_scope,		// static
 		*global_scope = &builtin_scope;		// externally visible
 
@@ -80,7 +80,6 @@ void start_file_scope(void)
 	file_scope = scope;
 
 	/* top-level stuff defaults to file scope, "extern" etc will choose global scope */
-	function_scope = scope;
 	block_scope = scope;
 }
 
@@ -138,6 +137,7 @@ void end_function_scope(void)
 {
 	end_scope(&block_scope);
 	end_scope(&function_scope);
+	function_scope = NULL;
 }
 
 int is_outer_scope(struct scope *scope)
-- 
2.26.2
