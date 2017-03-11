From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v1 2/4] make space for PSEUDO_VAL have a type
Date: Sat, 11 Mar 2017 16:47:23 +0100
Message-ID: <20170311154725.87906-3-luc.vanoostenryck@gmail.com>
References: <20170311154725.87906-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35730 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755394AbdCKPto (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 10:49:44 -0500
Received: by mail-wm0-f67.google.com with SMTP id z63so3366954wmg.2
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 07:49:33 -0800 (PST)
In-Reply-To: <20170311154725.87906-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/linearize.h b/linearize.h
index 9d192f7aa..7a3403095 100644
--- a/linearize.h
+++ b/linearize.h
@@ -31,12 +31,14 @@ enum pseudo_type {
 struct pseudo {
 	int nr;
 	enum pseudo_type type;
-	struct pseudo_user_list *users;
+	union {
+		struct pseudo_user_list *users;
+		long long value;	// PSEUDO_VAL
+	};
 	struct ident *ident;
 	union {
 		struct symbol *sym;	// PSEUDO_SYM & ARG
 		struct instruction *def;// PSEUDO_REG & PHI
-		long long value;	// PSEUDO_VAL
 	};
 	void *priv;
 };
-- 
2.11.1

