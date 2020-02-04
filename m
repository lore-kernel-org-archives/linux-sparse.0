From: Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 2/4] dissect: turn mk_name() into deanon()
Date: Tue, 4 Feb 2020 17:51:40 +0100
Message-ID: <20200204165140.GA24343@redhat.com>
References: <20200204165119.GA24330@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58062 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgBDQwC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 4 Feb 2020 11:52:02 -0500
In-Reply-To: <20200204165119.GA24330@redhat.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

Preparation. Change mk_name() to initialize base->ident itself, simplify it,
and rename to deanon().

Also change examine_sym_node() to accept "struct symbol *parent" rather than
"struct ident *root". Currently it is only used as ->ident holder, but this
will be changed.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/dissect.c b/dissect.c
index ff3a313..d34b38a 100644
--- a/dissect.c
+++ b/dissect.c
@@ -190,18 +190,22 @@ static struct symbol *report_symbol(usage_t mode, struct expression *expr)
 	return ret;
 }
 
-static inline struct ident *mk_name(struct ident *root, struct ident *node)
+static bool deanon(struct symbol *base, struct ident *node, struct symbol *parent)
 {
+	struct ident *pi = parent ? parent->ident : NULL;
 	char name[256];
 
+	if (!node)
+		return false;
+
 	snprintf(name, sizeof(name), "%.*s:%.*s",
-			root ? root->len : 0, root ? root->name : "",
-			node ? node->len : 0, node ? node->name : "");
+		pi ? pi->len : 0, pi ? pi->name : NULL, node->len, node->name);
 
-	return built_in_ident(name);
+	base->ident = built_in_ident(name);
+	return true;
 }
 
-static void examine_sym_node(struct symbol *node, struct ident *root)
+static void examine_sym_node(struct symbol *node, struct symbol *parent)
 {
 	struct symbol *base;
 	struct ident *name;
@@ -232,12 +236,12 @@ static void examine_sym_node(struct symbol *node, struct ident *root)
 				return;
 			base->evaluated = 1;
 
-			if (!base->ident && name)
-				base->ident = mk_name(root, name);
-			if (base->ident && reporter->r_symdef)
-				reporter->r_symdef(base);
+			if (base->ident || deanon(base, name, parent)) {
+				if (reporter->r_symdef)
+					reporter->r_symdef(base);
+			}
 			DO_LIST(base->symbol_list, mem,
-				examine_sym_node(mem, base->ident ?: root));
+				examine_sym_node(mem, base->ident ? base : parent));
 		default:
 			return;
 		}
-- 
2.5.0
