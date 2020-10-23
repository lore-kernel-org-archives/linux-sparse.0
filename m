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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80995C4363A
	for <linux-sparse@archiver.kernel.org>; Fri, 23 Oct 2020 16:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 282C1208C3
	for <linux-sparse@archiver.kernel.org>; Fri, 23 Oct 2020 16:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikkYl3+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465904AbgJWQjv (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 23 Oct 2020 12:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751741AbgJWQjv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 23 Oct 2020 12:39:51 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8F1C0613CE
        for <linux-sparse@vger.kernel.org>; Fri, 23 Oct 2020 09:39:51 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id k3so3224571ejj.10
        for <linux-sparse@vger.kernel.org>; Fri, 23 Oct 2020 09:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/YfF+nagDl8WGlG91VQCc+IdLALuCWQudt+ov9k+Mr0=;
        b=ikkYl3+RVrFEJ5ZAlVfJwOJwL4ilt+lXS7u/g0xgOp7tj3lLaT+jB9mTmVxk5BmiBD
         iZNbwP/7b+qbLKzaOwXQUW/CrFcXoBYVD0iNtqxhfIkW1UpGXd77XbXBR52WDOB/th/O
         t2FWvBby8Y73kyk0FDe0pDuGprK6Z/GLNz0g4/PSvsbY7v/CyOnMnm8qQcLqOcUmJmpK
         6s32bpdYWns+aNYm7jqbiHdf0cDhkf2DTf63O9uOUieTTLEYpl/5Dd3glwMGQoE0Edi+
         6PLqgsr4skHX++Dkc6ZRtPkrN8NCI+KgtZhsI3KmXODaJX8OVGecNKZ9kRaOo20HHnBI
         W1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/YfF+nagDl8WGlG91VQCc+IdLALuCWQudt+ov9k+Mr0=;
        b=Y7OJchRF8BqDKw1QAfHqiWur4RC4hdR3laxyv2dYNIddaBi60d0AP5TNZ10hrJd28+
         RC5/8xT5Eomdz2KdK+0eJeWIvV9GpPGkvPRKcE3948EES+4aQGTHUePIYzo885HUij7S
         b2sRaucLcMOrNFZ2jAyO+QcS+CyrFn/tg6nbLsWFa9oBgGa1gxSeI+ZV5X+SRdoqud5J
         ljOBXwoQT1FvFxRJ7eaplcRNo9Xt6hoIq5UVRq1ZHHDcDkrHo1M4FiyUNDN1Ty1vufT3
         qJLcDBVz/LJGJ7UZoA6dD2qfwNzBMpIEbA9pqzOHEQiUZtLl7pO3kjYhwgAsLgs+O5MV
         rK3w==
X-Gm-Message-State: AOAM530S6N5Bx8wVFk0tB1bYk36qLrL3KiL0GxbXWHDS2rfCn4gYt77J
        4wgTWuWDtfM4W80LcMl3EJlYngejIx0=
X-Google-Smtp-Source: ABdhPJwz6AsmD/0H/tAOGob2wxxt2ydhXmlQPhwazu85BnOraeumpGGGv4GWh/s1Lv19M09zcsNtmA==
X-Received: by 2002:a17:906:1494:: with SMTP id x20mr2725035ejc.339.1603471189606;
        Fri, 23 Oct 2020 09:39:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c9b0:42da:8135:1fa1])
        by smtp.gmail.com with ESMTPSA id m25sm1020734edp.36.2020.10.23.09.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:39:49 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 7/9] unop: simplify ~(C - x) --> x + ~C
Date:   Fri, 23 Oct 2020 18:39:37 +0200
Message-Id: <20201023163939.58359-8-luc.vanoostenryck@gmail.com>
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
 simplify.c                              | 6 ++++++
 validation/optim/simplify-not-sub-cte.c | 1 -
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index 63431b3d00b1..8173777652af 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1472,6 +1472,12 @@ static int simplify_unop(struct instruction *insn)
 			return replace_pseudo(insn, &insn->src1, src);
 		case OP_NOT:		// ~(~x) --> x
 			return replace_with_pseudo(insn, def->src);
+		case OP_SUB:
+			if (!constant(def->src1))
+				break;
+			insn->opcode = OP_ADD;	// ~(C - x) --> x + ~C
+			insn->src2 = eval_unop(OP_NOT, insn->size, def->src1);
+			return replace_pseudo(insn, &insn->src1, def->src2);
 		}
 		break;
 	case OP_NEG:
diff --git a/validation/optim/simplify-not-sub-cte.c b/validation/optim/simplify-not-sub-cte.c
index ec105beb31fe..1ea73ece2e27 100644
--- a/validation/optim/simplify-not-sub-cte.c
+++ b/validation/optim/simplify-not-sub-cte.c
@@ -5,7 +5,6 @@ int foo(int x) { return ~(C - x) == (x + ~C); }
 /*
  * check-name: simplify-not-sub-cte
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-contains: ret\\..*\\$1
-- 
2.28.0

