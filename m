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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6783AC388F9
	for <linux-sparse@archiver.kernel.org>; Fri, 23 Oct 2020 16:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 021A0206B5
	for <linux-sparse@archiver.kernel.org>; Fri, 23 Oct 2020 16:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rk/nA16d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752215AbgJWQju (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 23 Oct 2020 12:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751741AbgJWQju (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 23 Oct 2020 12:39:50 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2642CC0613CE
        for <linux-sparse@vger.kernel.org>; Fri, 23 Oct 2020 09:39:50 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p9so3245362eji.4
        for <linux-sparse@vger.kernel.org>; Fri, 23 Oct 2020 09:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x7+yEzfQGW9uY/sbesjKEzysE3F/TvZs1Jh+KWTzpv8=;
        b=rk/nA16dCgBKin/c0peyxmhntbBRZINQZ2Ll3+FsvdNh5e8YKfJ1ebySMD6qWTqk8x
         DxJ+j90rms97Pkj44fXJbGWhHzo6qY8Da9GKhny9IIy7mM37vp8x0A+lM3NM8A8vXHil
         5iY2B31WbsClMRDXDEmN+Fu900kQNYfs4OqTUXz8+N3RwrwniKzzQmBCBMqZHBd5iXxu
         w/02R2Z3HHTTLdTrjL84VM2vvjV0VXnFk07ADfBozg8YkYE82oRanSpf2b4gd7jpIrdR
         ZHNoVMeFMu9mmPnO53TOB/e8pNLzFvb2pFWQIseiUm1GQ0Lhx1HJ9wAX8+nNBrjHd8Z6
         0lNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x7+yEzfQGW9uY/sbesjKEzysE3F/TvZs1Jh+KWTzpv8=;
        b=sxdHDQSv0VsHidTO4cWj/Q8i9GJ+3a9iTWwyuLqQgwrwxvOF4HSAnO49b8nJpQUlJz
         zecF5agN10yZpqrDReEG/EKAgLxyctY5v8MGOzvIJ7EWLAud1E2bSqQM0nw/cS7dERTV
         p1WHxK/XCIeq+TXN8xzYv/7DfafQwNPloFvfARKFSxeolFdT95GF1NNTUzV6qdHW9OH9
         sNEXwm4zBMK67UJZbVYAmRCBQlteUZHNtT0HJBt/+vCgTEHOaAMWzgAWfVmOZto/pspi
         BGRvdSeGb+LP58tKGK57WDQXbSKVgfTtTme3MUWgq76U7HCUYZWovxfQ3IpMkM5nbQQS
         lUVA==
X-Gm-Message-State: AOAM5311h+GMvea4Zw5VcTCm2sEySJF+jQU+jlohllblQNY70jxXSgPg
        0ruvxJ5VrJrOQmJkP9pS7KD/4d2AkrM=
X-Google-Smtp-Source: ABdhPJx5oChJz/vjvDLj036qrlpnYF0vx3bBQO69B9EwGhCpjNMNeq43W6c+zWeXzBXN/8F9WgwGAw==
X-Received: by 2002:a17:906:30c8:: with SMTP id b8mr3033202ejb.77.1603471188660;
        Fri, 23 Oct 2020 09:39:48 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c9b0:42da:8135:1fa1])
        by smtp.gmail.com with ESMTPSA id m25sm1020734edp.36.2020.10.23.09.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:39:48 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 6/9] unop: simplify ~(x + C) --> ~C - x
Date:   Fri, 23 Oct 2020 18:39:36 +0200
Message-Id: <20201023163939.58359-7-luc.vanoostenryck@gmail.com>
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
 validation/optim/simplify-not-add-cte.c | 1 -
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index 8f6b821dcf8c..63431b3d00b1 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1463,6 +1463,13 @@ static int simplify_unop(struct instruction *insn)
 
 	case OP_NOT:
 		switch (DEF_OPCODE(def, src)) {
+		case OP_ADD:
+			if (!constant(def->src2))
+				break;
+			insn->opcode = OP_SUB;	// ~(x + C) --> ~C - x
+			src = eval_unop(OP_NOT, insn->size, def->src2);
+			use_pseudo(insn, def->src1, &insn->src2);
+			return replace_pseudo(insn, &insn->src1, src);
 		case OP_NOT:		// ~(~x) --> x
 			return replace_with_pseudo(insn, def->src);
 		}
diff --git a/validation/optim/simplify-not-add-cte.c b/validation/optim/simplify-not-add-cte.c
index cf7fe2f27258..6594012b5077 100644
--- a/validation/optim/simplify-not-add-cte.c
+++ b/validation/optim/simplify-not-add-cte.c
@@ -5,7 +5,6 @@ int foo(int x) { return ~(x + C) == (~C - x); }
 /*
  * check-name: simplify-not-add-cte
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-contains: ret\\..*\\$1
-- 
2.28.0

