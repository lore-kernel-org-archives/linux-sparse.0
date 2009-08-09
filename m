From: Kamil Dudka <kdudka@redhat.com>
Subject: [PATCH] cse: treat PHI-nodes as other instructions
Date: Sun, 9 Aug 2009 23:15:12 +0200
Message-ID: <200908092315.12957.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gxzfKWamXtTSVIl"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:39355 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421AbZHIVPo (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 9 Aug 2009 17:15:44 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n79LFjci003472
	for <linux-sparse@vger.kernel.org>; Sun, 9 Aug 2009 17:15:45 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n79LFjUB018796
	for <linux-sparse@vger.kernel.org>; Sun, 9 Aug 2009 17:15:45 -0400
Received: from vpn2-8-75.ams2.redhat.com (vpn2-8-75.ams2.redhat.com [10.36.8.75])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n79LFhJu020638
	for <linux-sparse@vger.kernel.org>; Sun, 9 Aug 2009 17:15:44 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse <linux-sparse@vger.kernel.org>

--Boundary-00=_gxzfKWamXtTSVIl
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I've encountered a bug in the cse (over-)optimization. A patch, testing input 
for test-linearize and its outputs before/after patch are attached.

Note there is still something odd which the attached test-case revealed. The 
output of test-unssa still contains two (4 without my previous patch applied) 
unprocessed phisrc nodes. As time permits I'll try to write another for it if
nobody will be faster ;-)

Kamil

--Boundary-00=_gxzfKWamXtTSVIl
Content-Type: text/plain;
  charset="us-ascii";
  name="cse-bug-after_patch.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cse-bug-after_patch.out"



test:
.L0x7fbd14330010
	<entry-point>
	phisrc.32   %phi1(i) <- %arg1
	phisrc.32   %phi4(i) <- %arg1
	br          .L0x7fbd14330130

.L0x7fbd14330130
	copy.32     %r1(i) <- %r5(i)
	br          %r1(i), .L0x7fbd14330178, .L0x7fbd143300e8

.L0x7fbd14330178
	call        test, $0
	br          .L0x7fbd143301c0

.L0x7fbd143301c0
	add.32      %r4 <- %r1(i), $1
	phisrc.32   %phi2(i) <- %r4
	phisrc.32   %phi5(i) <- %r4
	br          .L0x7fbd14330130

.L0x7fbd143300e8
	ret


--Boundary-00=_gxzfKWamXtTSVIl
Content-Type: text/x-csrc;
  charset="us-ascii";
  name="cse-bug-input.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cse-bug-input.c"

static void test(int i)
{
    while (i) {
        if (i)
            test(0);
        i++;
    }
}

--Boundary-00=_gxzfKWamXtTSVIl
Content-Type: text/plain;
  charset="us-ascii";
  name="cse-bug-before_patch.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cse-bug-before_patch.out"



test:
.L0x7f43c1f02010
	<entry-point>
	phisrc.32   %phi1(i) <- %arg1
	phisrc.32   %phi4(i) <- %arg1
	br          .L0x7f43c1f02130

.L0x7f43c1f02130
	br          %r3, .L0x7f43c1f02178, .L0x7f43c1f020e8

.L0x7f43c1f02178
	call        test, $0
	br          .L0x7f43c1f021c0

.L0x7f43c1f021c0
	copy.32     %r3 <- %r5
	add.32      %r4 <- %r3, $1
	phisrc.32   %phi2(i) <- %r4
	phisrc.32   %phi5(i) <- %r4
	br          .L0x7f43c1f02130

.L0x7f43c1f020e8
	ret


--Boundary-00=_gxzfKWamXtTSVIl
Content-Type: text/x-diff;
  charset="us-ascii";
  name="0001-cse-treat-PHI-nodes-as-other-instructions.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-cse-treat-PHI-nodes-as-other-instructions.patch"

From 7658e89de5b2568d1a8663277c306b6f009b7ca7 Mon Sep 17 00:00:00 2001
From: Kamil Dudka <kdudka@redhat.com>
Date: Sun, 9 Aug 2009 22:43:17 +0200
Subject: [PATCH] cse: treat PHI-nodes as other instructions

Without this patch test-linearize fails on a simple example:

static void test(int i)
{
    while (i) {
        if (i)
            test(0);
        i++;
    }
}

It generates a conditional jump depending on an uninitialized value
which is obviously not in the input code.

Signed-off-by: Kamil Dudka <kdudka@redhat.com>
---
 cse.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/cse.c b/cse.c
index 2a15745..2aabb65 100644
--- a/cse.c
+++ b/cse.c
@@ -317,13 +317,6 @@ static struct instruction * try_to_cse(struct entrypoint *ep, struct instruction
 	b2 = i2->bb;
 
 	/*
-	 * PHI-nodes do not care where they are - the only thing that matters
-	 * are the PHI _sources_.
-	 */
-	if (i1->opcode == OP_PHI)
-		return cse_one_instruction(i1, i2);
--Boundary-00=_gxzfKWamXtTSVIl--
