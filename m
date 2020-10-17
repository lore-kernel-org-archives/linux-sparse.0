Return-Path: <SRS0=IUSJ=DY=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FA9C43467
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Oct 2020 22:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59D5020878
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Oct 2020 22:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROKeyCHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439825AbgJQW4s (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 17 Oct 2020 18:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439822AbgJQW4r (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 17 Oct 2020 18:56:47 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6D7C061755
        for <linux-sparse@vger.kernel.org>; Sat, 17 Oct 2020 15:56:47 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id cm24so6487527edb.0
        for <linux-sparse@vger.kernel.org>; Sat, 17 Oct 2020 15:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hWuX5J7f4g+31ZemDmc5lgTq/Bv5hJ2Gx8IkgUGSJxg=;
        b=ROKeyCHWCpKe+ZMZqWGz3PSEVEpHSP2ODVK98ZTGK/JXK7D35YpqYVzkzKoLffZRC0
         kGkha0uk5VilXdgEkKyaVOdbKZJu+L2WDd04U/IN0i+jKXRDm4ALpqL8SPqMhIXEX/g/
         pmHlfZNZh7raS80wB8yBX7t1moz9pMirDs4lf8dbYj+tlHCejJ8Gadcw1CBBvhbdsebX
         wf0aPNUMXYxWGAUlw/yIMddk2GQi9uwopEUE5I+aWquzZ/8fZa5+YaY69v30cIL5Sb4c
         ZItdHYzZMggFKkG+V+z9R5ABY+2tPevVNnWOqZ27uS+jpnXAmcMyXi67Nk+rYeKgbZQz
         FVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hWuX5J7f4g+31ZemDmc5lgTq/Bv5hJ2Gx8IkgUGSJxg=;
        b=Z+JmCCpbI2hpmP48QmbP2Ao+1qZf4mga0HX119+ub3/w/jnseUsiow9H/DDdeeRYDI
         2ASo2iBvYHHlb6e9ybcK9j/uAaqO92vQ7sVHFUv7M5kDuS4j/XpnxUHFUG95lv1Rqzyg
         XEWAIkhaotMSIv+cyqu/LWDM3mqdU/MLruLTYXLKGJUSHXBAFpFu623tu9cluox3tzZz
         DNQuPojEl+CffzG1olKXwIiBHe4RjEMXwRLwJp9qdV5qIRXaSY7MoDg6Dwqwc2fd7nJI
         quwrneVNBy5dEIJB2EpuxRAf0Lv9e0ovJUE/0H2pG0C/wxTXHu5QwERUIz/0mqCoq22t
         xtrw==
X-Gm-Message-State: AOAM532qCpRSsRIA/nuj33YCzo5RgvYgyrsE43AuhWLVTJ3RbzLHzHS2
        2S8dDSYDOI4dwcpU0Kd9u5RWijCxoAo=
X-Google-Smtp-Source: ABdhPJynvS8Xvtd04hn921l7ptVC8+OXVjdwkMSvMLOObXBirXZf2apULsO7kPXHmAaYb2dv/w/R9g==
X-Received: by 2002:a05:6402:1004:: with SMTP id c4mr11144819edu.149.1602975405459;
        Sat, 17 Oct 2020 15:56:45 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c81f:df9c:7723:c5a1])
        by smtp.gmail.com with ESMTPSA id k26sm6129311eji.22.2020.10.17.15.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 15:56:45 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 08/12] builtin: add support for __atomic_add_fetch(), ...
Date:   Sun, 18 Oct 2020 00:56:29 +0200
Message-Id: <20201017225633.53274-9-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201017225633.53274-1-luc.vanoostenryck@gmail.com>
References: <20201017225633.53274-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Reuse the generic method for all these builtins.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/builtin.c b/builtin.c
index 4921a2429f55..a65cfd53ced1 100644
--- a/builtin.c
+++ b/builtin.c
@@ -479,6 +479,18 @@ static const struct builtin_fn builtins_common[] = {
 #define size_t_ctype	&size_t_alias
 #define va_list_ctype	&ptr_ctype
 #define vol_ptr		&volatile_ptr_ctype
+	{ "__atomic_add_fetch", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_and_fetch", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_fetch_add", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_fetch_and", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_fetch_nand",NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_fetch_or",  NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_fetch_sub", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_fetch_xor", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_nand_fetch",NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_or_fetch",  NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_sub_fetch", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
+	{ "__atomic_xor_fetch", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op = &atomic_op },
 	{ "__builtin_choose_expr", NULL, 1, .op = &choose_op },
 	{ "__builtin_constant_p", NULL, 1, .op = &constant_p_op },
 	{ "__builtin_expect", &long_ctype, 0, { &long_ctype ,&long_ctype }, .op = &expect_op },
-- 
2.28.0

