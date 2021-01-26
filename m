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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49BBC433DB
	for <linux-sparse@archiver.kernel.org>; Wed, 27 Jan 2021 03:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A998A206B5
	for <linux-sparse@archiver.kernel.org>; Wed, 27 Jan 2021 03:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbhA0DpR (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbhAZWFV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 26 Jan 2021 17:05:21 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39D7C061788
        for <linux-sparse@vger.kernel.org>; Tue, 26 Jan 2021 14:04:40 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id m13so3662030wro.12
        for <linux-sparse@vger.kernel.org>; Tue, 26 Jan 2021 14:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s4u24hLglrfhJEiU+ZVHHw5eMIoLKjrX49zqfITxO1g=;
        b=G4S7iU8MKj71xrmJjcUtHLoFjj+Hmc6ki92myn1kyBvJr/+h09l+tbyE24/mzsqTrv
         JRWPhIGo0M/bYvUL8HHjwl2XG8O/gOVa2ixV4aiMagYwau88VEoZrPfoDqBac01Uwt7b
         W/i0pUm1eI526LP15DKmxvJTaSSc8Ghl8rT/uQlICy3vLmrEFDBByl89Y8eAjSyLUKRG
         OOU8B4XB+yncQrSaxVpmxWBtHbXzIwbZB+oP3uheA722kuCMhoV/pfX3DbwUwnyQcA5A
         cpyxSDABY/2OffxJI60NfQjad6g6oZckm3fEwp9g8IxS4s1i/WN95Kdj4TGlWeNTqD78
         VxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s4u24hLglrfhJEiU+ZVHHw5eMIoLKjrX49zqfITxO1g=;
        b=Vn9++UbNjYVZkkMk7uZBA10r/e+KkS9VDvHlOFenEdYyKpYmqiCw+5SKPuh/jJD3vi
         uX3kj1BpnbwzvYAGZWqL5N5dZtlZL+PUgT524syCyKHETbBnCUexCH7GYNPyjpfj24VA
         K0SKBX/SszqW47mcgK693IaqlMm5qVVln7fptaYZ714OCj7OiRGS8TwrITP/cL4kZVF9
         vI1dQ0NS+mLpjGteraHPwmGFjQ2QpQNw4nAz0lkdbh/cxSXdLzGNh/EyzX5IXKcF2G7x
         wy2H5ICo7zb/9OmAU8nBhUmBe6AyEtiMF4Pu15I8g/KAND3KSM9sZOgzuMWYDwApJM6L
         ZHvg==
X-Gm-Message-State: AOAM532CAfpsHD+ta5y5emv8XmUSmJPWToVhFmZITM+B4UgmXheov7Ad
        qV4PuoSFvKMHPZovM5JcQB2EPRz3t/s=
X-Google-Smtp-Source: ABdhPJwQN6IeJhd7ZQxi2LosLE1Jeq5rKIrhQkPDo3psu0O4W6bYSa7e5ulKtWbjxpX5mPZDRRQ1Pg==
X-Received: by 2002:adf:9cc4:: with SMTP id h4mr7008967wre.403.1611698679770;
        Tue, 26 Jan 2021 14:04:39 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:285a:40db:3257:f0fd])
        by smtp.gmail.com with ESMTPSA id b132sm5268447wmh.21.2021.01.26.14.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 14:04:39 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 03/10] cmpu: fix canonicalization of unsigned (x {<,>=} C) --> (x {<=,>} C-1)
Date:   Tue, 26 Jan 2021 23:04:25 +0100
Message-Id: <20210126220432.58265-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126220432.58265-1-luc.vanoostenryck@gmail.com>
References: <20210126220432.58265-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

In Sparse, the PSEUDO_VALUEs are required to be truncated at their
effective size. For example, for a 32-bit instruction and Sparse using
64-bit integers, a pseudo of -1 must contain the value 0x00000000ffffffff,
not 0xffffffffffffffff.

Add the missing truncation in the canonicalization here.

Fixes: c355e5ac5dce35f3d95c30cd5e2e9a5074c38437
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/simplify.c b/simplify.c
index 9a24058f6e55..a306828c1c4b 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1178,7 +1178,7 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 		else if (value == bits)		// (x < ~0) --> (x != ~0)
 			return replace_binop_value(insn, OP_SET_NE, value);
 		else				// (x < y) --> (x <= (y-1))
-			changed |= replace_binop_value(insn, OP_SET_BE, value - 1);
+			changed |= replace_binop_value(insn, OP_SET_BE, (value - 1) & bits);
 		break;
 	case OP_SET_AE:
 		if (!value)			// (x >= 0) --> 1
@@ -1188,7 +1188,7 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 		else if (value == bits)		// (x >= ~0) --> (x == ~0)
 			return replace_binop_value(insn, OP_SET_EQ, value);
 		else				// (x >= y) --> (x > (y-1)
-			changed |= replace_binop_value(insn, OP_SET_A, value - 1);
+			changed |= replace_binop_value(insn, OP_SET_A, (value - 1) & bits);
 		break;
 	case OP_SET_BE:
 		if (!value)			// (x <= 0) --> (x == 0)
-- 
2.30.0

