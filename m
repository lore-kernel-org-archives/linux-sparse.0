Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03547C71155
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 16:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6D1E221EB
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 16:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u33/o9ym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731469AbgK0QwI (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 27 Nov 2020 11:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731952AbgK0QwH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 27 Nov 2020 11:52:07 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AFBC0613D1
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 08:52:07 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id k14so6262520wrn.1
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 08:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CAVlJGQ5x4FVveyNh51EYzXwMKdj7wwS/7sFlX2rgrs=;
        b=u33/o9ymKmRef84D59xQ863YiNkJJ8oPQ0dRqS0tWGIdYKJMx6kpCZ8SBQusXVDx1f
         mGxQcDWKEYe/bHT7YgBBDaXLKZTvmIOxq9h12kognt5GJ+2peHtR7bNRTzXAzG0R2H4N
         I/M+kyEM4DUn92BZ7xIUq8xEVUox2hIy/GPc6S5s03AFPTkPSemrVTse4XsNk3Muu2n/
         8GpCGSij2P268dE13LEU2kdo3KIjHw8y6N56vY2NjqXoGz7do6bKDo/2RwfsRUYVs5dJ
         gyeirLRF3Q3invMj0m/kSiVjxSXLr9diqATqymKEARV527r9AHpZP9DNrIQ8rx3CZAuE
         Pf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CAVlJGQ5x4FVveyNh51EYzXwMKdj7wwS/7sFlX2rgrs=;
        b=pGbuWtSYVCAgEcEt4Rl7UWzsAGml7y91waeoVNqBA9NoXOuKqGBI4Bkkj683uGNtUb
         qPXMt3fSXZw+ppWh8OntL5UIp2a1I/o9G3rkcTvS7dExSZqnzqHAJdPKiamLrAtA+6zc
         q03vaY+Oy5rnY286fNh+xL1BdssJGUWUc8n/mEVkSv1tsdiDGwNSM8oUok5pMx3ncgZA
         lSjEyRPqK9y+Y1p7oZu6qmScxplgJEp77qulPXXjbbXo5yE2FvT7ltQSk/sVPjVIRfdQ
         vrhEII9+0sgb3TETOgz123195jbQRXPliCQW2Yu2dG7L4KAZav590yFdq4UR0fHmj7BB
         +LGw==
X-Gm-Message-State: AOAM533F/uIFKz596jP4OAJza9mPtbzFoqsHlMkx0mm/HmSL6MqRDkHX
        tgqAJZJn7+g0R8mZgbj9kQ/i23dl3Ow=
X-Google-Smtp-Source: ABdhPJyyM/lhmuVqcgc5SptZ4xhQsnINTqqZkonGWtzO/7W1TVyR+9sEIfd6C4l1bE/w+ykFf21LVw==
X-Received: by 2002:a5d:6852:: with SMTP id o18mr11758157wrw.336.1606495925996;
        Fri, 27 Nov 2020 08:52:05 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:e9bd:38ae:745f:40ea])
        by smtp.gmail.com with ESMTPSA id y2sm15895539wrn.31.2020.11.27.08.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 08:52:05 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 6/8] refactor simplify_add() to avoid code duplication
Date:   Fri, 27 Nov 2020 17:49:48 +0100
Message-Id: <20201127164950.41517-7-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201127164950.41517-1-luc.vanoostenryck@gmail.com>
References: <20201127164950.41517-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Do some refactoring in simplify_add() to avoid some code
duplication there and better handle generic transforms
that need to be applied on both operands.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/simplify.c b/simplify.c
index 82ff1242bb0e..5174a903dfd6 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1620,11 +1620,11 @@ static int simplify_associative_binop(struct instruction *insn)
 	return REPEAT_CSE;
 }
 
-static int simplify_add(struct instruction *insn)
+static int simplify_add_one_side(struct instruction *insn, pseudo_t *p1, pseudo_t *p2)
 {
-	pseudo_t src1 = insn->src1;
-	pseudo_t src2 = insn->src2;
 	struct instruction *def;
+	pseudo_t src1 = *p1;
+	pseudo_t src2 = *p2;
 
 	switch (DEF_OPCODE(def, src1)) {
 	case OP_NEG:				// (-x + y) --> (y - x)
@@ -1635,19 +1635,15 @@ static int simplify_add(struct instruction *insn)
 			return replace_with_pseudo(insn, def->src1);
 		break;
 	}
-
-	switch (DEF_OPCODE(def, src2)) {
-	case OP_NEG:				// (x + -y) --> (x - y)
-		return replace_binop(insn, OP_SUB, &insn->src1, src1, &insn->src2, def->src);
-	case OP_SUB:
-		if (src1 == def->src2)		// x + (y - x) --> y
-			return replace_with_pseudo(insn, def->src1);
-		break;
-	}
-
 	return 0;
 }
 
+static int simplify_add(struct instruction *insn)
+{
+	return simplify_add_one_side(insn, &insn->src1, &insn->src2) ||
+	       simplify_add_one_side(insn, &insn->src2, &insn->src1);
+}
+
 static int simplify_sub(struct instruction *insn)
 {
 	pseudo_t src1 = insn->src1;
-- 
2.29.2

