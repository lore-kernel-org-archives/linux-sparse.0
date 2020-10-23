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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBA6C55179
	for <linux-sparse@archiver.kernel.org>; Fri, 23 Oct 2020 16:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F544206B5
	for <linux-sparse@archiver.kernel.org>; Fri, 23 Oct 2020 16:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaXoP5ty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752500AbgJWQjw (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 23 Oct 2020 12:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751741AbgJWQjw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 23 Oct 2020 12:39:52 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF4DC0613CE
        for <linux-sparse@vger.kernel.org>; Fri, 23 Oct 2020 09:39:51 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id h24so3231512ejg.9
        for <linux-sparse@vger.kernel.org>; Fri, 23 Oct 2020 09:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r9G52Y4rmKBrn/qlgJ6zlmtPEMPdSIzxzyXZbCnQHSU=;
        b=JaXoP5tyB8dYbS4kE2tJ5A67MgS6h1VD5G5Kz0pihlomGL930nao+DWIIh5z98Y2SU
         pU+Eq1ij0YcS44KD/A/DcmIAxSBwTRRx9ruYxMhWCra5CNfdphFWtR9Z3BtFPGBzQqc1
         JwLERZfkSLSjRrZC2bOYBVUorSLpfh+qdjeKeOE7ff5oqIdqo1ps6Ips3rOW72CnflAf
         vfJMhsr+mzlKrNbgjcIl/NSWO4oJZqlXOfOWNKqkUPxBfJYlTJtdZkHGnKKCli3WCVy2
         Xg7MErcVmN3BiiFTWENirJ/s8qqvheQkRUGZvzJGGcLhC1a7q5obhxpIrdBqAjcj+iNk
         k5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r9G52Y4rmKBrn/qlgJ6zlmtPEMPdSIzxzyXZbCnQHSU=;
        b=jl9ku0WtuMOCctYYuyO+tP3Exk6qKQGSKgeqNZ8MN3e3NIIOG4ANHsafkCUmirjs29
         gLPJ7dHWjReZYgbob/oqYHHNr9XgPK7l4GkC2XMnFLF+3mh7u08/jZitPSmjfYILCyaR
         1bNfXxHI/YtzW9BG2XO5c0KvU/sdCluxvyQtHngRo/BFo6N7DO8sfquk3MjV4lMUYVqC
         9PsTQ0aWUiSJe6Ts+SnHWnX8xq4J4E7orP/AeCBFBHrLhaFU8Tyj0UZ1QSm2grcJy3Xa
         bIzDhs9IxP3VzjJnuPyD8XUV2NSmYuRAxHfijjQDY6ktBxhIGd1IMfmZHnCpLp8Z3xlp
         87ew==
X-Gm-Message-State: AOAM533UKnuA1nmfWv96iHj7gCc14DdfmThNm/Zu+fc8Ksj2PxuE7adD
        OtXubd+bc5QHe9NWAEL/ybanU4FMeTA=
X-Google-Smtp-Source: ABdhPJwgsQnTR+yzRPctsPAIS8Y8+cTfMa6wXLSHfPeNxhuE2gR3NryMgTVVBCLh2t5hJPzzH4KYXw==
X-Received: by 2002:a17:906:a0cb:: with SMTP id bh11mr2956166ejb.314.1603471190399;
        Fri, 23 Oct 2020 09:39:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c9b0:42da:8135:1fa1])
        by smtp.gmail.com with ESMTPSA id m25sm1020734edp.36.2020.10.23.09.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:39:49 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 8/9] unop: simplify ~(x ^ C) --> x ^ ~C
Date:   Fri, 23 Oct 2020 18:39:38 +0200
Message-Id: <20201023163939.58359-9-luc.vanoostenryck@gmail.com>
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
 validation/optim/simplify-not-xor-cte.c | 1 -
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index 8173777652af..1b6e1cc2313b 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1478,6 +1478,12 @@ static int simplify_unop(struct instruction *insn)
 			insn->opcode = OP_ADD;	// ~(C - x) --> x + ~C
 			insn->src2 = eval_unop(OP_NOT, insn->size, def->src1);
 			return replace_pseudo(insn, &insn->src1, def->src2);
+		case OP_XOR:
+			if (!constant(def->src2))
+				break;
+			insn->opcode = OP_XOR;	// ~(x ^ C) --> x ^ ~C
+			insn->src2 = eval_unop(OP_NOT, insn->size, def->src2);
+			return replace_pseudo(insn, &insn->src1, def->src1);
 		}
 		break;
 	case OP_NEG:
diff --git a/validation/optim/simplify-not-xor-cte.c b/validation/optim/simplify-not-xor-cte.c
index d3046f208fce..c3c803b30250 100644
--- a/validation/optim/simplify-not-xor-cte.c
+++ b/validation/optim/simplify-not-xor-cte.c
@@ -5,7 +5,6 @@ int foo(int x) { return ~(x ^ C) == (x ^ ~C); }
 /*
  * check-name: simplify-not-xor-cte
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-contains: ret\\..*\\$1
-- 
2.28.0

