Return-Path: <SRS0=8Oh8=D7=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABF1C2D0A3
	for <linux-sparse@archiver.kernel.org>; Sat, 24 Oct 2020 22:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D2E120773
	for <linux-sparse@archiver.kernel.org>; Sat, 24 Oct 2020 22:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+UzJiCW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762798AbgJXWrX (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 24 Oct 2020 18:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762797AbgJXWrX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 24 Oct 2020 18:47:23 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA52C0613CE
        for <linux-sparse@vger.kernel.org>; Sat, 24 Oct 2020 15:47:23 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id p13so5431348edi.7
        for <linux-sparse@vger.kernel.org>; Sat, 24 Oct 2020 15:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kQHYiwmMyMuBH5wEUgHs1oeKnR7TbXE17JHvvJZJE/M=;
        b=I+UzJiCW3GANYoDZqPmFisavcCNqNj3KkOCUImlKmUegeF1KLd7rqPIRvHi4mMrG6c
         RJp8PvZk3oL2ptLRwMk4a96LDnrQmxK/ci6j6nABhrN3lVXYSZKpKCzDED7S9Svuw5ba
         Bl5vxJ0e3vNK0ywbDhh/Y8LLy+NPxbSmrC8cn+3Y38wfctdcNhLJG8gV+rGhCOQ+qV4r
         xNubxACSKL16sqGzDeYI2fFpA5v+9X4cq+EWG6GMIkMdtkCb1MHKgGrFkoFGs3RF3RpB
         bFEJeQCI37Nv9MUBwXjpRILZUpLHNRwYpDIrqOMwiRSSgwF0ggF6VEkp3q1R4CB8fokU
         /f9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kQHYiwmMyMuBH5wEUgHs1oeKnR7TbXE17JHvvJZJE/M=;
        b=kZp81dFPV7w4nZKBYiW1+MEPytOsXOvIZWyNqAxgvemheqmgNmY8pm7OKhXip4VRIN
         BmebmMI5rpINUN2K897CrIxo5tMElWDpPKwRD8ViZaPuLX8VFgf9Zfj4g+RRMHtUnFBb
         nQWVGMRAfut7A0wnQ/1j8cCAga91/zA07VcLJKbnTY/ezd5Gr7DSA9V93nA84yLpnFg1
         Dp5I4adffpzTIrvMff34Ae9rOFjhPO73sofhcl67cvsmEoIlTRE/r8fZ/Jpck0tmy9CG
         juW0ajNp0wrdLStF5DD9etqUhZMaVdDH2sUGceqowOePQcq4QRXSlWiUVw3IhLxh/nNE
         SDrA==
X-Gm-Message-State: AOAM532xSgOP/4+tyh34qVubVcUomUp0fg+UfOF8kB79JdGvld2DriZ8
        /s3xol5isGabflrfBmpCIPXrrA91zCk=
X-Google-Smtp-Source: ABdhPJz6O5PPMElpA475dc0CslP5RbT1SwnGeiNV/FUz58LEIArTL8ENiLSI/O78EuBZXEomMhkGIg==
X-Received: by 2002:a50:cf8f:: with SMTP id h15mr7613247edk.211.1603579641804;
        Sat, 24 Oct 2020 15:47:21 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:8010:c084:ff33:29b8])
        by smtp.gmail.com with ESMTPSA id r24sm2715509edm.95.2020.10.24.15.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 15:47:21 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] linearize: OP_INLINE do not use the function symbol
Date:   Sun, 25 Oct 2020 00:47:16 +0200
Message-Id: <20201024224716.9599-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The instruction OP_INLINE is a kind of note or comment, indicating
that the code below it used to be the body of a function which has
now been inlined. The symbol of the original function is displayed
when this instruction is displayed but this symbol should not be
considered as being used by the instruction since there is no
dependency or def-use chain between the two.

So, replace the use_pseudo() by a simple assignment.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linearize.c b/linearize.c
index 1081bda86425..e16c686ca73a 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2065,7 +2065,7 @@ static pseudo_t linearize_inlined_call(struct entrypoint *ep, struct statement *
 	pseudo = linearize_fn_statement(ep, stmt);
 	insn->target = pseudo;
 
-	use_pseudo(insn, symbol_pseudo(ep, stmt->inline_fn), &insn->func);
+	insn->func = symbol_pseudo(ep, stmt->inline_fn);
 	bb = ep->active;
 	if (!bb->insns)
 		bb->pos = stmt->pos;
-- 
2.29.0

