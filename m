From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 18/48] dump-ir: use defines
Date: Wed, 23 Aug 2017 22:15:24 +0200
Message-ID: <20170823201554.90551-19-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33674 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932678AbdHWUQg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:16:36 -0400
Received: by mail-wm0-f65.google.com with SMTP id b79so662116wmf.0
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:16:35 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 lib.c       | 5 +++--
 lib.h       | 4 ++++
 linearize.c | 4 ++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/lib.c b/lib.c
index a0ed29c3e..e1454661b 100644
--- a/lib.c
+++ b/lib.c
@@ -725,11 +725,12 @@ static char **handle_switch_ftabstop(char *arg, char **next)
 static char **handle_switch_fdump(char *arg, char **next)
 {
 	if (!strncmp(arg, "ir", 2)) {
+		fdump_ir = DUMP_IR_LINEARIZE;
 		arg += 2;
 		if (*arg == '\0')
-			fdump_ir = 1;
+			fdump_ir = DUMP_IR_LINEARIZE;
 		else if (!strcmp(arg, "=only"))
-			fdump_ir = 2;
+			fdump_ir |= DUMP_IR_ONLY;
 		else
 			goto err;
 	}
diff --git a/lib.h b/lib.h
index ccac27d0b..d0b699535 100644
--- a/lib.h
+++ b/lib.h
@@ -107,6 +107,10 @@ extern void expression_error(struct expression *, const char *, ...) FORMAT_ATTR
 #define	ERROR_PREV_PHASE	(1 << 1)
 extern int has_error;
 
+#define	DUMP_IR_ONLY		(1 << 0)
+#define	DUMP_IR_LINEARIZE	(1 << 1)
+#define	DUMP_IR_STOP(F,D)	(((F) & DUMP_IR_ONLY) && ((F) < ((D) << 1)))
+
 extern void add_pre_buffer(const char *fmt, ...) FORMAT_ATTR(1);
 
 extern int preprocess_only;
diff --git a/linearize.c b/linearize.c
index 85acfd9c1..d5606b708 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2262,8 +2262,8 @@ static struct entrypoint *linearize_fn(struct symbol *sym, struct symbol *base_t
 		add_one_insn(ep, insn);
 	}
 
-	if (fdump_ir) {
-		if (fdump_ir == 2)
+	if (fdump_ir & DUMP_IR_LINEARIZE) {
+		if (DUMP_IR_STOP(fdump_ir, DUMP_IR_LINEARIZE))
 			return ep;
 		show_entry(ep);
 	}
-- 
2.14.0

