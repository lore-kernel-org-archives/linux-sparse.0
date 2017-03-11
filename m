From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v0 3/4] add helper pseudo_type()
Date: Sat, 11 Mar 2017 16:47:24 +0100
Message-ID: <20170311154725.87906-4-luc.vanoostenryck@gmail.com>
References: <20170311154725.87906-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34620 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755432AbdCKPto (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 10:49:44 -0500
Received: by mail-wm0-f67.google.com with SMTP id u132so3377593wmg.1
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 07:49:34 -0800 (PST)
In-Reply-To: <20170311154725.87906-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/linearize.h b/linearize.h
index 7a3403095..a14733bd9 100644
--- a/linearize.h
+++ b/linearize.h
@@ -310,6 +310,22 @@ static inline void use_pseudo(struct instruction *insn, pseudo_t p, pseudo_t *pp
 		add_pseudo_user_ptr(alloc_pseudo_user(insn, pp), &p->users);
 }
 
+static inline struct symbol *pseudo_type(pseudo_t pseudo)
+{
+	switch (pseudo->type) {
+	case PSEUDO_SYM:
+	case PSEUDO_ARG:
+	case PSEUDO_VAL:
+		return pseudo->sym;
+	case PSEUDO_REG:
+	case PSEUDO_PHI:
+		return pseudo->def->type;
+	case PSEUDO_VOID:
+	default:
+		return &void_ctype;
+	}
+}
+
 static inline void remove_bb_from_list(struct basic_block_list **list, struct basic_block *entry, int count)
 {
 	delete_ptr_list_entry((struct ptr_list **)list, entry, count);
-- 
2.11.1

