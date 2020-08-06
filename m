Return-Path: <SRS0=443P=BQ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3694C433E0
	for <linux-sparse@archiver.kernel.org>; Thu,  6 Aug 2020 19:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAF872177B
	for <linux-sparse@archiver.kernel.org>; Thu,  6 Aug 2020 19:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zt3B+GwP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgHFTaT (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgHFTaQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 6 Aug 2020 15:30:16 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EC6C061574
        for <linux-sparse@vger.kernel.org>; Thu,  6 Aug 2020 12:30:15 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id qc22so36764125ejb.4
        for <linux-sparse@vger.kernel.org>; Thu, 06 Aug 2020 12:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GUZCXYhBI7nSEt0QAVwDSenAQwrjEfDyuqtcIQc46tg=;
        b=Zt3B+GwPxpilChZbuRyUK54KbnCIl3l5m0qiOXx0KuzJ3/YRoVgBPbcdTbU7scf19z
         HrICWlmv+vWXmpKvv3waSE8G+TM5e35Ie5p41jXWP2no2C0BLdbtRWmS2SkHaI5Lb/NL
         Olrk/uRaqNWdCdPwo1KrPqFRqUR16pnkSO2l3b2vTgXKk4adRepvqwkN09RE5eY4dSwJ
         qEhjPgiUnkmj/s+1oJnOLgGEQR3vS/54wyTGUeI3YRNyEHE6ZyTNH6SVUWTqhNZvwcMF
         VySspu2s01WXBYwI6tmxeTFiolJZFCJA3Zia8vXAmeMeciyt3R1J9lqd0C4wwpZMf59l
         QoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GUZCXYhBI7nSEt0QAVwDSenAQwrjEfDyuqtcIQc46tg=;
        b=EzEUoue8DzelVl+q+o8lMsYkqf/agsG9fjnyg3kRKP2RlB7KB61KLD3t8NOLixS9W6
         N2uOeACcvK2ow5f46X0LrhcHU2b77cc12uYWfK9Cpd9kd/UmOtIV2L4vHposlVNt1ECT
         lhHbVgJyXfte5kIn+LCef6XgsxanrFLi8Tg8PcQ00SgTrjJimUDrhVSo9hXQeALUs09K
         LlCyPwFV1jBsDpvHPELhmbjU57W9BqTMfUFYnalcwBJRBQW+dt5ptsJgeGGjHry3hNi3
         P2ie5CVJ1pSakWizaUDfwneSFUu5QJf/yHnjXcgZrt1L+qKQjD8ewGYjFLpVyk98Zi0P
         aMrg==
X-Gm-Message-State: AOAM5302uCK1NXw5yJlIvz4tKOocaZs38NJfBz9Fb4jrZqMDroz60oyM
        nzgMXeoaf1urWomn854yUcrdJTGa
X-Google-Smtp-Source: ABdhPJzntug+v3kwQfxIWKVChZJVvTxRPQFMBu7e4mWYjUQGMizSwl8cBS7MISJ+X0wDrs+fyNq1eA==
X-Received: by 2002:a17:906:aac6:: with SMTP id kt6mr5727730ejb.475.1596742213703;
        Thu, 06 Aug 2020 12:30:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:d567:ec52:e0a5:f485])
        by smtp.gmail.com with ESMTPSA id t19sm4055972edw.63.2020.08.06.12.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 12:30:13 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Stafford Horne <shorne@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/4] shift-assign: fix linearization of shift-assign
Date:   Thu,  6 Aug 2020 21:30:01 +0200
Message-Id: <20200806193003.10144-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200806193003.10144-1-luc.vanoostenryck@gmail.com>
References: <20200806193003.10144-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The result of a shift-assigns has the same type as the left
operand but the shift itself must be done on the promoted type.
The usual conversions are not done for shifts.

The problem is that this promoted type is not stored explicitly
in the data structure.  This is specific to shift-assigns because
for other operations, for example add-assign, the usual conversions
must be done and the resulting type can be found on the RHS.

Since at linearization, the LHS and the RHS must have the same type,
the solution is to cast the RHS to LHS's promoted type during
evaluation.

This solve a bunch of problems with shift-assigns, like doing
logical shift when an arithmetic shift was needed.

