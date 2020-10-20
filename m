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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A29C388F2
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B4772237B
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Npg65Whk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438673AbgJTVKk (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 20 Oct 2020 17:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438672AbgJTVKh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Oct 2020 17:10:37 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25854C0613D4
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:36 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id z5so4852571ejw.7
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nVl0dVv/acwHg4/sH+SKrAAhgej3MkYutdcwvImwICY=;
        b=Npg65WhkGWeh0PryVbVZAlT+nB5Lh0t1Q4tayM27i4XOwx6NrdsfgEOnurkT38XBUq
         C9UCIRfM6DuxuXjRyQOwNPwZc1Ko+dO8WcgISDCHHC6xILb3H4/WIsb0XBTM/ZJaVN/A
         Ig0BfjwLzdb8IkiUZg/bQ5+YMcsBPtM41H/mGs+77BK7RYk4Rr3rxTx/RUbkPcU5RjN2
         KmYfn3Rjl2SooiuYiKwXapBIsIb7/YhuYJbCirUf9hr7R2g42WTdcAIu+5yCR+Ce9icB
         1aEgiu/mN2iUdTKDRmJMA2Xil5pfBXPY4+eW/vIs3Yq4Af1dSIh222vw3ubEFkU0hhCw
         7qWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nVl0dVv/acwHg4/sH+SKrAAhgej3MkYutdcwvImwICY=;
        b=IJRTB19+B8z5ghHxWV6/t0yTHGy5AU4058TD+R9ijreobgKGp3vIsIb52pWiFU9LNT
         nMj4vK0/ErQ5nwfnH4/VkNLyUFKThu9l2b5RSn20qo8+e8eXSmVca3lNAdpnFbYssYco
         3L3+7WNHgkRg2VzdISVPYgk9/zxn7MYF2R6WfNHL0nPHFuPFxagB1Ax4+PIF6Q3Sf+LF
         RQMRxpwwjoOTI33C/fwDOdUp+nA6AruuWqb/cn9GzYdkqdTWCyjXrgQFCUhN1G5zCHKd
         wuH10Euv2bj2KDK7xNvDLdzsSdUBOONh5lEqRTI9cDzf7TL7/+HSbhW4eC3RGSwrdzi8
         i5tw==
X-Gm-Message-State: AOAM530hR//tdfQnMTJlDZWDPM3n3CdUJx2BM/462rIjWgAez4KOPXeY
        M9Tk52cqJfA89R9E2uA1hx1ZyaznwKI=
X-Google-Smtp-Source: ABdhPJxmltvqU0mhZJCdnUObJAK+tj/xXCUS0UY5OOYIMHdk94Un8wl/10O5ful8RCa8kDk4hpf5uA==
X-Received: by 2002:a17:906:4b0f:: with SMTP id y15mr115203eju.198.1603228234631;
        Tue, 20 Oct 2020 14:10:34 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:85fe:66cb:a92b:c664])
        by smtp.gmail.com with ESMTPSA id d12sm4012848ejt.105.2020.10.20.14.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 14:10:34 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 12/22] sub: simplify C - (D - z) --> z + eval(C-D)
Date:   Tue, 20 Oct 2020 23:10:11 +0200
Message-Id: <20201020211021.82394-13-luc.vanoostenryck@gmail.com>
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
 simplify.c                               | 8 ++++++++
 validation/optim/simplify-cte-sub-subr.c | 1 -
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index b97354bc40cc..7d1897e65b07 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1169,6 +1169,14 @@ static int simplify_const_leftsub(struct instruction *insn, struct instruction *
 			return replace_pseudo(insn, &insn->src2, def->src1);
 		}
 		break;
+	case OP_SUB:
+		if (constant(def->src1)) { // C - (D - z) --> z + eval(C-D)
+			pseudo_t val = eval_op(OP_SUB, size, src1, def->src1);
+			insn->opcode = OP_ADD;
+			use_pseudo(insn, def->src2, &insn->src1);
+			return replace_pseudo(insn, &insn->src2, val);
+		}
+		break;
 	}
 	return 0;
 }
diff --git a/validation/optim/simplify-cte-sub-subr.c b/validation/optim/simplify-cte-sub-subr.c
index 950b233e60c3..10fdbbc82933 100644
--- a/validation/optim/simplify-cte-sub-subr.c
+++ b/validation/optim/simplify-cte-sub-subr.c
@@ -3,7 +3,6 @@ int cte_sub_subr(int x) { return 1 - (1 - x); }
 /*
  * check-name: simplify-cte-sub-subr
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-contains: ret\\..* %arg1
-- 
2.28.0

