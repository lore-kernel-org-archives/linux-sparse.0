From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/4] Add support for show_data()
Date: Sun,  1 Feb 2015 03:19:44 +0100
Message-ID: <1422757186-8007-3-git-send-email-luc.vanoostenryck@gmail.com>
References: <CANeU7QnQWRRB1kmt7KOjuJ4PFasefaX91yPZ-DEYxE2qUzxX3A@mail.gmail.com>
 <1422757186-8007-1-git-send-email-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:51749 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754334AbbBACUc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 31 Jan 2015 21:20:32 -0500
Received: by mail-wi0-f169.google.com with SMTP id h11so9514249wiw.0
        for <linux-sparse@vger.kernel.org>; Sat, 31 Jan 2015 18:20:31 -0800 (PST)
In-Reply-To: <1422757186-8007-1-git-send-email-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: linux-sparse@vger.kernel.org, linux@rasmusvillemoes.dk, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The purpose of show_data() is to visualize data, more or less
like show_entry() allow to visualize the code.

The support is not complete but at least the basic types are handled.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 linearize.h |  1 +
 2 files changed, 87 insertions(+)

diff --git a/linearize.c b/linearize.c
index c6ada1e8..28beb271 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2220,3 +2220,89 @@ struct entrypoint *linearize_symbol(struct symbol *sym)
 		return linearize_fn(sym, base_type);
 	return NULL;
 }
+
+static void do_indent(int level)
+{
+	while (level--)
+		printf("\t");
+}
+
+static void show_data_expr(struct expression *expr, int indent)
+{
+	struct expression *entry;
+	struct symbol *sym;
+
+	switch (expr->type) {
+	case EXPR_VALUE:
+		printf("%lld", expr->value);
+		break;
+	case EXPR_SYMBOL:
+		sym = expr->symbol;
+		if (sym->initializer && sym->initializer->type == EXPR_STRING)
+			return show_data_expr(sym->initializer, indent);
+		printf("%s", show_ident(expr->symbol_name));
+		break;
+	case EXPR_IMPLIED_CAST:
+		show_data_expr(expr->cast_expression, indent);
+		break;
+	case EXPR_STRING:
+		printf("%s", show_string(expr->string));
+		break;
+	case EXPR_INITIALIZER:
+		printf("{");
+		FOR_EACH_PTR(expr->expr_list, entry) {
+			switch (entry->type) {
+			case EXPR_POS:
+			case EXPR_INDEX:
+			case EXPR_IDENTIFIER:
+				continue;
+			}
+			do_indent(indent+1);
+			show_data_expr(entry, indent+1);
+			printf(",\n");
+		} END_FOR_EACH_PTR(entry);
+		do_indent(indent);
+		printf("}");
+		break;
+	case EXPR_PREOP:
+		if (expr->op == '*') {
+			show_data_expr(expr->unop, indent);
+			break;
+		}
+		// Fall through
+	default:
+		printf("!!unhandled expression type (%d)", expr->type);
+		break;
+	}
+}
+
+void show_data(struct symbol *sym)
+{
+	struct expression *expr = sym->initializer;
+
+	printf("symbol %s:\n", show_ident(sym->ident));
+	printf("\t"); show_type(sym); printf("\n");
+	printf("\tbit_size = %i\n", sym->bit_size);
+	printf("\tval = ");
+	switch (sym->ctype.base_type->type) {
+	case SYM_BASETYPE:
+	case SYM_ENUM:
+		show_data_expr(expr, 0);
+		break;
+	case SYM_PTR:
+		printf("&");
+		show_data_expr(expr, 0);
+		break;
+	case SYM_ARRAY:
+		show_data_expr(expr, 0);
+		break;
+	case SYM_STRUCT:
+	case SYM_UNION:
+		show_data_expr(expr, 1);
+		break;
+	default:
+		printf("\ttype = %d\n", sym->ctype.base_type->type);
+		break;
+	}
+	printf("\n");
+}
diff --git a/linearize.h b/linearize.h
index 61fbd831..7b2d0681 100644
--- a/linearize.h
+++ b/linearize.h
@@ -344,6 +344,7 @@ void show_entry(struct entrypoint *ep);
 const char *show_pseudo(pseudo_t pseudo);
 void show_bb(struct basic_block *bb);
 const char *show_instruction(struct instruction *insn);
+void show_data(struct symbol *sym);
 
 #endif /* LINEARIZE_H */
 
-- 
2.2.0

