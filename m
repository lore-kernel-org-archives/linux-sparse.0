Return-Path: <SRS0=1LG9=AT=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384B4C433E0
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 21:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1705C20708
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 21:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYcsA7E/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgGHVzg (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 8 Jul 2020 17:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgGHVzg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Jul 2020 17:55:36 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0769C061A0B
        for <linux-sparse@vger.kernel.org>; Wed,  8 Jul 2020 14:55:35 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id l12so51353ejn.10
        for <linux-sparse@vger.kernel.org>; Wed, 08 Jul 2020 14:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NJLdNlLknV7LWbEL4fadKXiGr4UkDRdoEcI32y7pxzo=;
        b=BYcsA7E/CQoWdxVVs/Aw0NSeHXo8YyR3DOEIvXJ2NjEWpXzqQK/RG8x0j1wJfhpDD6
         y2CFU93qE7K7UmCs/8j7M69bziNTeyujQ12FwWKb/LNx84FRMk35f073+pW5DF3G9AZZ
         RyqvtWEakQjEg2YMiTg/+GYMmO/K0FOyZQNkfmvlqENbkk2kQ11ixncSRWW2hpwPXxHb
         62dXyIrVwXAnPR6N+tKpsyXVeDspgZ925YBf05/BAWZOXaOR2+FkxsUEjF6eR9rTXdzm
         PkZ+r7Oapc8KCskt35yEPakBdZIL5/ZS5389y2pdF3SYVniTTDjK92ECh73VCPlIuNHU
         8qsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NJLdNlLknV7LWbEL4fadKXiGr4UkDRdoEcI32y7pxzo=;
        b=MZwufif9fWjVEhO3B91NwyiCRxz9KeZAoCffumhFf58SN95totMrTdNpC+R4nIPaB/
         q2dW+vNSqF6ZMWkejP1wUSW0K7f9DpgRa8NTQzkixZG+VKUwPxV3J6yrjQ0L8437HbZd
         qZhiLrOvm0jFx8QOb+EHH8BXLJ+6yyGPoVngRRczU+x/YfUoOw4AiS6dj9c3lFNAc4iK
         raW3X6Eu8rv1cT0ETpNzZvqgashinlJDa2QR3nKOHFCJua4lh0NtwjQMWK4EYSrjw2Pf
         k1bdDFXYFUtNQ7wt0rIdI16ERqpTf5YGCHFrGr6cc4MVJFi7fRTpe5XA/VKChw3UDDMD
         cTSA==
X-Gm-Message-State: AOAM531qtNloJ4bCgwHZa8Ssyk7zS4dtEa5yn60P3SznhB19d0LC5MQN
        res/MxK47bu5xGQHx5fIOCcswi9E
X-Google-Smtp-Source: ABdhPJzVe2XpHhM6Oo4LF0VBj7GaIUSKksIHiSQP8EMjIdKHGWlDjDYOGUCTvabFk12Zbblmx5HbGA==
X-Received: by 2002:a17:906:c083:: with SMTP id f3mr46167847ejz.530.1594245334384;
        Wed, 08 Jul 2020 14:55:34 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:b1eb:f280:ff97:eab2])
        by smtp.gmail.com with ESMTPSA id a8sm478999ejp.51.2020.07.08.14.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 14:55:33 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] mips: add predefines __MIPSEL__ or __MIPSEB__ & friends
Date:   Wed,  8 Jul 2020 23:53:27 +0200
Message-Id: <20200708215329.56404-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708215329.56404-1-luc.vanoostenryck@gmail.com>
References: <20200708215329.56404-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 target-mips.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target-mips.c b/target-mips.c
index 3d73236feffd..1ff0760c2446 100644
--- a/target-mips.c
+++ b/target-mips.c
@@ -10,6 +10,16 @@ static void predefine_mips(const struct target *self)
 	predefine("_MIPS_SZINT", 1, "%d", int_ctype.bit_size);
 	predefine("_MIPS_SZLONG", 1, "%d", long_ctype.bit_size);
 	predefine("_MIPS_SZPTR", 1, "%d", ptr_ctype.bit_size);
+
+	if (arch_big_endian) {
+		predefine("_MIPSEB", 1, "1");
+		predefine("__MIPSEB", 1, "1");
+		predefine("__MIPSEB__", 1, "1");
+	} else {
+		predefine("_MIPSEL", 1, "1");
+		predefine("__MIPSEL", 1, "1");
+		predefine("__MIPSEL__", 1, "1");
+	}
 }
 
 
-- 
2.27.0

