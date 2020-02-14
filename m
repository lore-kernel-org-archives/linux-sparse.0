From: Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 1/3] struct_union_enum_specifier: set MOD_TOPLEVEL if
 toplevel(sym->scope)
Date: Fri, 14 Feb 2020 12:33:20 +0100
Message-ID: <20200214113320.GA31578@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40222 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726092AbgBNLd2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 14 Feb 2020 06:33:28 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

With this change dissect can know the scope of SYM_STRUCT/UNION/ENUM,
see the next patch.

Note that MOD_TOPLEVEL can be set even if struct/union/enum type is
private and bind_symbol() is not called.

IIUC nobody else looks at SYM_STRUCT->ctype.modifiers, "make check"
doesn't show any difference.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 parse.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/parse.c b/parse.c
index a08165a..4492586 100644
--- a/parse.c
+++ b/parse.c
@@ -741,6 +741,8 @@ static struct token *struct_union_enum_specifier(enum type type,
 			// symbol being redefined.
 			sym = alloc_symbol(token->pos, type);
 			bind_symbol(sym, token->ident, NS_STRUCT);
+			if (toplevel(sym->scope))
+				sym->ctype.modifiers |= MOD_TOPLEVEL;
 		}
 		if (sym->type != type)
 			error_die(token->pos, "invalid tag applied to %s", show_typename (sym));
@@ -772,6 +774,8 @@ static struct token *struct_union_enum_specifier(enum type type,
 	}
 
 	sym = alloc_symbol(token->pos, type);
+	if (toplevel(block_scope))
+		sym->ctype.modifiers |= MOD_TOPLEVEL;
 	token = parse(token->next, sym);
 	ctx->ctype.base_type = sym;
 	token =  expect(token, '}', "at end of specifier");
-- 
2.5.0
