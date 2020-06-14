From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] attribute: parse but ignore enum attributes
Date: Sun, 14 Jun 2020 18:02:35 +0200
Message-ID: <20200614160235.22320-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbgFNQCl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 14 Jun 2020 12:02:41 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869B5C05BD43
        for <linux-sparse@vger.kernel.org>; Sun, 14 Jun 2020 09:02:41 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id c35so9750491edf.5
        for <linux-sparse@vger.kernel.org>; Sun, 14 Jun 2020 09:02:41 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, sparse is confused whne encountering an enum attribute.

Teach sparse about these attributes and, for now, ignore them.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/parse.c b/parse.c
index 570b2516714f..70d8b237ce5e 100644
--- a/parse.c
+++ b/parse.c
@@ -937,8 +937,12 @@ static struct token *parse_enum_declaration(struct token *token, struct symbol *
 	while (token_type(token) == TOKEN_IDENT) {
 		struct expression *expr = NULL;
 		struct token *next = token->next;
+		struct decl_state ctx = { };
 		struct symbol *sym;
 
+		// FIXME: only 'deprecated' should be accepted
+		next = handle_attributes(next, &ctx, KW_ATTRIBUTE);
+
 		if (match_op(next, '=')) {
 			next = constant_expression(next->next, &expr);
 			lastval = get_expression_value(expr);
-- 
2.27.0
