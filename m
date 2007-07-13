From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 3/8] integer_promotions() can't get SYM_NODE
Date: Fri, 13 Jul 2007 18:44:47 +0100
Message-ID: <E1I9PCB-0000EF-51@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:49725 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbXGMRor (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 13 Jul 2007 13:44:47 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1I9PCB-0000EF-51
	for linux-sparse@vger.kernel.org; Fri, 13 Jul 2007 18:44:47 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 evaluate.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 7669c9a..88435da 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -98,17 +98,12 @@ static struct symbol *evaluate_string(struct expression *expr)
 	return sym;
 }
 
+/* type has come from classify_type and is an integer type */
 static inline struct symbol *integer_promotion(struct symbol *type)
 {
 	struct symbol *orig_type = type;
 	unsigned long mod =  type->ctype.modifiers;
-	int width;
-
-	if (type->type == SYM_NODE)
-		type = type->ctype.base_type;
-	if (type->type == SYM_ENUM)
-		type = type->ctype.base_type;
-	width = type->bit_size;
+	int width = type->bit_size;
 
 	/*
 	 * Bitfields always promote to the base type,
-- 
1.5.0-rc2.GIT
