Return-Path: <SRS0=Zl/b=D6=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66513C5517A
	for <linux-sparse@archiver.kernel.org>; Fri, 23 Oct 2020 16:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06309206B5
	for <linux-sparse@archiver.kernel.org>; Fri, 23 Oct 2020 16:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpeTbDqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751708AbgJWQjs (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 23 Oct 2020 12:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751741AbgJWQjs (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 23 Oct 2020 12:39:48 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF839C0613CE
        for <linux-sparse@vger.kernel.org>; Fri, 23 Oct 2020 09:39:46 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dt13so3216822ejb.12
        for <linux-sparse@vger.kernel.org>; Fri, 23 Oct 2020 09:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rqYh8SFgt8mPrKPt+xD7kue7Y//AF90VhIngQ5O5vuQ=;
        b=lpeTbDqmzEJFYCNwEVyRpJqJgA1fmku+25/pF2Ps9Aoem62DU0ZD7PAc0ki5PJO6/K
         Y3gQx3emOFkNHVxpvtlMETQSn5wiqzypIuy4na628raAMZaMMG7CDroGilnzONdOF2lR
         3d3zCToYAW36x0oHtKKiPS9TdPKQcEv4FagwfYxAkJH4hehJYdtIYMCvSv6iZgq6tssr
         9T2trklUa8C1K7qnJyP+u86HBlU+VMkruQUto1AZKnu9fqipuz6XWw2SsTBLZ96CUFXS
         OaKXTo911WDOIWpLttdxDtMNAo8UxWOLYr6dWMS5ySGaxWU3k5JVfLe+mFpKaRzzD3e4
         Ly9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rqYh8SFgt8mPrKPt+xD7kue7Y//AF90VhIngQ5O5vuQ=;
        b=LRy7OmCMdx45rdtm92Tz9w1KRFK2TcocPfcUpoJXVfksdww5RGSLEGWMyIk/v6hynC
         kYK5mHSqcj517Mrj5e0D/PcNY+4ggEHf2GfKMh4PR1Lt2A/xOKAa/mxCGHdcHNLzkR0X
         5T7SPteppQQPgGbWQP4PYA0c2Fql3tXEGm9QYmXAJvfSgRSW+Jm9r7vXR55xZtOHgId7
         heIRsnztzfeJtFoTMlMTWBdFV7BG8vFxkM5Kj4GZeZ6xERptAu5H65epeGaJXuBBdS5z
         s4cHhpr/UXDpq9i9pOdjsps7LJntesasS+xNBC7P8zD41hgyLIgfqqcmv8eY5NhNd/aM
         7jrA==
X-Gm-Message-State: AOAM532f6K/jEZ6F35irAAUmnM86ibGWOXf0Guz6Y6Wrez29W+DnuXla
        Kx6JnrV1GyN646fwqHpD9j6xaHb9Gtg=
X-Google-Smtp-Source: ABdhPJyDre8sTD1WxrusyhsbALjiCgeLxT6jqk4r2YkgAeUUdumeoB8U+FqfgUHeef4NO9IhQ99wsw==
X-Received: by 2002:a17:906:1b51:: with SMTP id p17mr423098ejg.10.1603471185426;
        Fri, 23 Oct 2020 09:39:45 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c9b0:42da:8135:1fa1])
        by smtp.gmail.com with ESMTPSA id m25sm1020734edp.36.2020.10.23.09.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:39:44 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/9] unop: simplify -(x + C) --> -C - x
Date:   Fri, 23 Oct 2020 18:39:33 +0200
Message-Id: <20201023163939.58359-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023163939.58359-1-luc.vanoostenryck@gmail.com>
References: <20201023163939.58359-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                              | 7 +++++++
 validation/optim/simplify-neg-add-cte.c | 1 -
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index 2750a90512b8..85c8d1d1df1c 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1469,6 +1469,13 @@ static int simplify_unop(struct instruction *insn)
 		break;
 	case OP_NEG:
 		switch (DEF_OPCODE(def, src)) {
+		case OP_ADD:
+			if (!constant(def->src2))
+				break;
+			insn->opcode = OP_SUB;	// -(x + C) --> (-C - x)
+			src = eval_unop(OP_NEG, insn->size, def->src2);
+			use_pseudo(insn, def->src1, &insn->src2);
+			return replace_pseudo(insn, &insn->src1, src);
 		case OP_NEG:		// -(-x) --> x
 			return replace_with_pseudo(insn, def->src);
 		}
diff --git a/validation/optim/simplify-neg-add-cte.c b/validation/optim/simplify-neg-add-cte.c
index 4e425096a489..a02c474fa25a 100644
--- a/validation/optim/simplify-neg-add-cte.c
+++ b/validation/optim/simplify-neg-add-cte.c
@@ -5,7 +5,6 @@ int foo(int x) { return -(x + C) == (-3 - x); }
 /*
  * check-name: simplify-neg-add-cte
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-contains: ret\\..*\\$1
-- 
2.28.0

