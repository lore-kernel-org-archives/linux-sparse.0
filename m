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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF597C43460
	for <linux-sparse@archiver.kernel.org>; Sun, 18 Apr 2021 11:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8398761207
	for <linux-sparse@archiver.kernel.org>; Sun, 18 Apr 2021 11:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhDRL5O (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 18 Apr 2021 07:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhDRL5O (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 18 Apr 2021 07:57:14 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C96CC06174A
        for <linux-sparse@vger.kernel.org>; Sun, 18 Apr 2021 04:56:45 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id j12so12358758edy.3
        for <linux-sparse@vger.kernel.org>; Sun, 18 Apr 2021 04:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AAVEv80tdd2CseM46A14LcW48P4xCQ/gB5to14QQkuQ=;
        b=EB8aFIYrTwg9M6PYjz6isOkU7cS4FeMepjgF/VAR3ETOC27JOX1/AhwbOeAI1izoeI
         1sq5AzKWWxkERFvDUxVEqpiwpN6hVSyb8uHFgAPNw411+3FDQtajgih5p694RHUkdXDL
         BHJ02Tsx5qfjSiHgM3E1sXNaXCxy/TzJWDopMJlGhwUG5YG4k0AKGDK0K6ZR0PoqpIEq
         gihYzhpwoXzigdVVxqTjimXxBlKLPbiw7FOlSjTFuopp6t23kyBk4k+nScXOfO79SKSH
         CWA7KpN6AS26/OHSTdt2ovHG6L80CvP5DPGGZIbjx6nuJHnnJyevm+PiTsp8jf6xZp5c
         Dk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AAVEv80tdd2CseM46A14LcW48P4xCQ/gB5to14QQkuQ=;
        b=Wh9A66cSXXGN63iGIln5+4oERh5wt58XUl9H/RLEgMxda6ghRDF95oESx2IBi0LHAf
         l9vMsaUHUxvnKbVaIHpLu+iYW4cFSTJWadlJiBn/S2Fq4Tk0dloJTpnJ+XlpRpzqjO51
         6MouzaGbOFyGBKw8+H+ZgE2mM8epHGMYEk/ba2HbIjzfv4qf/KG/6obiU2J88bvObHCQ
         wWdhnWsWG8sjAF5WotqC1efkLBz4cTE8zk7M4ETRjoHTVYJsXv68k0BHEBDbCf7NWaFM
         gXck7mNcaYd9P8NZXcCSyUTlJdBf0whdHdCPo1SqropjB7XfDJLOkzpJwH9mbJEQOomD
         bRXQ==
X-Gm-Message-State: AOAM530kP+TkQf6e+pvKeCQlmnymbbxL0KpBtSneJS9tvPZccDiIFOhQ
        UWqHbCFZYIpoMbdAYlK6J6zjOS8K85c=
X-Google-Smtp-Source: ABdhPJxMID0OhFW+hyCIcwgPiXk78qmR5L4YuiLmtyEN4TGeoAVJuQ7hJUrMf2M+KCFhhvCOx/Qjeg==
X-Received: by 2002:aa7:dd4d:: with SMTP id o13mr20468572edw.53.1618747003826;
        Sun, 18 Apr 2021 04:56:43 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:959c:c85:d486:38cf])
        by smtp.gmail.com with ESMTPSA id y11sm10298199eds.10.2021.04.18.04.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 04:56:43 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/3] simplify TRUNC(NOT(x)) --> NOT(TRUNC(x))
Date:   Sun, 18 Apr 2021 13:56:34 +0200
Message-Id: <20210418115635.40608-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210418115635.40608-1-luc.vanoostenryck@gmail.com>
References: <20210418115635.40608-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The goal is double:
1) be able to do the NOT operation on the smaller type
2) more importantly, give the opportunity to the TRUNC to
   cancel with a previous ZEXT if there is one.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                    | 15 +++++++++++++++
 validation/optim/trunc-not0.c |  1 -
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index 9e3514d838a9..b2311d397b23 100644
--- a/simplify.c
+++ b/simplify.c
@@ -2288,6 +2288,21 @@ static int simplify_cast(struct instruction *insn)
 			return replace_pseudo(insn, &insn->src1, def->src1);
 		}
 		break;
+	case OP_NOT:
+		switch (insn->opcode) {
+		case OP_TRUNC:
+			if (!one_use(src))
+				break;
+
+			// TRUNC(NOT(x)) --> NOT(TRUNC(x))
+			insn->opcode = OP_NOT;
+			def->orig_type = def->type;
+			def->opcode = OP_TRUNC;
+			def->type = insn->type;
+			def->size = insn->size;
+			return REPEAT_CSE;
+		}
+		break;
 	case OP_OR:
 		switch (insn->opcode) {
 		case OP_TRUNC:
diff --git a/validation/optim/trunc-not0.c b/validation/optim/trunc-not0.c
index febed165b0c4..882b446d9197 100644
--- a/validation/optim/trunc-not0.c
+++ b/validation/optim/trunc-not0.c
@@ -14,7 +14,6 @@ static _Bool ubar(uint64 a) { return (~(uint32) ~a) == (uint32)a; }
 /*
  * check-name: trunc-not0
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.31.1

