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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D344C388F7
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7ABE2237B
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHD5wagW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438663AbgJTVKi (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 20 Oct 2020 17:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438669AbgJTVKh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Oct 2020 17:10:37 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1BBC0613D5
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:36 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id qp15so4866714ejb.3
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bgRflzBA3aMwMm2Ard036ItvvTVFcTdtfRKHc9vwZQ4=;
        b=EHD5wagWTXoBZNF7q/Z22JflY3ay0KtDiXh2zIKdK4FxyiKsUzSBrHG2Bjp0AYp8nv
         PD4JYNybb/dX5g8NNwQGymqeefWtaugxQeESaHLCz5K8AKLjMij4DRCVHAJohDkZAIUc
         /VVkbtn1zpfaMZ6+84Sy0V+urZusoD4g31F2up/f2XQwiQtxlpv9gxyBiFtuTq3jQnBD
         CJf6gkWU6L3VE0bjvvCJZR9kfi6UT9fG2ViRjV0gOw13C9HLxxfZtefrBWF0oFUydKYG
         KZYh51A2mje5WZVTVSv2bikQ6TdWCtPvULHm9ZwTYPahB9dRqUe9Z6NqsblX1r0cINkx
         0fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bgRflzBA3aMwMm2Ard036ItvvTVFcTdtfRKHc9vwZQ4=;
        b=evG0Yx+3pmppT3GBTIHKglcej3eupPHFgI8e6K3xsDGZGUU6Twj76zpDZCftQstyS9
         olOPKRKjSdJeB1q4UvMEFYd6XelSxX7G1bjiYFFMSyHdAxda/1eGu/9tMQ+Xj6AnNGv0
         OH1LAZNEdqOLoAknAIBvTChgpd5avg68dC+rhfYL5CryQ3zFIhu+Hu6qBKfS538bT/2z
         d1jRQlzeDAKaj0G7JB0o+RYoTLI5fXUoFJACQYJCNpxx0ovd5SSswlFMShD/wdpsjzo0
         yoCz2EZMrQFMblP6nSka/O4Rr5UKIamxVhJr637O1uMm+g1n2cNbe0kGqw2yOyNK9w5t
         F64Q==
X-Gm-Message-State: AOAM531ylC0nMvfzqpm5mr+p0AIIKI67lqiiaRi8k0yGxfFrX+xbdHNr
        0LivnIswRbnSkrMw03rntXMDv7C4THo=
X-Google-Smtp-Source: ABdhPJywNhv+pMW+fG7RycrHBSAxszIjac/4R8i0Ga6q/lt4pFH9xfQcC25iXZcuVuPx/kjZ2jvAag==
X-Received: by 2002:a17:906:22d8:: with SMTP id q24mr62889eja.479.1603228235461;
        Tue, 20 Oct 2020 14:10:35 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:85fe:66cb:a92b:c664])
        by smtp.gmail.com with ESMTPSA id d12sm4012848ejt.105.2020.10.20.14.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 14:10:34 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 13/22] sub: simplify (C - y) + D --> eval(C+D) - y
Date:   Tue, 20 Oct 2020 23:10:12 +0200
Message-Id: <20201020211021.82394-14-luc.vanoostenryck@gmail.com>
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
 simplify.c                               | 20 ++++++++++++++++++++
 validation/optim/simplify-cte-sub-addl.c |  1 -
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index 7d1897e65b07..929a177631e5 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1096,6 +1096,24 @@ static int simplify_constant_mask(struct instruction *insn, unsigned long long m
 	return 0;
 }
 
+static int simplify_const_rightadd(struct instruction *def, struct instruction *insn)
+{
+	unsigned size = insn->size;
+	pseudo_t src2 = insn->src2;
+
+	switch (def->opcode) {
+	case OP_SUB:
+		if (constant(def->src1)) { // (C - y) + D --> eval(C+D) - y
+			pseudo_t val = eval_op(OP_ADD, size, def->src1, src2);
+			insn->opcode = OP_SUB;
+			use_pseudo(insn, def->src2, &insn->src2);
+			return replace_pseudo(insn, &insn->src1, val);
+		}
+		break;
+	}
+	return 0;
+}
+
 static int simplify_constant_rightside(struct instruction *insn)
 {
 	long long value = insn->src2->value;
@@ -1128,6 +1146,8 @@ static int simplify_constant_rightside(struct instruction *insn)
 	case OP_ADD:
 		if (!value)
 			return replace_with_pseudo(insn, insn->src1);
+		if (insn->src1->type == PSEUDO_REG)	// (x # y) + z
+			changed |= simplify_const_rightadd(insn->src1->def, insn);
 		return changed;
 	case OP_ASR:
 	case OP_SHL:
diff --git a/validation/optim/simplify-cte-sub-addl.c b/validation/optim/simplify-cte-sub-addl.c
index 49e510062c03..137029636f2d 100644
--- a/validation/optim/simplify-cte-sub-addl.c
+++ b/validation/optim/simplify-cte-sub-addl.c
@@ -3,7 +3,6 @@ int cte_sub_addl(int x) { return (1 - x) + 1; }
 /*
  * check-name: simplify-cte-sub-addl
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-contains: sub\\..*\\$2, %arg1
-- 
2.28.0

