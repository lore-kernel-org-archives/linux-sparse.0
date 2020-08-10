Return-Path: <SRS0=DkR5=BU=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC944C433DF
	for <linux-sparse@archiver.kernel.org>; Mon, 10 Aug 2020 05:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A1D420734
	for <linux-sparse@archiver.kernel.org>; Mon, 10 Aug 2020 05:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDAIexsE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbgHJFvI (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 10 Aug 2020 01:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgHJFvH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 10 Aug 2020 01:51:07 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E45C061756
        for <linux-sparse@vger.kernel.org>; Sun,  9 Aug 2020 22:51:07 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a26so8146565ejc.2
        for <linux-sparse@vger.kernel.org>; Sun, 09 Aug 2020 22:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+JKrzqvrsYPSF8z+ynm4f0nIRxLndAmUnk4WP89ZCv0=;
        b=EDAIexsERuO9XrRHCzg6uuEJh72D4OrSZ7fCt7LzGc+awuixmYmzraALCZSERvQOHJ
         vq+gp+qkob2953S2XoOm2igiyHLeCBf/xgKANV655gHON7QCQWsxeqjsbIhthohSCB9n
         U9Cb/6eRSganzdcKHx8LwL/ho7cU0IWa4JvbSUWWrXBsNM2ufeBCkszXIDgW4dhxP4Ja
         UIcz7EFFxOdB4SzqRJxzzrMYFKqruxwmXXfMH3J4aIbVABwkJCVJ0lWHVve1fIVjSMRs
         WDXD04uY3EQ9B1W0I3HarfO0za82YFZjcvb48WW63KZuaUD4Mhle4jjX1XRJLnKY85NW
         AaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+JKrzqvrsYPSF8z+ynm4f0nIRxLndAmUnk4WP89ZCv0=;
        b=e/+F7dUNIpRc9nvE0v+eKp6HCqv6008WkfKRzd+eN+Tg3+QfU5oY93L5cRPbAmFVkN
         +vZ3guwbvsQT3JVvHToJTnFrq/UkjciYxa0z55bRhd3v9C2+vZDliRVgkMfdRP0lKYBu
         Xla6odc1gUEWYtIGiA25MMTNKNbkVo+4J2AtIgxQcth6TSpqsuXlMGgIY9Lt0ddC91wN
         Rt0Kc/BI/rDFNP0YKdxGAjxT6CpsDlp+qB/Ub527grtTy21ii27ZVa5P6KgOn6RZEc0P
         2x3xiYJ98LXjdueaKwbBIPUndWgSG19oT8xo0RUpr6V1t00KBlSjdCjdA9EL1zYBg7HT
         XL8w==
X-Gm-Message-State: AOAM530DCtUDntm0TV1kRsodVGnycx0APdQsFhZvyf0JDCzZT10z6Z0m
        jBCYiWboAG3t56Xyx8QvUnE1IItF
X-Google-Smtp-Source: ABdhPJzPqzDLcs0k4YledQraRO3P+x/uCTilj3Vk67poIHOvR9lCnMFNxDT9LalmjdGMphB4MJZ4jw==
X-Received: by 2002:a17:906:3b83:: with SMTP id u3mr19914452ejf.55.1597038664844;
        Sun, 09 Aug 2020 22:51:04 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:51c4:32a8:154e:2fc3])
        by smtp.gmail.com with ESMTPSA id d23sm12243358ejj.74.2020.08.09.22.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 22:51:03 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] force to 0 expressions which are erroneously non-constant
Date:   Mon, 10 Aug 2020 07:51:03 +0200
Message-Id: <20200810055103.67977-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

When an expression that needs to be constant but is, in fact,
not constant, sparse throws an error and leaves it as-is.
But some code makes the assumption that the expression is
constant and uses its value, with some random result.

One situation where this happens is in code like:
	switch (x) {
	case <some non-const expression>: ...

In this case, the linearization of the switch/case statement
will unconditionally use the value of the case expression
but the expression has no value.

One way to avoid this would be to add defensive checks each
time a value is retrieved but this is a lot of work and time
for no benefits.

So, change this by forcing the expression to be a constant
value of 0 just after the error message has been issued.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 expand.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/expand.c b/expand.c
index 623b180025ad..c4f806dee1ba 100644
--- a/expand.c
+++ b/expand.c
@@ -1177,8 +1177,12 @@ static void expand_const_expression(struct expression *expr, const char *where)
 {
 	if (expr) {
 		expand_expression(expr);
-		if (expr->type != EXPR_VALUE)
+		if (expr->type != EXPR_VALUE) {
 			expression_error(expr, "Expected constant expression in %s", where);
+			expr->ctype = &int_ctype;
+			expr->type = EXPR_VALUE;
+			expr->value = 0;
+		}
 	}
 }
 
-- 
2.28.0

