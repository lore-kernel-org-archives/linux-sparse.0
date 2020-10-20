Return-Path: <SRS0=cyFV=D3=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAFEC4363A
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D07F2222C8
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLLqqiYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438671AbgJTVKh (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 20 Oct 2020 17:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438668AbgJTVKf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Oct 2020 17:10:35 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586D9C0613D3
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:35 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id t20so159280edr.11
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IRtDtAlL5j+s8GMlddko0p8KBGsquU4okwX0yha9+7U=;
        b=jLLqqiYmypJtElBivLXTfJ4a7eNfFk1LSC6nbjY6V6uE6eNV3QPKvAogbjofarWv4g
         aNEhe+k2p4luifuoxznw1g70sYNctZ3lmMjoI3hdRMl6I4o6gHOnC9DSqG2TYCzqnCDB
         LPuh27VY9XwHa1SO+ZCNQVRXGz2fFi5ZOvtcsU15gx3bEovw7vILdz4A/9IofuCz1AZI
         g4OGBNwimTNelu0B/DFT5wrlyX2b6X5Z38TfEMh31YVQZLD20wet8POUZLC3AxKTWIyx
         vN8mXEo/iuXANEwIRtIfVev+8XhkZcV3D+dbEna7R6O37NmVws1qaShATAi4NQ7dRNAK
         UAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IRtDtAlL5j+s8GMlddko0p8KBGsquU4okwX0yha9+7U=;
        b=HEikM5+u47EbZKA5HPmpv6da6G4dVEdpDeCEYpUNK9QReM71yBOHjo6SfLaRLr7owf
         bA7ly4BV3gwJbYj17RfpXp2WN+ZzbvNAbPzlmV9T+fl5pe6CUCJq2GwtUmHPELf8BYGT
         NvKoO7D59TmNEOFJUVyYSj/gCJ6Kdl4pBLEoVUimAAuBDl7b9LWYDHJhExp8fG5kq737
         0UaITWQbLtq+nYqAroXUQHEL/J3BG4KgjLRp/LGAn/fqxcgDvReSWGHffWDKsyMwfXIM
         Fi7kfp1ZW98gnyUZJ+xLY/NhEQruMgbMlX+00v4rts8Iey5G8zn/v1aFqXJRseLGi6v4
         Kxyg==
X-Gm-Message-State: AOAM532Bheo6zbRFVzGbyvPZRT4lBxFnV0lwt7SmgbW2h5lqO5p3LM2o
        P4OGBbAUnOM4xymDCOJ9SoP8AcHh/5A=
X-Google-Smtp-Source: ABdhPJybjlw34sUFJAb540f+1LTMJ21jxQKURh270ubLGcDfdkLUWDbCbW9qYPTgk5v4YaLeaI3abg==
X-Received: by 2002:aa7:dada:: with SMTP id x26mr4818810eds.167.1603228233832;
        Tue, 20 Oct 2020 14:10:33 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:85fe:66cb:a92b:c664])
        by smtp.gmail.com with ESMTPSA id d12sm4012848ejt.105.2020.10.20.14.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 14:10:33 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 11/22] sub: simplify C - (y + D) --> eval(C-D) - y
Date:   Tue, 20 Oct 2020 23:10:10 +0200
Message-Id: <20201020211021.82394-12-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020211021.82394-1-luc.vanoostenryck@gmail.com>
References: <20201020211021.82394-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                               | 18 ++++++++++++++++++
 validation/optim/simplify-cte-sub-addr.c |  1 -
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index aa0357d9e285..b97354bc40cc 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1157,6 +1157,22 @@ static int simplify_constant_rightside(struct instruction *insn)
 	return 0;
 }
 
+static int simplify_const_leftsub(struct instruction *insn, struct instruction *def)
+{
+	unsigned size = insn->size;
+	pseudo_t src1 = insn->src1;
+
+	switch (def->opcode) {
+	case OP_ADD:
+		if (constant(def->src2)) { // C - (y + D) --> eval(C-D) - y
+			insn->src1 = eval_op(OP_SUB, size, src1, def->src2);
+			return replace_pseudo(insn, &insn->src2, def->src1);
+		}
+		break;
+	}
+	return 0;
+}
+
 static int simplify_constant_leftside(struct instruction *insn)
 {
 	long long value = insn->src1->value;
@@ -1177,6 +1193,8 @@ static int simplify_constant_leftside(struct instruction *insn)
 	case OP_SUB:
 		if (!value)			// (0 - x) --> -x
 			return replace_with_unop(insn, OP_NEG, insn->src2);
+		if (insn->src2->type == PSEUDO_REG)
+			return simplify_const_leftsub(insn, insn->src2->def);
 		break;
 	}
 	return 0;
diff --git a/validation/optim/simplify-cte-sub-addr.c b/validation/optim/simplify-cte-sub-addr.c
index 81f5b34551c6..bf36c8a0a30a 100644
--- a/validation/optim/simplify-cte-sub-addr.c
+++ b/validation/optim/simplify-cte-sub-addr.c
@@ -3,7 +3,6 @@ int cte_sub_addr(int x) { return 2 - (x + 1); }
 /*
  * check-name: simplify-cte-sub-addr
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-contains: sub\\..*\\$1, %arg1
-- 
2.28.0

