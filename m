From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 1/8] Remove single-store shortcut
Date: Wed,  9 Aug 2017 01:06:27 +0200
Message-ID: <20170808230634.16227-2-luc.vanoostenryck@gmail.com>
References: <20170808230634.16227-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36328 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752469AbdHHXGy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 8 Aug 2017 19:06:54 -0400
Received: by mail-wm0-f68.google.com with SMTP id d40so4904065wma.3
        for <linux-sparse@vger.kernel.org>; Tue, 08 Aug 2017 16:06:53 -0700 (PDT)
In-Reply-To: <20170808230634.16227-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Current sparse code doesn't handle very gracefully
code with undefined pseudos. These can occurs, of
course because the dev has not initialize them,
maybe by error, but they can also occurs when they
are only set (and used) in a single path or even worse,
hen initiializing a bitfield.

The origin of the problem is the single store shortcut
in simplify_one_symbol() which doesn't take in account
the (absence of) dominance when loads exist without
stores.

Fix this by removing this single-store shortcut and leave
all the work for the general case which handle this
situation quite well (and/but set those variables to 0).

Warning: this change impact the performance.

Note: this will also solve most infinite loops that can
      happen when processing undefined vars.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c | 39 ++-------------------------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

diff --git a/flow.c b/flow.c
index 6cac21b24..6b2c879a8 100644
--- a/flow.c
+++ b/flow.c
@@ -650,11 +650,10 @@ void check_access(struct instruction *insn)
 
 static void simplify_one_symbol(struct entrypoint *ep, struct symbol *sym)
 {
-	pseudo_t pseudo, src;
+	pseudo_t pseudo;
 	struct pseudo_user *pu;
-	struct instruction *def;
 	unsigned long mod;
-	int all, stores, complex;
+	int all;
 
 	/* Never used as a symbol? */
 	pseudo = sym->pseudo;
@@ -670,17 +669,12 @@ static void simplify_one_symbol(struct entrypoint *ep, struct symbol *sym)
 	if (mod)
 		goto external_visibility;
 
-	def = NULL;
-	stores = 0;
-	complex = 0;
 	FOR_EACH_PTR(pseudo->users, pu) {
 		/* We know that the symbol-pseudo use is the "src" in the instruction */
 		struct instruction *insn = pu->insn;
 
 		switch (insn->opcode) {
 		case OP_STORE:
-			stores++;
-			def = insn;
 			break;
 		case OP_LOAD:
 			break;
@@ -697,37 +691,8 @@ static void simplify_one_symbol(struct entrypoint *ep, struct symbol *sym)
 		default:
 			warning(sym->pos, "symbol '%s' pseudo used in unexpected way", show_ident(sym->ident));
 		}
-		complex |= insn->offset;
 	} END_FOR_EACH_PTR(pu);
 
-	if (complex)
-		goto complex_def;
-	if (stores > 1)
-		goto multi_def;
-
-	/*
-	 * Goodie, we have a single store (if even that) in the whole
-	 * thing. Replace all loads with moves from the pseudo,
-	 * replace the store with a def.
-	 */
-	src = VOID;
-	if (def)
-		src = def->target;
-
-	FOR_EACH_PTR(pseudo->users, pu) {
-		struct instruction *insn = pu->insn;
-		if (insn->opcode == OP_LOAD) {
-			check_access(insn);
-			convert_load_instruction(insn, src);
-		}
-	} END_FOR_EACH_PTR(pu);
-
-	/* Turn the store into a no-op */
-	kill_store(def);
-	return;
