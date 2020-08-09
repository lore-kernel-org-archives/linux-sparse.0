Return-Path: <SRS0=O0OO=BT=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068C7C433DF
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 16:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9116206C3
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 16:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPybrYbB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgHIQlS (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 9 Aug 2020 12:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgHIQlQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Aug 2020 12:41:16 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E1CC061756
        for <linux-sparse@vger.kernel.org>; Sun,  9 Aug 2020 09:41:13 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id i6so4727203edy.5
        for <linux-sparse@vger.kernel.org>; Sun, 09 Aug 2020 09:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+JKrzqvrsYPSF8z+ynm4f0nIRxLndAmUnk4WP89ZCv0=;
        b=sPybrYbB6+MNEPVilSAXXdIE+2PhVTPo7vmY5rFx+u/xDYOC5myZKz/ZREmjIFCzSZ
         gUXsR1XwAbbyEGUhMiQS73eiKMyxkY3Ih3X+dSY8qkXw4faydOyHjYvMV3/R5LD12SQi
         dSQS7iezSRaNO3f6st+k3kXFyn6FF9+/LDQjyIl1PsXQDCgNUYgE2M8WWknlejRqZMEI
         SW2qwgntDwqKsBnfFU8CrXMU+j5eoUVVRkENQKAesGAUwbt6KKLd/a4w3tDOP75AizTc
         nBvmoXltiyXPtPn/G+Vr8VX1JFoJZazmdhbxcqenbVOXfF284beMrQuPO1ruSTfzwuzh
         5lcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+JKrzqvrsYPSF8z+ynm4f0nIRxLndAmUnk4WP89ZCv0=;
        b=dlHpUPlBcCgTpODeug+kkFrYKHp1wfx0qqYKfi58dLe0dauJWHOoC4XiGZXsD9ZTZC
         yQpDgPcd8rW74njiPyWp9jZrSeB5qyxPpI6PP2eNiG1zOEo61Xe5gTPhN452JmJDYsF4
         knM1BIQVEZ1K9uY/NaY+G7ocE7LXu9U+h5kQQg1pyd0EJyF7P8oDuXscqk1lV/1Y7cjm
         TdWYuFBI1g+x+M4SBqacilJXVAk1B6JPD6UmsissCdS9AdcThPZhJP0Rqa7s9I/IJWF1
         qW6VxRBcci76GyN9DP8Kn0jl2Za28AVVvpXIwB+1qpwx9/jJRHB6fpIQXRFBtNyBCdQI
         6oHg==
X-Gm-Message-State: AOAM533/YWG1OlPYhjdC+UTabBJS8ALlsYZgHkZo+R2RjGdwhYyqfhKF
        Ac5ZQappiOtr2WWqT6NqVTweem1B
X-Google-Smtp-Source: ABdhPJx3rm5OntJ4G+lJDqudaFpTsFeSmRUGkqPlTkxtTC8ijvaP47sBhxIz7F2G4qy8DIHelCWJcw==
X-Received: by 2002:a05:6402:a5b:: with SMTP id bt27mr18023872edb.120.1596991272202;
        Sun, 09 Aug 2020 09:41:12 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:79f2:f43a:7be8:9ec8])
        by smtp.gmail.com with ESMTPSA id bd13sm10194032edb.38.2020.08.09.09.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 09:41:11 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] force to 0 expressions which are erroneously non-constant
Date:   Sun,  9 Aug 2020 18:41:05 +0200
Message-Id: <20200809164105.36446-1-luc.vanoostenryck@gmail.com>
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

