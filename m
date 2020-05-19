From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v1 12/28] scope: no memset() needed after __alloc_scope()
Date: Tue, 19 May 2020 02:57:12 +0200
Message-ID: <20200519005728.84594-13-luc.vanoostenryck@gmail.com>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbgESA5q (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 May 2020 20:57:46 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D46C061A0C
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:46 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id n24so2399215ejd.0
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:46 -0700 (PDT)
In-Reply-To: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

When starting some scopes, the newly allocated struct is
memset'ed with zero but this is unneeded since the allocator
always returns zeroed memory.

Remove the unneeded call to memset().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 scope.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/scope.c b/scope.c
index 420c0f5a3f51..0e4fb3b42150 100644
--- a/scope.c
+++ b/scope.c
@@ -68,7 +68,6 @@ void rebind_scope(struct symbol *sym, struct scope *new)
 static void start_scope(struct scope **s)
 {
 	struct scope *scope = __alloc_scope(0);
-	memset(scope, 0, sizeof(*scope));
 	scope->next = *s;
 	*s = scope;
 }
@@ -77,7 +76,6 @@ void start_file_scope(void)
 {
 	struct scope *scope = __alloc_scope(0);
 
-	memset(scope, 0, sizeof(*scope));
 	scope->next = &builtin_scope;
 	file_scope = scope;
 
-- 
2.26.2
