Return-Path: <SRS0=7JZe=EO=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6971C388F9
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 01:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6769E20885
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 01:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLoxAE6B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbgKHBTy (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 7 Nov 2020 20:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728279AbgKHBTy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 7 Nov 2020 20:19:54 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7282C0613CF
        for <linux-sparse@vger.kernel.org>; Sat,  7 Nov 2020 17:19:53 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id k3so7238718ejj.10
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 17:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xH1VUOFWIU3nomIe48C0/JIkSj0BwVm9wOVBaq6KPFU=;
        b=rLoxAE6BZkO5WiRXZ9yz/rxvfNZA8V+rHdeAgIcFQE8z5kHUhF3SWi5kGJsTM7cj02
         6Fw7MjRTkauUJftlPjN/SkSocc6mI5io28CS84ozGtFKukY4tWSoMTxvwlhEasbafr4G
         4mGAJQqWuYZxPf1b5ve3Ld/fOlG84Nn1fUtwBfr0ZgJC4AydI3bpyTR/v5URyvlbUTn5
         YM7+9SHlPP1NDTeRpfijUGYinW8a/cbiUmoB7daSDXDdE2o98igqWZ6GsYvf1Yx2XRue
         kdjHh6TVECsTv4zCZ8w2bmp/p4XTHgQF5XV1AUdr3nM0iS45YJf8uYh377wzK1gXIMka
         I0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xH1VUOFWIU3nomIe48C0/JIkSj0BwVm9wOVBaq6KPFU=;
        b=Wd2xDkjvuk+WRS7Y16AKZekD5dAoxgR/LPRx9bc6XwZ/7dmW9oUcXLWakOYKF5HvWE
         x6XeZ+5NDAqB1kJvdMxMv+oUTr5q0NMyYzbbYD1F10CQmy4FZ9credwgfZfqEVfCpw6r
         FIap/na5pfqtz3ThqnKNEkNScvh6fBSOB4yIu2VQKrs0q6mEiWYaQXWBAtTzhDYff1Z6
         d2wVk2yhUIpDKVDhmmuqwZtcTVjg0XJcaJPPI5wA5x0ZxPnPM/oRBrBNpjAUthqm2BXL
         BW/xH+CNcOn/kBxgqOuDQ74aS9V9F6mWlKfAEOAkJFudQUDKpY1tbQWRoqyRQ3/RYHS9
         kZQQ==
X-Gm-Message-State: AOAM532mzMiO3pvKyBYkl0gIuZvwOk+jWWdFmsQQTAza6+kWwN8ChPyI
        hf69vkaZ4/6B0Vv+Y5Uga60DvifvIhQ=
X-Google-Smtp-Source: ABdhPJwdz0bu4MlZ4nl2z4dV/Yf7HYzFJhSbqYSRiOsy6GCnUh6aDLzEyUWhwpkYdECRO4SQhaCFYg==
X-Received: by 2002:a17:906:c315:: with SMTP id s21mr8576556ejz.285.1604798392263;
        Sat, 07 Nov 2020 17:19:52 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:fce6:5cb0:27db:5e8c])
        by smtp.gmail.com with ESMTPSA id t22sm4545127edq.64.2020.11.07.17.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 17:19:51 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 09/16] cmp: canonicalize unsigned (x {<=,>} SMAX)
Date:   Sun,  8 Nov 2020 02:19:39 +0100
Message-Id: <20201108011939.94252-10-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201108011939.94252-1-luc.vanoostenryck@gmail.com>
References: <20201108011939.94252-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Unsigned <= or > against SMAX are equivalent to testing if the
value is positive or not (when interpreted as a signed number).

Canonicalize to this positive/negative test since it only needs
the constant 0 which make it easier to handle at later steps.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                   | 4 ++++
 validation/optim/set-uimm3.c | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index 7921300f7280..2176f90dc133 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1112,6 +1112,8 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 			return replace_with_pseudo(insn, value_pseudo(1));
 		if (value == (bits - 1))	// (x <= ~1) --> (x != ~0)
 			return replace_binop_value(insn, OP_SET_NE, bits);
+		if (value == (bits >> 1))	// (x u<= SMAX) --> (x s>= 0)
+			changed |= replace_binop_value(insn, OP_SET_GE, 0);
 		break;
 	case OP_SET_A:
 		if (!value)			// (x > 0) --> (x != 0)
@@ -1120,6 +1122,8 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 			return replace_with_pseudo(insn, value_pseudo(0));
 		if (value == (bits - 1))	// (x > ~1) --> (x == ~0)
 			return replace_binop_value(insn, OP_SET_EQ, bits);
+		if (value == (bits >> 1))	// (x u> SMAX) --> (x s< 0)
+			changed |= replace_binop_value(insn, OP_SET_LT, 0);
 		break;
 	}
 	return changed;
diff --git a/validation/optim/set-uimm3.c b/validation/optim/set-uimm3.c
index b72ef8d6e819..5160f741d85b 100644
--- a/validation/optim/set-uimm3.c
+++ b/validation/optim/set-uimm3.c
@@ -4,7 +4,6 @@ int gt(int x) { return (x >  0x7fffffffU) == (x <  0); }
 /*
  * check-name: set-uimm3
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.29.2

