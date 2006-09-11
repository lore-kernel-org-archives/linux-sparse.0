From: Josh Triplett <josht@us.ibm.com>
Subject: [PATCH RESEND] graph: Show position in basic block nodes
Date: Mon, 11 Sep 2006 14:14:45 -0700
Message-ID: <1158009285.4373.51.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:20154 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S965035AbWIKVO1
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 11 Sep 2006 17:14:27 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8BLEQOD003974
	for <linux-sparse@vger.kernel.org>; Mon, 11 Sep 2006 17:14:26 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k8BLEQ1a252294
	for <linux-sparse@vger.kernel.org>; Mon, 11 Sep 2006 15:14:26 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k8BLEPCA000891
	for <linux-sparse@vger.kernel.org>; Mon, 11 Sep 2006 15:14:25 -0600
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>

Change the label for basic block nodes from the basic block address to the
position (file, line, column) of the basic block.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---

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
