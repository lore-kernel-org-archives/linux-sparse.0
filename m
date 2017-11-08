From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/9] dump-ir: add defines for the compilation passes
Date: Wed,  8 Nov 2017 11:27:54 +0100
Message-ID: <20171108102802.43987-2-luc.vanoostenryck@gmail.com>
References: <20171108102802.43987-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43783 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbdKHK2L (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Nov 2017 05:28:11 -0500
Received: by mail-wr0-f193.google.com with SMTP id 4so1955929wrt.0
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 02:28:11 -0800 (PST)
In-Reply-To: <20171108102802.43987-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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

