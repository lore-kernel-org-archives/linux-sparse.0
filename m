From: Emily Maier <emily@emilymaier.net>
Subject: [PATCH 1/2] linearize: Emit C99 declarations correctly
Date: Wed,  4 May 2016 08:39:43 -0400
Message-ID: <1462365584-20536-1-git-send-email-emily@emilymaier.net>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from emilymaier.net ([104.131.113.117]:54835 "EHLO
	mail.emilymaier.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752657AbcEDMpv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 4 May 2016 08:45:51 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Emily Maier <emily@emilymaier.net>

Variables declared with C99 syntax inside a for statement should be
linearized in the loop top, rather than implicitly inside the loop body.

Signed-off-by: Emily Maier <emily@emilymaier.net>
---
 linearize.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/linearize.c b/linearize.c
index c6ada1e..1309c7d 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1946,7 +1946,11 @@ static pseudo_t linearize_iterator(struct entrypoint *ep, struct statement *stmt
 	struct statement  *post_statement = stmt->iterator_post_statement;
 	struct expression *post_condition = stmt->iterator_post_condition;
 	struct basic_block *loop_top, *loop_body, *loop_continue, *loop_end;
+	struct symbol *sym;
 
+	FOR_EACH_PTR(stmt->iterator_syms, sym) {
+		linearize_one_symbol(ep, sym);
+	} END_FOR_EACH_PTR(sym);
 	concat_symbol_list(stmt->iterator_syms, &ep->syms);
 	linearize_statement(ep, pre_statement);
 
-- 
2.5.5

