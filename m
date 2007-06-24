From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 5/16] remove long-dead variable in evaluate_ptr_add()
Date: Sun, 24 Jun 2007 09:04:01 +0100
Message-ID: <E1I2N4j-0003cm-66@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:34688 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858AbXFXIEB (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 24 Jun 2007 04:04:01 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1I2N4j-0003cm-66
	for linux-sparse@vger.kernel.org; Sun, 24 Jun 2007 09:04:01 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


ptr_type in there is dead since commit 87900e832ac31d3aae63051ee054b01c17170439
(Nov 2004).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 evaluate.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 2510c2b..5eba817 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -601,12 +601,9 @@ static inline int want_int(struct expression **expr, struct symbol **ctype)
 static struct symbol *evaluate_ptr_add(struct expression *expr, struct symbol *ctype, struct expression **ip)
 {
 	struct expression *i = *ip;
-	struct symbol *ptr_type = ctype, *itype;
+	struct symbol *itype;
 	int bit_size;
 
-	if (ptr_type->type == SYM_NODE)
-		ptr_type = ptr_type->ctype.base_type;
-
 	if (!want_int(&i, &itype))
 		return bad_expr_type(expr);
 
-- 
1.5.0-rc2.GIT
