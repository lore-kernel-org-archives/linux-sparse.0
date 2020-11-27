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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416CDC71156
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 16:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10C88221EB
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 16:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4LBZzn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732138AbgK0QwK (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 27 Nov 2020 11:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732032AbgK0QwK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 27 Nov 2020 11:52:10 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E2FC0613D1
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 08:52:10 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id w24so7123561wmi.0
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 08:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6MxQEPAlZddDzkoKOwm1PjTUhwDPKHRvL3sAVuYJutc=;
        b=F4LBZzn8+KrmQ9/xOKNnBaV3DYPkt6A5niZWvc1re3mm80dXiRiS56gn/GVrv+WBfW
         VCMcffckbedwvoA57VZNoHEAulDhkSdccPp/qWxcDyI03R9oABvR0aZORDysgYNp9aF4
         Kxqig+mQkLiBnd4nLTT8AveBdXD9PTm7dHyZ9HzDOQSqGMB28y03gBFp2ocFpNCEA/YU
         uj8UBlq+B4yOnZX+gaXH+BZPy9J6caG2rzUgsIT1pxCF1G3vsA3nvKWkBMTxtFItbsrm
         rNdZfbho2UbeX2QMtw5YzZfVX4RySy8lS3nG6pprmN1uxoRfA6s5jYbZS4Wy+WImfqug
         SoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6MxQEPAlZddDzkoKOwm1PjTUhwDPKHRvL3sAVuYJutc=;
        b=UX+NG4rKchQdbqbLoLK0uRwJR7ySWH+Iw6191S8RRE7f1QrrNOQOzCMvjgWfNHGQ9X
         wSzpXeMqBtcpxYqDNR08exbRxmfUnKyTZ8siQ+USItLeQS6SQS1unXc8OSjEGg8iRd2A
         jJ0JjgbzYpJt1WAjcQ7aRr8TaMHOP8Ks9kMVDVDZwpxQ7roXqzlVN+By9Ed14xRcLm/x
         GgrTTRZZ9GVO87npMfmfK6lorP1WdCHYULZJzgC6JHO8cqFGpYawnAd96VZd0KtKFLnj
         3ZuqC1qUgQeH9pO6GNcIij8UumxSXs9BkiGMuN0PG0EtPt2qPL3Vqcoe5Uz7XWe8wJ8r
         GDkw==
X-Gm-Message-State: AOAM533xCUlvekCRCMpLvUzOy7fzbKzj5ovPUq1+wKvx6HIEUptOkaje
        z+clqbPoMtGCIWH7ljYjb2AfGwTI3AQ=
X-Google-Smtp-Source: ABdhPJytZnt9Axt5JXr5g0gCU99uUVU8mmWL7pxKliGhmVumBV75IU8rFGlBrE+NLjpqq3ynauaIsw==
X-Received: by 2002:a1c:4c14:: with SMTP id z20mr10037403wmf.149.1606495928610;
        Fri, 27 Nov 2020 08:52:08 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:e9bd:38ae:745f:40ea])
        by smtp.gmail.com with ESMTPSA id y2sm15895539wrn.31.2020.11.27.08.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 08:52:08 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 8/8] factorize SHIFT(x, s) OP SHIFT(y, s) into SHIFT((x OP y), s)
Date:   Fri, 27 Nov 2020 17:49:50 +0100
Message-Id: <20201127164950.41517-9-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201127164950.41517-1-luc.vanoostenryck@gmail.com>
References: <20201127164950.41517-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Factorize bitwise OPs of shifts with identical counts.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                        | 27 +++++++++++++++++++++++++++
 validation/optim/fact-and-shift.c |  1 -
 validation/optim/fact-ior-shift.c |  1 -
 validation/optim/fact-xor-shift.c |  1 -
 4 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/simplify.c b/simplify.c
index 319112a90b7b..89a064b93e85 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1754,6 +1754,15 @@ static int simplify_and_one_side(struct instruction *insn, pseudo_t *p1, pseudo_
 			}
 		}
 		break;
+	case OP_SHL: case OP_LSR: case OP_ASR:
+		if (DEF_OPCODE(defr, *p2) == def->opcode && defr->src2 == def->src2) {
+			if (can_move_to(def->src1, defr)) {
+				// SHIFT(x, s) & SHIFT(y, s) --> SHIFT((x & y), s)
+				swap_insn(insn, defr, def->src1, defr->src1, def->src2);
+				return REPEAT_CSE;
+			}
+		}
+		break;
 	}
 	return 0;
 }
@@ -1799,6 +1808,15 @@ static int simplify_ior_one_side(struct instruction *insn, pseudo_t *p1, pseudo_
 				return replace_with_value(insn, 1);
 		}
 		break;
+	case OP_SHL: case OP_LSR: case OP_ASR:
+		if (DEF_OPCODE(defr, *p2) == def->opcode && defr->src2 == def->src2) {
+			if (can_move_to(def->src1, defr)) {
+				// SHIFT(x, s) | SHIFT(y, s) --> SHIFT((x | y), s)
+				swap_insn(insn, defr, def->src1, defr->src1, def->src2);
+				return REPEAT_CSE;
+			}
+		}
+		break;
 	}
 	return 0;
 }
@@ -1844,6 +1862,15 @@ static int simplify_xor_one_side(struct instruction *insn, pseudo_t *p1, pseudo_
 				return replace_with_value(insn, 1);
 		}
 		break;
+	case OP_SHL: case OP_LSR: case OP_ASR:
+		if (DEF_OPCODE(defr, *p2) == def->opcode && defr->src2 == def->src2) {
+			if (can_move_to(def->src1, defr)) {
+				// SHIFT(x, s) ^ SHIFT(y, s) --> SHIFT((x ^ y), s)
+				swap_insn(insn, defr, def->src1, defr->src1, def->src2);
+				return REPEAT_CSE;
+			}
+		}
+		break;
 	}
 	return 0;
 }
diff --git a/validation/optim/fact-and-shift.c b/validation/optim/fact-and-shift.c
index 401750216b44..e9eb9cceef95 100644
--- a/validation/optim/fact-and-shift.c
+++ b/validation/optim/fact-and-shift.c
@@ -20,7 +20,6 @@ sint fact_and_asr(sint a, sint b, sint s)
 /*
  * check-name: fact-and-shift
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
diff --git a/validation/optim/fact-ior-shift.c b/validation/optim/fact-ior-shift.c
index 07fdf80604dc..5fa91eb5cfc2 100644
--- a/validation/optim/fact-ior-shift.c
+++ b/validation/optim/fact-ior-shift.c
@@ -20,7 +20,6 @@ sint fact_ior_asr(sint a, sint b, sint s)
 /*
  * check-name: fact-ior-shift
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
diff --git a/validation/optim/fact-xor-shift.c b/validation/optim/fact-xor-shift.c
index 81fcda851400..5fb228bd80a1 100644
--- a/validation/optim/fact-xor-shift.c
+++ b/validation/optim/fact-xor-shift.c
@@ -20,7 +20,6 @@ sint fact_xor_asr(sint a, sint b, sint s)
 /*
  * check-name: fact-xor-shift
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.29.2

