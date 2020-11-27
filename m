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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6108C3E8C5
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 22:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E44421D46
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 22:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uWtQQCcL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbgK0W3J (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 27 Nov 2020 17:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgK0W1a (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 27 Nov 2020 17:27:30 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F8FC061A47
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 14:27:29 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c198so6249258wmd.0
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 14:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s+w1yl8gKIlBvFF6/7fDEy9cWHTXXmi33iOvB8eGjSQ=;
        b=uWtQQCcLzT+dag22fk5n9+SCmJTE1CZ9V6QelaYdiKzlW1BHKo9FzCaclqSO3gtEUK
         l3GrcHk2FoJZdUcTgi750EbUDo3QzL/gL7UEM5oxYExOONspBXi/sfpVdI/m7UjQWcsz
         xl/czK9yp+onTV4RrKAhgjk2ABEK4UtIE+dqU7+NMr+Nq5vMerkmf009BmqV/rGx3cw3
         izTmJIzxxereYAff9J0QTKet6G7C4m4spAbP670DM+2v51V/HpCDHNUd7UyMX2yGc8MD
         ws8QOhf13VymdYJ7kcRZXcN3F5TtS35S+NjzTJlaCIVNXnuk8FLt6nyynxd98d634MqD
         1p4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s+w1yl8gKIlBvFF6/7fDEy9cWHTXXmi33iOvB8eGjSQ=;
        b=rRoOLe4Ic+JmEp5qonaMtc8Wn5P+3sbtdyA16AOGk8AZNkCetwjyqGdUYDXIw1fFhH
         gAm9NdyJAsU3eo+o2ImHk5wSxB66aL3VBtYToZ5UNB0ypvea54ON7le8opoWuwGs9dio
         sfy7tuSVkTATU9K+cZwNNRvnpIK0y5be8niKnifHVg9rL1wMCxFQMcXiNF0vVrMkhk5t
         yTLNTMdTcyalq1Bn7TPuR4TzWKo8ZzSxiZ/FpvQFqfD9/TfUs2HwVpqHX1fAicIP2KRG
         Uk3XRLMZVuVADJwcQpc2LrkZ6h6TtD9kxGKw2q5I1/pd4SsnLdfsaVNXnKhVKovb29tu
         35/A==
X-Gm-Message-State: AOAM531LXTOCbvvuBmutXCqojcFri8H6p+SjuZj8Ew+nwAdVSsB3Rid3
        SAQbPC25C333I9Cjr8p586+MFClb54o=
X-Google-Smtp-Source: ABdhPJy9HSGWwSLB3bnhdxeg0fiCVt6B42QMuia/tXl4zPI7sJkeyG8tK19sZxaPAcO7ah4MvK73zQ==
X-Received: by 2002:a1c:5603:: with SMTP id k3mr11752187wmb.151.1606516047678;
        Fri, 27 Nov 2020 14:27:27 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f469:b93b:e449:cc30])
        by smtp.gmail.com with ESMTPSA id q16sm17347050wrn.13.2020.11.27.14.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 14:27:27 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/6] add log base 2 function: log2_exact()
Date:   Fri, 27 Nov 2020 23:25:14 +0100
Message-Id: <20201127222516.44915-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201127222516.44915-1-luc.vanoostenryck@gmail.com>
References: <CAHk-=wjoJXrG=2_vnOX37fro12eyZc+uo2WL+F-utk51g9WuBA@mail.gmail.com>
 <20201127222516.44915-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Add log2_exact() to get the base 2 logarithm of a value known
to be a power of 2.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 bits.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/bits.h b/bits.h
index 63a663c248e4..9908190d8c2f 100644
--- a/bits.h
+++ b/bits.h
@@ -63,4 +63,11 @@ static inline int is_power_of_2(long long val)
 	return val && !(val & (val - 1));
 }
 
+///
+// log base 2 of an exact power-of-2
+static inline int log2_exact(unsigned long long val)
+{
+	return 8 * sizeof(val) - __builtin_clzl(val) - 1;
+}
+
 #endif
-- 
2.29.2

