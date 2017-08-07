From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] new helper: def_opcode()
Date: Mon,  7 Aug 2017 03:33:36 +0200
Message-ID: <20170807013338.46211-2-luc.vanoostenryck@gmail.com>
References: <20170807013338.46211-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37231 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751375AbdHGBdq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Aug 2017 21:33:46 -0400
Received: by mail-wm0-f67.google.com with SMTP id t138so12076864wmt.4
        for <linux-sparse@vger.kernel.org>; Sun, 06 Aug 2017 18:33:45 -0700 (PDT)
In-Reply-To: <20170807013338.46211-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: linux-sparse@vger.kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/simplify.c b/simplify.c
index f292fd5b6..cfb6b2cda 100644
--- a/simplify.c
+++ b/simplify.c
@@ -380,6 +380,13 @@ static int replace_with_pseudo(struct instruction *insn, pseudo_t pseudo)
 	return REPEAT_CSE;
 }
 
+static inline int def_opcode(pseudo_t p)
+{
+	if (p->type != PSEUDO_REG)
+		return -1;
+	return p->def->opcode;
+}
+
 static unsigned int value_size(long long value)
 {
 	value >>= 8;
@@ -404,9 +411,9 @@ static unsigned int operand_size(struct instruction *insn, pseudo_t pseudo)
 {
 	unsigned int size = insn->size;
 
-	if (pseudo->type == PSEUDO_REG) {
+	if (def_opcode(pseudo) == OP_CAST) {
 		struct instruction *src = pseudo->def;
-		if (src && src->opcode == OP_CAST && src->orig_type) {
+		if (src->orig_type) {
 			unsigned int orig_size = src->orig_type->bit_size;
 			if (orig_size < size)
 				size = orig_size;
@@ -822,13 +829,11 @@ static int simplify_associative_binop(struct instruction *insn)
 
 	if (!simple_pseudo(insn->src2))
 		return 0;
-	if (pseudo->type != PSEUDO_REG)
+	if (def_opcode(pseudo) != insn->opcode)
 		return 0;
 	def = pseudo->def;
 	if (def == insn)
 		return 0;
-	if (def->opcode != insn->opcode)
-		return 0;
 	if (!simple_pseudo(def->src2))
 		return 0;
 	if (ptr_list_size((struct ptr_list *)def->target->users) != 1)
@@ -993,9 +998,9 @@ static int simplify_cast(struct instruction *insn)
 	}
 
 	/* A cast of a "and" might be a no-op.. */
-	if (src->type == PSEUDO_REG) {
+	if (def_opcode(src) == OP_AND) {
 		struct instruction *def = src->def;
-		if (def->opcode == OP_AND && def->size >= size) {
+		if (def->size >= size) {
 			pseudo_t val = def->src2;
 			if (val->type == PSEUDO_VAL) {
 				unsigned long long value = val->value;
-- 
2.13.2

