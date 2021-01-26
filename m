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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC48C433DB
	for <linux-sparse@archiver.kernel.org>; Wed, 27 Jan 2021 03:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2548206B5
	for <linux-sparse@archiver.kernel.org>; Wed, 27 Jan 2021 03:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbhA0DqB (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728170AbhAZWF0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 26 Jan 2021 17:05:26 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51709C061794
        for <linux-sparse@vger.kernel.org>; Tue, 26 Jan 2021 14:04:46 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d16so17426742wro.11
        for <linux-sparse@vger.kernel.org>; Tue, 26 Jan 2021 14:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kgm7kxF29Ax0Vo6bQpRB0+xryXYstzCCJl7s01b9uBM=;
        b=UtBavKqqWrhcWOl80vDMmhHzFAJ/4+i0+qnox2WivFJ9yZLIZKEmI1WJqwRkE5pGfi
         4N6rVQdaz3f6+7piTa20Hk7WZ7xm8F0lqvifmCHqrqmN+BmKdZeti5qgqhY7v9sF4uNJ
         rsd7hceSYezCOWLezL3x6EmBiJNi189L1eiLajPDu6nd5DYOwqKqBB95l+IPIF7o1U7x
         NI4xVG2ryU53f1cjl6x6rXpXYp5V5ONJrWb1StPmgBZjz3mPbaS/BWL8ZdC7b46T44q4
         RC02zs9gY2rvqcaguVfGtp5fuIl5PaH/O/AuKUxcqMP9GvqHUa4czlucFdvfzh/RmGRY
         sMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kgm7kxF29Ax0Vo6bQpRB0+xryXYstzCCJl7s01b9uBM=;
        b=h42IH9wXKRimh6+WMPhwIXFP/xxvkxIBdhcGdRZNRklpUFop1pjqRDuFKP50Op5a7G
         7mcLmJmJMsRpXT3hx+oSe0ekurkX1bvOfz3B6D2RulZpIPLvY3LcYBGlIMZL3NPnqD20
         qn93A5snAqBSksqgqQBbcvC7+x7JOZlzBhBA0qc6qgqnugMRoeXI4HRKYcHbddenBKvb
         XneBtxVJxaHq+Qfk8N0pVPYohuc+JNDASnyXoumNqR5ks8wqat2OkOQx072VKzXVW+tQ
         +1++2xrB+LHWCwf4QSjZSHSJra7m8n2ck/Nrpf4QZ+PWw3ogw8rdps6m6X75g8J/xM/4
         wXNg==
X-Gm-Message-State: AOAM533AADLjRULzqvdie9Zfs7v8nkfEpIutMdxjEi1f/3gd43KZS8m/
        PAgyP8ugJVjhMirvtGKy1yV604gnNco=
X-Google-Smtp-Source: ABdhPJxKT1nSKm3zR4eJ6MkQSTCytIkELUIPzSbtWfmKbhh6SrvYegOlTVRc95K4X7pC6txOrf851w==
X-Received: by 2002:a5d:453b:: with SMTP id j27mr8305833wra.92.1611698685163;
        Tue, 26 Jan 2021 14:04:45 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:285a:40db:3257:f0fd])
        by smtp.gmail.com with ESMTPSA id b132sm5268447wmh.21.2021.01.26.14.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 14:04:44 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 08/10] cmps: canonicalize signed compares with constant
Date:   Tue, 26 Jan 2021 23:04:30 +0100
Message-Id: <20210126220432.58265-9-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126220432.58265-1-luc.vanoostenryck@gmail.com>
References: <20210126220432.58265-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Modify the constants to canonicalize (x < C) to (x <= (C-1)) and
(x <= C) to (x > (C-1)). This choice is partially arbitrary but
1) it's the one with the smallest positive constants,
2) it eliminates all OP_SET_LT & OP_SET_GE with a constant.
A disadvantage of this choice is that we lost some compares with 0:
(x < 0) is now canonicalized into (x <= -1).

Note: Another good choice would be to canonicalize using the
      smallest absolute constants. This would keep compares with 0
      but would also keep the 4 kinds of comparison.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                        | 2 ++
 validation/optim/canonical-cmps.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index ad3adb11595e..b29f5d5b2444 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1177,6 +1177,7 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 			return replace_opcode(insn, OP_SET_NE);
 		if (value == sign_bit(size) + 1)// (x < SMIN + 1) --> (x == SMIN)
 			return replace_binop_value(insn, OP_SET_EQ, sign_bit(size));
+		changed |= replace_binop_value(insn, OP_SET_LE, (value - 1) & bits);
 		break;
 	case OP_SET_LE:
 		if (value == sign_mask(size))	// (x <= SMAX) --> 1
@@ -1193,6 +1194,7 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 			return replace_opcode(insn, OP_SET_EQ);
 		if (value == sign_bit(size) + 1)// (x >= SMIN + 1) --> (x != SMIN)
 			return replace_binop_value(insn, OP_SET_NE, sign_bit(size));
+		changed |= replace_binop_value(insn, OP_SET_GT, (value - 1) & bits);
 		break;
 	case OP_SET_GT:
 		if (value == sign_mask(size))	// (x >  SMAX) --> 0
diff --git a/validation/optim/canonical-cmps.c b/validation/optim/canonical-cmps.c
index f42664b21e04..42801cdce520 100644
--- a/validation/optim/canonical-cmps.c
+++ b/validation/optim/canonical-cmps.c
@@ -10,7 +10,6 @@ _Bool ge_x(int a) { return (a >= 1234) == (a > 1233); }
 /*
  * check-name: canonical-cmps
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.30.0

