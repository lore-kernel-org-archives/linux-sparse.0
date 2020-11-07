Return-Path: <SRS0=cH/F=EN=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086E3C388F9
	for <linux-sparse@archiver.kernel.org>; Sat,  7 Nov 2020 11:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1038208E4
	for <linux-sparse@archiver.kernel.org>; Sat,  7 Nov 2020 11:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vu7HGR6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbgKGLmc (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 7 Nov 2020 06:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgKGLmb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 7 Nov 2020 06:42:31 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEECC0613CF
        for <linux-sparse@vger.kernel.org>; Sat,  7 Nov 2020 03:42:30 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id a71so3887374edf.9
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 03:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IbCoHUCVzcndRgbAYEehH1SlznfhrF3t4biMaVb5Was=;
        b=Vu7HGR6MIh+L7R40+UglBl7jSG7jSgf+f1h2nsCrzx3KEZDWkOsq31EwdNqK34qy3B
         Qzhm9HD4y/9EGne7AmXQefApT1nEKUMmWy0+ySdclD9odzEFxagz8hwrNEQX43ZPWZ/Y
         Kpmf3ODsSxBdIXkksyMjx7LA02oW2npaLL7SyNnNHTRfQG0T+GFJXTGdseIBNGh8xfhY
         jQqxFqCAfmr37sORwkGghYYGxijemh324j84HORgp6dUw8dqpYWqd0mtTXs7OH5KceOr
         D//iynrRYyy0n29B5XFAySwdzZCgp+Rr/sMSGipjbvHn+j2UO6uS4ZabYAkg/wWFVkvc
         ffQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IbCoHUCVzcndRgbAYEehH1SlznfhrF3t4biMaVb5Was=;
        b=dSHyKBbUP+xTVEYUTkK15soxNSPxCx30NROk7UeI4E0ql2CtcykU8iUmtbSmuvh71D
         jOPjMpXaMRE+5X6R9FqZ1RNcgLsMg5YTkKwhpZeHNITM0I/9sFjNBIL8gDX3b99QM0mx
         z1Jpwni5A7weehBJzBMVRQSkERTn6u4rrMHEDmNdeCSfgRfrb5v3pTwgDae72B545pg6
         4UE+7wlNoir8RH6d+rTyK9im7anR1EjBUA/oweNm0Kic19KYS5/QNdWxVdWQ7Iqt/YwD
         j6dUuVLmVuZ0Z2PGRRAM/ixwkBkljGz045Uoj0V1HfRYIo7HnFPZbGlZ9zQBYL0uc+fF
         kvWg==
X-Gm-Message-State: AOAM531RCIqEzrDcOcuLb61DDtlkfKRc9ep6vby18JuycK/gLwzaEsz6
        rIw5ylRwvNM+JXaamHGeiSbgHPhn/y4=
X-Google-Smtp-Source: ABdhPJw8dYrGoDTVq1X6Hf6stFTxMrBE1/KiZDPDWOHmKc2vjzGAanO5lv1BrsEzoTaUHIptxId5qg==
X-Received: by 2002:a50:b761:: with SMTP id g88mr6618677ede.387.1604749349291;
        Sat, 07 Nov 2020 03:42:29 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:9030:856f:68be:7b84])
        by smtp.gmail.com with ESMTPSA id s21sm3308311edc.42.2020.11.07.03.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 03:42:28 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/5] select: simplify SEL(SEL(x, C, 0), C, 0) --> SEL(x, C, 0) == cond
Date:   Sat,  7 Nov 2020 12:42:20 +0100
Message-Id: <20201107114222.11866-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201107114222.11866-1-luc.vanoostenryck@gmail.com>
References: <20201107114222.11866-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

If the condition of a select is also a select, both with the same
arguments: first a non-zero constant, then a zero constant, then
the outer select is equivalent to the inner one and can thus
be replaced by the result of the inner select (which is its own
condition).

Note: this is a special case of:
	SEL(SEL(x, C, 0), y, z) --> SEL(x, y, z)
      and without this patch we'll have:
	t = SEL(x, C, 0)
	r = SEL(t, C, 0)
      simplified into:
	t = SEL(x, C, 0)	// possibly unused now
	r = SEL(x, C, 0)
      but the present patch do
	t = SEL(x, C, 0)
	r = t
      In other words, functionally, the result is the same but
      now the result is taken from the first instruction.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/simplify.c b/simplify.c
index 6b44d447c0a9..1fcfc691579a 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1791,8 +1791,11 @@ static int simplify_select(struct instruction *insn)
 			// And if that one results in a "zero or not", use the
 			// original conditional instead.
 			//	SEL(SEL(x, C, 0), y, z) --> SEL(x, y, z)
+			//	SEL(SEL(x, C, 0), C, 0) --> SEL(x, C, 0) == cond
 			//	SEL(SEL(x, 0, C), y, z) --> SEL(x, z, y)
 			if (!def->src3->value) {
+				if ((src1 == def->src2) && (src2 == def->src3))
+					return replace_with_pseudo(insn, cond);
 				return replace_pseudo(insn, &insn->cond, def->cond);
 			}
 			if (!def->src2->value) {
-- 
2.29.2

