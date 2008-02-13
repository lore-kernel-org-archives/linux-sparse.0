From: Pavel Roskin <proski@gnu.org>
Subject: Re: Crash, apparent memory corruption
Date: Wed, 13 Feb 2008 14:04:42 -0500
Message-ID: <1202929482.2565.11.camel@dv>
References: <1202873443.9892.22.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:52533 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754032AbYBMTEo (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 13 Feb 2008 14:04:44 -0500
Received: from [192.168.1.21] (static-72-92-88-10.phlapa.fios.verizon.net [72.92.88.10])
	by relay.cesmail.net (Postfix) with ESMTP id 16F94619058
	for <linux-sparse@vger.kernel.org>; Wed, 13 Feb 2008 14:04:43 -0500 (EST)
In-Reply-To: <1202873443.9892.22.camel@dv>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hello!

Here are my results so far.

It's not just the "next" pointer that is corrupted.  The "nr" field in
struct ptr_list is corrupted too.  It becomes -1, which is an invalid
value.  This can be reproduced on both i386 and x86_64 platforms.

The earliest signs of problem I could find are in simplify_one_symbol().
The lower 4 bytes of insn->phi_list->list[0] should be a valid nr (from
0 to 29), but it's 0xffffffff.

I also found the place where -1 comes from.  If I change -1 to -2 in
symbol_pseudo(), the lower 4 bytes of insn->phi_list->list[0] become
0xfffffffe.  It other words, the same area of memory is treated as
struct ptr_list and as pseudo_t.

Here's the patch that demonstrates the problem.

diff --git a/flow.c b/flow.c
index 82fb23a..4946388 100644
--- a/flow.c
+++ b/flow.c
@@ -620,6 +620,7 @@ static void simplify_one_symbol(struct entrypoint *ep, struct symbol *sym)
 		/* We know that the symbol-pseudo use is the "src" in the instruction */
 		struct instruction *insn = pu->insn;
 
+		fprintf(stderr, "nr = %lx\n", (long int)(insn->phi_list->list[0]));
 		switch (insn->opcode) {
 		case OP_STORE:
 			stores++;
diff --git a/linearize.c b/linearize.c
index 8a68f05..fb03a4b 100644
--- a/linearize.c
+++ b/linearize.c
@@ -761,7 +761,7 @@ static pseudo_t symbol_pseudo(struct entrypoint *ep, struct symbol *sym)
 	pseudo = sym->pseudo;
 	if (!pseudo) {
 		pseudo = __alloc_pseudo(0);
-		pseudo->nr = -1;
+		pseudo->nr = -2;
 		pseudo->type = PSEUDO_SYM;
 		pseudo->sym = sym;
 		pseudo->ident = sym->ident;


-- 
Regards,
Pavel Roskin
