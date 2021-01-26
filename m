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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF95CC433E0
	for <linux-sparse@archiver.kernel.org>; Wed, 27 Jan 2021 03:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D481206B5
	for <linux-sparse@archiver.kernel.org>; Wed, 27 Jan 2021 03:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237064AbhA0Dpp (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbhAZWFZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 26 Jan 2021 17:05:25 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B78C06178B
        for <linux-sparse@vger.kernel.org>; Tue, 26 Jan 2021 14:04:43 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m187so3729300wme.2
        for <linux-sparse@vger.kernel.org>; Tue, 26 Jan 2021 14:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xn/y5fWz+bSTA74YnAs3vllw5bYBv1J7ij1cyNTfF3k=;
        b=rsFzlo0ZjmFRuSkVlhmA8i5uyKn1K8gz4j8o2+RLpJb/UWjoAsd8DxcGgoBmV//64O
         pyioA45qE29PNGSjQngqUMEKfR+4uyefbyqYiCMa+eT5Gt5wCbMKiF0pSm/+MJ7XJWvj
         RawF54xrdWl0oa621LJD1IuErN2Ge16jS3XWZQGBW3MJL3X2sV48soXw1MA/dEY32+QD
         Jn/OKlqJ1GKY8vm5yG/qgATzaT2pXT6WYAbsz3YZMGAjvIK/0RFpqa2AxzleXvXSH8dC
         1m0KhrdM/0CeC+lgsbGF/JKtED8u6ICnvFUHHZqmdsR9DXkSkPk9Zm5jMK9VbwkuZFxm
         89uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xn/y5fWz+bSTA74YnAs3vllw5bYBv1J7ij1cyNTfF3k=;
        b=C72boDjHkqB5NMVOrcUQdiIQ8xJLIQ/iZYCHLlsqGFEHj1RpbDK4Nbu9oN+bBZtUA6
         1AywxnQB37Ru3MgrLUKYx9iE/HY40O0Qq8XoOFUZYXfBLe0VeOJCaTtPP+m0vA2l2sxe
         ijUqJc9hlbkngEQG+ZznLV8YdKfX8HS0zOXmSa2zTQVMwGxUtcrfrFQ5ZYlf6iB7VZ3u
         GFdISY4HK7/x4zrhvADA2ncbEjp99tR3FWs9uAnIyQkMCU+dm07iKvGT2hotFtzCjyre
         ely4dv4GLWvdbsNVFZ3YxiBiFZrt7wX9FKGzlXZsO+Gms96h+ffXXsfI3CEwN1Qu2NXd
         QesQ==
X-Gm-Message-State: AOAM532wzNN6YP8rqwNUJK/5kmU7F0+ekiKjpfLG4cOdayqh04jn80qj
        dU0ufnM0WkkrUpLKZV50oABtTp77SYo=
X-Google-Smtp-Source: ABdhPJwuc1huwZRCgUw5lrcHpNo8D6Q0LXE0P7G44kjBtSb9MV/czs6z3Zf5prb01lpHwCFf37sATA==
X-Received: by 2002:a7b:cd8e:: with SMTP id y14mr1485794wmj.61.1611698681991;
        Tue, 26 Jan 2021 14:04:41 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:285a:40db:3257:f0fd])
        by smtp.gmail.com with ESMTPSA id b132sm5268447wmh.21.2021.01.26.14.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 14:04:41 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 05/10] cmps: simplify signed compares with SMIN or SMAX
Date:   Tue, 26 Jan 2021 23:04:27 +0100
Message-Id: <20210126220432.58265-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126220432.58265-1-luc.vanoostenryck@gmail.com>
References: <20210126220432.58265-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Simplify away signed compares with SMIN or SMAX which can be
statically be determined to be always true or always false.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                     | 17 +++++++++++++++++
 validation/optim/cmps-minmax.c |  1 -
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index a306828c1c4b..096742d51a16 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1170,6 +1170,23 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 	int changed = 0;
 
 	switch (insn->opcode) {
+	case OP_SET_LT:
+		if (value == sign_bit(size))	// (x <  SMIN) --> 0
+			return replace_with_pseudo(insn, value_pseudo(0));
+		break;
+	case OP_SET_LE:
+		if (value == sign_mask(size))	// (x <= SMAX) --> 1
+			return replace_with_pseudo(insn, value_pseudo(1));
+		break;
+	case OP_SET_GE:
+		if (value == sign_bit(size))	// (x >= SMIN) --> 1
+			return replace_with_pseudo(insn, value_pseudo(1));
+		break;
+	case OP_SET_GT:
+		if (value == sign_mask(size))	// (x >  SMAX) --> 0
+			return replace_with_pseudo(insn, value_pseudo(0));
+		break;
+
 	case OP_SET_B:
 		if (!value)			// (x < 0) --> 0
 			return replace_with_pseudo(insn, value_pseudo(0));
diff --git a/validation/optim/cmps-minmax.c b/validation/optim/cmps-minmax.c
index ded3286cf752..5802cdbcafd1 100644
--- a/validation/optim/cmps-minmax.c
+++ b/validation/optim/cmps-minmax.c
@@ -10,7 +10,6 @@ int gt_smax(int a) { return (a >  SMAX) == 0; }
 /*
  * check-name: cmps-minmax
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.30.0

