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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD2EC6379F
	for <linux-sparse@archiver.kernel.org>; Sun, 22 Nov 2020 15:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85C1420773
	for <linux-sparse@archiver.kernel.org>; Sun, 22 Nov 2020 15:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6hRn/gj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgKVP1m (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 22 Nov 2020 10:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgKVP1l (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 22 Nov 2020 10:27:41 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBB5C0613CF
        for <linux-sparse@vger.kernel.org>; Sun, 22 Nov 2020 07:27:41 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c9so15530113wml.5
        for <linux-sparse@vger.kernel.org>; Sun, 22 Nov 2020 07:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zltb2qLLAHtwKEbB3MDd2Q4e9WUZbVZ+eHiHjUTpFQw=;
        b=K6hRn/gjKJq711s95wMK2hXdueFWQP8HodgZW0aUJ0cKRF2goGN4U/NprCXzcRWGcb
         YP+nruKdzyOJcrCoFh2huXrogs0aEuYeqgdLF5l5/VwI4KYvMhdvDzwvQ/4Pg6Y+Cwji
         CXiytIaFK1Z5QyrccWcMbzp0uRppLcN6QJO+nIJEY8+y+Z6adFO43ChiBWTPbswc5y6V
         U3NRzu5bjhJEgsE8rILt1idJIgPt40IicNYN3K1IFn3gIfgFUbkBu1kTEms9d4Cc2tVu
         DLJNcPrKx+hhJsNV8Jsv1wZf+6u+hwfKESA6hglK/BrSv5/CJ2mUPO7Sr0C+jKKsF2fp
         ainw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zltb2qLLAHtwKEbB3MDd2Q4e9WUZbVZ+eHiHjUTpFQw=;
        b=rvaJBLmimPD7d2dkGkMu1bmPf7LzzEOtMjQOQnWfVxHWbRgY77oUU31F+zH9sF2kcJ
         bPoXL3eO8xocvBp3fHlUnF6qNCJ3R7sTxBK9+4ROujQ/7C+HawAD2FjT4aGLCmodHDEM
         rbtLoyOowNU6ACH0lyIiHvCgDp87uLTs1GJV07TAy8/otTt++VvdYf8pYmOpIHVVYKnt
         O2lmZffo+NoBLM3i3ytUrsQdIrXj8WGwsCgPrIsY+laCNCvXV0kWAWJv7HmMkDU/JzS6
         4zucNQqyMMOd1SyNrLL89DQIrUMLM6dsFLar4qu2XaSSMTbHIMuBy7l0MssaqC4nM32u
         mcHg==
X-Gm-Message-State: AOAM5331KMSX/hV6qpzk7zziFqgItCYZe5BR+/sQNlxgjcUlC2b6j93R
        kxXQD20sxTgmc1biQGkW3PwKllf2v+c=
X-Google-Smtp-Source: ABdhPJxTiQMzoiYGEex5XXD0wJV+bhhN64++XEw5aVNva0X5uyl9EOR7KnxJJ3upQjU+czlhQmUz+w==
X-Received: by 2002:a1c:6a16:: with SMTP id f22mr11407539wmc.86.1606058860032;
        Sun, 22 Nov 2020 07:27:40 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:b0e1:b041:18e2:46cf])
        by smtp.gmail.com with ESMTPSA id k1sm13712265wrp.23.2020.11.22.07.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 07:27:39 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 7/7] not: simplify ((x cmp y) {&,|,^} (x !cmp y)) --> {0,1,1}
Date:   Sun, 22 Nov 2020 16:27:31 +0100
Message-Id: <20201122152731.10994-8-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201122152731.10994-1-luc.vanoostenryck@gmail.com>
References: <20201122152731.10994-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Simplify bitwise operations on a compare and its complement
into 0 (for &) or 1 for (| and ^).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                   | 24 +++++++++++++++++++++---
 validation/optim/cse-not02.c |  1 -
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/simplify.c b/simplify.c
index b41c155735d1..9938a5974744 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1632,7 +1632,7 @@ static int simplify_compare(struct instruction *insn)
 
 static int simplify_and_one_side(struct instruction *insn, pseudo_t *p1, pseudo_t *p2)
 {
-	struct instruction *def;
+	struct instruction *def, *defr = NULL;
 	pseudo_t src1 = *p1;
 
 	switch (DEF_OPCODE(def, src1)) {
@@ -1640,6 +1640,12 @@ static int simplify_and_one_side(struct instruction *insn, pseudo_t *p1, pseudo_
 		if (def->src == *p2)
 			return replace_with_value(insn, 0);
 		break;
+	case OP_BINCMP ... OP_BINCMP_END:
+		if (DEF_OPCODE(defr, *p2) == opcode_negate(def->opcode)) {
+			if (def->src1 == defr->src1 && def->src2 == defr->src2)
+				return replace_with_value(insn, 0);
+		}
+		break;
 	}
 	return 0;
 }
@@ -1652,7 +1658,7 @@ static int simplify_and(struct instruction *insn)
 
 static int simplify_ior_one_side(struct instruction *insn, pseudo_t *p1, pseudo_t *p2)
 {
-	struct instruction *def;
+	struct instruction *def, *defr = NULL;
 	pseudo_t src1 = *p1;
 
 	switch (DEF_OPCODE(def, src1)) {
@@ -1660,6 +1666,12 @@ static int simplify_ior_one_side(struct instruction *insn, pseudo_t *p1, pseudo_
 		if (def->src == *p2)
 			return replace_with_value(insn, bits_mask(insn->size));
 		break;
+	case OP_BINCMP ... OP_BINCMP_END:
+		if (DEF_OPCODE(defr, *p2) == opcode_negate(def->opcode)) {
+			if (def->src1 == defr->src1 && def->src2 == defr->src2)
+				return replace_with_value(insn, 1);
+		}
+		break;
 	}
 	return 0;
 }
@@ -1672,7 +1684,7 @@ static int simplify_ior(struct instruction *insn)
 
 static int simplify_xor_one_side(struct instruction *insn, pseudo_t *p1, pseudo_t *p2)
 {
-	struct instruction *def;
+	struct instruction *def, *defr = NULL;
 	pseudo_t src1 = *p1;
 
 	switch (DEF_OPCODE(def, src1)) {
@@ -1680,6 +1692,12 @@ static int simplify_xor_one_side(struct instruction *insn, pseudo_t *p1, pseudo_
 		if (def->src == *p2)
 			return replace_with_value(insn, bits_mask(insn->size));
 		break;
+	case OP_BINCMP ... OP_BINCMP_END:
+		if (DEF_OPCODE(defr, *p2) == opcode_negate(def->opcode)) {
+			if (def->src1 == defr->src1 && def->src2 == defr->src2)
+				return replace_with_value(insn, 1);
+		}
+		break;
 	}
 	return 0;
 }
diff --git a/validation/optim/cse-not02.c b/validation/optim/cse-not02.c
index aa54a375a9ea..70addebcfbb6 100644
--- a/validation/optim/cse-not02.c
+++ b/validation/optim/cse-not02.c
@@ -5,7 +5,6 @@ int xor(int a, int b) { return ((a == b) ^ (a != b)) == 1; }
 /*
  * check-name: cse-not02
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.29.2

