From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 06/16] remove unused clear_phi()
Date: Thu, 16 Feb 2017 05:56:58 +0100
Message-ID: <20170216045708.50661-7-luc.vanoostenryck@gmail.com>
References: <20170216045708.50661-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33117 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753021AbdBPE5V (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 15 Feb 2017 23:57:21 -0500
Received: by mail-wr0-f195.google.com with SMTP id i10so641702wrb.0
        for <linux-sparse@vger.kernel.org>; Wed, 15 Feb 2017 20:57:20 -0800 (PST)
In-Reply-To: <20170216045708.50661-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/simplify.c b/simplify.c
index ddd0aa9c5..82ae97ae9 100644
--- a/simplify.c
+++ b/simplify.c
@@ -26,16 +26,6 @@ static struct basic_block *phi_parent(struct basic_block *source, pseudo_t pseud
 	return first_basic_block(source->parents);
 }
 
-static void clear_phi(struct instruction *insn)
-{
-	pseudo_t phi;
-
-	insn->bb = NULL;
-	FOR_EACH_PTR(insn->phi_list, phi) {
-		*THIS_ADDRESS(phi) = VOID;
-	} END_FOR_EACH_PTR(phi);
-}
