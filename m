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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C75C41604
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DBBE2237B
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmfbXD/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438667AbgJTVKe (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 20 Oct 2020 17:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438666AbgJTVKd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Oct 2020 17:10:33 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A58C0613CE
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:32 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id ce10so4852593ejc.5
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oSgXKGBteXypQavUok/ewpGN+i3rTzc8JXBXQ/AIbcY=;
        b=DmfbXD/d7vnJIpMYltgTRbl8ubUurngYFY9Yg/RzQfFEQ9sc3WsX0ZE+BNZkf71vbZ
         722KLeMimcpt5Lf7rwsvEkA4rBX9XjImwSc4fNu6wMdSJeNL+hprWdWVmN+FWskMoWpz
         X3CVbVOPi+nXzrwa9SsjuG0pnVsp666eOigkQFqLy/gTzSx9bJMCnlVmOG4RRd6ry5/Z
         7P9wwwR7QW15oztBzWFQPVshZKqt/kv3f21/lIP6XShN0t+IuTKkrNBRmfxC9sMwVEs2
         huo2XrQ2M9qHvCAEcIZtaX9xPUAjzI7alSLrquCQrtEHOjNuJlGNqO0yEmqP0jt9te3A
         i1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oSgXKGBteXypQavUok/ewpGN+i3rTzc8JXBXQ/AIbcY=;
        b=Egv1gPqiWBauSwlX9uEv0q/a6r9LsfYDxqV3O8qsKpHp7MOWgGEPbbdbTekXT3sJUD
         dhM88KYVX6P0I6ETbpOaawAdMDLiDMw1Z2pPRyoXJOEWZonhlg1rNJrcAtlX0YSa7ksH
         N3M6hLZhMnp2AMjtZxR5EWa7gNg+uD0NOQ1lFJ/BgD3bqFk3SbjHf+dqwu+ya3hfnja0
         eiuiURIUy0qx6Bmiw6dorhCVcFGhkHL88PxO4rb87IM6GF0zpdIgMChJ5EWtyIs4g5N9
         1eqVXumUw3hWmrPMIp+SY0hRNa0x6eOVoHhbHTDrsnZU9kv852N7T2EsAasO5t8FxTj7
         LuJQ==
X-Gm-Message-State: AOAM533Awr90iy08/RJwIcY9xSQ7Bn3vauXfD0FQ+6MDM+oMcdIdIRDL
        JxO6jZ3DeC4/vL9Q4SqgjhdS9eBMG8U=
X-Google-Smtp-Source: ABdhPJynTIIr17E4r31L/VDw4MdWLxWd6mQrCbry6HTlopbrSQLC9kCP4y3e1WEEepOA+Hz+0pw9Ug==
X-Received: by 2002:a17:906:1a19:: with SMTP id i25mr73519ejf.323.1603228231474;
        Tue, 20 Oct 2020 14:10:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:85fe:66cb:a92b:c664])
        by smtp.gmail.com with ESMTPSA id d12sm4012848ejt.105.2020.10.20.14.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 14:10:30 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 08/22] reassoc: simplify (x # C) # K --> x # eval(C # K)
Date:   Tue, 20 Oct 2020 23:10:07 +0200
Message-Id: <20201020211021.82394-9-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020211021.82394-1-luc.vanoostenryck@gmail.com>
References: <20201020211021.82394-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Do this simplification once for all associative binops.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                        | 5 +++++
 validation/optim/reassoc-op-op1.c | 1 -
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index 3935552bd6fa..b14f88405861 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1295,6 +1295,11 @@ static int simplify_associative_binop(struct instruction *insn)
 		return 0;
 	if (!simple_pseudo(def->src2))
 		return 0;
+	if (constant(def->src2) && constant(insn->src2)) {
+		// (x # C) # K --> x # eval(C # K)
+		insn->src2 = eval_op(insn->opcode, insn->size, insn->src2, def->src2);
+		return replace_pseudo(insn, &insn->src1, def->src1);
+	}
 	if (multi_users(def->target))
 		return 0;
 	switch_pseudo(def, &def->src1, insn, &insn->src2);
diff --git a/validation/optim/reassoc-op-op1.c b/validation/optim/reassoc-op-op1.c
index aa7092ff57a0..3d050c142249 100644
--- a/validation/optim/reassoc-op-op1.c
+++ b/validation/optim/reassoc-op-op1.c
@@ -8,7 +8,6 @@ int foo(int x, int *ptr)
 /*
  * check-name: reassoc-op-op1
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-pattern(1): add\\.
-- 
2.28.0

