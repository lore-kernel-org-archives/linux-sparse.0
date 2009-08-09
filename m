From: Kamil Dudka <kdudka@redhat.com>
Subject: [PATCH] unssa: track uses when replacing a phi node
Date: Sun, 9 Aug 2009 10:30:23 +0200
Message-ID: <200908091030.24138.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gkofK4DWwVS7Ocv"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:44987 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751536AbZHIIaz (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 9 Aug 2009 04:30:55 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n798Uuuw028149
	for <linux-sparse@vger.kernel.org>; Sun, 9 Aug 2009 04:30:56 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n798Utc2004825
	for <linux-sparse@vger.kernel.org>; Sun, 9 Aug 2009 04:30:55 -0400
Received: from vpn2-8-75.ams2.redhat.com (vpn2-8-75.ams2.redhat.com [10.36.8.75])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n798Us5i030383
	for <linux-sparse@vger.kernel.org>; Sun, 9 Aug 2009 04:30:55 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse <linux-sparse@vger.kernel.org>

--Boundary-00=_gkofK4DWwVS7Ocv
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

attached are patch, testing input for test-unssa and its outputs before patch 
and after patch. Thanks in advance for considering the patch!

Kamil

--Boundary-00=_gkofK4DWwVS7Ocv
Content-Type: text/plain;
  charset="us-ascii";
  name="unssa-bug-before_patch.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="unssa-bug-before_patch.out"



test:
.L0x7f9fb2030010
	<entry-point>
	phisrc.32   %phi2(ptr) <- %arg1
	br          .L0x7f9fb2030130

.L0x7f9fb2030130
	copy.32     %r1(ptr) <- %r5(ptr)
	br          %r1(ptr), .L0x7f9fb2030058, .L0x7f9fb20300e8

.L0x7f9fb2030058
	load.32     %r3 <- 0[%r1(ptr)]
	phisrc.32   %phi3(ptr) <- %r3
	br          .L0x7f9fb2030130

.L0x7f9fb20300e8
	ret


--Boundary-00=_gkofK4DWwVS7Ocv
Content-Type: text/x-csrc;
  charset="us-ascii";
  name="unssa-bug-input.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="unssa-bug-input.c"

static void test(void **ptr)
{
    while (ptr) {
        ptr = *ptr;
    }
}

--Boundary-00=_gkofK4DWwVS7Ocv
Content-Type: text/plain;
  charset="us-ascii";
  name="unssa-bug-after_patch.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="unssa-bug-after_patch.out"



test:
.L0x7f4a7f7f1010
	<entry-point>
	copy.32     %r5(ptr) <- %arg1
	br          .L0x7f4a7f7f1130

.L0x7f4a7f7f1130
	copy.32     %r1(ptr) <- %r5(ptr)
	br          %r1(ptr), .L0x7f4a7f7f1058, .L0x7f4a7f7f10e8

.L0x7f4a7f7f1058
	load.32     %r3 <- 0[%r1(ptr)]
	copy.32     %r5(ptr) <- %r3
	br          .L0x7f4a7f7f1130

.L0x7f4a7f7f10e8
	ret


--Boundary-00=_gkofK4DWwVS7Ocv
Content-Type: text/x-diff;
  charset="us-ascii";
  name="0001-unssa-track-uses-when-replacing-a-phi-node.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-unssa-track-uses-when-replacing-a-phi-node.patch"

From 66a02fa7cec780fc88d6ef4cce7a1e704928808a Mon Sep 17 00:00:00 2001
From: Kamil Dudka <kdudka@redhat.com>
Date: Sun, 9 Aug 2009 10:22:11 +0200
Subject: [PATCH] unssa: track uses when replacing a phi node

The output of test-unssa is inconsistent for a simple test-case without
this patch:

static void test(void **ptr)
{
    while (ptr) {
        ptr = *ptr;
    }
}

Signed-off-by: Kamil Dudka <kdudka@redhat.com>
---
 flow.h     |    1 +
 liveness.c |    2 +-
 unssa.c    |    2 ++
 3 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/flow.h b/flow.h
index 9f2e165..fbc9505 100644
--- a/flow.h
+++ b/flow.h
@@ -29,6 +29,7 @@ int dominates(pseudo_t pseudo, struct instruction *insn, struct instruction *dom
 extern void clear_liveness(struct entrypoint *ep);
 extern void track_pseudo_liveness(struct entrypoint *ep);
 extern void track_pseudo_death(struct entrypoint *ep);
+extern void track_phi_uses(struct instruction *insn);
 
 extern void vrfy_flow(struct entrypoint *ep);
 extern int pseudo_in_list(struct pseudo_list *list, pseudo_t pseudo);
diff --git a/liveness.c b/liveness.c
index 8b0dfd8..eeff0f7 100644
--- a/liveness.c
+++ b/liveness.c
@@ -279,7 +279,7 @@ static void merge_pseudo_list(struct pseudo_list *src, struct pseudo_list **dest
 	} END_FOR_EACH_PTR(pseudo);
 }
 
-static void track_phi_uses(struct instruction *insn)
+void track_phi_uses(struct instruction *insn)
 {
 	pseudo_t phi;
 	FOR_EACH_PTR(insn->phi_list, phi) {
diff --git a/unssa.c b/unssa.c
index cd18313..3eea9b2 100644
--- a/unssa.c
+++ b/unssa.c
@@ -26,6 +26,7 @@
 #include "lib.h"
 #include "linearize.h"
 #include "allocate.h"
+#include "flow.h"
 #include <assert.h>
 
 
@@ -51,6 +52,7 @@ static void replace_phi_node(struct instruction *phi)
 	// update the current liveness
 	remove_pseudo(&phi->bb->needs, phi->target);
 	add_pseudo(&phi->bb->needs, tmp);
+	track_phi_uses(phi);
 
 	phi->opcode = OP_COPY;
 	phi->src = tmp;
-- 
1.6.4


--Boundary-00=_gkofK4DWwVS7Ocv--
