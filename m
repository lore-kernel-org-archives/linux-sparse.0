From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] cleanup: remove unused 'struct pseudo_ptr_list'
Date: Wed, 14 Feb 2018 00:48:29 +0100
Message-ID: <20180213234829.21480-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36942 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966064AbeBMXsg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Feb 2018 18:48:36 -0500
Received: by mail-wm0-f68.google.com with SMTP id v71so18951585wmv.2
        for <linux-sparse@vger.kernel.org>; Tue, 13 Feb 2018 15:48:36 -0800 (PST)
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
