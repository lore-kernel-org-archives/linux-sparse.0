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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0ABC433DB
	for <linux-sparse@archiver.kernel.org>; Wed, 27 Jan 2021 03:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BABE4206B9
	for <linux-sparse@archiver.kernel.org>; Wed, 27 Jan 2021 03:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237068AbhA0Dpx (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbhAZWFZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 26 Jan 2021 17:05:25 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4DEC061793
        for <linux-sparse@vger.kernel.org>; Tue, 26 Jan 2021 14:04:45 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id u14so3724974wml.4
        for <linux-sparse@vger.kernel.org>; Tue, 26 Jan 2021 14:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UiDtC0rGEvDBNd5KuO4qSXEFzNoVybxHjeCANkLQb90=;
        b=GkgJ/gyJ/Eyxyq/clbj/M4nyNgImYOo+0AXcoeIU6dkKkPaswpxji+ipOrvYe1gJEq
         EZR5DhnVqaNX8CeJh/V8g46VrNt2On0+nEPVl61hj7YI9MfO7fZU/YUjl8xgkZr5c7wM
         PccpkzW45hE671dMO2rv8Txeh/sDxYWfZvAeJk4k8ezd8Hy9I4Xgo1T1hWFB2VmFuWvV
         Jfm64H4mItkpk3vmHkFcInygj4kzntJKJ3IoH1tDdJ3THCT9glFtY83uCA8qg8bli2sq
         IkIpPKUJJSZuAMg3GvwEKhIqeLOWzmcPbI7LwJ6mzi/jbYy1XB9lQDJFHUfKCRlUIWmS
         MKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UiDtC0rGEvDBNd5KuO4qSXEFzNoVybxHjeCANkLQb90=;
        b=an8z0Ex1/uP+2hElPnk6286CGS91UFuVKnNA7RE85uovuwMMWyw5xnumpUiErKULba
         1Bop1fPVJZE/FTVp07sdwB9TSeFlj42fuXqJDp7blR35mMhOZtUWyIZizW1z67naJ9Kx
         hr9cS9a0ObA3vWG/j8vaO5CjOY7Skaf55xhRiDxxKGkuq0dx+hGHaJ6EfH12il0qzL3N
         8njMFbJw7KC1mjuUB+wYqEPcb8ecxdP5j7KdBKGrOz7Te20e2O+BJhE4b5szSA6sTqYC
         34iDTyfOmbCFThwaxiz2VCo8GG+rNKmqwSnlDVz1Yuwk4MDeasE7uwrtIadJOgAF/FR7
         la8w==
X-Gm-Message-State: AOAM532ZfFcm7opmzNo4YgQGkfjupSY8+3jpkhaCGYdIxTWqWdw83363
        Q5S/Tq81VFq/d9mbvk29oa0Ad6P1DQY=
X-Google-Smtp-Source: ABdhPJz6Ib3KNYP1e6lRZecpn8pPCVRTkAUnSpA20rKncYd3AXULfMxRptb486O+mzgulU5MB256Fg==
X-Received: by 2002:a1c:4984:: with SMTP id w126mr1402302wma.139.1611698684274;
        Tue, 26 Jan 2021 14:04:44 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:285a:40db:3257:f0fd])
        by smtp.gmail.com with ESMTPSA id b132sm5268447wmh.21.2021.01.26.14.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 14:04:43 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 07/10] cmps: canonicalize SMIN/SMAX +- 1 --> EQ/NE
Date:   Tue, 26 Jan 2021 23:04:29 +0100
Message-Id: <20210126220432.58265-8-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126220432.58265-1-luc.vanoostenryck@gmail.com>
References: <20210126220432.58265-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Compares with SMIN  + 1 or SMAX - 1 are equivalent to an equality
testing. For example, (x < SMIN + 1) is the same as (x == SMIN).

Canonicalize these to the equality testing since these are usually
simpler to handle.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                               | 8 ++++++++
 validation/optim/canonical-cmpe-minmax.c | 1 -
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index f7c6c68d4ce9..ad3adb11595e 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1175,24 +1175,32 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 			return replace_with_pseudo(insn, value_pseudo(0));
 		if (value == sign_mask(size))	// (x <  SMAX) --> (x != SMAX)
 			return replace_opcode(insn, OP_SET_NE);
+		if (value == sign_bit(size) + 1)// (x < SMIN + 1) --> (x == SMIN)
+			return replace_binop_value(insn, OP_SET_EQ, sign_bit(size));
 		break;
 	case OP_SET_LE:
 		if (value == sign_mask(size))	// (x <= SMAX) --> 1
 			return replace_with_pseudo(insn, value_pseudo(1));
 		if (value == sign_bit(size))	// (x <= SMIN) --> (x == SMIN)
 			return replace_opcode(insn, OP_SET_EQ);
+		if (value == sign_mask(size) - 1) // (x <= SMAX - 1) --> (x != SMAX)
+			return replace_binop_value(insn, OP_SET_NE, sign_mask(size));
 		break;
 	case OP_SET_GE:
 		if (value == sign_bit(size))	// (x >= SMIN) --> 1
 			return replace_with_pseudo(insn, value_pseudo(1));
 		if (value == sign_mask(size))	// (x >= SMAX) --> (x == SMAX)
 			return replace_opcode(insn, OP_SET_EQ);
+		if (value == sign_bit(size) + 1)// (x >= SMIN + 1) --> (x != SMIN)
+			return replace_binop_value(insn, OP_SET_NE, sign_bit(size));
 		break;
 	case OP_SET_GT:
 		if (value == sign_mask(size))	// (x >  SMAX) --> 0
 			return replace_with_pseudo(insn, value_pseudo(0));
 		if (value == sign_bit(size))	// (x >  SMIN) --> (x != SMIN)
 			return replace_opcode(insn, OP_SET_NE);
+		if (value == sign_mask(size) - 1) // (x > SMAX - 1) --> (x == SMAX)
+			return replace_binop_value(insn, OP_SET_EQ, sign_mask(size));
 		break;
 
 	case OP_SET_B:
diff --git a/validation/optim/canonical-cmpe-minmax.c b/validation/optim/canonical-cmpe-minmax.c
index c72819244b95..32b272435fa2 100644
--- a/validation/optim/canonical-cmpe-minmax.c
+++ b/validation/optim/canonical-cmpe-minmax.c
@@ -10,7 +10,6 @@ int ge_smin(int a) { return (a >= (SMIN + 1)) == (a != SMIN); }
 /*
  * check-name: canonical-cmpe-minmax
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.30.0

