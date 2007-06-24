From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 15/16] deal with enum members without excessive PITA
Date: Sun, 24 Jun 2007 09:05:41 +0100
Message-ID: <E1I2N6L-0003fT-82@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:34747 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355AbXFXIFm (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 24 Jun 2007 04:05:42 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1I2N6L-0003fT-82
	for linux-sparse@vger.kernel.org; Sun, 24 Jun 2007 09:05:41 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


mark symbols for enum members, have primary_expression() copy their
->initializer instead of dancing through the EXRP_SYMBOL with
expand_expression() finally getting to the damn thing.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 expression.c |    7 +++++++
 parse.c      |    1 +
 symbol.h     |    2 +-
 3 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/expression.c b/expression.c
index cf076a9..a40ab2b 100644
--- a/expression.c
+++ b/expression.c
@@ -359,6 +359,13 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 				token = builtin_types_compatible_p_expr(token, &expr);
 				break;
 			}
+		} else if (sym->enum_member) {
+			expr = alloc_expression(token->pos, EXPR_VALUE);
+			*expr = *sym->initializer;
+			/* we want the right position reported, thus the copy */
+			expr->pos = token->pos;
+			token = next;
+			break;
 		}
 
 		expr = alloc_expression(token->pos, EXPR_SYMBOL);
diff --git a/parse.c b/parse.c
index cfbf190..4e8a18b 100644
--- a/parse.c
+++ b/parse.c
@@ -667,6 +667,7 @@ static struct token *parse_enum_declaration(struct token *token, struct symbol *
 		}
 
 		sym->initializer = expr;
+		sym->enum_member = 1;
 		sym->ctype.base_type = parent;
 		add_ptr_list(&entries, sym);
 
diff --git a/symbol.h b/symbol.h
index 157346d..2bde84d 100644
--- a/symbol.h
+++ b/symbol.h
@@ -109,7 +109,7 @@ extern int expand_constant_p(struct expression *expr, int cost);
 struct symbol {
 	enum type type:8;
 	enum namespace namespace:9;
-	unsigned char used:1, attr:2;
+	unsigned char used:1, attr:2, enum_member:1;
 	struct position pos;		/* Where this symbol was declared */
 	struct ident *ident;		/* What identifier this symbol is associated with */
 	struct symbol *next_id;		/* Next semantic symbol that shares this identifier */
-- 
1.5.0-rc2.GIT
