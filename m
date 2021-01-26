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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2847C433E0
	for <linux-sparse@archiver.kernel.org>; Wed, 27 Jan 2021 03:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E33E206B5
	for <linux-sparse@archiver.kernel.org>; Wed, 27 Jan 2021 03:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237047AbhA0Dpf (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbhAZWFZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 26 Jan 2021 17:05:25 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D2FC06178C
        for <linux-sparse@vger.kernel.org>; Tue, 26 Jan 2021 14:04:44 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id m187so3729332wme.2
        for <linux-sparse@vger.kernel.org>; Tue, 26 Jan 2021 14:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pTaH/oxw1TlzjdASrYk0d5gVWNTFa1swlm5naHKiok0=;
        b=l6v7Yi6eK/YvUSCaEFuZ4N87uyxAAoHKmu79v4eV3aI9Sih3TSnB54MMs8Yvc0c2EV
         t9jw4bzrsGDjFDmBQtG8Uy7zoi03cBgUOovEyPrMr4kMZvmFkLvqIeP5GO9IZggRl0MT
         u7oZz87ZD+D8v3zHOcex/s+anU8CCqjr9+s1+OIaOhJSUIsUdnAdjGjRfmDQDjJ3phkd
         lx+/VV3mRg8jSTxcDuVcsAeYgl51r/SQZl2HH/jZvrI+R11xzhGIz5G3gNoTFIwUUITQ
         Yg6LEC2HO6m0drKcefPj3kHgBw92QngmerK+CidYqumIreGszQ69OT5p9eODubs5VKn6
         dITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pTaH/oxw1TlzjdASrYk0d5gVWNTFa1swlm5naHKiok0=;
        b=A42tuHV0vevGTw/rckeT9cGSBzCEmvpZnl2hnCyRCOmX+M++DnJLMTTysX8UwkR3NG
         grMb2VuGz6FkGg3uEF1IOVZj3ZqTyg1lG5pRUY5pxhWvCB56rmlmJwAyVco4H7tJ0C/I
         e70LDUZfDq8hukpvXFWig35c6GOSfLWmOcHR2zvIVZSr+HY9e8nL+RyJt/V19AUWAkNF
         /gjqaPecOAoR6S+JzErWmPSlfeijkZixBS4WlCb3x23+LG0gWv+pZuuC8rI74FcFNUYu
         RHfaxcNTML0dVRwZ+GN0kKJEWPhd/ld/wxU7dgwDAHsXruQeI3KhRXfZ5FQwiCKAHdUO
         K+kg==
X-Gm-Message-State: AOAM53190vnwQEMNFqhkXZuKiym+w7GovqaiXKGYMMUwt+XpFBKfIeC7
        wQceiB+XU553HbpDdNMgD9mn2VOHNNs=
X-Google-Smtp-Source: ABdhPJymB1gjiBPDnwkQLNvGf5aQnkGec7yvY8vlpN3GKyk/9FglPZV0c9CPjkd4urqk9TNL20IRAg==
X-Received: by 2002:a1c:e346:: with SMTP id a67mr1494467wmh.142.1611698683145;
        Tue, 26 Jan 2021 14:04:43 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:285a:40db:3257:f0fd])
        by smtp.gmail.com with ESMTPSA id b132sm5268447wmh.21.2021.01.26.14.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 14:04:42 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 06/10] cmps: canonicalize signed compares with SMIN/SMAX
Date:   Tue, 26 Jan 2021 23:04:28 +0100
Message-Id: <20210126220432.58265-7-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126220432.58265-1-luc.vanoostenryck@gmail.com>
References: <20210126220432.58265-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The remaining compares with SMIN or SMAX are equivalent to an
equality testing. For example, (x < SMAX) is the same as (x != SMAX).

Canonicalize these to the equality testing since these are usually
simpler to handle.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                               | 8 ++++++++
 validation/optim/canonical-cmps-minmax.c | 1 -
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index 096742d51a16..f7c6c68d4ce9 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1173,18 +1173,26 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 	case OP_SET_LT:
 		if (value == sign_bit(size))	// (x <  SMIN) --> 0
 			return replace_with_pseudo(insn, value_pseudo(0));
+		if (value == sign_mask(size))	// (x <  SMAX) --> (x != SMAX)
+			return replace_opcode(insn, OP_SET_NE);
 		break;
 	case OP_SET_LE:
 		if (value == sign_mask(size))	// (x <= SMAX) --> 1
 			return replace_with_pseudo(insn, value_pseudo(1));
+		if (value == sign_bit(size))	// (x <= SMIN) --> (x == SMIN)
+			return replace_opcode(insn, OP_SET_EQ);
 		break;
 	case OP_SET_GE:
 		if (value == sign_bit(size))	// (x >= SMIN) --> 1
 			return replace_with_pseudo(insn, value_pseudo(1));
+		if (value == sign_mask(size))	// (x >= SMAX) --> (x == SMAX)
+			return replace_opcode(insn, OP_SET_EQ);
 		break;
 	case OP_SET_GT:
 		if (value == sign_mask(size))	// (x >  SMAX) --> 0
 			return replace_with_pseudo(insn, value_pseudo(0));
+		if (value == sign_bit(size))	// (x >  SMIN) --> (x != SMIN)
+			return replace_opcode(insn, OP_SET_NE);
 		break;
 
 	case OP_SET_B:
diff --git a/validation/optim/canonical-cmps-minmax.c b/validation/optim/canonical-cmps-minmax.c
index bab09282d241..48927f49db6e 100644
--- a/validation/optim/canonical-cmps-minmax.c
+++ b/validation/optim/canonical-cmps-minmax.c
@@ -10,7 +10,6 @@ int gt_smin(int a) { return (a >  SMIN) == (a != SMIN); }
 /*
  * check-name: canonical-cmps-minmax
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.30.0

