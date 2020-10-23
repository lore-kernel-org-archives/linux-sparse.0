Return-Path: <SRS0=Zl/b=D6=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25C3C4363A
	for <linux-sparse@archiver.kernel.org>; Fri, 23 Oct 2020 16:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90BA222210
	for <linux-sparse@archiver.kernel.org>; Fri, 23 Oct 2020 16:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0IqSFj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752532AbgJWQjx (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 23 Oct 2020 12:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751741AbgJWQjx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 23 Oct 2020 12:39:53 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D2BC0613D2
        for <linux-sparse@vger.kernel.org>; Fri, 23 Oct 2020 09:39:52 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dt13so3217176ejb.12
        for <linux-sparse@vger.kernel.org>; Fri, 23 Oct 2020 09:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JWwMoal34CnynR8yPIUGvMD38hg7zrZ1G+HjoHP1HPA=;
        b=m0IqSFj1nNtXKrk6t5C1gRFwd/x4ZLFmEq0Ohqf3GUqWzUul2LQJtLbauve26XQtJy
         gtL3CUtRZPF1HErXFLac02IEE895CM3r13MlRe4JmD3tQsCpVfaPqskJYRfH2nIAl4Bn
         g3V8WlLXj6qSe7C6QNDKvqoC6OvzbRAvLdHwkPU+H4ZmMVXf0Md52up7QANgOiUsQiJX
         2Vw41un7YNUe48iLx878Iv/d5ts1f4B9GELKoI5TFKZjIJ6RFFr000pcsUnRuMDOsIJ0
         7w8QsiFFKu77Dff5sXd6tUSwvIptnmh5y9qluw80ioVAyj/tE2j2IiIK+RFoN/awWwir
         Qo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JWwMoal34CnynR8yPIUGvMD38hg7zrZ1G+HjoHP1HPA=;
        b=AUL+uWFVgzkh0GdyuvVplLVGxHj++64XDoSeEN2TBIIThVOXXmbtT+kbAqlc1jfDUA
         +D4fes/e41G4gUnDsjAnoijMneNmv8jbZFmADvP1evqWpY6fr6zPQoWMwiSgKRC2pR/6
         9GyNuoNbbLvEI9tQ1aS0kBDY+lKLfedl1+QeSSS6v+tWHTLJKyhdLgSXz3OfkqULILr2
         0ooHmH9TqE86A4eh8ZthjiFNyGvtfrGtGK0TZGyB41gz8M0wPYXR8vsaPQhT4vsl57lk
         38e6SAwboitgB4sAuA1XLRcZcHsRIQsorXyHY9ieIuGWSuDILVBitBhINbrNtOGts38i
         Ch4Q==
X-Gm-Message-State: AOAM533CGJzPPU8HF3Eh/xSwo8vGKc8hNaevlbSFV9ZB85BsuzvCGW6N
        GiHEXHJCZWiRuwXAZ4K3F/XPogeOtyI=
X-Google-Smtp-Source: ABdhPJx4DG3+aAyr3h6kDCES+87ef+H6ICtMd8tE2H39lU5dtY8Qcb6HewnFCS0M38oZIMwxP8aSgg==
X-Received: by 2002:a17:907:20d6:: with SMTP id qq22mr2743678ejb.187.1603471191274;
        Fri, 23 Oct 2020 09:39:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c9b0:42da:8135:1fa1])
        by smtp.gmail.com with ESMTPSA id m25sm1020734edp.36.2020.10.23.09.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:39:50 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 9/9] unop: simplify ~(-x) --> x - 1
Date:   Fri, 23 Oct 2020 18:39:39 +0200
Message-Id: <20201023163939.58359-10-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023163939.58359-1-luc.vanoostenryck@gmail.com>
References: <20201023163939.58359-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                          | 4 ++++
 validation/optim/simplify-not-neg.c | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index 1b6e1cc2313b..6588f8af2820 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1470,6 +1470,10 @@ static int simplify_unop(struct instruction *insn)
 			src = eval_unop(OP_NOT, insn->size, def->src2);
 			use_pseudo(insn, def->src1, &insn->src2);
 			return replace_pseudo(insn, &insn->src1, src);
+		case OP_NEG:
+			insn->opcode = OP_SUB;	// ~(-x) --> x - 1
+			insn->src2 = value_pseudo(1);
+			return replace_pseudo(insn, &insn->src1, def->src);
 		case OP_NOT:		// ~(~x) --> x
 			return replace_with_pseudo(insn, def->src);
 		case OP_SUB:
diff --git a/validation/optim/simplify-not-neg.c b/validation/optim/simplify-not-neg.c
index b9675ea62049..3fd8400d7bd4 100644
--- a/validation/optim/simplify-not-neg.c
+++ b/validation/optim/simplify-not-neg.c
@@ -3,7 +3,6 @@ int foo(int x) { return ~(-x) == (x - 1); }
 /*
  * check-name: simplify-not-neg
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-contains: ret\\..*\\$1
-- 
2.28.0

