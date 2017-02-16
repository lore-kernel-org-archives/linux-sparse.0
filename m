From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/4] CSE: improve hashing of non-commutative binops
Date: Fri, 17 Feb 2017 00:12:31 +0100
Message-ID: <20170216231231.5781-5-luc.vanoostenryck@gmail.com>
References: <20170216231231.5781-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34564 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933744AbdBPXOt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Feb 2017 18:14:49 -0500
Received: by mail-wr0-f195.google.com with SMTP id c4so3668117wrd.1
        for <linux-sparse@vger.kernel.org>; Thu, 16 Feb 2017 15:14:48 -0800 (PST)
In-Reply-To: <20170216231231.5781-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

During CSE equivalent instructions should hash to the same value
but we should also try to *not* hash to the same value instructions
that cannot be equivalent.
For commutative ops this means that the hash function should itself
be commutative/symmetrical regarding the exchange of its operands.
This is already the case but the current hash function is symmetrical
for all binops, not only the commutative ones. Thus expressions like
'a - b' and 'b - a' hash to the same value while it should be the case
only when 'a == b'.

Fix this by changing the hashing of non-commutative binops so that it
is anti-symmetrical regarding the exchange of operands while keeping
commutative ones symmetrical.

This change have no functional effects (in the sense that it shoudl
CSE exactly the same instructiosn as before), it should only improve
the efficiency of the hashing+comparing.

Note: on the 5000+ test set I'm using, I can't see any significant
  speedup which is quite normal since most of the functions therein
  have (much) less instructions than the size of the hash table.
  The effect of this patch should only be on much bigger functions.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 cse.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/cse.c b/cse.c
index 0d3815c5a..89812afae 100644
--- a/cse.c
+++ b/cse.c
@@ -51,28 +51,30 @@ static void clean_up_one_instruction(struct basic_block *bb, struct instruction
 		hash += hashval(insn->src3);
 		/* Fall through */	
 
-	/* Binary arithmetic */
-	case OP_ADD: case OP_SUB:
-	case OP_MULU: case OP_MULS:
+	/* non-commutative binops */
+	case OP_SUB:
 	case OP_DIVU: case OP_DIVS:
 	case OP_MODU: case OP_MODS:
 	case OP_SHL:
 	case OP_LSR: case OP_ASR:
-	case OP_AND: case OP_OR:
-
-	/* Binary logical */
-	case OP_XOR: case OP_AND_BOOL:
-	case OP_OR_BOOL:
-
-	/* Binary comparison */
-	case OP_SET_EQ: case OP_SET_NE:
 	case OP_SET_LE: case OP_SET_GE:
 	case OP_SET_LT: case OP_SET_GT:
 	case OP_SET_B:  case OP_SET_A:
 	case OP_SET_BE: case OP_SET_AE:
+		hash -= hashval(insn->src2);
+		hash += hashval(insn->src1);
+		break;
+
+	/* commutative binops */
+	case OP_SET_EQ: case OP_SET_NE:
+	case OP_ADD:
+	case OP_MULU: case OP_MULS:
+	case OP_AND_BOOL: case OP_OR_BOOL:
+	case OP_AND: case OP_OR:
+	case OP_XOR:
 		hash += hashval(insn->src2);
 		/* Fall through */
-	
+
 	/* Unary */
 	case OP_NOT: case OP_NEG:
 		hash += hashval(insn->src1);
-- 
2.11.0

