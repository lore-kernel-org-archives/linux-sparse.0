From: Martin Kepplinger <martink@posteo.de>
Subject: [PATCH] compile-i386: make use of expression_list_size()
Date: Fri, 15 Sep 2017 09:02:19 +0200
Message-ID: <20170915070219.29239-1-martink@posteo.de>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mout02.posteo.de ([185.67.36.66]:57333 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750871AbdIOHC1 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:02:27 -0400
Received: from submission (posteo.de [89.146.220.130])
        by mout02.posteo.de (Postfix) with ESMTPS id BA4F220F51
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 09:02:25 +0200 (CEST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org, jgarzik@pobox.com
Cc: linux-sparse@vger.kernel.org, Martin Kepplinger <martink@posteo.de>

Instead of doing it my hand, there is the expression_list_size() API we
can use here.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---

This only builds. I have *not* tested it in any way though!!!



 compile-i386.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/compile-i386.c b/compile-i386.c
index e4d3f27..12fbcc7 100644
--- a/compile-i386.c
+++ b/compile-i386.c
@@ -997,11 +997,7 @@ static void sort_array(struct expression *expr)
 	struct expression *entry, **list;
 	unsigned int elem, sorted, i;
 
-	elem = 0;
-	FOR_EACH_PTR(expr->expr_list, entry) {
-		elem++;
-	} END_FOR_EACH_PTR(entry);
