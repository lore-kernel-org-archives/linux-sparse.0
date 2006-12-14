From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: [PATCH] dissect: simplify lookup_member()
Date: Fri, 15 Dec 2006 00:37:15 +0300
Message-ID: <20061214213715.GB422@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.sgg.ru ([217.23.135.1]:41625 "EHLO mail.sgg.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751987AbWLNXkj (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 14 Dec 2006 18:40:39 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

Change examine_sym_node() to recursively inspect the members of SYM_STRUCT.
This allows us to simplify lookup_member(): no need to do examine_sym_node(),
the member was already examined.

This is also good because now ->r_symdef(member) is called on declaration,
not when dissect detects the first usage of ->member.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- DS/dissect.c~	2006-04-20 23:49:03.000000000 +0400
+++ DS/dissect.c	2006-04-21 00:04:18.000000000 +0400
@@ -210,13 +210,16 @@ static void examine_sym_node(struct symb
 		case SYM_STRUCT: case SYM_UNION: //case SYM_ENUM:
 			if (base->evaluated)
 				return;
+			if (!base->symbol_list)
+				return;
+			base->evaluated = 1;
+
 			if (!base->ident && name)
 				base->ident = mk_name(root, name);
-			if (!base->ident || !base->symbol_list)
-				return;
-			if (reporter->r_symdef)
+			if (base->ident && reporter->r_symdef)
 				reporter->r_symdef(base);
-			base->evaluated = 1;
+			DO_LIST(base->symbol_list, mem,
+				examine_sym_node(mem, base->ident ?: root));
 		default:
 			return;
 		}
@@ -263,14 +266,8 @@ found:
 
 static struct symbol *lookup_member(struct symbol *type, struct ident *name, int *addr)
 {
-	struct symbol *node = __lookup_member(type, name, addr);
-
-	if (node != NULL)
-		examine_sym_node(node, type->ident);
-	else
-		node = no_member(name);
-
-	return node;
+	return __lookup_member(type, name, addr)
+		?: no_member(name);
 }
 
 static struct expression *peek_preop(struct expression *expr, int op)
