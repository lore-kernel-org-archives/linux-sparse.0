From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] no memset() needed after __alloc_scope()
Date: Fri, 10 Apr 2020 20:58:16 +0200
Message-ID: <20200410185816.65557-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35479 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgDJTAW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 10 Apr 2020 15:00:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so3330543wrx.2
        for <linux-sparse@vger.kernel.org>; Fri, 10 Apr 2020 12:00:20 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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
2.26.0
