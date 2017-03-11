From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 03/27] give a type to OP_SYMADDR
Date: Sat, 11 Mar 2017 10:06:42 +0100
Message-ID: <20170311090706.17171-4-luc.vanoostenryck@gmail.com>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34942 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752678AbdCKJHY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 04:07:24 -0500
Received: by mail-wr0-f196.google.com with SMTP id u108so14120074wrb.2
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 01:07:23 -0800 (PST)
In-Reply-To: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, OP_SYMADDR are given a size but not a type.

There is no good reasons for that and it complicates
further correct processing or makes it impossible because
we've lost this type information.

Fix this by using alloc_typed_instruction() when creating
OP_SYMADDRs instructions.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/linearize.c b/linearize.c
index 9321cde21..ea4616f80 100644
--- a/linearize.c
+++ b/linearize.c
@@ -982,9 +982,10 @@ static pseudo_t add_setval(struct entrypoint *ep, struct symbol *ctype, struct e
 	return target;
 }
 
-static pseudo_t add_symbol_address(struct entrypoint *ep, struct symbol *sym)
+static pseudo_t add_symbol_address(struct entrypoint *ep, struct expression *expr)
 {
-	struct instruction *insn = alloc_instruction(OP_SYMADDR, bits_in_pointer);
+	struct instruction *insn = alloc_typed_instruction(OP_SYMADDR, expr->ctype);
+	struct symbol *sym = expr->symbol;
 	pseudo_t target = alloc_pseudo(insn);
 
 	insn->target = target;
@@ -1552,7 +1553,7 @@ pseudo_t linearize_expression(struct entrypoint *ep, struct expression *expr)
 	switch (expr->type) {
 	case EXPR_SYMBOL:
 		linearize_one_symbol(ep, expr->symbol);
-		return add_symbol_address(ep, expr->symbol);
+		return add_symbol_address(ep, expr);
 
 	case EXPR_VALUE:
 		return value_pseudo(expr->value);
-- 
2.11.1

