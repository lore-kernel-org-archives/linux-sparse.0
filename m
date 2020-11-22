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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E187AC63697
	for <linux-sparse@archiver.kernel.org>; Sun, 22 Nov 2020 15:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A129820776
	for <linux-sparse@archiver.kernel.org>; Sun, 22 Nov 2020 15:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyXzgDSL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgKVP1j (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 22 Nov 2020 10:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbgKVP1i (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 22 Nov 2020 10:27:38 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657BFC061A4A
        for <linux-sparse@vger.kernel.org>; Sun, 22 Nov 2020 07:27:38 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 10so15530396wml.2
        for <linux-sparse@vger.kernel.org>; Sun, 22 Nov 2020 07:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dW9vlsLOdOZmbNrzdKKE/u+wafhEWcahlRHi87i9YIY=;
        b=RyXzgDSLsFIdOSuwZ9EkxnpZAvThSrLgvbg7XQrbXQj2K97ENTc0Pp0tyZieHqg3IR
         EpaTkiqD7WUUOdIXScznqsv+cTUm9xh2BwL/mrSfpchpnu53J+UNE+hZItULy3D6u1Vn
         uJNniUB5kU0XK9D3kWrABUoikCnbW+sZXuVXt5Iv9vBvGWO4B/HpnjcDQqU6yXzUtEz2
         QSwCd9j5QJwx0/a4k4S3EPfZGTcc1nNUIRH1HHGEYK/0Y35DwM8o1/rnGIdq4KxpXBLm
         X9MUXc6YOBPlM3aW0UomyHSsmoYydbEXCOADErp4DNG/gsuJ/ZAqsgy9QwHRJt3E/3wr
         y3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dW9vlsLOdOZmbNrzdKKE/u+wafhEWcahlRHi87i9YIY=;
        b=cgxfw3ECS59saLQ1P+Sk+uaJWRsl15ycS53fdLSPKv5H4/wmXNXpLMDzXPM/nzsthN
         PSdF57BZtHJcz9HdXDRVPcDW+eVszkvKIQ+0h21I4U5T7fyNGCSA8FJIg3i8la+xwj1+
         2GjF6zpfdgAHmJ+j3sCX4UBCNLY4JwTovsbMrMDlwoxML8kFuPU+dyg1ea33zUk57b5L
         VBXqoL8OZdP8P6laAxo7oxNtPd5y61y4Fl9F0NWRYLesWrCl5GxmA9zyC8neiN5kCv0N
         F8hS7XTk7MSzLFtNa5aBWh2EzFB9I1kMmbks5E04Oe8D3ArdJwYtzx2dVizTYmufA65t
         E+gg==
X-Gm-Message-State: AOAM530ZxoonlD3Q/loD3kMoTkupm9XvTpdK9ku0DWEuHrAK8U/EidhO
        kugMt4ZR1Cdw4ppVLo02Eda7AFvOPzc=
X-Google-Smtp-Source: ABdhPJxkjfHvIe0AlOpBLX5Smtofv5ikGv1hno+GizV4ehr2ynTJAI2ATuXTu0O0f9+PLT5CFbe/pA==
X-Received: by 2002:a1c:98cd:: with SMTP id a196mr19789066wme.42.1606058856913;
        Sun, 22 Nov 2020 07:27:36 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:b0e1:b041:18e2:46cf])
        by smtp.gmail.com with ESMTPSA id k1sm13712265wrp.23.2020.11.22.07.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 07:27:36 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/7] canon: put PSEUDO_REGs in canonical order too
Date:   Sun, 22 Nov 2020 16:27:27 +0100
Message-Id: <20201122152731.10994-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201122152731.10994-1-luc.vanoostenryck@gmail.com>
References: <20201122152731.10994-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Currently, only binops containing PSEUDO_VAL, SYM or ARG were
put in canonical order. This means that binops containing only
PSEUDO_REGs are not ordered. This is not directly
a problem for CSE because commutativity is taken in account but:
* more combination need to be checked during simplification
* 'anti-commutative' operations like (a > b) & (b < a) are not
  recognized as such.

So, take PSEUDO_REGs in account when checking if operands
are in canonical order.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                   | 3 +++
 validation/optim/cse-reg01.c | 1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index c809b832afeb..ee485798148b 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1474,6 +1474,9 @@ static int canonical_order(pseudo_t p1, pseudo_t p2)
 	if (p1->type == PSEUDO_ARG)
 		return (p2->type == PSEUDO_ARG && p1->nr <= p2->nr) || p2->type == PSEUDO_VAL || p2->type == PSEUDO_SYM;
 
+	if (p1->type == PSEUDO_REG)
+		return (p2->type == PSEUDO_REG && p1->nr <= p2->nr) || p2->type == PSEUDO_VAL || p2->type == PSEUDO_SYM || p2->type == PSEUDO_ARG;
+
 	return 1;
 }
 
diff --git a/validation/optim/cse-reg01.c b/validation/optim/cse-reg01.c
index 938858f4649b..3ea283d35368 100644
--- a/validation/optim/cse-reg01.c
+++ b/validation/optim/cse-reg01.c
@@ -3,7 +3,6 @@ int foo(int a, int b) { int x = a + b, y = ~b; return (x < y) == (y > x); }
 /*
  * check-name: cse-reg01
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.29.2

