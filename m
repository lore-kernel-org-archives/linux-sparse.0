From: Pavel Roskin <proski@gnu.org>
Subject: Re: Crash, apparent memory corruption
Date: Wed, 13 Feb 2008 18:18:01 -0500
Message-ID: <1202944681.8941.29.camel@dv>
References: <1202873443.9892.22.camel@dv>  <1202929482.2565.11.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:63229 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764725AbYBMXSE (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 13 Feb 2008 18:18:04 -0500
Received: from [192.168.1.21] (static-72-92-88-10.phlapa.fios.verizon.net [72.92.88.10])
	by relay.cesmail.net (Postfix) with ESMTP id E3EAD619058
	for <linux-sparse@vger.kernel.org>; Wed, 13 Feb 2008 18:18:02 -0500 (EST)
In-Reply-To: <1202929482.2565.11.camel@dv>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

OK, I think I know what's wrong.

The "phi_list" field in "struct instruction" should only be accessed if
"opcode" in the same structure is OP_PHI.  "phi_list" is a part of a
transparent union, and thus could overlap with other data, including
data of the "pseudo_t" type.

linearize_compound_statement() uses "phi_list" unconditionally, but
"opcode" can be OP_INLINED_CALL in some cases.

It's a pure coincidence that pseudo_list_size() avoids crashing in most
cases and returns some number.  That number has to be 1 to enable some
additional logic, which is quite unlikely for invalid data.

I don't know the code enough to fix it properly.  I don't know if it's
OK for "opcode" not to be OP_PHI in linearize_compound_statement().

One approach would be to use assert() to ensure it.  The problem is,
it's triggered on several files in the testsuite.  Here's the patch
anyway:

diff --git a/linearize.c b/linearize.c
index 8a68f05..a907c50 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1636,6 +1636,7 @@ static pseudo_t linearize_compound_statement(struct entrypoint *ep, struct state
 		if (!phi_node)
 			return pseudo;
 
+		assert(phi_node->opcode != OP_PHI);
 		if (pseudo_list_size(phi_node->phi_list)==1) {
 			pseudo = first_pseudo(phi_node->phi_list);
 			assert(pseudo->type == PSEUDO_PHI);

Another approach would be to act like pseudo_list_size() returns a
number other than 1 if opcode is not OP_PHI:

diff --git a/linearize.c b/linearize.c
index 8a68f05..11f3a8b 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1636,7 +1636,8 @@ static pseudo_t linearize_compound_statement(struct entrypoint *ep, struct state
 		if (!phi_node)
 			return pseudo;
 
-		if (pseudo_list_size(phi_node->phi_list)==1) {
+		if (phi_node->opcode == OP_PHI
+		    && pseudo_list_size(phi_node->phi_list) == 1) {
 			pseudo = first_pseudo(phi_node->phi_list);
 			assert(pseudo->type == PSEUDO_PHI);
 			return pseudo->def->src1;

Not only the testsuite passes, but I can also check the kernel and
ndiswrapper without sparse crashes.

But I don't know whether the patch is hiding the problem instead of
fixing it.  And we may want to have an additional tag in memory to make
sure that the lists are of the correct type.

-- 
Regards,
Pavel Roskin