Fixes: efdefb100d086aaabf20d475c3d1a65cbceeb534
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                         |  6 +++++-
 validation/linear/bug-assign-op0.c |  1 -
 validation/linear/shift-assign1.c  |  1 -
 validation/shift-undef.c           | 16 ++++++++--------
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index dddea76182ad..6d8ecd7f6c25 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1342,8 +1342,12 @@ static int evaluate_assign_op(struct expression *expr)
 				return 1;
 		} else if (op == SPECIAL_SHR_ASSIGN || op == SPECIAL_SHL_ASSIGN) {
 			// shifts do integer promotions, but that's it.
+			unrestrict(expr->left, tclass, &t);
+			target = integer_promotion(t);
+
 			unrestrict(expr->right, sclass, &s);
-			target = integer_promotion(s);
+			source = integer_promotion(s);
+			expr->right = cast_to(expr->right, source);
 			goto Cast;
 		} else if (!(sclass & TYPE_RESTRICT))
 			goto usual;
diff --git a/validation/linear/bug-assign-op0.c b/validation/linear/bug-assign-op0.c
index 0cabc6222b8a..b351bb5149be 100644
--- a/validation/linear/bug-assign-op0.c
+++ b/validation/linear/bug-assign-op0.c
@@ -46,7 +46,6 @@ unsigned int sldivu(unsigned int u, long s)
 /*
  * check-name: bug-assign-op0
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-start
 asr:
diff --git a/validation/linear/shift-assign1.c b/validation/linear/shift-assign1.c
index 9b3137bb2d04..4c96fc283121 100644
--- a/validation/linear/shift-assign1.c
+++ b/validation/linear/shift-assign1.c
@@ -45,7 +45,6 @@ u64 u64u64(u64 a, u64 b) { a >>= b; return a; }
 /*
  * check-name: shift-assign1
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-start
 s16s16:
diff --git a/validation/shift-undef.c b/validation/shift-undef.c
index 4e94fa23d122..613c6b95b113 100644
--- a/validation/shift-undef.c
+++ b/validation/shift-undef.c
@@ -140,23 +140,23 @@ shift-undef.c:32:11: warning: shift too big (100) for type int
 shift-undef.c:33:11: warning: shift too big (101) for type unsigned int
 shift-undef.c:34:11: warning: shift too big (102) for type unsigned int
 shift-undef.c:35:11: warning: shift count is negative (-1)
-shift-undef.c:36:11: warning: shift count is negative (-2)
-shift-undef.c:37:11: warning: shift count is negative (-3)
+shift-undef.c:36:11: warning: shift too big (4294967294) for type unsigned int
+shift-undef.c:37:11: warning: shift too big (4294967293) for type unsigned int
 shift-undef.c:38:25: warning: shift too big (103) for type int
 shift-undef.c:39:25: warning: shift too big (104) for type unsigned int
 shift-undef.c:40:25: warning: shift too big (105) for type unsigned int
 shift-undef.c:41:25: warning: shift count is negative (-4)
-shift-undef.c:42:25: warning: shift count is negative (-5)
-shift-undef.c:43:25: warning: shift count is negative (-6)
+shift-undef.c:42:25: warning: shift too big (4294967291) for type unsigned int
+shift-undef.c:43:25: warning: shift too big (4294967290) for type unsigned int
 shift-undef.c:44:30: warning: shift too big (106) for type int
 shift-undef.c:45:30: warning: shift too big (107) for type unsigned int
 shift-undef.c:46:30: warning: shift too big (108) for type unsigned int
 shift-undef.c:47:30: warning: shift count is negative (-7)
-shift-undef.c:48:30: warning: shift count is negative (-8)
-shift-undef.c:49:30: warning: shift count is negative (-9)
+shift-undef.c:48:30: warning: shift too big (4294967288) for type unsigned int
+shift-undef.c:49:30: warning: shift too big (4294967287) for type unsigned int
 shift-undef.c:50:26: warning: shift too big (109) for type int
-shift-undef.c:51:26: warning: shift too big (110) for type int
-shift-undef.c:52:26: warning: shift too big (111) for type int
+shift-undef.c:51:26: warning: shift too big (110) for type unsigned int
+shift-undef.c:52:26: warning: shift too big (111) for type unsigned int
 shift-undef.c:53:26: warning: shift count is negative (-10)
 shift-undef.c:54:26: warning: shift count is negative (-11)
 shift-undef.c:55:26: warning: shift count is negative (-12)
-- 
2.28.0

