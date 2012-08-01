From: Mauro Dreissig <mukadr@gmail.com>
Subject: [PATCH] Fix wrong array size expression
Date: Wed, 01 Aug 2012 13:07:35 -0300
Message-ID: <50195447.2060407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:41404 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752287Ab2HAQHk (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 1 Aug 2012 12:07:40 -0400
Received: by ghrr11 with SMTP id r11so998418ghr.19
        for <linux-sparse@vger.kernel.org>; Wed, 01 Aug 2012 09:07:39 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Signed-off-by: Mauro Dreissig <mukadr@gmail.com>
---
 expression.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/expression.c b/expression.c
index 0ae3a60..9f45c79 100644
--- a/expression.c
+++ b/expression.c
@@ -655,7 +655,7 @@ static struct token *unary_expression(struct token *token, struct expression **t
 				{ &__sizeof_ptr___ident, EXPR_PTRSIZEOF },
 			};
 			int i;
-			for (i = 0; i < 3; i++) {
+			for (i = 0; i < ARRAY_SIZE(type_information); i++) {
 				if (ident == type_information[i].id)
 					return type_info_expression(token, tree, type_information[i].type);
 			}
-- 
1.7.11.2

