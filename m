From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/8] dump-ir: add defines for the compilation passes
Date: Fri, 15 Sep 2017 09:40:27 +0200
Message-ID: <20170915074034.7785-2-luc.vanoostenryck@gmail.com>
References: <20170915074034.7785-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37693 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbdIOHkl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:40:41 -0400
Received: by mail-wm0-f65.google.com with SMTP id f4so2005926wmh.4
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:40:40 -0700 (PDT)
In-Reply-To: <20170915074034.7785-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/lib.h b/lib.h
index 307ccaeb2..27c990251 100644
--- a/lib.h
+++ b/lib.h
@@ -107,6 +107,22 @@ extern void expression_error(struct expression *, const char *, ...) FORMAT_ATTR
 #define	ERROR_PREV_PHASE	(1 << 1)
 extern int has_error;
 
+
+enum phase {
+	PASS__PARSE,
+	PASS__LINEARIZE,
+	PASS__MEM2REG,
+	PASS__OPTIM,
+	PASS__FINAL,
+};
+
+#define	PASS_PARSE		(1UL << PASS__PARSE)
+#define	PASS_LINEARIZE		(1UL << PASS__LINEARIZE)
+#define	PASS_MEM2REG		(1UL << PASS__MEM2REG)
+#define	PASS_OPTIM		(1UL << PASS__OPTIM)
+#define	PASS_FINAL		(1UL << PASS__FINAL)
+
+
 extern void add_pre_buffer(const char *fmt, ...) FORMAT_ATTR(1);
 
 extern int preprocess_only;
-- 
2.14.0

