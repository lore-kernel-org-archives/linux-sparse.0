Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFA7C3E8C5
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 22:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB92F22228
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 22:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1NdUbjO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgK0WcE (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 27 Nov 2020 17:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731378AbgK0W11 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 27 Nov 2020 17:27:27 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EAEC0617A7
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 14:27:27 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 64so7002029wra.11
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 14:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VEVhyCx6rFVqcPZ2YTAJKtQ0As6CDeHLt7rTuGNimiI=;
        b=W1NdUbjO1rdF0S0SDDZFGYn85NoNBYz1HVml0RiXbjcuBVfPrrZ4Cx+3nRR+6w2nbW
         5iNddFhUZY47CDFyy3ZRqqhreGP42SnXJMuz+2IBjRYW8181gGd7NoVyfN0Bt2dzXWcH
         zpQUl+XdnK0ETzwsvHf87aieU1YuFvS0XdbNHqIJzv3ak0fMaoSwG+8sRSaKrUMGIdWV
         NPglr+ad/Vx9bPkKjJJQz/qWD6AI8IWLE0IxJvtbpP4ME10xKyub0635OmY6wMjSfoSQ
         eerzl18DI0SZzshpxVNEo2WoIE93tmFpy68e9sxHupSqY4uQKPXXM3VZalW3XMjcYpph
         LyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VEVhyCx6rFVqcPZ2YTAJKtQ0As6CDeHLt7rTuGNimiI=;
        b=ect3vPuySg7fchgxGsNLKLUZb6Kt5NymmOxvV5WQBqvRmtxuLJ+O0JAIoTYMGHujuq
         WbmJOLR1OHBrrFOw/bGB0xgy9VJtd077o2npt7EmgymMGynT6jyzBvdEOt75dbqIke5U
         sSSk4u8o1iRGxnz5DNRWllg5AuSV7H0vc6omkmUrel9FdF0mKI2b8LH7OlZuS0usp7HW
         qN/mPPdwI/qYlMBJFZO/Qgt5sQq8Op/f9VxTFBmel7Szhkm4hEesOMetLJuiDgPdMMg+
         asS+EdpssGn6fYiEEbg9Xnep/41mri6P5XWiflFmaIqshyxjzxdfV2DmhsjhJ6BuFGt8
         34gg==
X-Gm-Message-State: AOAM5333Kzf2F0PH9pW0/KGMhgdIRhNKTM4dQ4TifGaIHk+uxu2hG0Cy
        OgpocLugmHQ5cAEzJFzftZ91kOOs5Dw=
X-Google-Smtp-Source: ABdhPJxq30EnDCkiWrOVg6qez7UWcUV/13RG+pnwZilF1OgDcat9z7u0BOgITeNoVJn5Q9gSmWApnw==
X-Received: by 2002:adf:de05:: with SMTP id b5mr13545841wrm.131.1606516045741;
        Fri, 27 Nov 2020 14:27:25 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f469:b93b:e449:cc30])
        by smtp.gmail.com with ESMTPSA id q16sm17347050wrn.13.2020.11.27.14.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 14:27:25 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/6] add helper is_power_of_2()
Date:   Fri, 27 Nov 2020 23:25:12 +0100
Message-Id: <20201127222516.44915-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201127222516.44915-1-luc.vanoostenryck@gmail.com>
References: <CAHk-=wjoJXrG=2_vnOX37fro12eyZc+uo2WL+F-utk51g9WuBA@mail.gmail.com>
 <20201127222516.44915-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Add is_power_of_2() to test if a value is a power of 2.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 bits.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/bits.h b/bits.h
index c0dc952eaed9..63a663c248e4 100644
--- a/bits.h
+++ b/bits.h
@@ -58,4 +58,9 @@ static inline long long bits_extend(long long val, unsigned size, int is_signed)
 	return val;
 }
 
+static inline int is_power_of_2(long long val)
+{
+	return val && !(val & (val - 1));
+}
+
 #endif
-- 
2.29.2

