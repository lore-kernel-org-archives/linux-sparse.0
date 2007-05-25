From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH] handle __alignof as equivalent of __alignof__
Date: Fri, 25 May 2007 04:57:29 +0100
Message-ID: <E1HrQvh-00018A-IV@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:58092 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbXEYD5a (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 May 2007 23:57:30 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1HrQvh-00018A-IV
	for linux-sparse@vger.kernel.org; Fri, 25 May 2007 04:57:29 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 expression.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/expression.c b/expression.c
index 457e1fd..cf076a9 100644
--- a/expression.c
+++ b/expression.c
@@ -544,6 +544,7 @@ static struct token *unary_expression(struct token *token, struct expression **t
 			} type_information[] = {
 				{ &sizeof_ident, EXPR_SIZEOF },
 				{ &__alignof___ident, EXPR_ALIGNOF },
+				{ &__alignof_ident, EXPR_ALIGNOF },
 				{ &__sizeof_ptr___ident, EXPR_PTRSIZEOF },
 			};
 			int i;
-- 
1.5.0-rc2.GIT
