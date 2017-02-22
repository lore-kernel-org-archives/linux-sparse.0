From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/5] allow to warn on all overlapping initializers
Date: Wed, 22 Feb 2017 16:30:04 +0100
Message-ID: <20170222153006.3035-4-luc.vanoostenryck@gmail.com>
References: <20170221110355.GD300@arm.com>
 <20170222153006.3035-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:32866 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932458AbdBVRQN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Feb 2017 12:16:13 -0500
Received: by mail-wr0-f193.google.com with SMTP id s27so1197444wrb.0
        for <linux-sparse@vger.kernel.org>; Wed, 22 Feb 2017 09:16:12 -0800 (PST)
In-Reply-To: <20170222153006.3035-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Boyd <stephen.boyd@linaro.org>, Will Deacon <will.deacon@arm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

By default, sparse only warns on the first overlapping initialier.

While this may be sensible for most situation, it's not always wanted
to hide those others errors. This is especially annoying when testing.

Change this by introducing a new warning flag '-Woverride-init-all',
disabled by default and whose intented use is sparse's testsuite.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 expand.c                    |  3 ++-
 lib.c                       |  2 ++
 lib.h                       |  1 +
 validation/field-override.c | 34 +++++++++++++++++++++++++++++++++-
 4 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/expand.c b/expand.c
index 7457c94dd..48cfa33d8 100644
--- a/expand.c
+++ b/expand.c
@@ -925,7 +925,8 @@ static void verify_nonoverlapping(struct expression_list **list)
 		if (a && bit_offset(a) == bit_offset(b)) {
 			warning(a->pos, "Initializer entry defined twice");
 			info(b->pos, "  also defined here");
-			return;
+			if (!Woverride_init_all)
+				return;
 		}
 		a = b;
 	} END_FOR_EACH_PTR(b);
diff --git a/lib.c b/lib.c
index a20f68aa2..b3b38a43f 100644
--- a/lib.c
+++ b/lib.c
@@ -232,6 +232,7 @@ int Wnon_pointer_null = 1;
 int Wold_initializer = 1;
 int Wone_bit_signed_bitfield = 1;
 int Woverride_init = 1;
+int Woverride_init_all = 0;
 int Wparen_string = 0;
 int Wptr_subtraction_blows = 0;
 int Wreturn_void = 0;
@@ -482,6 +483,7 @@ static const struct warning {
 	{ "old-initializer", &Wold_initializer },
 	{ "one-bit-signed-bitfield", &Wone_bit_signed_bitfield },
 	{ "override-init", &Woverride_init },
+	{ "override-init-all", &Woverride_init_all },
 	{ "paren-string", &Wparen_string },
 	{ "ptr-subtraction-blows", &Wptr_subtraction_blows },
 	{ "return-void", &Wreturn_void },
diff --git a/lib.h b/lib.h
index 35edd3217..265c5ec7f 100644
--- a/lib.h
+++ b/lib.h
@@ -118,6 +118,7 @@ extern int Wnon_pointer_null;
 extern int Wold_initializer;
 extern int Wone_bit_signed_bitfield;
 extern int Woverride_init;
+extern int Woverride_init_all;
 extern int Wparen_string;
 extern int Wptr_subtraction_blows;
 extern int Wreturn_void;
diff --git a/validation/field-override.c b/validation/field-override.c
index d5d00dfa8..cae30b4a2 100644
--- a/validation/field-override.c
+++ b/validation/field-override.c
@@ -68,21 +68,53 @@ static struct s b[2] = {
 
 /*
  * check-name: field-override
- * check-command: sparse -Woverride-init $file
+ * check-command: sparse -Woverride-init -Woverride-init-all $file
  * check-known-to-fail
  *
  * check-error-start
 field-override.c:2:10: warning: Initializer entry defined twice
 field-override.c:6:10:   also defined here
+field-override.c:3:10: warning: Initializer entry defined twice
+field-override.c:5:10:   also defined here
 field-override.c:14:10: warning: Initializer entry defined twice
 field-override.c:15:10:   also defined here
+field-override.c:14:10: warning: Initializer entry defined twice
+field-override.c:16:10:   also defined here
+field-override.c:14:10: warning: Initializer entry defined twice
+field-override.c:17:10:   also defined here
+field-override.c:14:10: warning: Initializer entry defined twice
+field-override.c:18:10:   also defined here
+field-override.c:14:10: warning: Initializer entry defined twice
+field-override.c:19:10:   also defined here
 field-override.c:23:10: warning: Initializer entry defined twice
 field-override.c:24:10:   also defined here
 field-override.c:23:10: warning: Initializer entry defined twice
 field-override.c:25:10:   also defined here
+field-override.c:23:10: warning: Initializer entry defined twice
+field-override.c:26:10:   also defined here
+field-override.c:26:10: warning: Initializer entry defined twice
+field-override.c:27:10:   also defined here
+field-override.c:26:10: warning: Initializer entry defined twice
+field-override.c:28:10:   also defined here
 field-override.c:34:10: warning: Initializer entry defined twice
 field-override.c:35:10:   also defined here
+field-override.c:34:10: warning: Initializer entry defined twice
+field-override.c:36:10:   also defined here
+field-override.c:34:10: warning: Initializer entry defined twice
+field-override.c:37:10:   also defined here
+field-override.c:34:10: warning: Initializer entry defined twice
+field-override.c:38:10:   also defined here
+field-override.c:34:10: warning: Initializer entry defined twice
+field-override.c:39:10:   also defined here
+field-override.c:34:10: warning: Initializer entry defined twice
+field-override.c:40:10:   also defined here
 field-override.c:62:10: warning: Initializer entry defined twice
 field-override.c:63:10:   also defined here
+field-override.c:62:10: warning: Initializer entry defined twice
+field-override.c:65:10:   also defined here
+field-override.c:62:10: warning: Initializer entry defined twice
+field-override.c:66:10:   also defined here
+field-override.c:62:10: warning: Initializer entry defined twice
+field-override.c:64:10:   also defined here
  * check-error-end
  */
-- 
2.11.1

