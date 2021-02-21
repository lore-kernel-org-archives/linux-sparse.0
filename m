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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E55C433E0
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Feb 2021 22:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FC7564EC3
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Feb 2021 22:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhBUWfj (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Feb 2021 17:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhBUWfi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Feb 2021 17:35:38 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBFEC061786
        for <linux-sparse@vger.kernel.org>; Sun, 21 Feb 2021 14:34:58 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id g5so26264203ejt.2
        for <linux-sparse@vger.kernel.org>; Sun, 21 Feb 2021 14:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PESktqMOy9uAdSFpdYi1YwHT32+LCSPy4rbiJuBOqIU=;
        b=Ct67mM9P+X/DajdsltV/PYg1M+Ui8hHCQHrNco7zvXaUM09ZhQH8WIX0aSCyTAuvj8
         P/biKqKhP+L3ypPCmW++qq7aNqJwPYMQU8HOrfq0apCcFkAa2qB+LS6QPTPzvdSiICHm
         MbyWO6TwvZJDp2o5Z5dnqdr5HCYbDjq85pN89JAtuv8mqUBjJNP3KiXfbNv1t0cE5yPw
         yTA1rws+AsTICR1eauByawR85w4ifMCtpBmH3JQer75ilHXRljN9WTaZd2D1kyHRMmBI
         MPChQjN8QsXJDz4r3wU1Gecs9cV+BUS1zzC3i9iSX0Q7VccXiCPE+vQPWDCPTfM09JT9
         PX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PESktqMOy9uAdSFpdYi1YwHT32+LCSPy4rbiJuBOqIU=;
        b=lXxpo0Xid4Bpc3flGDHp4kx3UzO7P8EDXAX/59h/UBsdTwt/Wa0NI0EvzG1xRGJMlv
         sqPVJZRgMM66OyPIgcHiFK0Nhv4hwR+RQyyVRpypoo6U3Imym0rO48NNqINPep0IzrBy
         KYY6seDalAauo7xjs9ECwKjbQB37KxIHqfWnCUffzWppehEtWbgrQc2MPmMC6t6HnUY+
         j+TgDDfLL/iilZSTZzEy0jlPvMridDKK4fSbkiZ0e+PTKTl+8wBkewjTNs0QKtixgtAE
         MJWlDU9YGnhmeD6mUdtPxaEOFJhLx8wFWR0BX/bMsicej5C6a+AxRX6b9P03MKJSQRN3
         howw==
X-Gm-Message-State: AOAM53203oOnkBQmaOF+5mfGAxSIOT3tef+86aSxVYBr5RdCqlw7dpwM
        NyXgLFXPuE13udcT66cMx7vyggYw2CA=
X-Google-Smtp-Source: ABdhPJwGT2YX65oB4UJzdBTRU0xEMhIXJWTmybyvVRdvl3PMzztAyag9xVybYOe/KFUIvoLIvoQaQw==
X-Received: by 2002:a17:907:9209:: with SMTP id ka9mr18186215ejb.123.1613946897100;
        Sun, 21 Feb 2021 14:34:57 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:9463:3f6a:e4eb:cf54])
        by smtp.gmail.com with ESMTPSA id p2sm10433622edm.94.2021.02.21.14.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 14:34:56 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/5] reorg dominates()
Date:   Sun, 21 Feb 2021 23:34:48 +0100
Message-Id: <20210221223452.8075-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210221223452.8075-1-luc.vanoostenryck@gmail.com>
References: <20210221223452.8075-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

To prepare the handling of OP_ASM instructions, reorganize the
opcode tests to use a switch.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/flow.c b/flow.c
index bda277aa551b..5751ce756518 100644
--- a/flow.c
+++ b/flow.c
@@ -490,12 +490,15 @@ static inline int distinct_symbols(pseudo_t a, pseudo_t b)
  */
 int dominates(pseudo_t pseudo, struct instruction *insn, struct instruction *dom, int local)
 {
-	int opcode = dom->opcode;
-
-	if (opcode == OP_CALL || opcode == OP_ENTRY)
+	switch (dom->opcode) {
+	case OP_CALL: case OP_ENTRY:
 		return local ? 0 : -1;
-	if (opcode != OP_LOAD && opcode != OP_STORE)
+	case OP_LOAD: case OP_STORE:
+		break;
+	default:
 		return 0;
+	}
+
 	if (dom->src != pseudo) {
 		if (local)
 			return 0;
-- 
2.30.0

