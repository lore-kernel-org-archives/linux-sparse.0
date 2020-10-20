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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD69C54FB2
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDF58222C8
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uk/zpIWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438666AbgJTVKe (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 20 Oct 2020 17:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438663AbgJTVKe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Oct 2020 17:10:34 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDA9C0613D3
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:33 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id z5so4852432ejw.7
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1hkU/TsYSEZAVvKboZ6K8XEVOVLU+DlbaodNM+SOl0U=;
        b=uk/zpIWevhVgL6uWCNe5IOYWRZq20oBWIuftR2rY3gUNhN0PnKwyNAsv4zmmBZwLcz
         VOOZuPaYGXBEm+hnCz2JGuiMifLzhcbQ10gvS8k2F/waTTPfVFXl9GchJhhmPIEVTijl
         ir2X8c5vumDIT64X17GrWyIEZ/29RRXgp2Fdoci4H2oML8EOoVRH6oEVAChTrOiD8RSB
         Sg+1r3lw9Ta6PbE5Kl9Jmet9rzTZgbJjxse12A3djLJBpALu0EJ9ANjWlsq8oK31xaYF
         ExeSo8N+ys6GCbrrDndub487OUnzDIuB5n8TkgWEn5d0pWcezcH9+xzzHQ7NnZtt3VZy
         Km/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1hkU/TsYSEZAVvKboZ6K8XEVOVLU+DlbaodNM+SOl0U=;
        b=UtKfYJBiMBIHwe9i/wy214R/SzSvfekuwJYQlIEsqjbZLBu4gh2d5KV0XST90hw7a+
         wmv/RzIHS+sDqYu8BVz8eUlp1EBzMgFQ6jyjZxt333kD+EmQN46n7xmzBb+Sxu4js/o+
         nU8WtY+0xBcG9Xn5CThDo/vbrEXhA1Yp6PNUyanpTDpCT6clbngN3pbHT4g8svmd4bAP
         v6XmX6qV3Ut2GPW/BfNNpAAOjo1R0OuuPi/hXdHgDbirdu0LNsLAaKA5Lxz26eAQEATP
         9IobPtQKpE4acJ8gSKO8x0V48uyPFShbRsMOqvBXk17OPbKE5D2m1ttu9iYyQ7/0QavV
         FnnQ==
X-Gm-Message-State: AOAM531qejahUvGku/TzskUnRPj8nMpP6Qn9V1xhzPrsPM6TyfrLpDyR
        kGZ9E5mcDDYSewcM8JEV5jalzYckPAY=
X-Google-Smtp-Source: ABdhPJz/fDU1zz/uRNgdHtkisyVXEeOZiiTZcmV2OWaEx1wxNAvCSllStNQrnc9x36ZBPMD199hXkQ==
X-Received: by 2002:a17:906:3748:: with SMTP id e8mr96699ejc.31.1603228232225;
        Tue, 20 Oct 2020 14:10:32 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:85fe:66cb:a92b:c664])
        by smtp.gmail.com with ESMTPSA id d12sm4012848ejt.105.2020.10.20.14.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 14:10:31 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 09/22] sub: reorganize handling of OP_{ADD,SUB}s with constant rightside
Date:   Tue, 20 Oct 2020 23:10:08 +0200
Message-Id: <20201020211021.82394-10-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020211021.82394-1-luc.vanoostenryck@gmail.com>
References: <20201020211021.82394-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This is a preparatory step for more interesting changes later.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/simplify.c b/simplify.c
index b14f88405861..f837b003efd4 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1101,6 +1101,7 @@ static int simplify_constant_rightside(struct instruction *insn)
 	long long value = insn->src2->value;
 	long long sbit = 1ULL << (insn->size - 1);
 	long long bits = sbit | (sbit - 1);
+	int changed = 0;
 
 	switch (insn->opcode) {
 	case OP_OR:
@@ -1113,20 +1114,21 @@ static int simplify_constant_rightside(struct instruction *insn)
 			insn->opcode = OP_NOT;
 			return REPEAT_CSE;
 		}
-		goto case_neutral_zero;
+		/* fallthrough */
+	case_neutral_zero:
+		if (!value)
+			return replace_with_pseudo(insn, insn->src1);
+		return 0;
 
 	case OP_SUB:
-		if (value) {
-			insn->opcode = OP_ADD;
-			insn->src2 = eval_unop(OP_NEG, insn->size, insn->src2);
-			return REPEAT_CSE;
-		}
-	/* Fall through */
+		insn->opcode = OP_ADD;
+		insn->src2 = eval_unop(OP_NEG, insn->size, insn->src2);
+		changed = REPEAT_CSE;
+		/* fallthrough */
 	case OP_ADD:
-	case_neutral_zero:
 		if (!value)
 			return replace_with_pseudo(insn, insn->src1);
-		return 0;
+		return changed;
 	case OP_ASR:
 	case OP_SHL:
 	case OP_LSR:
-- 
2.28.0

