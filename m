Return-Path: <SRS0=7JZe=EO=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A075C55178
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 01:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D418920885
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 01:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sMRxzBCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgKHBVe (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 7 Nov 2020 20:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgKHBVe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 7 Nov 2020 20:21:34 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230A6C0613CF
        for <linux-sparse@vger.kernel.org>; Sat,  7 Nov 2020 17:21:34 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id i19so7243186ejx.9
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 17:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kco6E19mF8RD+UzZRN8K70l4NpkdlnSFh1VJKe0zGfI=;
        b=sMRxzBCrnG5BW1k8x2MSWvjkgbAqyfMKZLjEk1khNTqzESK2JUrzNT54vZMm1V7zKy
         9pwHUfeHxpuD7QagMK1kbC7SGk5Mc6jbBpLaPKJbJafLnwUdx0QVZHBtn3YasAjfJQFT
         xDs4+aYIkLney9ONhucVyiJ1QokvYbdn5iNB5XM0Fqn6wQu2eD6mDcNU8+LT1W3v4v57
         9e8KqNtHbaSvp1MiYpV47BJtiV5R/7x6tZaEC+HQ8rbb2JZ4jTlZbp+eBjwblXIHrDVz
         j7EY26ofD3/Pf95HQoDiQ5hEl1t4NbEueGBIButA0wnBx538I3SleO2CHSexujFEmiEF
         o3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kco6E19mF8RD+UzZRN8K70l4NpkdlnSFh1VJKe0zGfI=;
        b=W56NDZ6ZC3BVT+YZ3XvXgOXzb18WzpcSt2T8WuyJ3MJwG8pilaSrPqZ0n91e+42A5w
         gtKnrOWuejba97G+rGYktw84bOVCSNrHfP+utlnWY1Qis8BgF58jd5lc8OeadIALuGDJ
         VhuCOw0OglM7YpPE/7LL7ieOA+7S3dMO/3pcuO98THr9daegCeB+iH3Bhf5GV5GA67wu
         +ceuNE631b2QFeiGDsCMWdtMGgSYxHB7vu4KnGKevqWxvpqj/P5ooG7bp4WSb9hZh+Rd
         MrTJIsaQ3tvkaMcX9FB3w4kNK6uJA8rZof+4uPUnOn2JtOCSZnraB7koftURAG5zekK3
         W+kw==
X-Gm-Message-State: AOAM531Rm4sH5ezJEr/5FHO1GXa42i/xO4GlN3A3B9sYs+Lam6aH33Jt
        MDxJiNGQqeaco9RYZg2Fy+7EcHRX3Y8=
X-Google-Smtp-Source: ABdhPJwFaFqeSNTayGLDcHR4/JfVH/pq1X4605TKl/8Ml7/7J06qPFAezCUurtx3Hao9cZh62RWpsw==
X-Received: by 2002:a17:906:2e4a:: with SMTP id r10mr4770180eji.266.1604798492633;
        Sat, 07 Nov 2020 17:21:32 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:fce6:5cb0:27db:5e8c])
        by smtp.gmail.com with ESMTPSA id u25sm4511426eje.99.2020.11.07.17.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 17:21:32 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 13/16] cmp: canonicalize sext(x) cmpu C (with C >= SMAX)
Date:   Sun,  8 Nov 2020 02:21:23 +0100
Message-Id: <20201108012126.94339-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201108012126.94339-1-luc.vanoostenryck@gmail.com>
References: <20201108011939.94252-1-luc.vanoostenryck@gmail.com>
 <20201108012126.94339-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

A unsigned compare of a sign-extended value against a value
bigger than the original SMAX is equivalent to a signed
compare against 0.

Canonicalize to the signed compare against 0.

Note: ultimately both forms are just a test of the sign bit.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                       | 12 ++++++++++++
 validation/optim/cmp-sext-uimm.c |  1 -
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index a59918697762..8a8b39b81e20 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1149,6 +1149,18 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 			return replace_pseudo(insn, &insn->src1, def->src);
 		}
 		switch (insn->opcode) {
+		case OP_SET_BE:
+			if (value >= sign_bit(osize)) {
+				replace_binop_value(insn, OP_SET_GE, 0);
+				return replace_pseudo(insn, &insn->src1, def->src);
+			}
+			break;
+		case OP_SET_A:
+			if (value >= sign_bit(osize)) {
+				replace_binop_value(insn, OP_SET_LT, 0);
+				return replace_pseudo(insn, &insn->src1, def->src);
+			}
+			break;
 		case OP_SET_LT: case OP_SET_LE:
 			if (value >= sign_bit(osize))
 				return replace_with_value(insn, 1);
diff --git a/validation/optim/cmp-sext-uimm.c b/validation/optim/cmp-sext-uimm.c
index cc89a80694a1..05da042f5030 100644
--- a/validation/optim/cmp-sext-uimm.c
+++ b/validation/optim/cmp-sext-uimm.c
@@ -19,7 +19,6 @@ int sext_gtu_m3(int x) { return (sext(x) > (NEG - 3)) == (x < 0); }
 /*
  * check-name: cmp-sext-uimm
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.29.2

