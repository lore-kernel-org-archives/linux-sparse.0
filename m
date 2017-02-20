From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] use VOID instead of directly using &void_pseudo
Date: Mon, 20 Feb 2017 11:45:36 +0100
Message-ID: <20170220104536.12105-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:32962 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751330AbdBTKrn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Feb 2017 05:47:43 -0500
Received: by mail-wr0-f193.google.com with SMTP id s27so2349418wrb.0
        for <linux-sparse@vger.kernel.org>; Mon, 20 Feb 2017 02:47:43 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 linearize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linearize.c b/linearize.c
index 99203d915..6908e9f57 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1862,7 +1862,7 @@ static pseudo_t linearize_return(struct entrypoint *ep, struct statement *stmt)
 	struct basic_block *active;
 	pseudo_t src = linearize_expression(ep, expr);
 	active = ep->active;
-	if (active && src != &void_pseudo) {
+	if (active && src != VOID) {
 		struct instruction *phi_node = first_instruction(bb_return->insns);
 		pseudo_t phi;
 		if (!phi_node) {
-- 
2.11.0

