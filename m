Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27164C43334
	for <linux-sparse@archiver.kernel.org>; Mon, 27 Jun 2022 19:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbiF0TFx (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 27 Jun 2022 15:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbiF0TFw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Jun 2022 15:05:52 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C71C25CE
        for <linux-sparse@vger.kernel.org>; Mon, 27 Jun 2022 12:05:51 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id o9so14388086edt.12
        for <linux-sparse@vger.kernel.org>; Mon, 27 Jun 2022 12:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O0ltlf8Y5LDaNVwRLH9nm1tiZfoBbWKE4JiYzHKpQK4=;
        b=kBw8BUqUEYUzPahOiR8RPORp4URbQ7xey7B4eFIkWlBGaRqiWNqm8XvrO7GmADqAaC
         LNGoDbE6TFhDE6ADmnphubdfRifyNSOLs9eYknxfEwzaqTMtDtt8/ag3AZu9VQvsLn4k
         nzCJbbVkmM3XNN4uas4tRwZaS4v2ZVYeuQIwaRqGUc4brjMWQqDDVbm7L0FSjBvNUFsw
         nXza03JW2dOpYMW+iJ5U1Ch0PjqF+7B1fcu6URS/fGFopF2vQAzeg+GRZ2gBNcllQkwx
         k0mPE4jRYjXDN37VQYJoIKYXkHAl7B9TUIj5xuSwnwyCa0/GFWtDWyyLMlrU88YE8Voo
         68vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O0ltlf8Y5LDaNVwRLH9nm1tiZfoBbWKE4JiYzHKpQK4=;
        b=qWt0biKz4vHxAJEKzzgErU1p8K066ofJIqT7oYj2B/B0S4eT/tjhOaumYayE1KRmI5
         OtqK9q5RrP8hD3RNI6xbGw83sfYUcSXbLatbc4QS3+xGGGNacwxEx7oRz0zjyON2vVSa
         UDY7uhlGLsJgtGs+IH9wUs2CXUbkpfiPoEmDxF8Oo/hTcyVMsjfX5v4YbFcDKyRktmP9
         JkBipgQbRQAY5D8cwA/ty+cAwMl4MWcZQT7pAjNKqdo5uM6vba+nena5pEW45DSiHll2
         KDtbp8MAIfcBN7vQg8MvwGbe1jduGp8nvjjUbNC5tg4qn+v+wi3p2c6dOoGNvNB7Pr5L
         yyJQ==
X-Gm-Message-State: AJIora9GqrHTxMY3VPC4zXGXU2We9hNSXkBo0z9ByBiNRm/c7eScg+Nf
        X66dND5kPiMvn1dV3touJ54kU2dM6dQ=
X-Google-Smtp-Source: AGRyM1skz9TSyel+NHHhZIUbVpCwIuPzpe/soU1iM54SyYLeaQxf7XFfqSwGd14Jh6/LvuYfcGDLwQ==
X-Received: by 2002:a05:6402:430a:b0:435:8ec9:31ec with SMTP id m10-20020a056402430a00b004358ec931ecmr18528842edc.248.1656356749603;
        Mon, 27 Jun 2022 12:05:49 -0700 (PDT)
Received: from localhost.localdomain (239.125-180-91.adsl-dyn.isp.belgacom.be. [91.180.125.239])
        by smtp.gmail.com with ESMTPSA id p24-20020a170906615800b00709343c0017sm5456776ejl.98.2022.06.27.12.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 12:05:49 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/5] bitwise: accept all ones as non-restricted value
Date:   Mon, 27 Jun 2022 21:05:37 +0200
Message-Id: <20220627190540.13358-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627190540.13358-1-luc.vanoostenryck@gmail.com>
References: <CAHk-=wj8gM8q04v2jS5JGjEdoE2d+B4_nm74xrFjZ77f9YRsbA@mail.gmail.com>
 <20220627190540.13358-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Currently, the only value bitwise types can act on is 0
because the this value is anyway invariant for all bitwise
operations and endianness conversions.

But, a bit-pattern of all ones has the same properties and
is also very often used.

So, accept all ones as a valid value for bitwise operations.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                |  2 +-
 validation/bitwise-cast.c | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/evaluate.c b/evaluate.c
index 61f59ee3908e..bcbcdf1ef0cc 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -417,7 +417,7 @@ static int restricted_value(struct expression *v, struct symbol *type)
 {
 	if (v->type != EXPR_VALUE)
 		return 1;
-	if (v->value != 0)
+	if (v->value != 0 && v->value != bits_mask(type->bit_size))
 		return 1;
 	return 0;
 }
diff --git a/validation/bitwise-cast.c b/validation/bitwise-cast.c
index 0583461cb745..1075a3e9410c 100644
--- a/validation/bitwise-cast.c
+++ b/validation/bitwise-cast.c
@@ -35,6 +35,19 @@ static __be32 quuy(void)
 	return (__attribute__((force)) __be32) 1730;
 }
 
+/* Implicit casts of all ones, legal */
+static __be32 foo1(void)
+{
+	__be32 x = 0xffffffff;
+	return x;
+}
+
+/* Explicit cast of all ones, legal */
+static __be32 bar1(void)
+{
+	return (__be32)0xffffffff;
+}
+
 /*
  * check-name: conversions to bitwise types
  * check-command: sparse -Wbitwise $file
-- 
2.36.1

