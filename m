From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 20/48] dump-ir: make it more flexible
Date: Wed, 23 Aug 2017 22:15:26 +0200
Message-ID: <20170823201554.90551-21-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33698 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932565AbdHWUQj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:16:39 -0400
Received: by mail-wm0-f68.google.com with SMTP id b79so662357wmf.0
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:16:39 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 lib.c                                  | 17 +++++++++--------
 validation/linear/bitfield-init-mask.c |  2 +-
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/lib.c b/lib.c
index c107505a7..d3aaf10d2 100644
--- a/lib.c
+++ b/lib.c
@@ -490,7 +490,6 @@ static unsigned long lookup_mask(const char *name, const struct mask_map *map)
 	return 0;
 }
 
-inline
 static unsigned long handle_suboption_mask(char *arg, const struct mask_map *map)
 {
 	const char *token;
@@ -757,16 +756,18 @@ static char **handle_switch_ftabstop(char *arg, char **next)
 	return next;
 }
 
+static const struct mask_map dump_ir_options[] = {
+	{ "$default",		DUMP_IR_LINEARIZE },
+	{ "linearize",		DUMP_IR_LINEARIZE },
+	{ "only",		DUMP_IR_ONLY },
+	{ },
+};
+
 static char **handle_switch_fdump(char *arg, char **next)
 {
 	if (!strncmp(arg, "ir", 2)) {
-		fdump_ir = DUMP_IR_LINEARIZE;
-		arg += 2;
-		if (*arg == '\0')
-			fdump_ir = DUMP_IR_LINEARIZE;
-		else if (!strcmp(arg, "=only"))
-			fdump_ir |= DUMP_IR_ONLY;
-		else
+		fdump_ir = handle_suboption_mask(arg+2, dump_ir_options);
+		if (fdump_ir == ~0UL)
 			goto err;
 	}
 
diff --git a/validation/linear/bitfield-init-mask.c b/validation/linear/bitfield-init-mask.c
index f43605855..fa91fec90 100644
--- a/validation/linear/bitfield-init-mask.c
+++ b/validation/linear/bitfield-init-mask.c
@@ -18,7 +18,7 @@ struct bfu bfu_init_20_23(int a)
 
 /*
  * check-name: bitfield initializer mask
- * check-command: test-linearize -fdump-ir=only -Wno-decl $file
+ * check-command: test-linearize -fdump-ir=linearize,only -Wno-decl $file
  * check-output-ignore
  *
  * check-output-contains: and\\..*fffff800\$
-- 
2.14.0

