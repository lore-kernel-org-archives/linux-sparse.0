From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 46/48] mem2reg: allow dumping IR
Date: Wed, 23 Aug 2017 22:15:52 +0200
Message-ID: <20170823201554.90551-47-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36207 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbdHWURc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:17:32 -0400
Received: by mail-wm0-f68.google.com with SMTP id f127so643066wmf.3
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:17:32 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 lib.c       | 1 +
 lib.h       | 1 +
 linearize.c | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/lib.c b/lib.c
index 0705775e5..f32fbda9f 100644
--- a/lib.c
+++ b/lib.c
@@ -763,6 +763,7 @@ static char **handle_switch_ftabstop(char *arg, char **next)
 static const struct mask_map dump_ir_options[] = {
 	{ "$default",		DUMP_IR_LINEARIZE },
 	{ "linearize",		DUMP_IR_LINEARIZE },
+	{ "mem2reg",		DUMP_IR_MEM2REG },
 	{ "only",		DUMP_IR_ONLY },
 	{ },
 };
diff --git a/lib.h b/lib.h
index a2fd04e67..30e097338 100644
--- a/lib.h
+++ b/lib.h
@@ -109,6 +109,7 @@ extern int has_error;
 
 #define	DUMP_IR_ONLY		(1 << 0)
 #define	DUMP_IR_LINEARIZE	(1 << 1)
+#define	DUMP_IR_MEM2REG		(1 << 2)
 #define	DUMP_IR_STOP(F,D)	(((F) & DUMP_IR_ONLY) && ((F) < ((D) << 1)))
 
 extern void add_pre_buffer(const char *fmt, ...) FORMAT_ATTR(1);
diff --git a/linearize.c b/linearize.c
index 2c49d29d9..8db4638bc 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2278,6 +2278,11 @@ static struct entrypoint *linearize_fn(struct symbol *sym, struct symbol *base_t
 	 * Turn symbols into pseudos
 	 */
 	promote_symbols_usage(ep);
+	if (fdump_ir & DUMP_IR_MEM2REG) {
+		if (DUMP_IR_STOP(fdump_ir, DUMP_IR_MEM2REG))
+			return ep;
+		show_entry(ep);
+	}
 
 repeat:
 	/*
-- 
2.14.0

