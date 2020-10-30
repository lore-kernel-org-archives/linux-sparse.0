Return-Path: <SRS0=2q2/=EF=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836E2C00A89
	for <linux-sparse@archiver.kernel.org>; Fri, 30 Oct 2020 16:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20A2020727
	for <linux-sparse@archiver.kernel.org>; Fri, 30 Oct 2020 16:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVnRb+Np"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgJ3QgS (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 30 Oct 2020 12:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgJ3QgS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 30 Oct 2020 12:36:18 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF86C0613D2
        for <linux-sparse@vger.kernel.org>; Fri, 30 Oct 2020 09:36:18 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id dg9so7255642edb.12
        for <linux-sparse@vger.kernel.org>; Fri, 30 Oct 2020 09:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HQ8orL5201FjNF+5jLNI3rvBs6oSRVaZ22RPG6fUna4=;
        b=NVnRb+NpEBJkChfD8eD9kALL2sIT4nhU1/b6LHREgSHOJvXMJAkFe/5sXhNvg5rDYn
         NW0YjzpeZcZxCfEb2bm/js/EBEGRlSPboGRmK/wX/Y7agvk5/o3SICQBPnVgBnhsTBVQ
         KB++f3fLFZrkucOv2RZ/c6+LmxovYSht/S5gVmIOwXdeH+tcwUqXbxTTTblt2L/yfZZ5
         A0UGPsxco6SZmVZVXjm/d+ZZNVws4BTeZk5nkE1dp6Ya4jhmXKsvjZtGYeZeNspEsgS0
         nHTQ881CDdtV4kaDDYhzaVJv+4FZLsi6lXS+N56k492Cm2jVkrppNA2ZrnLaCHP0kfif
         CThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HQ8orL5201FjNF+5jLNI3rvBs6oSRVaZ22RPG6fUna4=;
        b=lEYQG7LVudLRZYrC0NqVlulgEC5cyYN8DgfozMWA62UQjII1ZQmrf/Vy/4NkD8OH4r
         JjBEMTzfghmFZnEUjjulXUsMRPqQHwnE4uDoqRDEjuuidtaIoprrpKOnREt2M1DVq+As
         GKiQ7FkoTd+htsPA7RfOvdigQgfGiQwQ/9Olq9Bl9tbFeIKe5A5NvFeULVS7X5FMp0Zj
         8j3o2NI0FDWkrCHGzomNzYqY/Za4roDVLFS0lg7QUNkYyjrSRkhkYCAu5XNTYw3mhX55
         WxKo5aw+tk7ICMWqRsK8A2nkdIOzlqCV3h5VZHywQLlaK5a69LIsTSLkYoY5J0F/6+k4
         iaCg==
X-Gm-Message-State: AOAM531rWc8D/+CvKvNoXc0r6+i6soLueQtlrnzINKrn/yTVC1guMKeZ
        h2xdFsX5EF1bHRVNUoC/XkkwODZQL/I=
X-Google-Smtp-Source: ABdhPJz5PFOKALaXB5fY6ZStcVMGcl5SIqZEvMnaAFlKYEU5aGKCMxKzsCoVWiRKZl6AJTIBgWzcXg==
X-Received: by 2002:a50:e041:: with SMTP id g1mr3405132edl.385.1604075776700;
        Fri, 30 Oct 2020 09:36:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:d903:f0ee:996c:c255])
        by smtp.gmail.com with ESMTPSA id y12sm3277498ede.82.2020.10.30.09.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 09:36:15 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] linearize __builtin_isdigit()
Date:   Fri, 30 Oct 2020 17:36:05 +0100
Message-Id: <20201030163605.20165-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

As an experiment about the linearization of builtins,
try this easy one (and statically expand it if the
argument is constant).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c   | 21 +++++++++++++++++++++
 linearize.c | 22 ++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/builtin.c b/builtin.c
index acc49871644c..5c7321cad3e4 100644
--- a/builtin.c
+++ b/builtin.c
@@ -305,6 +305,26 @@ static struct symbol_op fp_unop_op = {
 };
 
 
+static int expand_isdigit(struct expression *expr, int cost)
+{
+	struct expression *arg = first_expression(expr->args);
+	long long val = get_expression_value_silent(arg);
+
+	if (cost)
+		return cost;
+
+	expr->value = (val >= '0') && (val <= '9');
+	expr->type = EXPR_VALUE;
+	expr->taint = 0;
+	return 0;
+}
+
+static struct symbol_op isdigit_op = {
+	.evaluate = evaluate_pure_unop,
+	.expand = expand_isdigit,
+};
+
+
 static int evaluate_overflow_gen(struct expression *expr, int ptr)
 {
 	struct expression *arg;
@@ -552,6 +572,7 @@ static const struct builtin_fn builtins_common[] = {
 	{ "__builtin_inf", &double_ctype, 0 },
 	{ "__builtin_inff", &float_ctype, 0 },
 	{ "__builtin_infl", &ldouble_ctype, 0 },
+	{ "__builtin_isdigit", &int_ctype, 0, { &int_ctype }, .op = &isdigit_op },
 	{ "__builtin_isfinite", &int_ctype, 1, .op = &fp_unop_op },
 	{ "__builtin_isgreater", &int_ctype, 0, { &float_ctype, &float_ctype }},
 	{ "__builtin_isgreaterequal", &int_ctype, 0, { &float_ctype, &float_ctype }},
diff --git a/linearize.c b/linearize.c
index bf9b6ecdc92e..b74651765f6c 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2602,6 +2602,27 @@ static pseudo_t linearize_fma(struct entrypoint *ep, struct expression *expr)
 	return insn->target = alloc_pseudo(insn);
 }
 
+static pseudo_t linearize_isdigit(struct entrypoint *ep, struct expression *expr)
+{
+	struct instruction *insn;
+	pseudo_t src;
+
+	insn = alloc_typed_instruction(OP_SUB, &int_ctype);
+	src = linearize_expression(ep, first_expression(expr->args));
+	use_pseudo(insn, src, &insn->src1);
+	insn->src2 = value_pseudo('0');
+	src = insn->target = alloc_pseudo(insn);
+	add_one_insn(ep, insn);
+
+	insn = alloc_typed_instruction(OP_SET_BE, &int_ctype);
+	use_pseudo(insn, src, &insn->src1);
+	insn->src2 = value_pseudo(9);
+	insn->target = alloc_pseudo(insn);
+	add_one_insn(ep, insn);
+
+	return insn->target;
+}
+
 static pseudo_t linearize_unreachable(struct entrypoint *ep, struct expression *exp)
 {
 	add_unreachable(ep);
@@ -2617,6 +2638,7 @@ static struct sym_init {
 	{ "__builtin_fma", linearize_fma },
 	{ "__builtin_fmaf", linearize_fma },
 	{ "__builtin_fmal", linearize_fma },
+	{ "__builtin_isdigit", linearize_isdigit },
 	{ "__builtin_unreachable", linearize_unreachable },
 	{ }
 };
-- 
2.29.1

