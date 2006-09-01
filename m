From: Josh Triplett <josht@us.ibm.com>
Subject: [PATCHv2] graph: Show position in basic block nodes
Date: Fri, 01 Sep 2006 14:05:29 -0700
Message-ID: <1157144729.4217.3.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:9705 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750866AbWIAVFW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 1 Sep 2006 17:05:22 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k81L5L1G011860
	for <linux-sparse@vger.kernel.org>; Fri, 1 Sep 2006 17:05:21 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k81L5KYU325874
	for <linux-sparse@vger.kernel.org>; Fri, 1 Sep 2006 15:05:20 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k81L5K9F003255
	for <linux-sparse@vger.kernel.org>; Fri, 1 Sep 2006 15:05:20 -0600
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>

Change the label for basic block nodes from the basic block address to the
position (file, line, column) of the basic block.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
Please ignore the previous patch, which unintentionally included part of
an unrelated change.

 graph.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/graph.c b/graph.c
index db940ae..ede3dfa 100644
--- a/graph.c
+++ b/graph.c
@@ -27,7 +27,8 @@ static void graph_ep(struct entrypoint *
 	printf("ep%p [label=\"%s\",shape=ellipse];\n",
 	       ep, show_ident(ep->name->ident));
 	FOR_EACH_PTR(ep->bbs, bb) {
-		printf("bb%p [shape=record,label=\"bb at %p\"]\n", bb, bb);
+		printf("bb%p [shape=record,label=\"%s:%d:%d\"]\n", bb,
+		       stream_name(bb->pos.stream), bb->pos.line, bb->pos.pos);
 	} END_FOR_EACH_PTR(bb);
 	FOR_EACH_PTR(ep->bbs, bb) {
 		struct basic_block *child;
-- 
1.4.1.1



-- 
VGER BF report: H 0
