From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v1 20/28] scope: add is_in_scope()
Date: Tue, 19 May 2020 02:57:20 +0200
Message-ID: <20200519005728.84594-21-luc.vanoostenryck@gmail.com>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgESA5y (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 May 2020 20:57:54 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03541C05BD09
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:54 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id e10so10222193edq.0
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:53 -0700 (PDT)
In-Reply-To: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Add an helper to check if a scope is included into another one.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 scope.c | 9 +++++++++
 scope.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/scope.c b/scope.c
index 2e3a1c37ec15..017c0dcd8600 100644
--- a/scope.c
+++ b/scope.c
@@ -162,3 +162,12 @@ int is_outer_scope(struct scope *scope)
 	return 1;
 }
 
+int is_in_scope(struct scope *outer, struct scope *inner)
+{
+	while (inner != outer) {
+		if (!inner)
+			return 0;
+		inner = inner->next;
+	}
+	return 1;
+}
diff --git a/scope.h b/scope.h
index ddcb90bd146b..36a56d6adf1d 100644
--- a/scope.h
+++ b/scope.h
@@ -62,4 +62,6 @@ extern void bind_scope(struct symbol *, struct scope *);
 extern void rebind_scope(struct symbol *, struct scope *);
 
 extern int is_outer_scope(struct scope *);
+extern int is_in_scope(struct scope *outer, struct scope *inner);
+
 #endif
-- 
2.26.2
