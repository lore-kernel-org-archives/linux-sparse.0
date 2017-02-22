From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/5] ignore whole-range overlapping initializer
Date: Wed, 22 Feb 2017 16:30:06 +0100
Message-ID: <20170222153006.3035-6-luc.vanoostenryck@gmail.com>
References: <20170221110355.GD300@arm.com>
 <20170222153006.3035-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36748 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932946AbdBVPgm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Feb 2017 10:36:42 -0500
Received: by mail-wr0-f194.google.com with SMTP id z61so820245wrc.3
        for <linux-sparse@vger.kernel.org>; Wed, 22 Feb 2017 07:36:41 -0800 (PST)
In-Reply-To: <20170222153006.3035-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Boyd <stephen.boyd@linaro.org>, Will Deacon <will.deacon@arm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

When an array is initialized, it may be convenient to first
initialize all entries with some default value via the
'[a ... b]' notation and then override some of these entries
with a non-default value. Unfortunately, this, of course,
is not compatible with the default warning flag '-Woverride-init'.

Fix this by introducing an exception to the usual detection
of overlapping initializers which, only for what concerns this
warning, ignore an '[a ... b]' entry if:
- it is the first one
- it covers the whole range of the array.

If needed, the previous ehaviour can be restored by using a new
warning flag, disabled by default: '-Woverride-init-whole-range'.

Suggested-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 expand.c                    | 13 +++++++++++--
 lib.c                       |  1 +
 lib.h                       |  1 +
 validation/field-override.c | 30 ++++++------------------------
 4 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/expand.c b/expand.c
index 80699c4d6..e6928bdc4 100644
--- a/expand.c
+++ b/expand.c
@@ -925,10 +925,11 @@ static void sort_expression_list(struct expression_list **list)
 	sort_list((struct ptr_list **)list, compare_expressions);
 }
 
-static void verify_nonoverlapping(struct expression_list **list)
+static void verify_nonoverlapping(struct expression_list **list, struct expression *expr)
 {
 	struct expression *a = NULL;
 	unsigned long max = 0;
+	unsigned long whole = expr->ctype->bit_size;
 	struct expression *b;
 
 	if (!Woverride_init)
@@ -946,6 +947,14 @@ static void verify_nonoverlapping(struct expression_list **list)
 				return;
 		}
 		end = off + bit_range(b);
+		if (!a && !Woverride_init_whole_range) {
+			// If first entry is the whole range, do not let
+			// any warning about it (this allow to initialize
+			// an array with some default value and then override
+			// some specific entries).
+			if (off == 0 && end == whole)
+				continue;
+		}
 		if (end > max) {
 			max = end;
 			a = b;
@@ -1019,7 +1028,7 @@ static int expand_expression(struct expression *expr)
 
 	case EXPR_INITIALIZER:
 		sort_expression_list(&expr->expr_list);
-		verify_nonoverlapping(&expr->expr_list);
+		verify_nonoverlapping(&expr->expr_list, expr);
 		return expand_expression_list(expr->expr_list);
 
 	case EXPR_IDENTIFIER:
diff --git a/lib.c b/lib.c
index b3b38a43f..95a4c461d 100644
--- a/lib.c
+++ b/lib.c
@@ -233,6 +233,7 @@ int Wold_initializer = 1;
 int Wone_bit_signed_bitfield = 1;
 int Woverride_init = 1;
 int Woverride_init_all = 0;
+int Woverride_init_whole_range = 0;
 int Wparen_string = 0;
 int Wptr_subtraction_blows = 0;
 int Wreturn_void = 0;
diff --git a/lib.h b/lib.h
index 265c5ec7f..134e56040 100644
--- a/lib.h
+++ b/lib.h
@@ -119,6 +119,7 @@ extern int Wold_initializer;
 extern int Wone_bit_signed_bitfield;
 extern int Woverride_init;
 extern int Woverride_init_all;
+extern int Woverride_init_whole_range;
 extern int Wparen_string;
 extern int Wptr_subtraction_blows;
 extern int Wreturn_void;
diff --git a/validation/field-override.c b/validation/field-override.c
index 5b77af73e..ec6987df7 100644
--- a/validation/field-override.c
+++ b/validation/field-override.c
@@ -75,15 +75,9 @@ field-override.c:2:10: warning: Initializer entry defined twice
 field-override.c:6:10:   also defined here
 field-override.c:3:10: warning: Initializer entry defined twice
 field-override.c:5:10:   also defined here
-field-override.c:14:10: warning: Initializer entry defined twice
-field-override.c:15:10:   also defined here
-field-override.c:14:10: warning: Initializer entry defined twice
-field-override.c:16:10:   also defined here
-field-override.c:14:10: warning: Initializer entry defined twice
-field-override.c:17:10:   also defined here
-field-override.c:14:10: warning: Initializer entry defined twice
+field-override.c:17:10: warning: Initializer entry defined twice
 field-override.c:18:10:   also defined here
-field-override.c:14:10: warning: Initializer entry defined twice
+field-override.c:17:10: warning: Initializer entry defined twice
 field-override.c:19:10:   also defined here
 field-override.c:23:10: warning: Initializer entry defined twice
 field-override.c:24:10:   also defined here
@@ -95,25 +89,13 @@ field-override.c:26:10: warning: Initializer entry defined twice
 field-override.c:27:10:   also defined here
 field-override.c:26:10: warning: Initializer entry defined twice
 field-override.c:28:10:   also defined here
-field-override.c:34:10: warning: Initializer entry defined twice
-field-override.c:35:10:   also defined here
-field-override.c:34:10: warning: Initializer entry defined twice
+field-override.c:35:10: warning: Initializer entry defined twice
 field-override.c:36:10:   also defined here
-field-override.c:34:10: warning: Initializer entry defined twice
-field-override.c:37:10:   also defined here
-field-override.c:34:10: warning: Initializer entry defined twice
+field-override.c:37:10: warning: Initializer entry defined twice
 field-override.c:38:10:   also defined here
-field-override.c:34:10: warning: Initializer entry defined twice
+field-override.c:37:10: warning: Initializer entry defined twice
 field-override.c:39:10:   also defined here
-field-override.c:34:10: warning: Initializer entry defined twice
+field-override.c:37:10: warning: Initializer entry defined twice
 field-override.c:40:10:   also defined here
-field-override.c:62:10: warning: Initializer entry defined twice
-field-override.c:63:10:   also defined here
-field-override.c:62:10: warning: Initializer entry defined twice
-field-override.c:65:10:   also defined here
-field-override.c:62:10: warning: Initializer entry defined twice
-field-override.c:66:10:   also defined here
-field-override.c:62:10: warning: Initializer entry defined twice
-field-override.c:64:10:   also defined here
  * check-error-end
  */
-- 
2.11.1

