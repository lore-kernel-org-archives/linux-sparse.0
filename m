From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/5] unssa: eliminate trivial phisrc copies
Date: Thu,  1 Dec 2016 16:07:04 +0100
Message-ID: <20161201150705.31590-5-luc.vanoostenryck@gmail.com>
References: <20161201150705.31590-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:33943 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932845AbcLAPHY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 1 Dec 2016 10:07:24 -0500
Received: by mail-wj0-f196.google.com with SMTP id xy5so26733331wjc.1
        for <linux-sparse@vger.kernel.org>; Thu, 01 Dec 2016 07:07:23 -0800 (PST)
In-Reply-To: <20161201150705.31590-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

A OP_PHISOURCE which is the only user of its operand
can be trivially eliminated. For example, in:
	add	%r6, ...
	...
	phisrc	%rt, %r6
the phisrc can safely be eliminated if no other instruction use %r6.
With this patch it's rewritten as:
	add	%rt, ...
	...

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 unssa.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/unssa.c b/unssa.c
index 397130e3..f0a1392f 100644
--- a/unssa.c
+++ b/unssa.c
@@ -30,6 +30,11 @@
 #include <assert.h>
 
 
+static inline int nbr_pseudo_users(pseudo_t p)
+{
+	return ptr_list_size((struct ptr_list *)p->users);
+}
+
 static int simplify_phi_node(struct instruction *phi, pseudo_t tmp)
 {
 	pseudo_t target = phi->target;
@@ -72,6 +77,7 @@ static void replace_phi_node(struct instruction *phi)
 	// rewrite all it's phi_src to copy to a new tmp
 	FOR_EACH_PTR(phi->phi_list, p) {
 		struct instruction *def = p->def;
+		pseudo_t src;
 
 		if (p == VOID)
 			continue;
@@ -80,6 +86,21 @@ static void replace_phi_node(struct instruction *phi)
 
 		def->opcode = OP_COPY;
 		def->target = tmp;
+
+		// can we eliminate the copy?
+		src = def->phi_src;
+		if (src->type != PSEUDO_REG)
+			continue;
+		switch (nbr_pseudo_users(src)) {
+			struct instruction *insn;
+		case 1:
+			insn = src->def;
+			insn->target = tmp;
+			tmp->def = insn;
+		case 0:
+			kill_instruction(def);
+			def->bb = NULL;
+		}
 	} END_FOR_EACH_PTR(p);
 
 	if (!phi->bb)
-- 
2.10.2

