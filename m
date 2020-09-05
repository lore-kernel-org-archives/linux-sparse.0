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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D11DC2D0A7
	for <linux-sparse@archiver.kernel.org>; Sat,  5 Sep 2020 11:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8DC32074B
	for <linux-sparse@archiver.kernel.org>; Sat,  5 Sep 2020 11:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtTfYx/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgIELMc (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 5 Sep 2020 07:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbgIELMW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 5 Sep 2020 07:12:22 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298DAC061247
        for <linux-sparse@vger.kernel.org>; Sat,  5 Sep 2020 04:12:22 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id c8so8386946edv.5
        for <linux-sparse@vger.kernel.org>; Sat, 05 Sep 2020 04:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QO3anLvSeGn6IAwSx7rlCmQM1i8Y1JKz/q4br5mhYZs=;
        b=PtTfYx/4iD1fQbI3/GuLS1JSe8VdUKEc123FKf5+LeCBlpi1pf3BMxMDBFvfKRbZdI
         67IsB/rcYoAmcNpjn1Jdhez49EtgaKQV7PTJTBs0IPH2Mjl271RPbK0rGBoefqxtALlp
         VYrm5Z/x6lzunJK4yhxqhKaGCsI3hX3hgOOefO6N5AuTDUd94DLm5Jo2x9lqY85yuMCP
         E4vaqL1PqjOn7NXogtKxRVhavONKJxtqH3/pOY32/OchNb2ATwThTh8/SSTjczoHDMQX
         0oIXVPFZmRfWk6mMQOMXI5aU+kHdEu0qte9zCE/aY7AB8NOf0JOX9MeMWp9NwX2KbWQG
         L86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QO3anLvSeGn6IAwSx7rlCmQM1i8Y1JKz/q4br5mhYZs=;
        b=IY4snggzyCKdV66r60zoT+5mmwOUe/8AHeNXI2K+iHj7QEyLpIZiBLyVAFlStFJoDr
         3zI7hLTHjhyXQypzbHzxchpxof0Wdc4dwZbQjZxpxbOD87S+N2Kbj1x2sZdS4x0li898
         0aaxl+V1vbvyMv9Mitk5npnrz+20FWNHDp6pEuDcIUelzexWPZeUmPJvljJQPQaYqfAv
         H1ZmSquYh3GFVRgv3ci/+k0RQUr8rKUl7f+EX4mJ3qbseVSIkDydhqMF3aywlsvdJ+bB
         Xq+vknDkJUGxOsIUfySEUV8BIpO8o8blBGGBsg5DfZqzfTGxX0trV+pwurN+qpXGyp6S
         y31A==
X-Gm-Message-State: AOAM5331HMwvWrEE94oiaJ5Nfb3vwhg/zONPabUVA8k2Imu0BxZOs8Ks
        xGiLUuev3QBcrAjANuDdBO6ZrTED5Gs=
X-Google-Smtp-Source: ABdhPJySMvNBh0NhaqaHnDga8QGS33KMU12HWifHJ/qWyYfMHLdD396hiBWvVrrGetBVyQBNYCJkMA==
X-Received: by 2002:a50:f69a:: with SMTP id d26mr12654752edn.21.1599304340539;
        Sat, 05 Sep 2020 04:12:20 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:e1b1:2430:dffc:e425])
        by smtp.gmail.com with ESMTPSA id u15sm8319506edj.69.2020.09.05.04.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 04:12:19 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/4] builtin: teach sparse to linearize __builtin_fma()
Date:   Sat,  5 Sep 2020 13:12:11 +0200
Message-Id: <20200905111211.82199-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200905111211.82199-1-luc.vanoostenryck@gmail.com>
References: <20200905111211.82199-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The support for the linearization of builtins was already
added for __builtin_unreachable() but this builtin has
no arguments and no return value.

So, to complete the experience of builtin linearization,
add the linearization of __builtin_fma().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/linearize.c b/linearize.c
index bf55045bcbce..7157ba511671 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2585,6 +2585,23 @@ struct entrypoint *linearize_symbol(struct symbol *sym)
  * Builtin functions
  */
 
+static pseudo_t linearize_fma(struct entrypoint *ep, struct expression *expr)
+{
+	struct instruction *insn = alloc_typed_instruction(OP_FMA, expr->ctype);
+	struct expression *arg;
+
+	PREPARE_PTR_LIST(expr->args, arg);
+		insn->src1 = linearize_expression(ep, arg);
+		NEXT_PTR_LIST(arg)
+		insn->src2 = linearize_expression(ep, arg);
+		NEXT_PTR_LIST(arg)
+		insn->src3 = linearize_expression(ep, arg);
+	FINISH_PTR_LIST(arg);
+
+	add_one_insn(ep, insn);
+	return insn->target = alloc_pseudo(insn);
+}
+
 static pseudo_t linearize_unreachable(struct entrypoint *ep, struct expression *exp)
 {
 	add_unreachable(ep);
@@ -2597,6 +2614,9 @@ static struct sym_init {
 	struct symbol_op op;
 } builtins_table[] = {
 	// must be declared in builtin.c:declare_builtins[]
+	{ "__builtin_fma", linearize_fma },
+	{ "__builtin_fmaf", linearize_fma },
+	{ "__builtin_fmal", linearize_fma },
 	{ "__builtin_unreachable", linearize_unreachable },
 	{ }
 };
-- 
2.28.0

