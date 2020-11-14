Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B126FC5519F
	for <linux-sparse@archiver.kernel.org>; Sat, 14 Nov 2020 08:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53CA522254
	for <linux-sparse@archiver.kernel.org>; Sat, 14 Nov 2020 08:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rFdBEar9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgKNIWO (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 14 Nov 2020 03:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgKNIWN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 14 Nov 2020 03:22:13 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA6FC0613D1
        for <linux-sparse@vger.kernel.org>; Sat, 14 Nov 2020 00:22:13 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id v4so13538394edi.0
        for <linux-sparse@vger.kernel.org>; Sat, 14 Nov 2020 00:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tps0+7Mfd4vmp2/PRi1xEKQaiKxYuC1/2wwABI2eNsA=;
        b=rFdBEar9+6XiN3OVcoLa3pOxqVNCUbI5khi5+45iegufvgaUFrESAXPOnuhvR3Fniq
         Uuwgd7SRyW0tvxdtT8Q19ljO36ZDj2JTukt1GFWXOQYAwzMI8pxyDcS4pbrCiD8kkvlh
         BWFvjPWrT+YfVVcz173IqmWGMJusCesd/eIkbQcZJr43BRgnzM+XsbgAZyDOqm7MahiY
         RAA9i9wCu3OY5warUCmZd9lZvtZ1LYWGLhfpY7YjVtiv34YVFwJGX7MuuJgMI0ltDc4x
         96Xl5zB9U+Oey08wNqiDg7R9vRrVCW/G/AE0WIGxWz04zBU4bXqqwvzrv7qNU1IZKipA
         Wv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tps0+7Mfd4vmp2/PRi1xEKQaiKxYuC1/2wwABI2eNsA=;
        b=ky0ILtyn2Aj4fANWB6XgUzn+if7k8EZ+icjrB/CajFCL6RO6jdyAKquEqBGcEzM6XL
         xCfh+RfmyP/V/P7GTQhq6ixlrukeDKt6ykqYSOShNKB22joV2BWK9L5WIiTrEbeK8WTd
         M0AZrR34FYzSTbL2iyjsuZRyU93zFibaNTR32Ksm5yng+uXVlL3S5QaKu7TR+KE+VxgJ
         1kw36Q/n6BWnMcTyCgIKTzY/CpcmWgByP4zQmOTkdOwsNwJxDK9WLEAj+clUfeHf4HD5
         BhczZ7haaiVHceMB5JYiDKHfXu8BbpOztaBNBdijl4crbyDa7YCrLSZjW2MBn65bqTUt
         8GHw==
X-Gm-Message-State: AOAM533w/yGlIqPRXvWgSqo48URKCNbcH5swXnj6LZxJCehDKYE5itk0
        O+nRsGkUXPcUkUFEUHLK4w3FTWc7lYs=
X-Google-Smtp-Source: ABdhPJwC5yGu1uWd5J2+Vam6r2F9dzJWeRm0O3Qy3eR4Twu3gSCwyx2xJgx7+o4yvo07hSMF+B0EIA==
X-Received: by 2002:a05:6402:22ab:: with SMTP id cx11mr6277815edb.98.1605342131995;
        Sat, 14 Nov 2020 00:22:11 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:e8ee:663e:d7a3:b425])
        by smtp.gmail.com with ESMTPSA id s19sm5871293ejz.103.2020.11.14.00.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 00:22:11 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] simplify OP_COMPUTEDGOTO with known target
Date:   Sat, 14 Nov 2020 09:22:08 +0100
Message-Id: <20201114082208.58578-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

If the OP_COMPUTEDGOTO's source pseudo is defined by an OP_SETVAL
with a label, then this label is the only possible destination of
the computed goto which can then be transformed into a simple branch.

So, convert such computed goto into a simple OP_BR which may then
participate in other flow simplifications.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                 | 30 ++++++++++++++++++++++++++++++
 validation/optim/cgoto01.c | 24 ++++++++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 validation/optim/cgoto01.c

diff --git a/simplify.c b/simplify.c
index e58fb6cf3941..08022c97437a 100644
--- a/simplify.c
+++ b/simplify.c
@@ -2112,6 +2112,34 @@ found:
 	return REPEAT_CSE;
 }
 
+static int simplify_cgoto(struct instruction *insn)
+{
+	struct basic_block *target, *bb = insn->bb;
+	struct instruction *def;
+	struct multijmp *jmp;
+
+	switch (DEF_OPCODE(def, insn->cond)) {
+	case OP_SETVAL:
+		if (def->val->type != EXPR_LABEL)
+			break;
+		target = def->val->symbol->bb_target;
+		if (!target->ep)
+			return 0;
+		FOR_EACH_PTR(insn->multijmp_list, jmp) {
+			if (jmp->target == target)
+				continue;
+			remove_bb_from_list(&jmp->target->parents, bb, 1);
+			remove_bb_from_list(&bb->children, jmp->target, 1);
+			MARK_CURRENT_DELETED(jmp);
+		} END_FOR_EACH_PTR(jmp);
+		kill_use(&insn->cond);
+		insn->opcode = OP_BR;
+		insn->bb_true = target;
+		return REPEAT_CSE|REPEAT_CFG_CLEANUP;
+	}
+	return 0;
+}
+
 int simplify_instruction(struct instruction *insn)
 {
 	unsigned flags;
@@ -2190,6 +2218,8 @@ int simplify_instruction(struct instruction *insn)
 		return simplify_branch(insn);
 	case OP_SWITCH:
 		return simplify_switch(insn);
+	case OP_COMPUTEDGOTO:
+		return simplify_cgoto(insn);
 	case OP_RANGE:
 		return simplify_range(insn);
 	case OP_FADD:
diff --git a/validation/optim/cgoto01.c b/validation/optim/cgoto01.c
new file mode 100644
index 000000000000..94b2c2c429db
--- /dev/null
+++ b/validation/optim/cgoto01.c
@@ -0,0 +1,24 @@
+void abort(void) __attribute__((__noreturn__));
+
+int foo(int a)
+{
+	void *label;
+
+	if (a == a)
+		label = &&L1;
+	else
+		label = &&L2;
+	goto *label;
+L1:	return 0;
+L2:	abort();
+}
+
+/*
+ * check-name: cgoto01
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-excludes: set\\.
+ * check-output-excludes: jmp
+ * check-output-excludes: call
+ */
-- 
2.29.2

