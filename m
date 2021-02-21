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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEACC43381
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Feb 2021 22:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7169B64EBE
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Feb 2021 22:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhBUWft (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Feb 2021 17:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbhBUWfl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Feb 2021 17:35:41 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85985C06178C
        for <linux-sparse@vger.kernel.org>; Sun, 21 Feb 2021 14:35:00 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id q10so19592972edt.7
        for <linux-sparse@vger.kernel.org>; Sun, 21 Feb 2021 14:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vIv1t53ectFeOVyiXsEEZ4xhYCJ930zM41PWD/+TfVs=;
        b=MKhwEYJFWT4sG1crsLZKzanRL++c5LI/eVa2ZFaW97c3tlw03dVjfHEuopK/tMXH7v
         OrSXpSBVRDZt54UGHkS2RLJEfFqBmhjrNcPQtNogAk4TTfT2mKQkqNDeDwzJ1yHSFuQ4
         iek5iCy7A44F59J76RPtiTbJF7pfSSMgznE8YbjTNKFr1QUklrfa+Cl+j034+KF4fzmN
         ObvqV39LlJTKt45yFieXO+kkLFeKM6rknjXrJ7hHqN2iFa+HLmrpLlepFBD9QwiJWzek
         /YYhfnFAoEVBKC8LGl5MHP5cSVObplp1XY1DkUcsYQUCppoNQbpoZ8FKDQRIJj1CAKO5
         s5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vIv1t53ectFeOVyiXsEEZ4xhYCJ930zM41PWD/+TfVs=;
        b=k1SStB720DMrbZ7yjeOTLLkLZnj389cI1sbw1swTV1vcTL95Nrn3kHOP+dLEaixITc
         AAxTERvK5npn9QIoSz/FJDB/ShHPmVnMiLYha7b5kGi1EPjH5uusGY8KrEuCTXhCx/Ox
         fYT53lht7DeeFG2Q/sF8siWMY/er3sQU9VjlNfFWAfg1gu4rusZ7MR8FvRCc5jwDHDKV
         lqzIfny9ZaDlSfguw1xDCZNvNMTu+YrrsOnYNhdE93tFDkKeIqi5n96aN8w1/C2ZJ24e
         PnsoFHGhaYPfFe834Mijn6TxGntBrJ2kDPKoTPKfP6/i39cB59PCFWv8F0Hm435LCTvj
         EKzw==
X-Gm-Message-State: AOAM532jD0IZI6wRIqh3Ws/6YDf7oyEaKgztJK24gQJc5H5XAbPel+Nc
        9Z97myVz40nCZ++zl0S+CnCdqdMzYHY=
X-Google-Smtp-Source: ABdhPJyuS+JJJ+EzTgwpperqj5GL2l43kEKo7DqeXb7oJJWZUtkFkuhGBK5WVSLyrOQMvDXlNKtq2A==
X-Received: by 2002:a05:6402:278a:: with SMTP id b10mr20033858ede.347.1613946898923;
        Sun, 21 Feb 2021 14:34:58 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:9463:3f6a:e4eb:cf54])
        by smtp.gmail.com with ESMTPSA id p2sm10433622edm.94.2021.02.21.14.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 14:34:58 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/5] asm-mem: does it output to memory?
Date:   Sun, 21 Feb 2021 23:34:51 +0100
Message-Id: <20210221223452.8075-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210221223452.8075-1-luc.vanoostenryck@gmail.com>
References: <20210221223452.8075-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

If an asm statement have a memory output operand, it modifies memory.

Since this information is needed during memops simplification,
add this info directly in the corresponding instruction,
avoiding the need to scan the output operands list each time.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 1 +
 linearize.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/linearize.c b/linearize.c
index 4140b60caebd..0c9b0e59cc4b 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2153,6 +2153,7 @@ static void add_asm_output_address(struct entrypoint *ep, struct instruction *in
 
 	pseudo = linearize_expression(ep, op->expr);
 	add_asm_rule(insn, &insn->asm_rules->outputs, op, pseudo);
+	insn->output_memory = 1;
 }
 
 static void add_asm_output(struct entrypoint *ep, struct instruction *insn, struct asm_operand *op)
diff --git a/linearize.h b/linearize.h
index fb51327684bb..cf0cf066a8e5 100644
--- a/linearize.h
+++ b/linearize.h
@@ -151,6 +151,7 @@ struct instruction {
 			const char *string;
 			struct asm_rules *asm_rules;
 			int clobber_memory:1;
+			int output_memory:1;
 		};
 	};
 };
-- 
2.30.0

