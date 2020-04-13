From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 14/17] scope: add is_in_scope()
Date: Mon, 13 Apr 2020 18:16:02 +0200
Message-ID: <20200413161605.95900-15-luc.vanoostenryck@gmail.com>
References: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731405AbgDMQQ1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Apr 2020 12:16:27 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC909C0A3BE2
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 09:16:25 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id p10so10708992wrt.6
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 09:16:25 -0700 (PDT)
In-Reply-To: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Add an helper to check if a scope is included into
another one.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 scope.c | 9 +++++++++
 scope.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/scope.c b/scope.c
index 24c8a7a484f7..b5c9e454b55d 100644
--- a/scope.c
+++ b/scope.c
@@ -163,3 +163,12 @@ int is_outer_scope(struct scope *scope)
 	return 1;
 }
 
+int is_in_scope(struct scope *outer, struct scope *inner)
+{
+	while (inner != outer) {
+		if (inner == &builtin_scope)
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
2.26.0
