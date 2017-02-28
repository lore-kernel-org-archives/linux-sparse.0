From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 2/2] remove unused helper is_branch_goto()
Date: Tue, 28 Feb 2017 14:30:28 +0100
Message-ID: <20170228133028.45237-3-luc.vanoostenryck@gmail.com>
References: <CANeU7Q=60E+2tvn=bdjaYnZFS3U3PMiTTq0=eYS-NkPDK3aJNA@mail.gmail.com>
 <20170228133028.45237-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33441 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752542AbdB1NdN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Feb 2017 08:33:13 -0500
Received: by mail-wm0-f65.google.com with SMTP id v77so2412267wmv.0
        for <linux-sparse@vger.kernel.org>; Tue, 28 Feb 2017 05:32:43 -0800 (PST)
In-Reply-To: <20170228133028.45237-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This helper is also made unneeded since the introduction of OP_CBR.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/linearize.h b/linearize.h
index 2aa255154..bac82d7ff 100644
--- a/linearize.h
+++ b/linearize.h
@@ -237,10 +237,6 @@ struct basic_block {
 	};
 };
 
-static inline int is_branch_goto(struct instruction *br)
-{
-	return br && br->opcode==OP_BR && (!br->bb_true || !br->bb_false);
-}
 
 static inline void add_bb(struct basic_block_list **list, struct basic_block *bb)
 {
-- 
2.11.1

