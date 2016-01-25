From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH v2 08/13] expression: recognize references to labels as address constants
Date: Mon, 25 Jan 2016 15:59:37 +0100
Message-ID: <87vb6hemcm.fsf@gmail.com>
References: <87twm1g1go.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35646 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757253AbcAYO7k (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Jan 2016 09:59:40 -0500
Received: by mail-wm0-f67.google.com with SMTP id 123so11799356wmz.2
        for <linux-sparse@vger.kernel.org>; Mon, 25 Jan 2016 06:59:39 -0800 (PST)
In-Reply-To: <87twm1g1go.fsf@gmail.com> (Nicolai Stange's message of "Mon, 25
	Jan 2016 15:47:51 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Nicolai Stange <nicstange@gmail.com>, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

As an extension, GCC allows labels to be referenced a la
  label1:
  ...

  void *ptr = &&label1;

Tag these label references as being address constants allowing them
to be used as initializers for objects of static storage duration.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 expression.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/expression.c b/expression.c
index afc4f39..b82a036 100644
--- a/expression.c
+++ b/expression.c
@@ -683,6 +683,7 @@ static struct token *unary_expression(struct token *token, struct expression **t
 				sym->ctype.modifiers |= MOD_ADDRESSABLE;
 				add_symbol(&function_computed_target_list, sym);
 			}
+			expr_set_flag(&label->flags, EXPR_FLAG_ADDR_CONST_EXPR);
 			label->label_symbol = sym;
 			*tree = label;
 			return token->next->next;
-- 
2.7.0

