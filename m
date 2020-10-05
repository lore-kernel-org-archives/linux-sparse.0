Return-Path: <SRS0=4is7=DM=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50E3C4363D
	for <linux-sparse@archiver.kernel.org>; Mon,  5 Oct 2020 23:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 890192083B
	for <linux-sparse@archiver.kernel.org>; Mon,  5 Oct 2020 23:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6I2L2j1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgJEXEM (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 5 Oct 2020 19:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgJEXEK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 5 Oct 2020 19:04:10 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D934C0613A7
        for <linux-sparse@vger.kernel.org>; Mon,  5 Oct 2020 16:04:10 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id n22so11332024edt.4
        for <linux-sparse@vger.kernel.org>; Mon, 05 Oct 2020 16:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wSKVeH1Pgs4UaWbLvt3oLHkeP6jw7uLY7E9miW5CuTQ=;
        b=m6I2L2j1ppEupPQ2e75CyRTzbuS2EVK92D3E2On6OUbdWaB71T6F+95QohyyCGm4UV
         sjIF2dfaJDcLH9UmH93diKO+aQi5KPAY7pdBe09BVDTvX6XrE0U1XeqMn4Tjn0KnHQWT
         8WJbhd5ba2PeFZaimjdogZ9ExG/hAIbZQXzLLIDVvWp6oM2SKIjbBtcQGjMR2yWsFrJv
         Deiwdas6Swi4JIGv7y1G5qcesNFgTGOOS//+kdAmD0vW1SzlmTg64yYTJ8FLGTImmpAj
         to0K5UzXxkYqUz/yEayYacpNXHtR3orzAJpHA4UPt4hVakf2h3uRE7nRLF1NoJ8kZYLi
         xttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wSKVeH1Pgs4UaWbLvt3oLHkeP6jw7uLY7E9miW5CuTQ=;
        b=NkcL24wH+NwDpR2IwbLWBgbVL7QvHG2Gn0rb8ftde4CGDSvZVpC9W6AHk91+hM4zSE
         V1nupNYssOFHwYhYpdP14tykU7A+7q8rqRVc7EqC3ON237eOM3lje1mM8lwChn9jWro1
         0Wb3f8DSdPUCUdD75/Eum0+lPoafzNiiyNQ9vgyJ9fga21m9Xb58mSY2TT6WW1zo+aVu
         YVkqBV9OwfOAA9gXaY95mIKx3MAlSmfN3zoBcYfV2JmgDKF8IyEYwXdFfmLjhj/Qnl9R
         8VIJxO8kd4/1CWd8a+mQPY1KQyacws7KWcRnuwvLMMZ16aqgZU4+7fM2m+z++8lPQiFc
         BnPA==
X-Gm-Message-State: AOAM532SjtepCt9aqm6p5Spxx6kTu+RpBF8qSUXeGtg9QF6n0cUNZA6g
        UHK7b9az/mtZq7d55Ydr6D1ZTJt+hYU=
X-Google-Smtp-Source: ABdhPJxompCXtA4HUc/fvCB8NS/w5vgMZ7L1xZ+EjNPLcllj9JCga9gSPOV/I+jds2hy8WqzDUPa7A==
X-Received: by 2002:aa7:dc50:: with SMTP id g16mr2113592edu.95.1601939048842;
        Mon, 05 Oct 2020 16:04:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:414e:4652:8edc:a08f])
        by smtp.gmail.com with ESMTPSA id r9sm673546ejc.102.2020.10.05.16.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 16:04:08 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/4] fix usual conversion of integers
Date:   Tue,  6 Oct 2020 01:04:01 +0200
Message-Id: <20201005230401.74777-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005230401.74777-1-luc.vanoostenryck@gmail.com>
References: <20201005230401.74777-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The current implementation of the usual conversion doesn't handle
correctly the case of 'long' + 'unsigned int' on a 32-bit arch.
The resulting type is 'unsigned int' instead of 'unsigned long'.

Fix this by following closely the C99's wording.
This now gives the expected result for C89 & C99 on 32 & 64-bit archs
(as tested with the GCC testsuite).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 65 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 31 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 2f3dc06f8ccb..9106aa340649 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -164,49 +164,52 @@ static inline struct symbol *integer_promotion(struct symbol *type)
 }
 
 /*
- * integer part of usual arithmetic conversions:
- *	integer promotions are applied
- *	if left and right are identical, we are done
- *	if signedness is the same, convert one with lower rank
- *	unless unsigned argument has rank lower than signed one, convert the
- *	signed one.
- *	if signed argument is bigger than unsigned one, convert the unsigned.
- *	otherwise, convert signed.
- *
- * Leaving aside the integer promotions, that is equivalent to
- *	if identical, don't convert
- *	if left is bigger than right, convert right
- *	if right is bigger than left, convert right
- *	otherwise, if signedness is the same, convert one with lower rank
- *	otherwise convert the signed one.
+ * After integer promotons:
+ * If both types are the same
+ *   -> no conversion needed
+ * If the types have the same signedness (their rank must be different)
+ *   -> convert to the type of the highest rank
+ * If rank(unsigned type) >= rank(signed type)
+ *   -> convert to the unsigned type
+ * If size(signed type) > size(unsigned type)
+ *   -> convert to the signed type
+ * Otherwise
+ *   -> convert to the unsigned type corresponding to the signed type.
  */
 static struct symbol *bigger_int_type(struct symbol *left, struct symbol *right)
 {
+	static struct symbol *unsigned_types[] = {
+		[0] = &uint_ctype,
+		[1] = &ulong_ctype,
+		[2] = &ullong_ctype,
+		[3] = &uint128_ctype,
+	};
 	unsigned long lmod, rmod;
+	struct symbol *stype, *utype;
 
 	left = integer_promotion(left);
 	right = integer_promotion(right);
 
 	if (left == right)
-		goto left;
-
-	if (left->bit_size > right->bit_size)
-		goto left;
-
-	if (right->bit_size > left->bit_size)
-		goto right;
+		return left;
 
 	lmod = left->ctype.modifiers;
 	rmod = right->ctype.modifiers;
-	if ((lmod ^ rmod) & MOD_UNSIGNED) {
-		if (lmod & MOD_UNSIGNED)
-			goto left;
-	} else if (left->rank > right->rank)
-		goto left;
-right:
-	left = right;
-left:
-	return left;
+	if (((lmod ^ rmod) & MOD_UNSIGNED) == 0)
+		return (left->rank > right->rank) ? left : right;
+	if (lmod & MOD_UNSIGNED) {
+		utype = left;
+		stype = right;
+	} else {
+		stype = left;
+		utype = right;
+	}
+	if (utype->rank >= stype->rank)
+		return utype;
+	if (stype->bit_size > utype->bit_size)
+		return stype;
+	utype = unsigned_types[stype->rank];
+	return utype;
 }
 
 static int same_cast_type(struct symbol *orig, struct symbol *new)
-- 
2.28.0

