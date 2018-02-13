From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 07/10] add helper: has_users()
Date: Tue, 13 Feb 2018 22:58:09 +0100
Message-ID: <20180213215812.18735-8-luc.vanoostenryck@gmail.com>
References: <20180213215812.18735-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40202 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965865AbeBMWA1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Feb 2018 17:00:27 -0500
Received: by mail-wm0-f67.google.com with SMTP id v123so18592239wmd.5
        for <linux-sparse@vger.kernel.org>; Tue, 13 Feb 2018 14:00:26 -0800 (PST)
In-Reply-To: <20180213215812.18735-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This is a wrapper around pseudo_user_list_size() which
can directly be used on a pseudo.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/linearize.h b/linearize.h
index 0a08c602e..15a6be9c9 100644
--- a/linearize.h
+++ b/linearize.h
@@ -330,6 +330,11 @@ static inline int pseudo_user_list_size(struct pseudo_user_list *list)
 	return ptr_list_size((struct ptr_list *)list);
 }
 
+static inline int has_users(pseudo_t p)
+{
+	return pseudo_user_list_size(p->users) != 0;
+}
+
 static inline struct pseudo_user *alloc_pseudo_user(struct instruction *insn, pseudo_t *pp)
 {
 	struct pseudo_user *user = __alloc_pseudo_user(0);
-- 
2.16.0

