Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB01C64E75
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 22:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36011221FD
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 22:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+Sjfo0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731772AbgK0W1q (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 27 Nov 2020 17:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730724AbgK0W1Z (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 27 Nov 2020 17:27:25 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A315FC0613D1
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 14:27:24 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id u12so7049022wrt.0
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 14:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vv1Y0h64a6bAOuvhcUfa5beVyuDohxVSASaQpiLqNrk=;
        b=j+Sjfo0ZG8VbKq101X40UWBfcT/YHng+DI7jwPlHF7QeirF0E+HwmJ4thyS4jgg0sX
         vjvznkK01GgLIxw6SNzF0Ma2EiUin3zrrlsMxJe6ZDCaAcVHmSTRxR+BCy7XFyAWq3sO
         PWpTIHKx9ve+CiBzymke30Lj8kPiAE0gm3I0klvzW3DVOVpOk0z0EraDt2ghgxqltC5Y
         W55e0bhYUCbqDfwi2kicuZl8bgpPixCFEjGgzgWYGw1w9VjXW5qlv40KOQpRU2kVLYhl
         PLJfcxmnEdwwbGFYlBGarxEMl2Z0kMrsYmQb1VLnhmY1y8RAuRuBHPeWzRtl1w0fChvl
         FKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vv1Y0h64a6bAOuvhcUfa5beVyuDohxVSASaQpiLqNrk=;
        b=A1O654XM92xxM9fJuApDczTZeJZYPV4v4oXy0VOPfoeIMDhEooXyhoPHG8frXGre6j
         /lflo7rMLgouK7dqhs1Oze5lioEiNKvtnx8qMYr+jljuiseN8EaZ/YTLLLpMPNhPKIPc
         JmpXNJA7U/agyPuhxtf6NYsaFK1n+TwEYVbkhh8Y8b4lk614qTDb4tyzZ0DJSapdeCkB
         XCFnJdm0JxyPkffAZLV+ezOQfAiWtuElZ9d/KXpSbgxvmDUJUQGobdiT1TH8a6cyXxtH
         UC9sZJBvgqvNk+FPdhnslIwpFVxlp0+1Cgh3YblrQ2XqRUsUhVi/qRtTta6HlCuFz7WJ
         ww8Q==
X-Gm-Message-State: AOAM531pQCeDYvWtSbOxLTjmCe5AakC0uwGUB9q9wgJitubEHbb6FGmK
        WBkm226vlg/RN+y6wAbG8YzDIy6swfQ=
X-Google-Smtp-Source: ABdhPJzqVkA5Fp9Rn6DwXAS4/+Qc7DTvasgfvONJsAnDye04jwWE3w7IlQ2S3hp0sASlUPMs06z60A==
X-Received: by 2002:adf:f102:: with SMTP id r2mr13535874wro.315.1606516043151;
        Fri, 27 Nov 2020 14:27:23 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f469:b93b:e449:cc30])
        by smtp.gmail.com with ESMTPSA id q16sm17347050wrn.13.2020.11.27.14.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 14:27:22 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/6] 'bits translation' simplification
Date:   Fri, 27 Nov 2020 23:25:09 +0100
Message-Id: <20201127222516.44915-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <CAHk-=wjoJXrG=2_vnOX37fro12eyZc+uo2WL+F-utk51g9WuBA@mail.gmail.com>
References: <CAHk-=wjoJXrG=2_vnOX37fro12eyZc+uo2WL+F-utk51g9WuBA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This series allows the simplification of expressions like:
	if (val1 & 4)
		val2 |= 8;
into
	val2 |= (val1 & 4) << 1;

With a better if-conversion mechanism it also allows to optimize
	int translate_bits(int x)
	{
		int y = 0;
		if (x & 4)
			y |= 16;
		if (x & 8)
			y |= 32;
		return y;
	}

into this nice:
	translate_bits:
		and.32      %r2 <- %arg1, $12
		shl.32      %r5 <- %r2, $2
		ret.32      %r5

when applied on top of the previous 'factorization' series.

This series is available for review and testing at:
  git://git.kernel.org/pub/scm/devel/sparse/sparse-dev.git bit-trans

Luc Van Oostenryck (6):
  add testscases for 'bits translation' optimization
  factorize SEL(x, OP(y,z), y) into OP(SEL(x, z, 0), y)
  add helper is_power_of_2()
  add helper is_pow2()
  add log base 2 function: log2_exact()
  convert SEL(x & BIT1, BIT2, 0) into SHIFT(x & BIT1, S)

 bits.h                              | 12 ++++++
 simplify.c                          | 64 +++++++++++++++++++++++++++++
 validation/optim/fact-select01.c    | 25 +++++++++++
 validation/optim/select-and-shift.c | 17 ++++++++
 4 files changed, 118 insertions(+)
 create mode 100644 validation/optim/fact-select01.c
 create mode 100644 validation/optim/select-and-shift.c

-- 
2.29.2

