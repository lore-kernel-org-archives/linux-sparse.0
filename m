From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 1/7] casting null pointer constant to non-zero address space is always OK
Date: Sun, 01 Oct 2006 14:57:11 +0100
Message-ID: <E1GU1od-0006tw-PF@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:32940 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932194AbWJAN5J
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 1 Oct 2006 09:57:09 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1GU1od-0006tw-PF
	for linux-sparse@vger.kernel.org; Sun, 01 Oct 2006 14:57:11 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 evaluate.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 0dc05b9..fd29edf 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2126,14 +2126,25 @@ static int get_as(struct symbol *sym)
 static void cast_to_as(struct expression *e, int as)
 {
 	struct expression *v = e->cast_expression;
+	struct symbol *type = v->ctype;
 
 	if (!Wcast_to_address_space)
 		return;
 
+	if (v->type != EXPR_VALUE || v->value)
+		goto out;
+
 	/* cast from constant 0 to pointer is OK */
-	if (v->type == EXPR_VALUE && is_int_type(v->ctype) && !v->value)
+	if (is_int_type(type))
+		return;
+
+	if (type->type == SYM_NODE)
+		type = type->ctype.base_type;
+
+	if (type->type == SYM_PTR && type->ctype.base_type == &void_ctype)
 		return;
 
+out:
 	warning(e->pos, "cast adds address space to expression (<asn:%d>)", as);
 }
 
-- 
1.4.2.GIT
