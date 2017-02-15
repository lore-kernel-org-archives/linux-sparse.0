From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/4] fix show-parse()'s labels
Date: Wed, 15 Feb 2017 23:13:58 +0100
Message-ID: <20170215221358.68400-5-luc.vanoostenryck@gmail.com>
References: <20170215221358.68400-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33123 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752609AbdBOWOK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 15 Feb 2017 17:14:10 -0500
Received: by mail-wm0-f66.google.com with SMTP id v77so472877wmv.0
        for <linux-sparse@vger.kernel.org>; Wed, 15 Feb 2017 14:14:09 -0800 (PST)
In-Reply-To: <20170215221358.68400-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

show_statement() sometimes displays BBs as "L0x0" because
it uses the symbol::bb_target field which is never set when
show_statement() is usefull (before or during linearization).

Fix this by using the address of the underlaying symbol like
done when displaying others BBs (for example for the label at
the beginning of a BB).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 show-parse.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/show-parse.c b/show-parse.c
index fb5437555..d365d737f 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -529,14 +529,14 @@ static void show_switch_statement(struct statement *stmt)
 			} else
 				printf("    what?");
 		}
-		printf(": .L%p\n", sym->bb_target);
+		printf(": .L%p\n", sym);
 	} END_FOR_EACH_PTR(sym);
 	printf("# end case table\n");
 
 	show_statement(stmt->switch_statement);
 
 	if (stmt->switch_break->used)
-		printf(".L%p:\n", stmt->switch_break->bb_target);
+		printf(".L%p:\n", stmt->switch_break);
 }
 
 static void show_symbol_decl(struct symbol_list *syms)
@@ -683,7 +683,7 @@ int show_statement(struct statement *stmt)
 			int val = show_expression(stmt->goto_expression);
 			printf("\tgoto\t\t*v%d\n", val);
 		} else {
-			printf("\tgoto\t\t.L%p\n", stmt->goto_label->bb_target);
+			printf("\tgoto\t\t.L%p\n", stmt->goto_label);
 		}
 		break;
 	case STMT_ASM:
-- 
2.11.0

