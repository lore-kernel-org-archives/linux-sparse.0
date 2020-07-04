From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/3] add memory asm constraint for S390
Date: Sat,  4 Jul 2020 15:57:47 +0200
Message-ID: <20200704135747.87752-4-luc.vanoostenryck@gmail.com>
References: <20200704135747.87752-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgGDN5z (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 4 Jul 2020 09:57:55 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E749C061794
        for <linux-sparse@vger.kernel.org>; Sat,  4 Jul 2020 06:57:55 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id dm19so24073258edb.13
        for <linux-sparse@vger.kernel.org>; Sat, 04 Jul 2020 06:57:55 -0700 (PDT)
In-Reply-To: <20200704135747.87752-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The 'Q', 'R', 'S' & 'T'' asm constraint are used for for memory
operands on S390 but only 'Q' belong to the 'common constraints'.

Fix this by handling the 3 others with an arch-specific method.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 target-s390.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target-s390.c b/target-s390.c
index 8fe7d93677b2..9dbc810e507c 100644
--- a/target-s390.c
+++ b/target-s390.c
@@ -1,6 +1,7 @@
 #include "symbol.h"
 #include "target.h"
 #include "machine.h"
+#include "expression.h"
 
 
 static void predefine_s390(const struct target *self)
@@ -8,6 +9,16 @@ static void predefine_s390(const struct target *self)
 	predefine("__s390__", 1, "1");
 }
 
+static const char *asm_constraint_s390(struct asm_operand *op, int c, const char *str)
+{
+	switch (c) {
+	case 'R': case 'S': case 'T':
+		op->is_memory = true;
+		break;
+	}
+	return str;
+}
+
 const struct target target_s390 = {
 	.mach = MACH_S390,
 	.bitness = ARCH_LP32,
@@ -21,6 +32,7 @@ const struct target target_s390 = {
 	.target_64bit = &target_s390x,
 
 	.predefine = predefine_s390,
+	.asm_constraint = asm_constraint_s390,
 };
 
 
@@ -45,4 +57,5 @@ const struct target target_s390x = {
 	.target_32bit = &target_s390,
 
 	.predefine = predefine_s390x,
+	.asm_constraint = asm_constraint_s390,
 };
-- 
2.27.0
