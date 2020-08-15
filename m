Return-Path: <SRS0=rhKz=BZ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6838CC433E4
	for <linux-sparse@archiver.kernel.org>; Sat, 15 Aug 2020 21:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4128C206B6
	for <linux-sparse@archiver.kernel.org>; Sat, 15 Aug 2020 21:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiFOJTXj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgHOVwN (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgHOVwI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:08 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67381C09B048
        for <linux-sparse@vger.kernel.org>; Sat, 15 Aug 2020 08:28:12 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p24so12943124ejf.13
        for <linux-sparse@vger.kernel.org>; Sat, 15 Aug 2020 08:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jTBPlGckpLgZr6G5fFVFi9pIJh4KjZHk8+baZOaSTkY=;
        b=GiFOJTXjZWfvxmVYqEECDUv6xeaXZsODQ7t2ThXOnLf/bMZb4MnavriAAPD6HiA8RV
         9rFLkmI108INEDoyZGZb/47lD4fTao+T+nj6XM0mrluxlbmxxb+clAU3NnkkOLX46Kta
         gZToj26sAqOLM/SS9HdPRDUnY9uAM2GWpmME3AmbU2lxVhIbkGCH2CmEEM7LmpT/T++N
         2SJ8BuIldw3Gud4NibEANXsEaJTzgSz1M2LmDSG1vyP7rqS3D9dnvnWMcg+I30BT/oxZ
         Y5XJY7pefWuUIAFg1tz1QKqpVIyrlQfOgDRcK3Iwg28DnH54v0OV1Yz63ixPULOab0Tn
         tdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jTBPlGckpLgZr6G5fFVFi9pIJh4KjZHk8+baZOaSTkY=;
        b=EMQvzBwxkjMvV4J9w6puMfEvoXGxWOvShau9kSHgCPhp1lgH4T5Nv0CNJoD4tbqrz5
         Cg0/DBmJG+xjqEeluMbdNhd3g7sMfIzfozwKHwbqn+06HdZkFnw+BmWigmT3lqoXIY7h
         DOFr+xvTVAb059+gYFI/y4FzgWrYaBE+ztYbgv3Kgr4XUrJ8j16zI1hYYyLhZO5YrImf
         W1FT+DQjGRVO9D7oqcTBNrU0QCwrs+sNPPvkwGGM56ZUJB2jGwnaMaXdnIpeZO3CEOVB
         xp+RScpoEOFHApADpRtN6c2XqTiR9M41ownOH4jbqFj5i94tVTojoCmJ/VWd0RIgonI6
         gA7g==
X-Gm-Message-State: AOAM532Xyc62za/QAIyFL37gUvVhcCaHOdZPUyLxjt8xCJhva1oIO2BY
        miIPPHwXUxcxKvt1Td6RlwKSgNVcTYg=
X-Google-Smtp-Source: ABdhPJyaC7uGbfjYd7+nUqle2GeXW5j/+s03qmbFAH9Ry/tioDgXNAFp3YMY4axgiRAVdD+44CNZQQ==
X-Received: by 2002:a17:906:6558:: with SMTP id u24mr7027723ejn.364.1597505290897;
        Sat, 15 Aug 2020 08:28:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:9042:5c68:7405:68b0])
        by smtp.gmail.com with ESMTPSA id o7sm9065091edq.53.2020.08.15.08.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 08:28:10 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/3] union-cast: extract evaluate_compound_literal()
Date:   Sat, 15 Aug 2020 17:28:02 +0200
Message-Id: <20200815152803.2788-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200815152803.2788-1-luc.vanoostenryck@gmail.com>
References: <20200815152803.2788-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

extract evaluate_compound_literal() from evaluate_cast,
in preparation for supporting union casts.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 63a9390b5ee7..0563be939f23 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2948,6 +2948,26 @@ static int cast_flags(struct expression *expr, struct expression *old)
 	return flags;
 }
 
+static struct symbol *evaluate_compound_literal(struct expression *expr, struct expression *source)
+{
+	struct expression *addr = alloc_expression(expr->pos, EXPR_SYMBOL);
+	struct symbol *sym = expr->cast_type;
+
+	sym->initializer = source;
+	evaluate_symbol(sym);
+
+	addr->ctype = &lazy_ptr_ctype;	/* Lazy eval */
+	addr->symbol = sym;
+	if (sym->ctype.modifiers & MOD_TOPLEVEL)
+		addr->flags |= CEF_ADDR;
+
+	expr->type = EXPR_PREOP;
+	expr->op = '*';
+	expr->deref = addr;
+	expr->ctype = sym;
+	return sym;
+}
+
 static struct symbol *evaluate_cast(struct expression *expr)
 {
 	struct expression *source = expr->cast_expression;
@@ -2970,25 +2990,8 @@ static struct symbol *evaluate_cast(struct expression *expr)
 	 * dereferenced as part of a post-fix expression.
 	 * We need to produce an expression that can be dereferenced.
 	 */
-	if (source->type == EXPR_INITIALIZER) {
-		struct symbol *sym = expr->cast_type;
-		struct expression *addr = alloc_expression(expr->pos, EXPR_SYMBOL);
-
-		sym->initializer = source;
-		evaluate_symbol(sym);
-
-		addr->ctype = &lazy_ptr_ctype;	/* Lazy eval */
-		addr->symbol = sym;
-		if (sym->ctype.modifiers & MOD_TOPLEVEL)
-			addr->flags |= CEF_ADDR;
-
-		expr->type = EXPR_PREOP;
-		expr->op = '*';
-		expr->unop = addr;
-		expr->ctype = sym;
-
-		return sym;
-	}
+	if (source->type == EXPR_INITIALIZER)
+		return evaluate_compound_literal(expr, source);
 
 	ctype = examine_symbol_type(expr->cast_type);
 	expr->ctype = ctype;
-- 
2.28.0

