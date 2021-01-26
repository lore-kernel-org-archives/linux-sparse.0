Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF28BC433DB
	for <linux-sparse@archiver.kernel.org>; Wed, 27 Jan 2021 03:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C10B6206B5
	for <linux-sparse@archiver.kernel.org>; Wed, 27 Jan 2021 03:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbhA0DpD (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727934AbhAZWFT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 26 Jan 2021 17:05:19 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381D6C0613ED
        for <linux-sparse@vger.kernel.org>; Tue, 26 Jan 2021 14:04:39 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a1so18104375wrq.6
        for <linux-sparse@vger.kernel.org>; Tue, 26 Jan 2021 14:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mCp66NLhpBgYgFPO6oStYivRlowXSYjV5YHCs1YAk1U=;
        b=FEdODn3dX3yDorqu/WcXgDOVbqbySwQwso22vwJhzdFj4ke3fx6SUUlYruDEkpK3ac
         QxQLA4kwrKY/IVNfsXeRGmW1ZmzSLjtjQorxSnGWruzNeRg47qnTfqIM7onANq3+RjZp
         rmzc7jlkes1eMBP0nYB7ru0I11oBaZhHIAzRAa7bTEM0U+2XvqLlvODbys0DEwSc2FLt
         wU+iNlMzikdN7EtEX682oGO0Bhs4BbNjod96x5YoBAKd2unyfcnDWCXxu2SMqjRMrHSa
         EjGAQ0o7gs832Bi6iH6imgJjkuxUBUNxqDa6ceyjqc6vy9p4a2RV6UUGCgckc1AKf90R
         Vctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mCp66NLhpBgYgFPO6oStYivRlowXSYjV5YHCs1YAk1U=;
        b=p1UrhO+uDJnY3XUzP0rVPDEaMGKNXdJzs3+GVNZo2SwNRGuHKAyls0lySTXGlD0fiv
         iJDDIpQZyUGnJU5CGNYRlzNxZ+T/GVgGNBJFOKsIRxO9hPOiGCGPHse5xVrmJUtVhqin
         Jwp3OVJwYj5ejCc6HuECXoGoBqRAeRGMWSpknPFomvqw7fab0PkSNyFLghn2vl4bSqWt
         kLeocOSJnBxv20XFfnZBVwN9O4jTXi1E8sELbdwmf5f8fit8UxWXLMvy1rQDxCQ+XyVn
         4FmHdnJcs3qEQTudRVmypjT2s1bweeedKZ0J6IpeWpttYSOuOUOmueVGIBzKe0fYIGX4
         IJJQ==
X-Gm-Message-State: AOAM533X81nqe89xC95bN9OS+eAJwKXhJQlHDAzWHo/jTuzJ++YI19rj
        K0pIneQVr6cPqPrObzdbWzrp2ze0oHo=
X-Google-Smtp-Source: ABdhPJyOX07bwggTUjfVCEjcFsfbJHHpK8obSz0P6meMz0eftgqv2AoL41/T2gCWJnECg1x5h8D0xQ==
X-Received: by 2002:adf:f183:: with SMTP id h3mr8414554wro.30.1611698677982;
        Tue, 26 Jan 2021 14:04:37 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:285a:40db:3257:f0fd])
        by smtp.gmail.com with ESMTPSA id b132sm5268447wmh.21.2021.01.26.14.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 14:04:37 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 01/10] cmps: make clearer we're using the operands' size
Date:   Tue, 26 Jan 2021 23:04:23 +0100
Message-Id: <20210126220432.58265-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126220432.58265-1-luc.vanoostenryck@gmail.com>
References: <20210126220432.58265-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

When handling compares of an {zero,sign}-extended value, the
size of these extended values are used but this size is just
the operands' size of the compares.

Make this clearer by using a single variable 'size' for it.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/simplify.c b/simplify.c
index bf6397dfd582..2f6f41c249dc 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1162,7 +1162,8 @@ static int simplify_seteq_setne(struct instruction *insn, long long value)
 
 static int simplify_compare_constant(struct instruction *insn, long long value)
 {
-	unsigned long long bits = bits_mask(insn->itype->bit_size);
+	unsigned size = insn->itype->bit_size;
+	unsigned long long bits = bits_mask(size);
 	struct instruction *def;
 	pseudo_t src1, src2;
 	unsigned int osize;
@@ -1217,7 +1218,7 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 	switch (DEF_OPCODE(def, src1)) {
 	case OP_SEXT:				// sext(x) cmp C --> x cmp trunc(C)
 		osize = def->orig_type->bit_size;
-		if (is_signed_constant(value, osize, def->size)) {
+		if (is_signed_constant(value, osize, size)) {
 			insn->itype = def->orig_type;
 			insn->src2 = value_pseudo(zero_extend(value, osize));
 			return replace_pseudo(insn, &insn->src1, def->src);
@@ -1263,13 +1264,13 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 		}
 		switch (insn->opcode) {
 		case OP_SET_LT: case OP_SET_LE:
-			if (sign_extend(value, def->size) > (long long)bits)
+			if (sign_extend(value, size) > (long long)bits)
 				return replace_with_value(insn, 1);
 			else
 				return replace_with_value(insn, 0);
 			break;
 		case OP_SET_GE: case OP_SET_GT:
-			if (sign_extend(value, def->size) > (long long)bits)
+			if (sign_extend(value, size) > (long long)bits)
 				return replace_with_value(insn, 0);
 			else
 				return replace_with_value(insn, 1);
-- 
2.30.0

