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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9275C43461
	for <linux-sparse@archiver.kernel.org>; Sun, 18 Apr 2021 15:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B288B610CB
	for <linux-sparse@archiver.kernel.org>; Sun, 18 Apr 2021 15:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbhDRPdT (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 18 Apr 2021 11:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbhDRPdQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 18 Apr 2021 11:33:16 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312D7C06174A
        for <linux-sparse@vger.kernel.org>; Sun, 18 Apr 2021 08:32:48 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id e14so49074673ejz.11
        for <linux-sparse@vger.kernel.org>; Sun, 18 Apr 2021 08:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HlUpvbNldbTvl7Ip9LFRTzGxZeFNlUyYCGeSWyyELMQ=;
        b=YWVl5rlKaElZ9r9QZEe1O8ziezkMqMPlqSMA4+rZKyoBB3qKSzhyg6meiXlZPO3iUc
         UzldeW0RqnbdqeFICNM6i9YRVLZwsxNhIaoyoedxy937ERxu0uhY6HSKL1Cr1UaPP7Fq
         bHoDtlO8cbu3LbagL5F2uKYJddbQRVew3iL7DjCl2CP28MWCqZUIoynk3vSbaIkfDrhf
         NkPIpjp2gIVIfQ6QYPuC5NkDuVb8j0KOKCy1NhhsuL4dtKOiowz7v60WwQcpfGhDSAon
         IwMZ6TCgbSDirHkBuCu6xwxbmGy9r8KvFSZq3Nz8X3OqVMziopq5kOTv5cKho2s6bj9N
         Wy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HlUpvbNldbTvl7Ip9LFRTzGxZeFNlUyYCGeSWyyELMQ=;
        b=Hwn5LdX9N/NDRbUToqBAKy4vYWz0eZLbAQXYwZNj23DXUKDoJmp8lu/lD1UmW4CtRV
         UATsp/9Ve+JiAVefEU4khQDn1ma17xyEi8Dt1YV0yTOeVJemzXOIotIdin/LexCulOAe
         o1NzIXEpS7r52/Is6LM16h+fA9KwneHojdWfoZ/MHPz889S0GSerWU1mANjLsx1XLhhE
         haoZK5VDEYRfsh0OrHGlZTRZblC8uACK5XXVJ3/Jev5PW5a/3oqrupSXQVb7J9LGgEtB
         GqgBTpFm5gENKn6s0EyZTVHw2Xtqp9VwIFC9LytN0/+/CILTITtK1tX4+Z/yoZrUBaDN
         Vdvg==
X-Gm-Message-State: AOAM531OZxJFjqFpgoXg0YxWknufQH+R0FM5yT3GXHkp2qmAPKRD2tb2
        BdPcD6nU5WLsTHjPwcQzCTan+CG67c0=
X-Google-Smtp-Source: ABdhPJyoDI7MvFh28UruUXkawW7QjWgaomKXBDOrjDCbCZt4v0Ftvmj8DdGB7UmgDMldtXjXB3UHiQ==
X-Received: by 2002:a17:906:1313:: with SMTP id w19mr17773606ejb.64.1618759966999;
        Sun, 18 Apr 2021 08:32:46 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:959c:c85:d486:38cf])
        by smtp.gmail.com with ESMTPSA id k9sm8632888eje.102.2021.04.18.08.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 08:32:46 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [SPARSE 4/4] simplify AND(x >= 0, x < C) --> (unsigned)x < C
Date:   Sun, 18 Apr 2021 17:32:33 +0200
Message-Id: <20210418153233.45234-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210418153233.45234-1-luc.vanoostenryck@gmail.com>
References: <20210418153233.45234-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Such compares with a signed value are relatively common and can be
easily be simplified into a single unsigned compare. So, do it.

Note: This simplification triggers only 27 times in a x86-64 defconfig
      kernel. I expected more but I suppose it's because most checks
      aren't done against a constant or are done with unsigned values.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                      | 11 +++++++++++
 validation/optim/range-check1.c |  1 -
 validation/optim/range-check2.c |  1 -
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/simplify.c b/simplify.c
index e0e4f9ebcba9..0a29db189b55 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1920,6 +1920,17 @@ static int simplify_and_one_side(struct instruction *insn, pseudo_t *p1, pseudo_
 			if (def->src1 == defr->src1 && def->src2 == defr->src2)
 				return replace_with_value(insn, 0);
 		}
+		if (def->opcode == OP_SET_GE && is_zero(def->src2)) {
+			switch (DEF_OPCODE(defr, *p2)) {
+			case OP_SET_LE:
+				if (!is_positive(defr->src2, defr->itype->bit_size))
+					break;
+				// (x >= 0) && (x <= C) --> (x u<= C)
+				insn->itype = defr->itype;
+				replace_binop(insn, OP_SET_BE, &insn->src1, defr->src1, &insn->src2, defr->src2);
+				return REPEAT_CSE;
+			}
+		}
 		break;
 	case OP_OR:
 		if (DEF_OPCODE(defr, *p2) == OP_OR) {
diff --git a/validation/optim/range-check1.c b/validation/optim/range-check1.c
index 82b939917da4..358da045c456 100644
--- a/validation/optim/range-check1.c
+++ b/validation/optim/range-check1.c
@@ -8,7 +8,6 @@ _Bool check_ok(long i)
 /*
  * check-name: range-check1
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-contains: setbe\\..*0x3ff
diff --git a/validation/optim/range-check2.c b/validation/optim/range-check2.c
index f565b84ea9db..69c01b9d36d5 100644
--- a/validation/optim/range-check2.c
+++ b/validation/optim/range-check2.c
@@ -8,7 +8,6 @@ _Bool check_ok(int i)
 /*
  * check-name: range-check2
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.31.1

