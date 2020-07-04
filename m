From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/3] add memory asm constraint for PPC
Date: Sat,  4 Jul 2020 15:57:46 +0200
Message-ID: <20200704135747.87752-3-luc.vanoostenryck@gmail.com>
References: <20200704135747.87752-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgGDN5y (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 4 Jul 2020 09:57:54 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E74EC061794
        for <linux-sparse@vger.kernel.org>; Sat,  4 Jul 2020 06:57:54 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id n26so23419583ejx.0
        for <linux-sparse@vger.kernel.org>; Sat, 04 Jul 2020 06:57:54 -0700 (PDT)
In-Reply-To: <20200704135747.87752-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The 'Z' asm constraint is used for doing IO accessors on PPC but
isn't part of the 'common constraints'. It's responsible for
more than half of all warnings (with defconfig + allyesconfig).

Fix this by handling this constraint in a specific method for PPC.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 target-ppc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target-ppc.c b/target-ppc.c
index b138635b9103..c0d6068f436a 100644
--- a/target-ppc.c
+++ b/target-ppc.c
@@ -1,6 +1,7 @@
 #include "symbol.h"
 #include "target.h"
 #include "machine.h"
+#include "expression.h"
 
 
 static void predefine_ppc(const struct target *self)
@@ -15,6 +16,16 @@ static void predefine_ppc(const struct target *self)
 		predefine("_BIG_ENDIAN", 1, "1");
 }
 
+static const char *asm_constraint_ppc(struct asm_operand *op, int c, const char *str)
+{
+	switch (c) {
+	case 'Z':
+		op->is_memory = true;
+		break;
+	}
+	return str;
+}
+
 
 static void predefine_ppc32(const struct target *self)
 {
@@ -32,6 +43,7 @@ const struct target target_ppc32 = {
 	.target_64bit = &target_ppc64,
 
 	.predefine = predefine_ppc32,
+	.asm_constraint = asm_constraint_ppc,
 };
 
 
@@ -55,4 +67,5 @@ const struct target target_ppc64 = {
 	.target_32bit = &target_ppc32,
 
 	.predefine = predefine_ppc64,
+	.asm_constraint = asm_constraint_ppc,
 };
-- 
2.27.0
