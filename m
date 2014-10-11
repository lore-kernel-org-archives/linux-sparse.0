From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 3/4] parse.c: remove duplicate 'may_alias' ignored_attributes
Date: Sat, 11 Oct 2014 20:58:14 +0100
Message-ID: <54398BD6.6070908@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta004.mxout.tch.inty.net ([91.221.169.45]:46288 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751075AbaJKT6Q (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 11 Oct 2014 15:58:16 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 parse.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/parse.c b/parse.c
index 896420b..b43d683 100644
--- a/parse.c
+++ b/parse.c
@@ -548,8 +548,6 @@ const char *ignored_attributes[] = {
 	"__l1_data__",
 	"l2",
 	"__l2__",
-	"may_alias",
-	"__may_alias__",
 	"malloc",
 	"__malloc__",
 	"may_alias",
-- 
2.1.0
