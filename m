From: Josh Triplett <josht@us.ibm.com>
Subject: [PATCH RESEND] bb_terminated: Use boundary values rather than
	specific opcodes
Date: Mon, 11 Sep 2006 14:15:17 -0700
Message-ID: <1158009317.4373.53.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:14729 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S965046AbWIKVO6
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 11 Sep 2006 17:14:58 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8BLEveR002445
	for <linux-sparse@vger.kernel.org>; Mon, 11 Sep 2006 17:14:57 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k8BLEvTf294858
	for <linux-sparse@vger.kernel.org>; Mon, 11 Sep 2006 15:14:57 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k8BLEvJH000978
	for <linux-sparse@vger.kernel.org>; Mon, 11 Sep 2006 15:14:57 -0600
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>

The opcode enum defines the boundary values OP_TERMINATOR and
OP_TERMINATOR_END for terminator instructions; use those in bb_terminated
rather than the specific values they currently equal.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 linearize.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/linearize.h b/linearize.h
index ac946f3..517ec67 100644
--- a/linearize.h
+++ b/linearize.h
@@ -254,7 +254,8 @@ static inline int bb_terminated(struct b
 	if (!bb)
 		return 0;
 	insn = last_instruction(bb->insns);
-	return insn && insn->opcode >= OP_RET && insn->opcode <= OP_UNWIND;
+	return insn && insn->opcode >= OP_TERMINATOR
+	            && insn->opcode <= OP_TERMINATOR_END;
 }
 
 static inline int bb_reachable(struct basic_block *bb)
-- 
1.4.1.1
