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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA97BC5519F
	for <linux-sparse@archiver.kernel.org>; Sat, 21 Nov 2020 20:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5948A20727
	for <linux-sparse@archiver.kernel.org>; Sat, 21 Nov 2020 20:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBa8Lx+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgKUUxQ (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 21 Nov 2020 15:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgKUUxQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 21 Nov 2020 15:53:16 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AE1C0613CF
        for <linux-sparse@vger.kernel.org>; Sat, 21 Nov 2020 12:53:15 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a3so13651264wmb.5
        for <linux-sparse@vger.kernel.org>; Sat, 21 Nov 2020 12:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9sWbOXCAlsRJ29Zj/2fPeyjIAWIaMpzqTdBLgnXDtso=;
        b=LBa8Lx+AnerB/GlwHniocK5TdSCdCS4NguP5sYcPEz+j8/WSPd+ALagfRNKECzDGdD
         q/ha2GjC/tvKVyfw23JGjA7+3jK+cduKaYn8ThZrLBEaADn2nb6mQ2BgnVXlQoLq+4x2
         v5RoOlDvuppydcmlddgsEgP8ve5d0Oc6umAT+iKfsCA2bvzrhNPjXOsji3CqqrsiaE4a
         tmSwlqhMkrSz4ANjcjhzxUg1HlwHJBwRpIolANylqd58H6E6tQGM5hRQDDtYmwfR3OOi
         lypDSzETJOcpMvs7inTtODiHSeBlhSLZeta5KIUwHwjyfN+uf7CRVWdlguW+aJWBQRMV
         DtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9sWbOXCAlsRJ29Zj/2fPeyjIAWIaMpzqTdBLgnXDtso=;
        b=S170gKpyroqBLDrL1T09sKib7cTR55K8HQMEHGL6bNNBJVWWNjId7Pms54+PkTq85K
         JvqnFtTSW6xUOeORolPqmbEmJsbv5Ww010eVLqIJUxy7BjeGmGW9pV+apAETSxsTBYDt
         KnyVOlCiuLcUA0mwVFNqT4++bRL9t/4RjidKKh1rcngX5GDRMnZc6zqnqB3KwPHN8+58
         toED6woWPdTp/iPp32VBXExxjeTzZS4KHiGQ+bSGCO+4buEBAOI9Ddv6VHDydMFojmUD
         DJ7B2T+QSDcQbknZxOTnBv5I4zrLBk8iYGF8jUvNjYPwiusvSAGmBjt8vACDa0B3Blds
         AbYw==
X-Gm-Message-State: AOAM532RKHjVCBJ4cJNKzAO93OccfHmp7ifJKU9/2yrNuf4r7dRp2KQS
        QcOLQRHhlyvtEchR442UoasWbhVrFLU=
X-Google-Smtp-Source: ABdhPJwPc+pgPmTmWoMHHDIR+9RctSVLZ8ThNlNwpTMwFDePj9NlsaapVCqQL/ctEFeiE9O1U7D0+A==
X-Received: by 2002:a1c:2b03:: with SMTP id r3mr15466695wmr.184.1605991994271;
        Sat, 21 Nov 2020 12:53:14 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:dcb6:7e9c:ccbf:c450])
        by smtp.gmail.com with ESMTPSA id p4sm9369815wmc.46.2020.11.21.12.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 12:53:13 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/4] simplify OP_COMPUTEDGOTO with unique and known target
Date:   Sat, 21 Nov 2020 21:52:58 +0100
Message-Id: <20201121205300.94642-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201121205300.94642-1-luc.vanoostenryck@gmail.com>
References: <20201121205300.94642-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

If the OP_COMPUTEDGOTO's source pseudo is defined by a single
OP_SETVAL/EXPR_LABEL, then the corresponding basic block is the
only possible destination and the computed goto can then be
simplified into a simple branch.

So, convert such computed goto into a simple OP_BR which may
then participate in other flow simplifications.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                 | 30 ++++++++++++++++++++++++++++++
 validation/optim/cgoto01.c |  1 -
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index e58fb6cf3941..132d408f59f1 100644
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
+	switch (DEF_OPCODE(def, insn->src)) {
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
+		kill_use(&insn->src);
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
index 350c6cd99f08..94b2c2c429db 100644
--- a/validation/optim/cgoto01.c
+++ b/validation/optim/cgoto01.c
@@ -16,7 +16,6 @@ L2:	abort();
 /*
  * check-name: cgoto01
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-excludes: set\\.
-- 
2.29.2

