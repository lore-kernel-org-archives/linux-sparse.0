From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 2/8] new helper: def_opcode()
Date: Mon,  7 Aug 2017 21:11:59 +0200
Message-ID: <20170807191205.86590-3-luc.vanoostenryck@gmail.com>
References: <CACXZuxd30jwczag_GHW3cmqPcBybEi7jfwfku81vW2nHzo_kyA@mail.gmail.com>
 <20170807191205.86590-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34620 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751919AbdHGTMN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 15:12:13 -0400
Received: by mail-wm0-f67.google.com with SMTP id x64so2066441wmg.1
        for <linux-sparse@vger.kernel.org>; Mon, 07 Aug 2017 12:12:12 -0700 (PDT)
In-Reply-To: <20170807191205.86590-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: linux-sparse@vger.kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Getting the opcode corresponding to the instruction defining
a pseudo if the psedudo has such and instruction (PSEUDO_REG)
is an common operation in the simplification phase.

Use an helper to make the code a bit easier to read.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/simplify.c b/simplify.c
index 2bc86f53e..d9528de43 100644
--- a/simplify.c
+++ b/simplify.c
@@ -352,6 +352,13 @@ static int replace_with_pseudo(struct instruction *insn, pseudo_t pseudo)
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
@@ -376,9 +383,9 @@ static unsigned int operand_size(struct instruction *insn, pseudo_t pseudo)
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
@@ -786,13 +793,11 @@ static int simplify_associative_binop(struct instruction *insn)
 
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
@@ -957,9 +962,9 @@ static int simplify_cast(struct instruction *insn)
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

