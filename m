From: =?ISO-8859-1?Q?Jan_Pokorn=FD?= <pokorny_jan@seznam.cz>
Subject: [PATCH] flow.c: make comment for `dominates' reflect code
Date: Fri, 08 Apr 2011 00:42:47 +0200
Message-ID: <4D9E3DE7.3080003@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fep19.mx.upcmail.net ([62.179.121.39]:53259 "EHLO
	fep19.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756280Ab1DGWmw (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 7 Apr 2011 18:42:52 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: linux-sparse@vger.kernel.org

Signed-off-by: Jan Pokorny <pokorny_jan@seznam.cz>
---
 flow.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/flow.c b/flow.c
index 5bd9a1d..7db9548 100644
--- a/flow.c
+++ b/flow.c
@@ -284,8 +284,8 @@ static inline int same_memop(struct instruction *a, struct instruction *b)
 }
 
 /*
- * Return 1 if "one" dominates the access to 'pseudo'
- * in insn.
+ * Return 1 if "dom" dominates the access to "pseudo"
+ * in "insn".
  *
  * Return 0 if it doesn't, and -1 if you don't know.
  */
-- 
1.7.1
