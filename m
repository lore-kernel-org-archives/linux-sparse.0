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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731DDC64E7C
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 16:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 418DF221EB
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 16:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dz2lDWif"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732001AbgK0QwF (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 27 Nov 2020 11:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732143AbgK0QwF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 27 Nov 2020 11:52:05 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36219C0613D1
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 08:52:05 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id e7so6236909wrv.6
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 08:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+vUf0KW2sZz7OITOeA3UReNoLMOlG7LaRjTI4rJr6JA=;
        b=dz2lDWifrZuBZ2x1EVDYGvyxBP7Ca7MKuQbKjgBJfHq5Yy3qrHZy7wi8DdoBfOK9uP
         yrIlU4Cok7zem+1jovzHi/JJvW8UQiPOJ4qacKm7TqccUfC+DCWC10sOHA7JbjPHRJD0
         VjRUoTrLHVeCj0a8764tXwYjMBTxqSMHm7ArRaldt5ljjlujjUjCYVERltoPIPxuCrU6
         2Saw+xSVSreKQ3C9MgQs6hMQ+/eNbXW8p+u+XtIHBCvKnQLXyAHDklwiA9JTb4UFnikK
         cinVa39zwD3r6D391c6uX1PYNcaD02A6tcyRGdmIBAeFVxAyS2GApqM74i1dGXTWYnEg
         Dr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+vUf0KW2sZz7OITOeA3UReNoLMOlG7LaRjTI4rJr6JA=;
        b=JGO2Dc9RRnl+fXdLyoOmshAtw173oXrFxaXvxxr25CUXGoH9i781GHOLdZWRJhqUhJ
         ZJozFfkOxkyK/l3I0WMR5q4MnzpcKzAfhEQU1T0+kxQOV/jfyHip+cU+oHzF5W8aDQ6n
         mW3G//Eif/3/dMandKITtcJprSkvnua5qvTRhzGx7BZKdYf/G/A+e2rOocH/F7xWze+J
         Z7WEjZ2IK8qt6nLbTyogMWHWtJhz5Smj+qRCfAyqw/WI2Yl81AXh8R0G8ovDazVZY7Ir
         sD0hALa8ZuQkkFgoFxvDreHNvchHXAMmrqmVfLbigej+4EgV8DvUvbtw8ccRh0Z6c/Nr
         JnrA==
X-Gm-Message-State: AOAM530Sicgy58KYoW72rz9WIbso4FPKEWlf27EIsLUu/B14lOHsRmP5
        1X1m9oGaQF0xWqP31t2foh2ONnz+HZc=
X-Google-Smtp-Source: ABdhPJylEZMoMmJFFm2ElRYNZrdTjnko6zwZ2YkwBpuS0CNCNVr543pDphbh5uOU2iF1H8GQSgFT6g==
X-Received: by 2002:adf:bc13:: with SMTP id s19mr11890860wrg.397.1606495923713;
        Fri, 27 Nov 2020 08:52:03 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:e9bd:38ae:745f:40ea])
        by smtp.gmail.com with ESMTPSA id y2sm15895539wrn.31.2020.11.27.08.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 08:52:03 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/8] add helper replace_binop()
Date:   Fri, 27 Nov 2020 17:49:46 +0100
Message-Id: <20201127164950.41517-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201127164950.41517-1-luc.vanoostenryck@gmail.com>
References: <20201127164950.41517-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Add an helper to replace a binop OP(a, b) and taking care to
drop the usage of the previous operands.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/simplify.c b/simplify.c
index 24b3dcb52428..046bf02c6d36 100644
--- a/simplify.c
+++ b/simplify.c
@@ -497,6 +497,23 @@ static inline int replace_binop_value(struct instruction *insn, int op, long lon
 	return REPEAT_CSE;
 }
 
+///
+// replace binop's opcode and values
+// @insn: the instruction to be replaced
+// @op: the instruction's new opcode
+// @return: REPEAT_CSE
+static inline int replace_binop(struct instruction *insn, int op, pseudo_t *pa, pseudo_t a, pseudo_t *pb, pseudo_t b)
+{
+	pseudo_t olda = *pa;
+	pseudo_t oldb = *pb;
+	insn->opcode = op;
+	use_pseudo(insn, a, pa);
+	use_pseudo(insn, b, pb);
+	remove_usage(olda, pa);
+	remove_usage(oldb, pb);
+	return REPEAT_CSE;
+}
+
 ///
 // replace the opcode of an instruction
 // @return: REPEAT_CSE
-- 
2.29.2

