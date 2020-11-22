Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBBCC63697
	for <linux-sparse@archiver.kernel.org>; Sun, 22 Nov 2020 15:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B432720773
	for <linux-sparse@archiver.kernel.org>; Sun, 22 Nov 2020 15:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9TL5kMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgKVP1l (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 22 Nov 2020 10:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgKVP1l (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 22 Nov 2020 10:27:41 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB271C0613CF
        for <linux-sparse@vger.kernel.org>; Sun, 22 Nov 2020 07:27:40 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r17so16045431wrw.1
        for <linux-sparse@vger.kernel.org>; Sun, 22 Nov 2020 07:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oDGqLs35aEjYeKpnafqEha/8dZETW9wL39KF/lxxmH4=;
        b=P9TL5kMyMIszzdk/uq/IOtsIuFVxVn33KS3T/Tem2KwoxpuyhUVyRtZxvWGqo0nIyQ
         LEYusfi0CaQEPBUTsOarr51+G78x1cPDlxho7nQcz2AV0vfdvxIB2pvntkwGlPQQCWoA
         LGMWLmnZmYQqmYfYh/Avcq+ZlxwBfo174OSy5GJkFhtMCLhrnC1cr/3MQ3gU3Zk3d7Hu
         ukLyvdMrkDm37r/x/reADcKtZThzSULoWagvebxO/UcMLh4m9uetSuv5bXoXMGoHmuzU
         tSIhzJnVFwY9THj4bUZbh5YpthNG9F1qq8/evr8A0YZyP/kqE0aal36bRdiLGRIu1yNM
         jI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oDGqLs35aEjYeKpnafqEha/8dZETW9wL39KF/lxxmH4=;
        b=AvpP40coCwPLeEqNBn39xyZ6WacWnDZFjNeZSfuPzpKpyn4awTMsm7axZVwvBnIH+3
         6JaSquFq28xAaZHM/t8+lRMfUWj5fsqxSZCwa6PdxqHs59C3Y0JGwM/mRGmsf7mA7lje
         +3OE86deutY4XWr8Xapvf3+ytd0xZ2xy3XxikVGXPTUKBq+2DUqouBRCG/eaSkQ6n9bT
         VyQygMdgG9ZnpdcFA1TZf6edfAePTcuDV0wVvkNGCVQ8bTL0+ZC5lkhRbvyT16Hcj5Jt
         8srrA6NgMKLNMLhCMak6SZvMjTuyfIW3uqinYYmCdThke+4C1fCXZyBfnjeGkeTjRnR2
         e8gQ==
X-Gm-Message-State: AOAM532fxj2hYSxMrnAaB0+8/FEF0pbYuUsoZlxWgug6POQ09c8RXOP/
        ehrE2DIAgpLyuNpuwBmgU2WMTOU1BVI=
X-Google-Smtp-Source: ABdhPJyq+Pnm3GiLErpJJMcOutlWhpLzgoZvsmM98AFByIii5bwopT7bdTw9Lb6HC9tO2e2dNn6C9g==
X-Received: by 2002:a5d:66d2:: with SMTP id k18mr25180198wrw.327.1606058859318;
        Sun, 22 Nov 2020 07:27:39 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:b0e1:b041:18e2:46cf])
        by smtp.gmail.com with ESMTPSA id k1sm13712265wrp.23.2020.11.22.07.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 07:27:38 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 6/7] not: simplify (~x {&,|,^} x) --> {0,~0,~0}
Date:   Sun, 22 Nov 2020 16:27:30 +0100
Message-Id: <20201122152731.10994-7-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201122152731.10994-1-luc.vanoostenryck@gmail.com>
References: <20201122152731.10994-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Simplify bitwise operations on a pseudo and its complement
into 0 (for &) or ~0 for (| and ^).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                   | 66 ++++++++++++++++++++++++++++++++++--
 validation/optim/cse-not01.c |  1 -
 2 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/simplify.c b/simplify.c
index 203472972bca..b41c155735d1 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1630,6 +1630,66 @@ static int simplify_compare(struct instruction *insn)
 	return 0;
 }
 
+static int simplify_and_one_side(struct instruction *insn, pseudo_t *p1, pseudo_t *p2)
+{
+	struct instruction *def;
+	pseudo_t src1 = *p1;
+
+	switch (DEF_OPCODE(def, src1)) {
+	case OP_NOT:
+		if (def->src == *p2)
+			return replace_with_value(insn, 0);
+		break;
+	}
+	return 0;
+}
+
+static int simplify_and(struct instruction *insn)
+{
+	return simplify_and_one_side(insn, &insn->src1, &insn->src2) ||
+	       simplify_and_one_side(insn, &insn->src2, &insn->src1);
+}
+
+static int simplify_ior_one_side(struct instruction *insn, pseudo_t *p1, pseudo_t *p2)
+{
+	struct instruction *def;
+	pseudo_t src1 = *p1;
+
+	switch (DEF_OPCODE(def, src1)) {
+	case OP_NOT:
+		if (def->src == *p2)
+			return replace_with_value(insn, bits_mask(insn->size));
+		break;
+	}
+	return 0;
+}
+
+static int simplify_ior(struct instruction *insn)
+{
+	return simplify_ior_one_side(insn, &insn->src1, &insn->src2) ||
+	       simplify_ior_one_side(insn, &insn->src2, &insn->src1);
+}
+
+static int simplify_xor_one_side(struct instruction *insn, pseudo_t *p1, pseudo_t *p2)
+{
+	struct instruction *def;
+	pseudo_t src1 = *p1;
+
+	switch (DEF_OPCODE(def, src1)) {
+	case OP_NOT:
+		if (def->src == *p2)
+			return replace_with_value(insn, bits_mask(insn->size));
+		break;
+	}
+	return 0;
+}
+
+static int simplify_xor(struct instruction *insn)
+{
+	return simplify_xor_one_side(insn, &insn->src1, &insn->src2) ||
+	       simplify_xor_one_side(insn, &insn->src2, &insn->src1);
+}
+
 static int simplify_constant_unop(struct instruction *insn)
 {
 	long long val = insn->src1->value;
@@ -2162,10 +2222,10 @@ int simplify_instruction(struct instruction *insn)
 	switch (insn->opcode) {
 	case OP_ADD: return simplify_add(insn);
 	case OP_SUB: return simplify_sub(insn);
+	case OP_AND: return simplify_and(insn);
+	case OP_OR:  return simplify_ior(insn);
+	case OP_XOR: return simplify_xor(insn);
 	case OP_MUL:
-	case OP_AND:
-	case OP_OR:
-	case OP_XOR:
 	case OP_SHL:
 	case OP_LSR:
 	case OP_ASR:
diff --git a/validation/optim/cse-not01.c b/validation/optim/cse-not01.c
index f87123f14f13..ea1bb7cf25d4 100644
--- a/validation/optim/cse-not01.c
+++ b/validation/optim/cse-not01.c
@@ -5,7 +5,6 @@ int xor(int a) { return (~a ^ a) == ~0; }
 /*
  * check-name: cse-not01
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.29.2

