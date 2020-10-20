Return-Path: <SRS0=cyFV=D3=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A8DC388F2
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C59FA2237B
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hv+94FTB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438678AbgJTVKm (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 20 Oct 2020 17:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438669AbgJTVKm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Oct 2020 17:10:42 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B6CC0613CE
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:41 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id cm24so231465edb.0
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i6FwKg1+QC+r/ssprlJGdvFWepCTp/uMRUnc9NEh0sI=;
        b=Hv+94FTBtUhno1Abq9T9zXsPmKh1/7mfwk+5SjPHBukKYtdR/ceA5/dT/7lhP0jvRE
         Le/tJ7MwNa2SBplqOsPXbPCXAdsFRe+IdFGW+e6Mm8trKUFgwqjygimxXDdq9Iuj0hwH
         Xo0fP+4kdWd+2dHTjGiXQlm9kXYLn4wQfsSRf7+1IPNii1df2w1aAx3X1aFgwKLLAqBF
         ggcYPIQwatAb2e3OAKKvvUu4/EmIObpPAulvjy7tZaFN+OTy7j0ARGw7aMxVhV4YMdLj
         e+ndNxmqjN9lelWz7vhoFmL5PTRzJZOsq9Vj7OfIwJ4EyW3IBGyekwArCzqXLj0f8WyY
         aQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i6FwKg1+QC+r/ssprlJGdvFWepCTp/uMRUnc9NEh0sI=;
        b=SFiBq+Zb6mjZDvWONYod01+Ntnz2Kuv/dLjPUuTd8aZXGtNh5a+EQuXvvtk+6cTQT9
         O2RlIPcl13qg1iADINZ25qKwpjdfI+mBLk6yJUoT0i9uq7LirZTpF/p6se9i9NclaD4H
         n/GBXWSLUlX/RWGH5fMdugbMgXc4U7b2WVGhYIa4sfmzMmOgHx6TGeQKBod2oMP3o741
         HkIsLsAOO3B3cCuymG0P+KjeZQI7tNmsc+hKb0Gi9xBLcYP/DPtZBa8CUaWIh712gGHQ
         4Sc6h2CuJc1vqlJeM8LcLY7Jjbejk4rxDLuMuI07CItNxhvAd2K9TgD0ng46BiwSMYeV
         V8Bw==
X-Gm-Message-State: AOAM533+xij/z271QmMxVwFdXbDkE633Mrtn75RFB07BCCfKAA5C0/6F
        fNxysQpzyZ76ulUi9ACMYHso9LK7qW8=
X-Google-Smtp-Source: ABdhPJx7bzsj3Dry7y49omY4sbvbeU2dxH7mTiLeZTnIlXmo8XhWrKoXMSEliPRrtAEDBBJxp6aSFA==
X-Received: by 2002:aa7:d781:: with SMTP id s1mr4927256edq.102.1603228240237;
        Tue, 20 Oct 2020 14:10:40 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:85fe:66cb:a92b:c664])
        by smtp.gmail.com with ESMTPSA id d12sm4012848ejt.105.2020.10.20.14.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 14:10:39 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 18/22] sub: simplify (x + y) - y --> x
Date:   Tue, 20 Oct 2020 23:10:17 +0200
Message-Id: <20201020211021.82394-19-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020211021.82394-1-luc.vanoostenryck@gmail.com>
References: <20201020211021.82394-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                                | 2 ++
 validation/optim/simplify-same-add-subr.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index cb401d8fac9f..08b706ca8f41 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1390,6 +1390,8 @@ static int simplify_sub(struct instruction *insn)
 	case OP_ADD:
 		if (def->src1 == src2)		// (x + y) - x --> y
 			return replace_with_pseudo(insn, def->src2);
+		if (def->src2 == src2)		// (x + y) - y --> x
+			return replace_with_pseudo(insn, def->src1);
 		break;
 	}
 
diff --git a/validation/optim/simplify-same-add-subr.c b/validation/optim/simplify-same-add-subr.c
index e8540703ee7d..071021c485d7 100644
--- a/validation/optim/simplify-same-add-subr.c
+++ b/validation/optim/simplify-same-add-subr.c
@@ -3,7 +3,6 @@ int add_subr(int x, int y) { return (x + y) - y; }
 /*
  * check-name: simplify-same-add-subr
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-start
 add_subr:
-- 
2.28.0

