Return-Path: <SRS0=ez6N=CO=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F76C433E2
	for <linux-sparse@archiver.kernel.org>; Sat,  5 Sep 2020 12:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 374F320757
	for <linux-sparse@archiver.kernel.org>; Sat,  5 Sep 2020 12:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HS1dHczi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgIEMOJ (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 5 Sep 2020 08:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgIEMOH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 5 Sep 2020 08:14:07 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B5AC061245
        for <linux-sparse@vger.kernel.org>; Sat,  5 Sep 2020 05:14:06 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id z23so11915883ejr.13
        for <linux-sparse@vger.kernel.org>; Sat, 05 Sep 2020 05:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AZY10VfsIy0J98QGDqghhWbMA+gvKEGSsKayEjX4SHE=;
        b=HS1dHcziO5PYqa/iVIWS4ilP+TbHenGoTXmvVW/zR7mSPubuDuKhEfztSUFz2bR7Jr
         j4ohGnOeimdCDNZTNI86F3RiGEyZZg38O0mp18EdJFv8kkr7wvhhtOsQ1qCcHTUlXTms
         jAMGJG0AWXkDuJ54tzZlvHfEasKa0jX8EHgYko0GuUIseJsalBtNzd1fTDXqsezPSndo
         dC8QVkVE9ItCV0d+QCCMfLAZb31xVeYqHM3Mcr5D+ZA7Xgna1ve5aKDY5nUIiz8oGNdu
         EpOPPWnmKR8xiEa2fNuZN0h1rXKE/dloiCmAKn7FNLGK9AXSBSqXsKam5oM7nkk1KBvy
         z6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AZY10VfsIy0J98QGDqghhWbMA+gvKEGSsKayEjX4SHE=;
        b=Gqj+O9VRhG7OgZytkyYwZXE90vWVTbsbBYIyKkk338lI8VDun92DQ3DwqPl+wTi8PP
         DQFhxbPGOrDNsB6+WoT6fih7YhJScmofGnGxW1pcPavT6juvRn3CH/V+rEuQaMJrZ7IR
         kXyjehCIspUhn7sbLcIJVwBNdXSbSwDsDpY9TzaS8cJ8NX9Kl4hB+j/D3MBLVJZ+A31i
         807Xo4pf9+BO6fWM9lLqNcT3KuYlbHQtyuDleob4/IX29igcjJevn/zFrQaaGy1+Sdoa
         7E8HP7L3Qx6NZsxVILQjpcawXDxRLYR6412pcxp4zn7xt5QXhaZ2rkDDXJ+7ryClHdsy
         +ayw==
X-Gm-Message-State: AOAM532dv+GhR4qK0Ta1ui0DykiolXHPjET0g5FcsDdF5pbKx9t+66dz
        BJTSS4EtJWKgYQlTdV8PGpXJVsmELck=
X-Google-Smtp-Source: ABdhPJwZaGg80+ERwcBrXaN0BGujTHDzaCyoSsP3MNrRJUOcibjnl/yLUonDE7Z9/tGcTxlHvHvCdw==
X-Received: by 2002:a17:906:914b:: with SMTP id y11mr12747285ejw.145.1599308044488;
        Sat, 05 Sep 2020 05:14:04 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:e1b1:2430:dffc:e425])
        by smtp.gmail.com with ESMTPSA id k14sm8577412edo.89.2020.09.05.05.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 05:14:04 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/3] use replace_with_value()
Date:   Sat,  5 Sep 2020 14:13:57 +0200
Message-Id: <20200905121358.83080-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200905121358.83080-1-luc.vanoostenryck@gmail.com>
References: <20200905121358.83080-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Replace existing 'replace_with_pseudo(insn, value_pseudo($N))'
by 'replace_with_value($N)'.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/simplify.c b/simplify.c
index 0c75b3fadcab..3c4b972ce607 100644
--- a/simplify.c
+++ b/simplify.c
@@ -838,7 +838,7 @@ static int simplify_shift(struct instruction *insn, pseudo_t pseudo, long long v
 			omask = def->src2->value;
 			nmask = omask & mask;
 			if (nmask == 0)
-				return replace_with_pseudo(insn, value_pseudo(0));
+				return replace_with_value(insn, 0);
 			if (nmask == mask)
 				return replace_pseudo(insn, &insn->src1, def->src1);
 			if (nbr_users(pseudo) > 1)
@@ -874,7 +874,7 @@ static int simplify_shift(struct instruction *insn, pseudo_t pseudo, long long v
 			omask = def->src2->value;
 			nmask = omask & mask;
 			if (nmask == 0)
-				return replace_with_pseudo(insn, value_pseudo(0));
+				return replace_with_value(insn, 0);
 			if (nmask == mask)
 				return replace_pseudo(insn, &insn->src1, def->src1);
 			// do not simplify into ((A << S) & (M << S))
@@ -912,7 +912,7 @@ new_value:
 		return replace_pseudo(insn, &insn->src1, pseudo->def->src1);
 	}
 zero:
-	return replace_with_pseudo(insn, value_pseudo(0));
+	return replace_with_value(insn, 0);
 replace_mask:
 	insn->opcode = OP_AND;
 	insn->src2 = value_pseudo(mask);
@@ -1104,7 +1104,7 @@ static int simplify_constant_rightside(struct instruction *insn)
 
 	case OP_MODU: case OP_MODS:
 		if (value == 1)
-			return replace_with_pseudo(insn, value_pseudo(0));
+			return replace_with_value(insn, 0);
 		return 0;
 
 	case OP_DIVU: case OP_DIVS:
@@ -1167,14 +1167,14 @@ static int simplify_binop_same_args(struct instruction *insn, pseudo_t arg)
 			warning(insn->pos, "self-comparison always evaluates to false");
 	case OP_SUB:
 	case OP_XOR:
-		return replace_with_pseudo(insn, value_pseudo(0));
+		return replace_with_value(insn, 0);
 
 	case OP_SET_EQ:
 	case OP_SET_LE: case OP_SET_GE:
 	case OP_SET_BE: case OP_SET_AE:
 		if (Wtautological_compare)
 			warning(insn->pos, "self-comparison always evaluates to true");
-		return replace_with_pseudo(insn, value_pseudo(1));
+		return replace_with_value(insn, 1);
 
 	case OP_AND:
 	case OP_OR:
@@ -1298,7 +1298,7 @@ static int simplify_constant_unop(struct instruction *insn)
 	mask = 1ULL << (insn->size-1);
 	res &= mask | (mask-1);
 	
-	replace_with_pseudo(insn, value_pseudo(res));
+	replace_with_value(insn, res);
 	return REPEAT_CSE;
 }
 
@@ -1577,7 +1577,7 @@ static int simplify_select(struct instruction *insn)
 	if (cond == src2 && is_zero(src1)) {
 		kill_use(&insn->src1);
 		kill_use(&insn->src3);
-		replace_with_pseudo(insn, value_pseudo(0));
+		replace_with_value(insn, 0);
 		return REPEAT_CSE;
 	}
 	return 0;
-- 
2.28.0

