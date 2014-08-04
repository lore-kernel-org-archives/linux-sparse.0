From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] parse.c: remove duplicate 'may_alias' ignored_attributes
Date: Mon, 04 Aug 2014 21:01:41 +0100
Message-ID: <53DFE6A5.2070903@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:41041 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750831AbaHDUBp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 Aug 2014 16:01:45 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Chris,

I noticed this recently when rebasing an old branch, but forgot
to write a patch.

ATB,
Ramsay Jones

 parse.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/parse.c b/parse.c
index 69bcf82..471fb31 100644
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
2.0.0
