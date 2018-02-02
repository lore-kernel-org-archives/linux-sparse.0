From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix examination of bad typeof
Date: Fri,  2 Feb 2018 19:53:07 +0100
Message-ID: <20180202185307.78965-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52277 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752826AbeBBSxQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 2 Feb 2018 13:53:16 -0500
Received: by mail-wm0-f66.google.com with SMTP id g1so14611826wmg.2
        for <linux-sparse@vger.kernel.org>; Fri, 02 Feb 2018 10:53:15 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

When the operand of typeof() is invalid, the corresponding
type is also invalid and can't be used. But currently,
when the corresponding SYM_TYPEOF symbol is examined,
this symbol is then simply returned as is. This, of course,
create problem for subsequent code since an examined type is
not supposed to be a SYM_TYPEOF anymore (one of the symptoms
will be warning about "unknown type 11").

Fix this by changing the SYM_TYPEOF into a SYM_NODE (as it's
expect) but pointing to bad_ctype. So further processing gently
continue and the 'bad_ctype' will do its job when needed.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.c                |  4 +++-
 validation/typeof-bad.c | 17 +++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100644 validation/typeof-bad.c

diff --git a/symbol.c b/symbol.c
index e87cd1cb3..7e46ba9c4 100644
--- a/symbol.c
+++ b/symbol.c
@@ -496,7 +496,9 @@ struct symbol *examine_symbol_type(struct symbol * sym)
 			sym->ctype.base_type = base;
 			return examine_node_type(sym);
 		}
-		break;
+		sym->type = SYM_NODE;
+		sym->ctype.base_type = &bad_ctype;
+		return sym;
 	}
 	case SYM_PREPROCESSOR:
 		sparse_error(sym->pos, "ctype on preprocessor command? (%s)", show_ident(sym->ident));
diff --git a/validation/typeof-bad.c b/validation/typeof-bad.c
new file mode 100644
index 000000000..a9366bad1
--- /dev/null
+++ b/validation/typeof-bad.c
@@ -0,0 +1,17 @@
+static typeof(undef) a;
+
+static int foo(void)
+{
+	return a;
+}
+
+/*
+ * check-name: typeof-bad
+ *
+ * check-error-start
+typeof-bad.c:1:15: error: undefined identifier 'undef'
+typeof-bad.c:5:16: warning: incorrect type in return expression (different base types)
+typeof-bad.c:5:16:    expected int
+typeof-bad.c:5:16:    got bad type static [toplevel] a
+ * check-error-end
+ */
-- 
2.16.0

