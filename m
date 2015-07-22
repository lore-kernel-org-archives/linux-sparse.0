From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH RFC 13/13] symbol: do not inherit storage modifiers from base types at examination
Date: Thu, 23 Jul 2015 01:24:41 +0200
Message-ID: <87bnf3ixmu.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33751 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbbGVXYo (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 22 Jul 2015 19:24:44 -0400
Received: by wicmv11 with SMTP id mv11so715227wic.0
        for <linux-sparse@vger.kernel.org>; Wed, 22 Jul 2015 16:24:43 -0700 (PDT)
Received: from localhost.localdomain (x55b1cac6.dyn.telefonica.de. [85.177.202.198])
        by smtp.gmail.com with ESMTPSA id lj2sm55312wic.1.2015.07.22.16.24.42
        for <linux-sparse@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2015 16:24:42 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Consider the following code snippet:
  static inline foo(int dummy, ...) {}
  static int a = 0;
  static void bar(void)
  {
  	foo(0, a);
  }

Sparse moans:
  test.c:5:9: warning: initializer for static storage duration object
              is not a constant expression

The cause can be tracked down as follows:
The anonymous node created by inline_function() for the variadic
argument will get assigned to its base_type whatever the passed
expression's ctype is. For the special case of a primary expression
referencing a symbol, this ctype is the referenced symbol itself.
Furthermore, inline_function() sets that symbol node's initializer
to this expression.

Now, when the anonymous symbol node is evaluated, its base_type is
handled in examine_base_type(). This applies the base_type's modifiers,
i.e. the referenced symbol's MOD_STATIC in this case, to the inheriting
ctype, that of the anonymous node, itself.
This in turn instructs the evaluation of the symbol's initializer to
allow constant expressions only.

Do not inherit a base_type's storage related modifiers in
examine_base_type().

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 symbol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/symbol.c b/symbol.c
index cbc846b..605ec1c 100644
--- a/symbol.c
+++ b/symbol.c
@@ -214,7 +214,8 @@ static struct symbol *examine_base_type(struct symbol *sym)
 	if (!base_type || base_type->type == SYM_PTR)
 		return base_type;
 	sym->ctype.as |= base_type->ctype.as;
-	sym->ctype.modifiers |= base_type->ctype.modifiers & MOD_PTRINHERIT;
+	sym->ctype.modifiers |= base_type->ctype.modifiers & MOD_PTRINHERIT &
+		~MOD_STORAGE;
 	concat_ptr_list((struct ptr_list *)base_type->ctype.contexts,
 			(struct ptr_list **)&sym->ctype.contexts);
 	if (base_type->type == SYM_NODE) {
-- 
2.4.5

