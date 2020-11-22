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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBD5C5519F
	for <linux-sparse@archiver.kernel.org>; Sun, 22 Nov 2020 17:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7970E2076B
	for <linux-sparse@archiver.kernel.org>; Sun, 22 Nov 2020 17:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDc92kdN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgKVRuh (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 22 Nov 2020 12:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbgKVRug (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 22 Nov 2020 12:50:36 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D575C0613CF
        for <linux-sparse@vger.kernel.org>; Sun, 22 Nov 2020 09:50:36 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 64so2819911wra.11
        for <linux-sparse@vger.kernel.org>; Sun, 22 Nov 2020 09:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZHzOS3UE5f7p9IIRbjMv52YVmYU0rnuQ9++3gIbvGyY=;
        b=nDc92kdN/RdYvtfhIeNfxyenMe0APxSZTRsp89V0gk/Ep4AvmKRLn2TJRnS4mqnAjD
         qwkftb5l5RWM96O6mVZDnViKseQ4OSXGYUGnP7Yrx73Zu858F+/5Er8Bp05b5de/gpLN
         MlH9G/f9XLzYWxX/CuAYrC6To84/VHUXC51jKVCQdF425rqg0UjPXfVxSdFfOzvsMj7E
         93+3bids/uvNro/7ijQKjciv4q/HF3bir8UkNgLHaBpF3zJbGQGAZHb01spUzZ8MNfGn
         U3C4/g0KN/8uTFWclmOpBR5UyZI9ARmPqybjby7gm15ll6zIbuMIVfUtDdFhsjffqVNb
         5QGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZHzOS3UE5f7p9IIRbjMv52YVmYU0rnuQ9++3gIbvGyY=;
        b=pKUk+wpR/61+Qk8jWQhrHugXOAfPVoTyejyp2FxzXPbbFomHpC3m5H0w85mwhST474
         LDwLgXsJU3HV71axPUaFPN4GG7UbXEkeVoaTcEy0xXxvmy3Ti+/dSg+KM/lHl7KRANB7
         d8pjImyLEatY9I+Ui2DUqdHBHS1v1EdM75zOpnerDs37LdsEmHAyNlnOTNro/fMjkENU
         raNJKbknQ0vi/QdcMVZdr2nMKxqevbXAiqW5sX54zHH01S+uXxTW34CGMEdoQ3H8VNet
         77UU20ZSXyJO942/BQ6WySb92WCuGYLBizYnwV+5cTRvBHnTdRhkPdlt7bZeKe7DlluA
         AatA==
X-Gm-Message-State: AOAM530sx0odOKkDJ+4sh1A8NavkDj8Kmp95Q2lDIzNiD/k23i35fy+x
        sOOPIIoPcq3FkGv4PVquMm22vU9lgyc=
X-Google-Smtp-Source: ABdhPJwoh5DU/sffAsAslEuPbsn/4N+oVIn9lCnrjsubtQdphu+Ym27u2c5raAfNim2JMsTU7MblJA==
X-Received: by 2002:a5d:6783:: with SMTP id v3mr25849391wru.45.1606067435069;
        Sun, 22 Nov 2020 09:50:35 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:b0e1:b041:18e2:46cf])
        by smtp.gmail.com with ESMTPSA id w17sm13778893wru.82.2020.11.22.09.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 09:50:34 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] symaddr: give a type to OP_SYMADDR
Date:   Sun, 22 Nov 2020 18:50:30 +0100
Message-Id: <20201122175030.18689-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Currently, OP_SYMADDRs are given a size but not a type.
But the type is needed for several things, the idea being
that for each instruction producing a pseudo (PSEUDO_REG)
it's possible to:
* retrieve its defining instruction
* retrieve its type via this defining instruction

Fix this by giving to OP_SYMADDRs the type of their symbol.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/linearize.c b/linearize.c
index 8a3cf09bfae2..9fecb4b57e43 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1128,13 +1128,13 @@ static pseudo_t add_setfval(struct entrypoint *ep, struct symbol *ctype, long do
 	return target;
 }
 
-static pseudo_t add_symbol_address(struct entrypoint *ep, struct symbol *sym)
+static pseudo_t add_symbol_address(struct entrypoint *ep, struct expression *expr)
 {
-	struct instruction *insn = alloc_instruction(OP_SYMADDR, bits_in_pointer);
+	struct instruction *insn = alloc_typed_instruction(OP_SYMADDR, expr->ctype);
 	pseudo_t target = alloc_pseudo(insn);
 
 	insn->target = target;
-	use_pseudo(insn, symbol_pseudo(ep, sym), &insn->src);
+	use_pseudo(insn, symbol_pseudo(ep, expr->symbol), &insn->src);
 	add_one_insn(ep, insn);
 	return target;
 }
@@ -1914,7 +1914,7 @@ static pseudo_t linearize_expression(struct entrypoint *ep, struct expression *e
 	switch (expr->type) {
 	case EXPR_SYMBOL:
 		linearize_one_symbol(ep, expr->symbol);
-		return add_symbol_address(ep, expr->symbol);
+		return add_symbol_address(ep, expr);
 
 	case EXPR_VALUE:
 		return value_pseudo(expr->value);
-- 
2.29.2

