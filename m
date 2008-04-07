From: Pavel Roskin <proski@gnu.org>
Subject: [RFC PATCH] Fix crash in linearize_compound_statement()
Date: Mon, 07 Apr 2008 16:45:11 -0400
Message-ID: <1207601111.22430.28.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:54946 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751504AbYDGUpP (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 7 Apr 2008 16:45:15 -0400
Received: from [192.168.1.21] (static-72-92-88-10.phlapa.fios.verizon.net [72.92.88.10])
	by relay.cesmail.net (Postfix) with ESMTP id 4EA2A619058
	for <linux-sparse@vger.kernel.org>; Mon,  7 Apr 2008 16:45:13 -0400 (EDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hello!

The current sparse crashes on this program:


static int x;
static inline void foo(void)
{
    if (x)
	x = 1;
}
static void bar(void)
{
    foo();
}
static typeof(bar) quux;


The crash happens in linearize_compound_statement(), and I believe that
the reason is incorrect access to phi_node->phi_list without making sure
that phi_node->opcode is OP_PHI.  When processing the above program,
phi_node->phi_list can be OP_INLINED_CALL.

I understand very little in sparse code, and I have no idea what kind of
fallback is needed when phi_node->opcode is not OP_PHI.

But this patch fixes the crash:


diff --git a/linearize.c b/linearize.c
index 8a68f05..ff4f3b6 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1633,7 +1633,7 @@ static pseudo_t linearize_compound_statement(struct entrypoint *ep, struct state
 		struct basic_block *bb = add_label(ep, ret);
 		struct instruction *phi_node = first_instruction(bb->insns);
 
-		if (!phi_node)
+		if (!phi_node || phi_node->opcode != OP_PHI)
 			return pseudo;
 
 		if (pseudo_list_size(phi_node->phi_list)==1) {


-- 
Regards,
Pavel Roskin
