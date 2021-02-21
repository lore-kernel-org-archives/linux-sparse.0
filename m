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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B32C433E9
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Feb 2021 22:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A72D61606
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Feb 2021 22:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhBUWfp (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Feb 2021 17:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbhBUWfk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Feb 2021 17:35:40 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C06BC06178B
        for <linux-sparse@vger.kernel.org>; Sun, 21 Feb 2021 14:34:59 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id d8so26228273ejc.4
        for <linux-sparse@vger.kernel.org>; Sun, 21 Feb 2021 14:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/EzbR+Du2BxaJJadZeD2HbcmcwMUcvujgdONk2vLKNQ=;
        b=JGMslxXiA4l/HqLLmh0a7bkzBkb3dFSaO2ozayzefDIZheaVUfv8cYetPfli0vrGt3
         orJS0zHUUMBwgxoHOGR5Gy9Xy2Y6eJG/rSCAQJNBwAjwbD7sMJjzDYUYaU4jnNbr1iWN
         3jV8CgiFQfHzsbvB1ZqKmJWA09CXSMkcQRgCovus8As86QLKuL+S5XVN/RQk5FvStc6R
         7uPBStxrBkdiuX9XbJxZJRv0S8C1szP+I4+Kd2I1qxeQgAKSisRHEVUyNBVuuDjr0zpF
         JIRpDxMmtEq7YIi+qh5r8Epuz2qrrPJnfJDfGfxeYIp9dsMSiSQ03XqcsezToziTWZNE
         4Zsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/EzbR+Du2BxaJJadZeD2HbcmcwMUcvujgdONk2vLKNQ=;
        b=dng6GUg5+hnHnOjY9eZKcalm5LSqP3yOToOQELreGs1YThdpX/j/8bxHAYLoq5lmPj
         hUatq0TfbHHTjGqxBV2QtJOSs7MjHQpP2PguXOSVi58nd5Hu7AW8KEEhE/KA4CYl6cvY
         BkEiBv7FeIx21zWRBJBhqLdIEtvgJ5kap45yxCPegWww2ykuJ2TsvZCm/Cb61pKLe2PF
         NrimDjyjtu21KfGMxbO2ZbhFNpMAdnMCDGMNji/cdDzzjMjxYTx2Z/j0bQ3yNT5e5jPB
         CoTSQ1duHdvMgbWS76mb8h61vagw7B1b34M24BvV5oJyGLMIYhs3155oeCpFdwme1xrX
         17ZQ==
X-Gm-Message-State: AOAM531eVCJ3gHiWJgifGkmvkHSbaOKyg+inxl/brjRt2XQy3cC7CrX9
        ztduxbWL6JNRdEJcLfiraNMB5vSCfYI=
X-Google-Smtp-Source: ABdhPJwHOMpae5b3Qpg/i4AubJ9xFG5tDhMSk5gFrGQoC4r2ml8dFrc3N9o/LEDQgyOKMauD2pb8SA==
X-Received: by 2002:a17:906:b0d8:: with SMTP id bk24mr18675378ejb.252.1613946898327;
        Sun, 21 Feb 2021 14:34:58 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:9463:3f6a:e4eb:cf54])
        by smtp.gmail.com with ESMTPSA id p2sm10433622edm.94.2021.02.21.14.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 14:34:58 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/5] asm-mem: does it clobber memory?
Date:   Sun, 21 Feb 2021 23:34:50 +0100
Message-Id: <20210221223452.8075-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210221223452.8075-1-luc.vanoostenryck@gmail.com>
References: <20210221223452.8075-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

An asm statement can specify that it clobbers memory.
Add this info directly in the corresponding instruction, avoiding
the need to scan the clobber list each time.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 8 +++++++-
 linearize.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/linearize.c b/linearize.c
index 33d641b40de6..4140b60caebd 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2174,7 +2174,7 @@ static void add_asm_output(struct entrypoint *ep, struct instruction *insn, stru
 static pseudo_t linearize_asm_statement(struct entrypoint *ep, struct statement *stmt)
 {
 	struct instruction *insn;
-	struct expression *expr;
+	struct expression *expr, *clob;
 	struct asm_rules *rules;
 	struct asm_operand *op;
 
@@ -2206,6 +2206,12 @@ static pseudo_t linearize_asm_statement(struct entrypoint *ep, struct statement
 		add_asm_output(ep, insn, op);
 	} END_FOR_EACH_PTR(op);
 
+	/* and finally, look if it clobbers memory */
+	FOR_EACH_PTR(stmt->asm_clobbers, clob) {
+		if (!strcmp(clob->string->data, "memory"))
+			insn->clobber_memory = 1;
+	} END_FOR_EACH_PTR(clob);
+
 	return VOID;
 }
 
diff --git a/linearize.h b/linearize.h
index a77e4b3e5f6f..fb51327684bb 100644
--- a/linearize.h
+++ b/linearize.h
@@ -150,6 +150,7 @@ struct instruction {
 		struct /* asm */ {
 			const char *string;
 			struct asm_rules *asm_rules;
+			int clobber_memory:1;
 		};
 	};
 };
-- 
2.30.0

