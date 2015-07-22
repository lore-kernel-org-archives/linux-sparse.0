From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH RFC 08/13] expression: recognize references to labels as address constants
Date: Thu, 23 Jul 2015 01:20:04 +0200
Message-ID: <87wpxrixuj.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34783 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125AbbGVXUH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 22 Jul 2015 19:20:07 -0400
Received: by wibud3 with SMTP id ud3so584897wib.1
        for <linux-sparse@vger.kernel.org>; Wed, 22 Jul 2015 16:20:06 -0700 (PDT)
Received: from localhost.localdomain (x55b1cac6.dyn.telefonica.de. [85.177.202.198])
        by smtp.gmail.com with ESMTPSA id gt10sm5589375wib.20.2015.07.22.16.20.05
        for <linux-sparse@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2015 16:20:05 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

As an extension, GCC allows labels to be referenced a la
  label1:
  ...

  void *ptr = &&label1;

Tag these label references as being address constants allowing them
to be used as initializers for objects of static storage duration.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 expression.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/expression.c b/expression.c
index 4d5edc8..19786e8 100644
--- a/expression.c
+++ b/expression.c
@@ -684,6 +684,8 @@ static struct token *unary_expression(struct token *token, struct expression **t
 				sym->ctype.modifiers |= MOD_ADDRESSABLE;
 				add_symbol(&function_computed_target_list, sym);
 			}
+			label->flags |=
+				expr_set_flag_mask(EXPR_FLAG_ADDR_CONST_EXPR);
 			label->label_symbol = sym;
 			*tree = label;
 			return token->next->next;
-- 
2.4.5

