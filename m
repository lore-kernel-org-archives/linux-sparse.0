From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 4/5] unssa: eliminate trivial phisrc copies
Date: Mon, 12 Dec 2016 16:29:00 +0100
Message-ID: <20161212152901.24948-5-luc.vanoostenryck@gmail.com>
References: <20161212152901.24948-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35338 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932237AbcLLP3M (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 12 Dec 2016 10:29:12 -0500
Received: by mail-wm0-f67.google.com with SMTP id a20so11995018wme.2
        for <linux-sparse@vger.kernel.org>; Mon, 12 Dec 2016 07:29:11 -0800 (PST)
In-Reply-To: <20161212152901.24948-1-luc.vanoostenryck@gmail.com>
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
 unssa.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/unssa.c b/unssa.c
index 50782352..a7085ca0 100644
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
@@ -80,6 +86,22 @@ static void replace_phi_node(struct instruction *phi)
 
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
+			if (!insn)
+				break;
+			insn->target = tmp;
+		case 0:
+			kill_instruction(def);
+			def->bb = NULL;
+		}
 	} END_FOR_EACH_PTR(p);
 
 	if (!phi->bb)
-- 
2.10.2

