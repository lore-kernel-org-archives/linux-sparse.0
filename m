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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C448C71155
	for <linux-sparse@archiver.kernel.org>; Sun, 29 Nov 2020 14:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E288820825
	for <linux-sparse@archiver.kernel.org>; Sun, 29 Nov 2020 14:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1GwdWV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgK2OuR (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 29 Nov 2020 09:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgK2OuQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 29 Nov 2020 09:50:16 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9BBC0613D2
        for <linux-sparse@vger.kernel.org>; Sun, 29 Nov 2020 06:49:29 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id m19so9979361ejl.11
        for <linux-sparse@vger.kernel.org>; Sun, 29 Nov 2020 06:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OckwUd4cIgpFSKEPj5ll7DpZrSOgqoPQejCBf4kM9eI=;
        b=a1GwdWV3h+I4WYT9FXqONzF5fCFeefIPgOw58aN8iWsiQ+BA1IgZOuAV/85hYr4eDq
         oEGdQ8tEmqmZUsqRwq517PBu/5yoMYP7C7xH78+ZYlTrOAfEYJuCYBaLxec55gUruCkA
         Ru2y+/HPXMgJHx5FQBYEalJci7fJDRsK9dLhR0r0dijLxZeSM0rnWDMC8c430e+BZ+aV
         h66SewPOtF1W0iE1xTc0tLJnG4eN9C6B53ISgkqnspGDofZKiSnIrvKLinWHfxeavusH
         lIPCQ7LDw4S96jmQ8Ettk2fKuWUGx3uT+g6ZakStq0CdPINsmTFkqkAr0ZPJxn1G+Fnf
         bVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OckwUd4cIgpFSKEPj5ll7DpZrSOgqoPQejCBf4kM9eI=;
        b=Tinpq3NnP5YUDvgOxpfxRMpdHdQC5lFN7RMROdhPh4VkU7HtrnXXuJgvXvHAxGxq2P
         x+ppj7rlgQvz6290lupTnBO3EFHdbv/us1HaTh7ZfReR3JKh9bSxVKYdtvwFuVWN30VJ
         i3luZamDbYrOuYbEYQnWd8zcKryeLcgi3cYny09amBy02DThlqzwyQ8UTYWGPMbi8a/Y
         JMNmKiwlxY0+CeOudXCwb5hmOEUmMYKY2PhQQdKQfalnRHIg0GBZyfXOfYkYcvmMW4ja
         lk0Eci12/QlMqGZT5uRQiinNjlgbta19hdYuQJWKqIDrH8yGqlUJ4TxXiXdDnw63IHVp
         CXaQ==
X-Gm-Message-State: AOAM530UFzg5qccXHOoCwcdBK/Wj1sx8VDyxXQybHCIARVxcJ/0oeKdP
        Z7S2N8Uc2M4+pKjVtlK9fmZJSsKpung=
X-Google-Smtp-Source: ABdhPJzkPPY+iVlvIF6p8H+y6OdwrQMKsttICqdCV12liqokitUWBQ6xEUjrgkABME0iPvL+qeUepA==
X-Received: by 2002:a17:906:e81:: with SMTP id p1mr16673823ejf.494.1606661368304;
        Sun, 29 Nov 2020 06:49:28 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:149a:de72:e1c0:dd0f])
        by smtp.gmail.com with ESMTPSA id p25sm7435649eju.63.2020.11.29.06.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 06:49:27 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/5] let replace_with_pseudo() use kill_instruction()
Date:   Sun, 29 Nov 2020 15:49:18 +0100
Message-Id: <20201129144922.56209-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201129144922.56209-1-luc.vanoostenryck@gmail.com>
References: <20201129144922.56209-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

In replace_with_pseudo(), the replaced instruction needs to be killed
and for this contains ts own code.

But this is a duplication of what is already done in kill_instruction().

So, replace this part of the code by a cal to kill_instruction().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/simplify.c b/simplify.c
index de03d315ec33..29b368e94ff4 100644
--- a/simplify.c
+++ b/simplify.c
@@ -445,23 +445,7 @@ static inline int replace_pseudo(struct instruction *insn, pseudo_t *pp, pseudo_
 static int replace_with_pseudo(struct instruction *insn, pseudo_t pseudo)
 {
 	convert_instruction_target(insn, pseudo);
-
-	switch (insn->opcode) {
-	case OP_SEL:
-	case OP_RANGE:
-		kill_use(&insn->src3);
-	case OP_BINARY ... OP_BINCMP_END:
-		kill_use(&insn->src2);
-	case OP_UNOP ... OP_UNOP_END:
-	case OP_SYMADDR:
-		kill_use(&insn->src1);
-		break;
-
-	default:
-		assert(0);
-	}
-	insn->bb = NULL;
-	return REPEAT_CSE;
+	return kill_instruction(insn);
 }
 
 static inline int replace_with_value(struct instruction *insn, long long val)
-- 
2.29.2

