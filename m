From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/5] fix checking of overlapping initializer
Date: Wed, 22 Feb 2017 16:30:05 +0100
Message-ID: <20170222153006.3035-5-luc.vanoostenryck@gmail.com>
References: <20170221110355.GD300@arm.com>
 <20170222153006.3035-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33386 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932833AbdBVQb3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Feb 2017 11:31:29 -0500
Received: by mail-wm0-f68.google.com with SMTP id v77so1319406wmv.0
        for <linux-sparse@vger.kernel.org>; Wed, 22 Feb 2017 08:31:28 -0800 (PST)
In-Reply-To: <20170222153006.3035-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Boyd <stephen.boyd@linaro.org>, Will Deacon <will.deacon@arm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The current routine checking if some initializers overlap with each
others only check the offset of the initialierd fields, not taking
in account that array elements can be initialized by range with the
'[a ... b]' notation.

Fix this by changing the check so that now we compare the offset of
the current field with the end of the previous one.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 expand.c                    | 25 +++++++++++++++++++++++--
 validation/field-override.c |  1 -
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/expand.c b/expand.c
index 48cfa33d8..80699c4d6 100644
--- a/expand.c
+++ b/expand.c
@@ -896,6 +896,20 @@ static unsigned long bit_offset(const struct expression *expr)
 	return offset;
 }
 
+static unsigned long bit_range(const struct expression *expr)
+{
+	unsigned long range = 0;
+	unsigned long size = 0;
+	while (expr->type == EXPR_POS) {
+		unsigned long nr = expr->init_nr;
+		size = expr->ctype->bit_size;
+		range += (nr - 1) * size;
+		expr = expr->init_expr;
+	}
+	range += size;
+	return range;
+}
+
 static int compare_expressions(const void *_a, const void *_b)
 {
 	const struct expression *a = _a;
@@ -914,21 +928,28 @@ static void sort_expression_list(struct expression_list **list)
 static void verify_nonoverlapping(struct expression_list **list)
 {
 	struct expression *a = NULL;
+	unsigned long max = 0;
 	struct expression *b;
 
 	if (!Woverride_init)
 		return;
 
 	FOR_EACH_PTR(*list, b) {
+		unsigned long off, end;
 		if (!b->ctype || !b->ctype->bit_size)
 			continue;
-		if (a && bit_offset(a) == bit_offset(b)) {
+		off = bit_offset(b);
+		if (a && off < max) {
 			warning(a->pos, "Initializer entry defined twice");
 			info(b->pos, "  also defined here");
 			if (!Woverride_init_all)
 				return;
 		}
-		a = b;
+		end = off + bit_range(b);
+		if (end > max) {
+			max = end;
+			a = b;
+		}
 	} END_FOR_EACH_PTR(b);
 }
 
diff --git a/validation/field-override.c b/validation/field-override.c
index cae30b4a2..5b77af73e 100644
--- a/validation/field-override.c
+++ b/validation/field-override.c
@@ -69,7 +69,6 @@ static struct s b[2] = {
 /*
  * check-name: field-override
  * check-command: sparse -Woverride-init -Woverride-init-all $file
- * check-known-to-fail
  *
  * check-error-start
 field-override.c:2:10: warning: Initializer entry defined twice
-- 
2.11.1

