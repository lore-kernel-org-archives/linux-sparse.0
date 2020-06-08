From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] generic: fix crash when nothing match
Date: Tue,  9 Jun 2020 01:32:38 +0200
Message-ID: <20200608233238.66101-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732490AbgFHXcp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 8 Jun 2020 19:32:45 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F36C08C5C2
        for <linux-sparse@vger.kernel.org>; Mon,  8 Jun 2020 16:32:44 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id m21so14828670eds.13
        for <linux-sparse@vger.kernel.org>; Mon, 08 Jun 2020 16:32:44 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The code for the generic selection doesn't take in account
the fact that the default entry could be absent.

Catch the case where nothing matches and issue an error.

Fixes: c100a7ab2504f9e6fe6b6d3f9a010a8ea5ed30a3
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                |  8 ++++++--
 validation/generic-bad0.c | 23 +++++++++++++++++++++++
 2 files changed, 29 insertions(+), 2 deletions(-)
 create mode 100644 validation/generic-bad0.c

diff --git a/evaluate.c b/evaluate.c
index bc69a1fa57ee..95aef4dc0758 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3299,11 +3299,15 @@ static struct symbol *evaluate_generic_selection(struct expression *expr)
 			continue;
 
 		res = map->expr;
-		goto end;
+		goto found;
 	}
 	res = expr->def;
+	if (!res) {
+		sparse_error(expr->pos, "no generic selection for '%s'", show_typename(ctrl));
+		return NULL;
+	}
 
-end:
+found:
 	*expr = *res;
 	return evaluate_expression(expr);
 }
diff --git a/validation/generic-bad0.c b/validation/generic-bad0.c
new file mode 100644
index 000000000000..acc3d5e78b53
--- /dev/null
+++ b/validation/generic-bad0.c
@@ -0,0 +1,23 @@
+struct s;
+
+void foo(int n)
+{
+	_Generic(n, default: 1, default: 2);
+	_Generic(n, int[n]:0, default:1);
+	_Generic(n, struct s:0, default:1);
+	_Generic(n, void:0, default:1);
+	_Generic(n, void (void):0, default:1);
+	_Generic(&n, int:5, signed int:7, default:23);
+	_Generic(n, void *:5);
+}
+
+/*
+ * check-name: generic-bad0
+ *
+ * check-error-start
+generic-bad0.c:5:33: warning: multiple default in generic expression
+generic-bad0.c:5:30: note: previous was here
+generic-bad0.c:6:25: warning: Variable length array is used.
+generic-bad0.c:11:17: error: no generic selection for 'int [addressable] n'
+ * check-error-end
+ */
-- 
2.27.0
