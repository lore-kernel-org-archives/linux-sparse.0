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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F36C41604
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E19C92237B
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixhbVuoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438674AbgJTVKj (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 20 Oct 2020 17:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438669AbgJTVKi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Oct 2020 17:10:38 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B8AC0613D3
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:38 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id cm24so231363edb.0
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JubeBH/bUDS2du04BRkOUnycgmlSww6vh4bLTZNWLgY=;
        b=ixhbVuoODQ1qOtcmfAhqX5lvXTdFARwBLsnJcj0qoXcvomCbvJQ9oD0DDjki+ixxJk
         KGOgd/v/N9eo7x3aBoCv5g67rXa0ep7SRbmiAIpIYVJ8a5Yz+EnwqFSNrwnBC+tYkZEP
         +XV6h8MIwycDvrGUkHUPWsaG0UY159NrzZwemoDnmk6ObohRxZQwm5F6/KYyIJNf6EgH
         GQtiXdTj9nexmCkqQm1BkEzsX9NjkGR12UiPMzqBo3CNIuDm0Gpv9+kLTka5uR9z9yPB
         ZeKT7SoHRYp4oUHL+KlhczodZXwNpvArlrSKViu1ZICimN40KWpVABGtJDHt+UUrFooW
         g7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JubeBH/bUDS2du04BRkOUnycgmlSww6vh4bLTZNWLgY=;
        b=Iv4evKIeYXioZ69P6qxGVrkfNpxZmETXKYEcKKQDBxEKtXEz+iFlhjLmi8aC1QC+n/
         vtpHuoDy3/PPrJzDkmMdayqRQfZj3Zn2Pn6rzqcMCu7CCpxOMJRbSut9LP2kc8xuaUHU
         6l48qw7R9OBWs/ElrmM4UxNYdVmyrlawdmZMWFLGRqBz3g8A4C+YkaRC25tFcUU2uEiJ
         F03MuvGwg5QeHH7DLahYRjsfl5dfrWTVSTV+kJst2Qlxl8WLvKU5DNP/37UPu6FCHDa5
         uBFp6qQDOj/YUvQcoETTcrUv73JvURz22EIA6YJyYtyL8U0EKlgAcNWefyREpqKiyhQ6
         YpYQ==
X-Gm-Message-State: AOAM531MxDTrNUKev6AvMUZcsum+Cmc1vSH0AG4xZ6IctSMA4xgC6Epy
        J+xo07MP02vSpTwdUea+eqF5YJlTBXk=
X-Google-Smtp-Source: ABdhPJzSmA5LUkWN4Wos/bBcHe5KNnYo+NmMgoykz5s32vUyYls4hFJwVTFT/rrGQocgEqCC4BFSvQ==
X-Received: by 2002:aa7:d759:: with SMTP id a25mr4723253eds.344.1603228237126;
        Tue, 20 Oct 2020 14:10:37 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:85fe:66cb:a92b:c664])
        by smtp.gmail.com with ESMTPSA id d12sm4012848ejt.105.2020.10.20.14.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 14:10:36 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 15/22] add: simplify (x + -y) --> (x - y)
Date:   Tue, 20 Oct 2020 23:10:14 +0200
Message-Id: <20201020211021.82394-16-luc.vanoostenryck@gmail.com>
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
 simplify.c                          | 16 +++++++++++++++-
 validation/optim/simplify-add-neg.c |  1 -
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/simplify.c b/simplify.c
index fa7e1679d7ac..f8a0ba726561 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1358,6 +1358,20 @@ static int simplify_associative_binop(struct instruction *insn)
 	return REPEAT_CSE;
 }
 
+static int simplify_add(struct instruction *insn)
+{
+	pseudo_t src2 = insn->src2;
+	struct instruction *def;
+
+	switch (DEF_OPCODE(def, src2)) {
+	case OP_NEG:				// (x + -y) --> (x - y)
+		insn->opcode = OP_SUB;
+		return replace_pseudo(insn, &insn->src2, def->src);
+	}
+
+	return 0;
+}
+
 static int simplify_sub(struct instruction *insn)
 {
 	pseudo_t src2 = insn->src2;
@@ -1832,8 +1846,8 @@ int simplify_instruction(struct instruction *insn)
 	}
 
 	switch (insn->opcode) {
+	case OP_ADD: return simplify_add(insn);
 	case OP_SUB: return simplify_sub(insn);
-	case OP_ADD:
 	case OP_MUL:
 	case OP_AND:
 	case OP_OR:
diff --git a/validation/optim/simplify-add-neg.c b/validation/optim/simplify-add-neg.c
index 19b64b096567..c24b8e19e5c3 100644
--- a/validation/optim/simplify-add-neg.c
+++ b/validation/optim/simplify-add-neg.c
@@ -3,7 +3,6 @@ int add_neg(int x, int y) { return x + -y; }
 /*
  * check-name: simplify-add-neg
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-contains: sub\\..*%arg1, %arg2
-- 
2.28.0

