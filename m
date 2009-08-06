From: Kamil Dudka <kdudka@redhat.com>
Subject: [PATCH] linearize.h: sanitize header
Date: Thu, 6 Aug 2009 11:02:14 +0200
Message-ID: <200908061102.14935.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_WwpeK+nnTQatjOH"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:54853 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753706AbZHFJAt (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 6 Aug 2009 05:00:49 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n7690ncJ002488
	for <linux-sparse@vger.kernel.org>; Thu, 6 Aug 2009 05:00:49 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n7690mYF016380
	for <linux-sparse@vger.kernel.org>; Thu, 6 Aug 2009 05:00:49 -0400
Received: from dhcp-lab-205.englab.brq.redhat.com (dhcp-lab-205.englab.brq.redhat.com [10.34.33.205])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n7690lnD030863
	for <linux-sparse@vger.kernel.org>; Thu, 6 Aug 2009 05:00:48 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse <linux-sparse@vger.kernel.org>

--Boundary-00=_WwpeK+nnTQatjOH
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

please consider applying the attached one-line patch. Feel free to choose 
better identifiers if these are not accurate enough. Thanks!

Kamil



--Boundary-00=_WwpeK+nnTQatjOH
Content-Type: text/x-patch;
  charset="us-ascii";
  name="0001-linearize.h-sanitize-header.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="0001-linearize.h-sanitize-header.patch"

From 4ad2c5943c1d0b16a19feefe721ebc53a4875a35 Mon Sep 17 00:00:00 2001
From: Kamil Dudka <kdudka@redhat.com>
Date: Thu, 6 Aug 2009 10:54:56 +0200
Subject: [PATCH] linearize.h: sanitize header

It's unfortunate to use 'true' and 'false' as identifiers in a system
header. It clashes with corresponding macros from <stdbool.h> when
included before <sparse/linearize.h>.

Signed-off-by: Kamil Dudka <kdudka@redhat.com>
---
 linearize.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/linearize.h b/linearize.h
index 2205082..50b3601 100644
--- a/linearize.h
+++ b/linearize.h
@@ -328,7 +328,7 @@ struct entrypoint {
 	struct instruction *entry;
 };
 
-extern void insert_select(struct basic_block *bb, struct instruction *br, struct instruction *phi, pseudo_t true, pseudo_t false);
+extern void insert_select(struct basic_block *bb, struct instruction *br, struct instruction *phi, pseudo_t if_true, pseudo_t if_false);
 extern void insert_branch(struct basic_block *bb, struct instruction *br, struct basic_block *target);
 
 pseudo_t alloc_phi(struct basic_block *source, pseudo_t pseudo, int size);
-- 
1.6.2.5


--Boundary-00=_WwpeK+nnTQatjOH--
