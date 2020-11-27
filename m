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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4CCC3E8C5
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 22:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4882021D46
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 22:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3cNNp5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731355AbgK0WaU (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 27 Nov 2020 17:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731413AbgK0W12 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 27 Nov 2020 17:27:28 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F36BC061A04
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 14:27:28 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id k14so7046807wrn.1
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 14:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fy1/8aHGLqmG6nr3Py2q0Ie8D12Oq5+K1Jwk8epTuy0=;
        b=G3cNNp5YbHrTWnHEkQORnLpB3gfhjfGdrLKBJ+s5PwfcI59k6sDrCeuXQVcwyLheBY
         YpOs2fIpTItnwDf2pptFS6KHmC1gNuriGshLa4H8QDmpA11nQNKPSmfF0ElvXKa6sRs8
         livEdZJoAQIFh1LfsA/Fs3KyeGwYyAKqf9v2dIx98uIA1F/pJPl1zmPhiL1hXXpnqPW6
         SOvKgJQM6SwoAonNrXGgNZWWUvKQpjyoxky2yhHJcpeaDHzW/MT1xiT7VGIVgi4S0OsD
         yyWsrwzvW05vsZMw8O7nkTCZyzjcbkZFUacVO3aVqUmyqE1k0ITw3nBKV5qxxm/EbrH3
         xxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fy1/8aHGLqmG6nr3Py2q0Ie8D12Oq5+K1Jwk8epTuy0=;
        b=PYAHyoBbHUrSls4OHnJTCJqd/jo2zu9TLaFsqK6UPrq1FxHsS/XD0Qeec3iKShshbU
         2qHdVWBO578m4elT4yTwRK8D2nYn/W88Kh+Hz5mE8NPPwn/heAztE1AbEiKVdjc3ArcK
         y9PqNvDCAjEaKGpKY7+9jbAJDvo/wiBNmjNh05R6cvGx1+JbbNHHOUi8/i3VBKIQCRrZ
         ElG8zbE00xJsVYjEPKUKG2BUX2M7XK8MtVjCNUC0CEgSDvRiaT3YOy9vRcmAeAPSZqru
         +HZD3L2gDauqtdLTLxxg1qWol9OqnFT9MvAnirDQe+AO6OBX+yFJwopp2hBf+XZiZLU0
         7HiQ==
X-Gm-Message-State: AOAM530mSToIqAlEbYa8sK/xvPzt6D4DC0c+bW/zsEKTKbDFXo2K77QE
        x4KYvQzb6PFEGGSyMTgatAB/9YAoETU=
X-Google-Smtp-Source: ABdhPJwTdwkC0cIQaBWjkzXJhiI0CQBrnGOF9Flo43IsYiCUTdgr5Wnmncnvvidoc2r9APQD/ypYKg==
X-Received: by 2002:adf:ba47:: with SMTP id t7mr13209731wrg.47.1606516046749;
        Fri, 27 Nov 2020 14:27:26 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f469:b93b:e449:cc30])
        by smtp.gmail.com with ESMTPSA id q16sm17347050wrn.13.2020.11.27.14.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 14:27:26 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/6] add helper is_pow2()
Date:   Fri, 27 Nov 2020 23:25:13 +0100
Message-Id: <20201127222516.44915-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201127222516.44915-1-luc.vanoostenryck@gmail.com>
References: <CAHk-=wjoJXrG=2_vnOX37fro12eyZc+uo2WL+F-utk51g9WuBA@mail.gmail.com>
 <20201127222516.44915-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Add is_pow2() to test if a pseudo is a power of 2.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/simplify.c b/simplify.c
index d729b390ae76..0d9391e21a56 100644
--- a/simplify.c
+++ b/simplify.c
@@ -52,6 +52,15 @@
 // Utilities
 // ^^^^^^^^^
 
+///
+// check if a pseudo is a power of 2
+static inline bool is_pow2(pseudo_t src)
+{
+	if (src->type != PSEUDO_VAL)
+		return false;
+	return is_power_of_2(src->value);
+}
+
 ///
 // find the trivial parent for a phi-source
 static struct basic_block *phi_parent(struct basic_block *source, pseudo_t pseudo)
-- 
2.29.2

