From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH] fix interaction of typeof with bitwise types
Date: Fri, 25 May 2007 04:57:49 +0100
Message-ID: <E1HrQw1-00018q-JI@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:58096 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbXEYD5u (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 May 2007 23:57:50 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1HrQw1-00018q-JI
	for linux-sparse@vger.kernel.org; Fri, 25 May 2007 04:57:49 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


typeof(bitwise) should resolve to the same SYM_RESTRICT type node, not just
to a copy of its contents.  Similar problem exists for struct and union,
BTW, but that's a separate story.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 symbol.c                       |    6 ++++++
 validation/restricted-typeof.c |    4 ++++
 2 files changed, 10 insertions(+), 0 deletions(-)
 create mode 100644 validation/restricted-typeof.c

diff --git a/symbol.c b/symbol.c
index 20a04f3..abdc734 100644
--- a/symbol.c
+++ b/symbol.c
@@ -408,6 +408,12 @@ struct symbol *examine_symbol_type(struct symbol * sym)
 				warning(base->pos, "typeof applied to bitfield type");
 			if (base->type == SYM_NODE)
 				base = base->ctype.base_type;
+			if (base->type == SYM_RESTRICT) {
+				sym->type = SYM_NODE;
+				sym->ctype.modifiers = 0;
+				sym->ctype.base_type = base;
+				return examine_node_type(sym);
+			}
 			*sym = *base;
 			break;
 		}
diff --git a/validation/restricted-typeof.c b/validation/restricted-typeof.c
new file mode 100644
index 0000000..be77af8
--- /dev/null
+++ b/validation/restricted-typeof.c
@@ -0,0 +1,4 @@
+typedef unsigned __attribute__((bitwise)) A;
+A x;
+__typeof__(x) y;
+A *p = &y;
-- 
1.5.0-rc2.GIT
