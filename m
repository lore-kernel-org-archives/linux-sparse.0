From: Michael Buesch <mb@bu3sch.de>
Subject: [PATCH] let sparse warn on &inline_function
Date: Sat, 20 May 2006 16:21:48 +0200
Message-ID: <200605201621.48466.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:58496
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S964860AbWETOWx
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 20 May 2006 10:22:53 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Cc: Johannes Berg <johannes@sipsolutions.net>

Let sparse warn, if we take pointers to inline functions.

Signed-off-by: Michael Buesch <mb@bu3sch.de>

diff --git a/evaluate.c b/evaluate.c
index 2c70cee..1cf562f 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1297,6 +1297,8 @@ static struct symbol *create_pointer(str
 		warning(expr->pos, "taking address of 'register' variable '%s'", show_ident(sym->ident));
 		sym->ctype.modifiers &= ~MOD_REGISTER;
 	}
+	if (sym->ctype.modifiers & MOD_INLINE)
+		warning(expr->pos, "taking address of 'inline' function '%s'", show_ident(sym->ident));
 	if (sym->type == SYM_NODE) {
 		ptr->ctype.as |= sym->ctype.as;
 		ptr->ctype.modifiers |= sym->ctype.modifiers & MOD_PTRINHERIT;
