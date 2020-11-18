Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A49EC6379D
	for <linux-sparse@archiver.kernel.org>; Wed, 18 Nov 2020 21:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01B77246B0
	for <linux-sparse@archiver.kernel.org>; Wed, 18 Nov 2020 21:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwBUi1N3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgKRVL6 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 18 Nov 2020 16:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgKRVL6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 18 Nov 2020 16:11:58 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F236CC0613D4
        for <linux-sparse@vger.kernel.org>; Wed, 18 Nov 2020 13:11:57 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id o21so4784691ejb.3
        for <linux-sparse@vger.kernel.org>; Wed, 18 Nov 2020 13:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JY+fyPbOOZovKigCiTDcuZXpZAz76HCmg1MDGlFGtxw=;
        b=mwBUi1N3iztb7dM5AQyuARoCg6vYwQtdrjhrJeKUnbHhebJVwedlXZfgiCbGP+toe6
         z9OAteiesiK+mJPnCGKgRjjcilfzPK0n1iw8GE9quauyDjoUqguiZZ3LTBZvSiWrml8l
         Mbqip/23iqIzfBfGp4rpyCGX1HvNRfJluzW7BbgEgvQYMvfS9/VqZhz59pI7bRoy1Uwr
         Dg6oM/KIKCQEO4GkfX+I1OYfex7AOEF/kSm4NXNgiGdPRgPvdKNdAiU0SIb2MgQCkrBv
         fsRsmVzFwtuPyqjvoYom3yeqKbf6etiSw6AKpFiGsFsytwECejx2s7JZeUOGkF9wl/xy
         9hPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JY+fyPbOOZovKigCiTDcuZXpZAz76HCmg1MDGlFGtxw=;
        b=MXxYEeVzOKD1eqhEEtOnuuuqmRAqAyrB5RBPYUhpRb6Gahorf2616TNbvRBvXt04bv
         kbt21Qp1yt//JH4fbKY6fl2DR7PNfqayD0qK6TOgTA67MW/qqOThG256rcGAIxDMySQT
         3LoXRI01fB2nU30xqQx7LzZLoFoPqqPbvE8Gs1n6aRlMXIsLJRWBNqKobHJnv/NZ7dgk
         pkrZ1f2XukAO798T49ECTpjqu+xDAGk2XuG4H5CmF+27BzB3U13XOdHp5Rhgf6Myyngl
         bi9rygUPnWTAegEQPklyYZDFyEM68oiGwLAN1xXscgknHBGWHXpwoOhYx59pceP9hOfB
         FdXQ==
X-Gm-Message-State: AOAM532DuIxlSEQKMGU1xgVEyTEhVpcOpRKx9Qzr+y7jO5RFN16qy3vm
        kdHxKbHJq/6ojWXuOMfuhiQ7O2+XpUs=
X-Google-Smtp-Source: ABdhPJz69t4YqMoZx/QaaI8SRHYJQtINyHpzW9Gqlg7C6awrUdH6VMX+HwJs1j0oswVr9rJCTobVXw==
X-Received: by 2002:a17:906:2a4b:: with SMTP id k11mr26839131eje.467.1605733916487;
        Wed, 18 Nov 2020 13:11:56 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:491a:3e51:301b:6e24])
        by smtp.gmail.com with ESMTPSA id rp13sm13510712ejb.79.2020.11.18.13.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 13:11:55 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/5] unqual: pre- & post-increment/decrement should *not* drop qualifiers
Date:   Wed, 18 Nov 2020 22:11:47 +0100
Message-Id: <20201118211147.10680-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118211147.10680-1-luc.vanoostenryck@gmail.com>
References: <20201118211147.10680-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Increment and decrement expressions are not subjected to lvalue-conversion
and thus should *not* drop qualifiers.

However, while the lvalue-conversion is not done, the qualifiers
are dropped because the type used for the result is the one returned
by classify_type() which always return the base type.

Fix this by using the type of the operand as the result type.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                      | 3 +--
 validation/eval/unqual-postop.c | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 48ce61f0302d..8599fcee6875 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1935,8 +1935,7 @@ static struct symbol *evaluate_postop(struct expression *expr)
 	if (multiply) {
 		evaluate_assign_to(op, op->ctype);
 		expr->op_value = multiply;
-		expr->ctype = ctype;
-		return ctype;
+		return expr->ctype = op->ctype;
 	}
 
 	expression_error(expr, "bad argument type for ++/--");
diff --git a/validation/eval/unqual-postop.c b/validation/eval/unqual-postop.c
index fb3082dc8836..48b6be8b8508 100644
--- a/validation/eval/unqual-postop.c
+++ b/validation/eval/unqual-postop.c
@@ -10,7 +10,6 @@ static void test_volatile(void)
 /*
  * check-name: unqual-postop
  * check-command: sparse -Wno-declaration-after-statement $file
- * check-known-to-fail
  *
  * check-error-start
 eval/unqual-postop.c:6:40: warning: incorrect type in assignment (different modifiers)
-- 
2.29.2

