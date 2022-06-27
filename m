Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D8DC433EF
	for <linux-sparse@archiver.kernel.org>; Mon, 27 Jun 2022 19:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbiF0TGB (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 27 Jun 2022 15:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237731AbiF0TF5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Jun 2022 15:05:57 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE2625CE
        for <linux-sparse@vger.kernel.org>; Mon, 27 Jun 2022 12:05:53 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u15so21089618ejc.10
        for <linux-sparse@vger.kernel.org>; Mon, 27 Jun 2022 12:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TR0QCYW1q5RLAc3Oo9msp5UqgHZzA89aYBB4rMPEmQs=;
        b=gmtagYc0QdlGmWBGix/L6frSpx0D86980PSJuoVtDgsiso94GnnfeO8wdBXyxZ7Pn4
         DYeNzKKVMxfEHps485JwDYZT0/qJYO/iblhrDrOo0rRVDmFc1zHqsfZGPFKfQspa3+4L
         phzBisLrsxUYLcOLiTgI2SwkdtcVcVh2RmthI9z3jym6fDwwAJ4b+ujcGiH93uQYPBDv
         wOsWIYInNJ/bFdAjpOCOy8AVm0yBZcbfklZLPNLBEfNRTyddBOoieVL+7MyXIXhFrp1z
         2i0umPfRow8VM4gM7iJJH5n3A+7MQaTftYWg9AYz4kpmjR30vWMzw9DKBu9W8uGAtKZA
         /qcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TR0QCYW1q5RLAc3Oo9msp5UqgHZzA89aYBB4rMPEmQs=;
        b=IRVdvIWk6t/HVjdLeWUYxMHtpfHBWRulGVew5X8xSVLSPAq4g1jP44E43qY4TFvlkE
         +TY9NA+M0ulB0nec7+umibaA4THdXPkMGNRYC2DBo8KX5OZYZbRoJeFvVlTM4BUqL7bD
         5HDwUY+bupSxnUzmnkzMB10zyAdcTGQGODUpvF5ujBzhIGtvUvsXA8sIVJ3z5PejK9Ry
         7FqMGp8hMcg+PNkzrn5LrIhf1+HXp+ZmAOWD7NbQVlqJks1NVwkxbl+cxoKgsPcHPQi8
         js9n6E3m0jYoSYpuRIg0qFfCcaUgs94SY2lJyPZIRQ5xlCDKgWcG2Sa7SVicYi12xry3
         WV0A==
X-Gm-Message-State: AJIora8I7e3j9f96dZtWWRcddb1Sv9PWAyYCVCgUtklJEdV+S1CGvTAF
        zpgQzB5nW3U5rC3UY5RV6nIjv9xPhLM=
X-Google-Smtp-Source: AGRyM1uEQnvvcvDjqOvZtQ3hhWkE2or1TJ7QKVnauLoAnHFhjcYGX/9Jx7Vrh3e9urJ5gSZFz4MwAA==
X-Received: by 2002:a17:906:c10:b0:6f4:6c70:b00f with SMTP id s16-20020a1709060c1000b006f46c70b00fmr14109130ejf.660.1656356752036;
        Mon, 27 Jun 2022 12:05:52 -0700 (PDT)
Received: from localhost.localdomain (239.125-180-91.adsl-dyn.isp.belgacom.be. [91.180.125.239])
        by smtp.gmail.com with ESMTPSA id p24-20020a170906615800b00709343c0017sm5456776ejl.98.2022.06.27.12.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 12:05:51 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/5] bitwise: early expansion of simple constants
Date:   Mon, 27 Jun 2022 21:05:40 +0200
Message-Id: <20220627190540.13358-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627190540.13358-1-luc.vanoostenryck@gmail.com>
References: <CAHk-=wj8gM8q04v2jS5JGjEdoE2d+B4_nm74xrFjZ77f9YRsbA@mail.gmail.com>
 <20220627190540.13358-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

C has only positive constants: -1 is really an expression,
the unary '-' operator applied to the constant 1. '-1' as
a constant value only exists after the expansion of constant
expressions.

This is rather unfortunate since it inhibits easy testing
of such constants in the evaluation phase, like here for
restricted_value().

So, expand expressions like +CTE, -CTE or ~CTE before
calling restricted_value().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                     | 48 +++++++++++++++++++++++++++++++++-
 validation/bitwise-cast.c      | 13 +++++++++
 validation/bitwise-is-signed.c |  1 -
 3 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index bb8c0caa905a..33cc85c8d40f 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -413,11 +413,56 @@ static struct symbol *bad_expr_type(struct expression *expr)
 	return expr->ctype = &bad_ctype;
 }
 
+static bool expand_simple_constant(struct expression *expr, struct symbol *type)
+{
+	unsigned long long val, mask;
+	struct expression *pre;
+	struct symbol *ctype;
+	unsigned size;
+
+	if (expr->type != EXPR_PREOP)
+		return false;
+	pre = expr->unop;
+	if (pre->type != EXPR_VALUE)
+		return false;
+
+	ctype = pre->ctype;
+	if (!ctype || ctype != type)
+		return false;
+
+	size = ctype->bit_size;
+	if (!size)
+		return false;
+
+	mask = sign_bit(size);
+	switch (expr->op) {
+	case '+':
+		val = pre->value;
+		break;
+	case '-':
+		val = pre->value;
+		if (val == mask && !(ctype->ctype.modifiers & MOD_UNSIGNED))
+			return false;
+		val = -val;
+		break;
+	case '~':
+		val = pre->value;
+		val = ~val;
+		break;
+	default:
+		return false;
+	}
+	expr->op = 0;
+	expr->type = EXPR_VALUE;
+	expr->value = val & bits_mask(size);
+	return true;
+}
+
 static int restricted_value(struct expression *v, struct symbol *type)
 {
 	if (v->type != EXPR_VALUE)
 		return 1;
-	if (v->value != 0 && v->value != bits_mask(type->bit_size))
+	if (v->value != 0 && v->value != bits_mask(v->ctype->bit_size))
 		return 1;
 	return 0;
 }
@@ -1919,6 +1964,7 @@ Normal:
 	if (!(class & TYPE_FLOAT)) {
 		ctype = integer_promotion(ctype);
 		expr->unop = cast_to(expr->unop, ctype);
+		expand_simple_constant(expr, ctype);
 	} else if (expr->op != '~') {
 		/* no conversions needed */
 	} else {
diff --git a/validation/bitwise-cast.c b/validation/bitwise-cast.c
index 1075a3e9410c..01af56c73751 100644
--- a/validation/bitwise-cast.c
+++ b/validation/bitwise-cast.c
@@ -48,6 +48,19 @@ static __be32 bar1(void)
 	return (__be32)0xffffffff;
 }
 
+/* Implicit casts of minus one, legal */
+static __be32 foom(void)
+{
+	__be32 x = -1;
+	return x;
+}
+
+/* Explicit cast of minus one, legal */
+static __be32 barm(void)
+{
+	return (__be32)-1;
+}
+
 /*
  * check-name: conversions to bitwise types
  * check-command: sparse -Wbitwise $file
diff --git a/validation/bitwise-is-signed.c b/validation/bitwise-is-signed.c
index dd9c147173cd..99d16bd20f9b 100644
--- a/validation/bitwise-is-signed.c
+++ b/validation/bitwise-is-signed.c
@@ -15,7 +15,6 @@ int fou(void) { return !is_signed_type(u); }
 /*
  * check-name: bitwise-is-signed
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.36.1

