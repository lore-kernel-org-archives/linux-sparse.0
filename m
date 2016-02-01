From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH v3 20/21] symbol: do not inherit storage modifiers from base types at examination
Date: Mon, 01 Feb 2016 03:46:31 +0100
Message-ID: <877fipgnaw.fsf@gmail.com>
References: <87lh75jh9l.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36627 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177AbcBACqe (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 31 Jan 2016 21:46:34 -0500
Received: by mail-wm0-f67.google.com with SMTP id 128so7042117wmz.3
        for <linux-sparse@vger.kernel.org>; Sun, 31 Jan 2016 18:46:33 -0800 (PST)
In-Reply-To: <87lh75jh9l.fsf@gmail.com> (Nicolai Stange's message of "Mon, 01
	Feb 2016 03:28:38 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nicolai Stange <nicstange@gmail.com>

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
index 42e6a8f..4766adb 100644
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
2.7.0

