From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 18/29] ptrmap: add type-safe interface
Date: Wed, 16 Aug 2017 17:34:44 +0200
Message-ID: <20170816153455.97693-19-luc.vanoostenryck@gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:32909 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbdHPPfl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 11:35:41 -0400
Received: by mail-wr0-f193.google.com with SMTP id n88so3698118wrb.0
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 08:35:40 -0700 (PDT)
In-Reply-To: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Add the external API for the ptrmap implementation.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ptrmap.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/ptrmap.h b/ptrmap.h
index 070db15e2..cbbb61da9 100644
--- a/ptrmap.h
+++ b/ptrmap.h
@@ -3,6 +3,22 @@
 
 struct ptrmap;
 
+#define DECLARE_PTRMAP(name, ktype, vtype)				\
+	struct name ## _pair { ktype key; vtype val; };			\
+	struct name { struct name ## _pair block[1]; };			\
+	static inline							\
+	void name##_add(struct name **map, ktype k, vtype v) {		\
+		__ptrmap_add((struct ptrmap**)map, k, v);		\
+	}								\
+	static inline							\
+	void name##_update(struct name **map, ktype k, vtype v) {	\
+		__ptrmap_update((struct ptrmap**)map, k, v);		\
+	}								\
+	static inline							\
+	vtype name##_lookup(struct name *map, ktype k) {		\
+		vtype val = __ptrmap_lookup((struct ptrmap*)map, k);	\
+		return val;						\
+	}								\
 
 /* ptrmap.c */
 void __ptrmap_add(struct ptrmap **mapp, void *key, void *val);
-- 
2.14.0

