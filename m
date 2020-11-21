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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0758C63798
	for <linux-sparse@archiver.kernel.org>; Sat, 21 Nov 2020 20:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B7F20771
	for <linux-sparse@archiver.kernel.org>; Sat, 21 Nov 2020 20:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6vM3apJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgKUUxR (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 21 Nov 2020 15:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgKUUxR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 21 Nov 2020 15:53:17 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0640C0613CF
        for <linux-sparse@vger.kernel.org>; Sat, 21 Nov 2020 12:53:16 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id p22so14245159wmg.3
        for <linux-sparse@vger.kernel.org>; Sat, 21 Nov 2020 12:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T1X2PIa+ZvMWoHd+u1U+/PKDh8K41btoB+fUbSkfK0k=;
        b=f6vM3apJdOfkTG6lCq25STb7uuEcxJ6AJI/G++eWcfs5z5IKt+cyEweOVLM7h0LS0v
         y0OIy8yKKKy7CK1SMCYSQHZxhbETjrtsgzgFh1yDBQU5kjznGiCKrjg0A1ElcVRh9Viz
         n5pNUtZ+JJsY31JK/mM2lbEDMXDfaUz3pU/xeUEnV9SlEMbyoh9gtTjIBm9skOb+QZ7C
         IdQSDh2YPSCVPXX7/TG3iApT/gUp5HAjwkFFo+O7jEUfZJDNUtiWs/zycqN62HDTm7c7
         1yjuBOOtYbovKHeK+BY/8oHukNt3X8rzmHXf8NyIV3aAAA4Uu+0VUS6oq/PrlLPxibRm
         cwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T1X2PIa+ZvMWoHd+u1U+/PKDh8K41btoB+fUbSkfK0k=;
        b=D26s8eHMteThb0NZo8mHxSKmwkMgX7uOgxpEt5XQDTfUtfuPoY9T7dAaHRhukLj/EP
         OZ9KqWwkU9eTcgJ+EEHNTyEMcVIbwBGtbDDOsdjJxjBDXkFMYUrKHVPHE2yBI6dSzwEE
         z+y5DPg3u2m4b/+cGEo08VhO4TDzIk3sdvjxhxWt1yTbrQTCvfM+HediwU5tZBheZuy3
         OMY6rJYHbrpDSMqc3AS4yTXCUgNyEac+8Viilz3/NevaLH5j6b3Nugdu9HhCAPT5KcSq
         +1x2Gsy3yMI5BkepEpe+nILymlw+Y2IEFIROcyXkiNUwm0fGhkcQ+Qn+Hi6mzAtWgSfT
         Oa0g==
X-Gm-Message-State: AOAM530c8cpOBXOlvtSE49EFxgyhJlqVGSWUAa84mgOHMC50caGhEWDv
        KPK8EvVB9Lc9LnsrDv/d3X2fF1HYcf4=
X-Google-Smtp-Source: ABdhPJxShR91r+tU1gGYdwY4UVXRdik7xjjvzVFKflUJBYpM6v5hf8RN/0kfrX9yjZwy1FdTfmZihA==
X-Received: by 2002:a7b:ca43:: with SMTP id m3mr16418947wml.25.1605991995300;
        Sat, 21 Nov 2020 12:53:15 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:dcb6:7e9c:ccbf:c450])
        by smtp.gmail.com with ESMTPSA id p4sm9369815wmc.46.2020.11.21.12.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 12:53:14 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/4] simplify CGOTO(SEL(x, L1, L2)) into CBR x, L1, L2
Date:   Sat, 21 Nov 2020 21:52:59 +0100
Message-Id: <20201121205300.94642-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201121205300.94642-1-luc.vanoostenryck@gmail.com>
References: <20201121205300.94642-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

A computed goto having as operand a select of 2 statically known addresses
(OP_SETVAL/EXPR_LABEL) is equivalent to a simple conditional branch.

Simplify such computed goto into the corresponding OP_CBR

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                 | 22 ++++++++++++++++++++++
 validation/optim/cgoto02.c |  1 -
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index 132d408f59f1..24ecf074206e 100644
--- a/simplify.c
+++ b/simplify.c
@@ -2112,13 +2112,35 @@ found:
 	return REPEAT_CSE;
 }
 
+static struct basic_block *is_label(pseudo_t pseudo)
+{
+	struct expression *expr;
+	struct instruction *def;
+
+	if (DEF_OPCODE(def, pseudo) != OP_SETVAL)
+		return NULL;
+	expr = def->val;
+	if (expr->type != EXPR_LABEL)
+		return NULL;
+	return expr->symbol->bb_target;
+}
+
 static int simplify_cgoto(struct instruction *insn)
 {
 	struct basic_block *target, *bb = insn->bb;
+	struct basic_block *bbt, *bbf;
 	struct instruction *def;
 	struct multijmp *jmp;
 
 	switch (DEF_OPCODE(def, insn->src)) {
+	case OP_SEL:	// CGOTO(SEL(x, L1, L2)) --> CBR x, L1, L2
+		if ((bbt = is_label(def->src2)) && (bbf = is_label(def->src3))) {
+			insn->opcode = OP_CBR;
+			insn->bb_true = bbt;
+			insn->bb_false = bbf;
+			return replace_pseudo(insn, &insn->src1, def->cond);
+		}
+		break;
 	case OP_SETVAL:
 		if (def->val->type != EXPR_LABEL)
 			break;
diff --git a/validation/optim/cgoto02.c b/validation/optim/cgoto02.c
index 5869d5b4a24d..932c3164e5ee 100644
--- a/validation/optim/cgoto02.c
+++ b/validation/optim/cgoto02.c
@@ -11,7 +11,6 @@ l2:
 /*
  * check-name: cgoto02
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: %arg1
-- 
2.29.2

