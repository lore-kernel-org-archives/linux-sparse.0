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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E87C433E9
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 12:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 613976194D
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 12:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhCUMf2 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Mar 2021 08:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhCUMfU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Mar 2021 08:35:20 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9E3C061574
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 05:35:20 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id j3so16028560edp.11
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 05:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gb/WVZ1THkivgKLK4xRh0ywfmgqDYSFXZFQyeEHJhos=;
        b=GcHMio2ZAjadcHnwvoLstBumWAlrYV6HyGub2FKtaxNPDIich8Uj7K3wi5jgv4E8AZ
         cMA0CYsWqnMSbpbiWUCX+/U3oqtmkNpEbVjdok5uVrWs9H0GcUbaYj+V2/dBeFOo9ARZ
         MdOvb5sJRs80ieh2s9Hl1x0vrNsI0ZaDaNvPM8Cv3djq8t31YCCtzRiOnfkYlUj8NjQv
         9jLy4vEEE1EFQLqEQbZkpJValVAtDul1w4zOTVREmpQHF7pbUWYDi8fkqWvb5IB/0Cmr
         hEO4TsoFhjZ0DT7AQKX1lM23xDg9PiVZzlX3e3YmJMZ2CaGQYI2VseXJBRiajzw1Wcc7
         Ni5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gb/WVZ1THkivgKLK4xRh0ywfmgqDYSFXZFQyeEHJhos=;
        b=k5Ymm0oxm/U7BQ+eukL0BU7DBpPYVtO7K4PobvoH08VlE6Pko+PQ8f7EYjOjiZOc4z
         p6tAOC1jYeXP0MfTB7jEjaefbgvkHxorb8Akebv4BFrOlrjGLhVbpjtWgIabHC350+As
         x0OYw1lOxb0rPDPXQhWkRWdqiN0VAF99PbTSp77In9t+5xcdjIl+XKaR0LGOyKEDIzwx
         PCloDBF5tLJ1OHHkhg8PXqrBLmztCrZq4dV1BjYBGrUmaYEHoB/V+/RWlgpJJMJ88PPj
         tlW9/DXWiWU1Lw38jO0M1d/ZLzAsI5wAbMAEc5bO2vRWEpRYS+IUg1Zp0R4t7Vq80kPl
         ntXA==
X-Gm-Message-State: AOAM533eWltlR4MJwPETomXFxmT1naxO/bjVJKAc6Gbyk0q6gFy+1gT+
        k8GX0aPxSVdUhdv9ylxcme1mW3ebiFw=
X-Google-Smtp-Source: ABdhPJwItPAR/mfBTbdhYqksnRIdlbdifPYgomihuzWk9sszn4ia1ABAow4XpiCpsqLhofobuwyiJQ==
X-Received: by 2002:a05:6402:447:: with SMTP id p7mr20378196edw.89.1616330119097;
        Sun, 21 Mar 2021 05:35:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:b090:4406:df97:c155])
        by smtp.gmail.com with ESMTPSA id jv19sm6998641ejc.74.2021.03.21.05.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 05:35:18 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 11/13] fix phisources during CBR-BR conversion
Date:   Sun, 21 Mar 2021 13:35:03 +0100
Message-Id: <20210321123505.27993-12-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210321123505.27993-1-luc.vanoostenryck@gmail.com>
References: <20210321123505.27993-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

When a parent is removed from a BB containing one or several phi-nodes,
the corresponding phi-sources must be removed from the phi-node.

However this is not done and consequentially:
* it becomes impossibly to correctly reason about the flow of values
  through these phi-nodes.
* simplifications are missed (e.g. if-conversion).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c                          | 5 +++++
 validation/optim/bad-phisrc1.c  | 1 -
 validation/optim/bad-phisrc1a.c | 1 -
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/flow.c b/flow.c
index 4952562a373d..69d95a98a512 100644
--- a/flow.c
+++ b/flow.c
@@ -760,6 +760,11 @@ int convert_to_jump(struct instruction *insn, struct basic_block *target)
 	struct basic_block *child;
 	int changed = REPEAT_CSE;
 
+	switch (insn->opcode) {
+	case OP_CBR:
+		changed |= remove_phisources(insn->bb, insn->bb_true == target ? insn->bb_false : insn->bb_true);
+		break;
+	}
 	kill_use(&insn->cond);
 	insn->bb_true = target;
 	insn->bb_false = NULL;
diff --git a/validation/optim/bad-phisrc1.c b/validation/optim/bad-phisrc1.c
index 59c5e4f1e66a..aa12dd0ae542 100644
--- a/validation/optim/bad-phisrc1.c
+++ b/validation/optim/bad-phisrc1.c
@@ -8,7 +8,6 @@ void foo(int a, int b)
 /*
  * check-name: bad-phisrc1
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-excludes: phi\\.
diff --git a/validation/optim/bad-phisrc1a.c b/validation/optim/bad-phisrc1a.c
index cf07573b1fd3..b7519ee7cf5d 100644
--- a/validation/optim/bad-phisrc1a.c
+++ b/validation/optim/bad-phisrc1a.c
@@ -16,7 +16,6 @@ out:
 /*
  * check-name: bad-phisrc1a
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-contains: select\\.
-- 
2.31.0

