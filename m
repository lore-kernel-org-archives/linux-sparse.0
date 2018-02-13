From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] cleanup: remove unused 'struct pseudo_ptr_list'
Date: Tue, 13 Feb 2018 01:49:32 +0100
Message-ID: <20180213004932.34780-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38469 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932736AbeBMAtn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 12 Feb 2018 19:49:43 -0500
Received: by mail-wr0-f195.google.com with SMTP id t94so16981615wrc.5
        for <linux-sparse@vger.kernel.org>; Mon, 12 Feb 2018 16:49:43 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

'struct pseudo_ptr_list' was used to store pseudo usage
but this structure is not used since commit e7fb6e092
(Add instruction to pseudo user tracking).

Remove the leftovers.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/linearize.h b/linearize.h
index c0c49bdf0..eba0dd532 100644
--- a/linearize.h
+++ b/linearize.h
@@ -9,7 +9,6 @@
 #include "symbol.h"
 
 struct instruction;
-DECLARE_PTR_LIST(pseudo_ptr_list, pseudo_t);
 
 struct pseudo_user {
 	struct instruction *insn;
@@ -310,11 +309,6 @@ static inline int bb_reachable(struct basic_block *bb)
 	return bb != NULL;
 }
 
-static inline void add_pseudo_ptr(pseudo_t *ptr, struct pseudo_ptr_list **list)
-{
-	add_ptr_list(list, ptr);
-}
