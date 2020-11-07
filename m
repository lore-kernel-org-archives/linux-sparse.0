Return-Path: <SRS0=cH/F=EN=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E586BC4742C
	for <linux-sparse@archiver.kernel.org>; Sat,  7 Nov 2020 11:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD2BC208E4
	for <linux-sparse@archiver.kernel.org>; Sat,  7 Nov 2020 11:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FC8XVfNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgKGLma (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 7 Nov 2020 06:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgKGLma (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 7 Nov 2020 06:42:30 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9C2C0613CF
        for <linux-sparse@vger.kernel.org>; Sat,  7 Nov 2020 03:42:29 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id o21so5622205ejb.3
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 03:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ia6EHJiRvbRmHIQIXHNxt3XLKRmMrIk/BFzIUDwA6C4=;
        b=FC8XVfNFZzSR6ByNSKICklXogmrJxzd0a/p3m8A7bR3uI6ITtzBCFDexEa/0GYnWie
         LUZnRbf2aNoN3lVU7D10fQex/BQ3tMihzqXSJS7fhH8J1QYyiC9X8lRDg8JopMa5TNmI
         3HErbSfgRNrIRByWAfhlS++DBgehorhiC4CaamI931kYPfedA92E2VfvPVOLC6Ne4qM5
         8SuMdMv7m5/s3Q5daH9n+S2EDOV865BfF00EZRB+pEUdy2EiEH+DvydpprvWVzGYtkr3
         upCx4VW6wmyPcnNxA27P4w+ekgJvO54tCPb7Bu6KqSKWVNy5jufGmI7XS+IIL8WjI8Ic
         72RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ia6EHJiRvbRmHIQIXHNxt3XLKRmMrIk/BFzIUDwA6C4=;
        b=mNX1cLRo7VIvUbXS9o71ZYZorbpLSfwtCyFn+aN2wx7LsjDLns1PRC+RYQJbakfgps
         e5HoboGTG0JHdKk3VaC8hHI/VVstMh30JfNHNPgkLSL2vv8WGqv1ey/wZ0Rml3BPSokO
         Tw3a43ITUzKnLrEmucZUTitkSB4gpA2+HPa19ZUGT6mnyDlXpwy7Yqyt6VIhiXolkMb1
         dkDm2CfQ60ei8IFwzgNI0dFqXXT6l0LQtICWVkMRbaHRvOIim7lbkmscukSCc7kEoGT2
         gTkBzvND3A1NVtJIYm8kKrvijI19+cftBw1+ELrEOj1/depaxMCB2jg2l8zFo0do0paI
         StXA==
X-Gm-Message-State: AOAM530v/DL8+z1sf9FnVecPw9DA7t5ezN68h+y18z7S5Wx4xcWzU0k+
        hbQ4C2eVorn4gPZxUHeHa+uL0pZHu0A=
X-Google-Smtp-Source: ABdhPJyiDYi+HIIjp+5MEa5hKxBow7jN20w802pNTuQao2bGh+4+8OfjkMCex3CU8agQ5y2p6yy/QA==
X-Received: by 2002:a17:906:d931:: with SMTP id rn17mr6416092ejb.308.1604749348195;
        Sat, 07 Nov 2020 03:42:28 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:9030:856f:68be:7b84])
        by smtp.gmail.com with ESMTPSA id s21sm3308311edc.42.2020.11.07.03.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 03:42:27 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/5] select: simplify SEL(SEL(x, C, 0), y, z) --> SEL(x, y, z) and its dual
Date:   Sat,  7 Nov 2020 12:42:19 +0100
Message-Id: <20201107114222.11866-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201107114222.11866-1-luc.vanoostenryck@gmail.com>
References: <20201107114222.11866-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

If the condition of a select is also a select but with constant
operands, some simplification can be done:
* if the second operand is 0, the original condition can be used,
* idem if the first operand is 0s but the operand must be swapped.

Originally-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                                   | 20 ++++++++++++++++++++
 validation/optim/select-select-true-false0.c |  1 -
 validation/optim/select-select-true-false1.c |  1 -
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/simplify.c b/simplify.c
index f2aaa52de84b..6b44d447c0a9 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1748,6 +1748,7 @@ static int simplify_cast(struct instruction *insn)
 static int simplify_select(struct instruction *insn)
 {
 	pseudo_t cond, src1, src2;
+	struct instruction *def;
 
 	cond = insn->src1;
 	src1 = insn->src2;
@@ -1782,6 +1783,25 @@ static int simplify_select(struct instruction *insn)
 		kill_use(&insn->src3);
 		return replace_with_value(insn, 0);
 	}
+
+	switch (DEF_OPCODE(def, cond)) {
+	case OP_SEL:
+		if (constant(def->src2) && constant(def->src3)) {
+			// Is the def of the conditional another select?
+			// And if that one results in a "zero or not", use the
+			// original conditional instead.
+			//	SEL(SEL(x, C, 0), y, z) --> SEL(x, y, z)
+			//	SEL(SEL(x, 0, C), y, z) --> SEL(x, z, y)
+			if (!def->src3->value) {
+				return replace_pseudo(insn, &insn->cond, def->cond);
+			}
+			if (!def->src2->value) {
+				switch_pseudo(insn, &insn->src2, insn, &insn->src3);
+				return replace_pseudo(insn, &insn->cond, def->cond);
+			}
+		}
+		break;
+	}
 	return 0;
 }
 
diff --git a/validation/optim/select-select-true-false0.c b/validation/optim/select-select-true-false0.c
index 46bd7667400d..4066c2dad6fc 100644
--- a/validation/optim/select-select-true-false0.c
+++ b/validation/optim/select-select-true-false0.c
@@ -4,7 +4,6 @@ int bw(int p, int a, int b) { return ((p ? 0 : 42) ? a : b) == ( p ? b : a); }
 /*
  * check-name: select-select-true-false0
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
diff --git a/validation/optim/select-select-true-false1.c b/validation/optim/select-select-true-false1.c
index 00ffdcd1bc9b..32c0364de2ba 100644
--- a/validation/optim/select-select-true-false1.c
+++ b/validation/optim/select-select-true-false1.c
@@ -7,7 +7,6 @@ int foo(int p)
 /*
  * check-name: select-select-true-false1
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.29.2

