From: Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 4/4] dissect: disallow NULL pointers in struct reporter
Date: Tue, 4 Feb 2020 17:51:44 +0100
Message-ID: <20200204165144.GA24349@redhat.com>
References: <20200204165119.GA24330@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53535 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727310AbgBDQvx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 4 Feb 2020 11:51:53 -0500
In-Reply-To: <20200204165119.GA24330@redhat.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

This makes dissect.c a bit more readable.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/dissect.c b/dissect.c
index 57dcdb2..88eaab1 100644
--- a/dissect.c
+++ b/dissect.c
@@ -135,7 +135,7 @@ static struct symbol *report_member(usage_t mode, struct position *pos,
 {
 	struct symbol *ret = mem->ctype.base_type;
 
-	if (mem->ident && reporter->r_member)
+	if (mem->ident)
 		reporter->r_member(fix_mode(ret, mode), pos, type, mem);
 
 	return ret;
@@ -146,9 +146,6 @@ static void report_implicit(usage_t mode, struct position *pos, struct symbol *t
 	if (type->type != SYM_STRUCT && type->type != SYM_UNION)
 		return;
 
-	if (!reporter->r_member)
-		return;
-
 	if (type->ident != NULL)
 		reporter->r_member(mode, pos, type, NULL);
 
@@ -184,8 +181,7 @@ static struct symbol *report_symbol(usage_t mode, struct expression *expr)
 	if (0 && ret->type == SYM_ENUM)
 		return report_member(mode, &expr->pos, ret, expr->symbol);
 
-	if (reporter->r_symbol)
-		reporter->r_symbol(fix_mode(ret, mode), &expr->pos, sym);
+	reporter->r_symbol(fix_mode(ret, mode), &expr->pos, sym);
 
 	return ret;
 }
@@ -238,10 +234,8 @@ static void examine_sym_node(struct symbol *node, struct symbol *parent)
 				return;
 			base->evaluated = 1;
 
-			if (base->ident || deanon(base, name, parent)) {
-				if (reporter->r_symdef)
-					reporter->r_symdef(base);
-			}
+			if (base->ident || deanon(base, name, parent))
+				reporter->r_symdef(base);
 			DO_LIST(base->symbol_list, mem,
 				examine_sym_node(mem, base->ident ? base : parent));
 		default:
@@ -577,19 +571,15 @@ static struct symbol *do_initializer(struct symbol *type, struct expression *exp
 
 static inline struct symbol *do_symbol(struct symbol *sym)
 {
-	struct symbol *type;
