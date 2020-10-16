Return-Path: <SRS0=+i1M=DX=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B151C433DF
	for <linux-sparse@archiver.kernel.org>; Fri, 16 Oct 2020 23:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B76EC20874
	for <linux-sparse@archiver.kernel.org>; Fri, 16 Oct 2020 23:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n4cMm0Es"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410733AbgJPXLb (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 16 Oct 2020 19:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409789AbgJPXLb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 16 Oct 2020 19:11:31 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0448EC061755
        for <linux-sparse@vger.kernel.org>; Fri, 16 Oct 2020 16:11:31 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id e22so5625207ejr.4
        for <linux-sparse@vger.kernel.org>; Fri, 16 Oct 2020 16:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oUf1TK1wHUyaV6imQVeKfN33VDkMVqpDrpr7yfbCRKg=;
        b=n4cMm0EsNZbnF2GFsX7LmB8uDyI9X+aMuim5FogcYuzL6KnseZ9Ho2JY9kg/0ftXi+
         simXeSqzIVwIpkUaVwJIos/VLpczYGGz5A8u/ss1+IHQfbB8E7bWQIkmzXyHOkodWE4w
         ODRn+6aVxMFd1P+r3H6s15Luh5POHITvF+LE7v0XyBQdHu/vWnsoN6O81ybNZgGAca9j
         9WdkkFvSy/FkWOb4DDVxEWPudIcRUy3+lCqw7O/I5wLtne12jtSjVi7U7G4orVjtZG57
         cUEFxQW2whQbENcvMMG2sdfUN0m1c4UbokcQLRBMclAKuxZhQF++mAVOl0Q+3B/qdQyP
         u1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oUf1TK1wHUyaV6imQVeKfN33VDkMVqpDrpr7yfbCRKg=;
        b=d37M7Dvlb5EJfXAJs0TW9k7dqOKxAN7HzaSMthOXRWw5NhtxfQZouPgDCAm2P+Ke+J
         TFxtlbItgl+l52g9Sg1upCqPxObJMYGvaaF30+naJjaWOYSwqCoqLHPO7SUtxW+kTFQC
         Ag7DiNSUrSjLDEdBa2IlPmM4W1T0GzY2SLqcpcgzHxNxuKgY2KJH5rM0cKolShV7G7vY
         opMSRfhtwsCKPmZeb4+8+IwIFnTjpAJeuo1X11uytszeYgP8uHzshxnGS2vII/C32/dU
         umP+c2gM1QvXcn99cnQCWGn80X6eECTb3mrjL9V60eYUHphe3ofnqHR3ZYH1V7ulZEQQ
         ulOg==
X-Gm-Message-State: AOAM533UwBxKJCyZ7W+RSQvyc9Hs8hiVejKqtuYhDZhda4Gqz+tOp1O+
        piPBFmbPpEw4UfKdYf1Sm2d3OwN8jJY=
X-Google-Smtp-Source: ABdhPJy2zJovUEL0bW4+PIEHkaaJMCl2uEjb9PfJSbaz7La1LMVBLM1EXlwTZzDMXi2JQF0a6Nsh1A==
X-Received: by 2002:a17:906:c1d4:: with SMTP id bw20mr6100653ejb.91.1602889889425;
        Fri, 16 Oct 2020 16:11:29 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:bc01:c497:d684:8944])
        by smtp.gmail.com with ESMTPSA id dp1sm3258146ejc.74.2020.10.16.16.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 16:11:28 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] warn when taking the address of a built-in function
Date:   Sat, 17 Oct 2020 01:11:26 +0200
Message-Id: <20201016231126.23899-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Built-in functions are meant to be expanded by the compiler. As such,
they don't have an address.

So, issue an error when trying take the address of a built-in function.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                 |  4 ++++
 validation/builtin-arith.c | 25 +++++++++++++++----------
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 3ff76fa85e14..d742025287cd 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1787,6 +1787,8 @@ static struct symbol *degenerate(struct expression *expr)
 			expression_error(expr, "strange non-value function or array");
 			return &bad_ctype;
 		}
+		if (ctype->builtin)
+			sparse_error(expr->pos, "taking the address of built-in function '%s'", show_ident(ctype->ident)); 
 		*expr = *expr->unop;
 		ctype = create_pointer(expr, ctype, 1);
 		expr->ctype = ctype;
@@ -1807,6 +1809,8 @@ static struct symbol *evaluate_addressof(struct expression *expr)
 		return NULL;
 	}
 	ctype = op->ctype;
+	if (ctype->builtin)
+		sparse_error(expr->pos, "taking the address of built-in function '%s'", show_ident(ctype->ident));
 	*expr = *op->unop;
 
 	mark_addressable(expr);
diff --git a/validation/builtin-arith.c b/validation/builtin-arith.c
index 7aabbcb1bd58..3ce593045b37 100644
--- a/validation/builtin-arith.c
+++ b/validation/builtin-arith.c
@@ -31,22 +31,27 @@ void test(void (*fun)(void))
 /*
  * check-name: builtin arithmetic
  * check-command: sparse -Wno-decl $file
- * check-known-to-fail
  *
  * check-error-start
-builtin-arith.c:10:xx: error: ...
-builtin-arith.c:11:xx: error: ...
+builtin-arith.c:10:14: error: taking the address of built-in function '__builtin_trap'
+builtin-arith.c:11:13: error: taking the address of built-in function '__builtin_trap'
+builtin-arith.c:12:14: error: taking the address of built-in function '__builtin_trap'
+builtin-arith.c:13:14: error: taking the address of built-in function '__builtin_trap'
 builtin-arith.c:13:29: error: arithmetics on pointers to functions
+builtin-arith.c:14:14: error: taking the address of built-in function '__builtin_trap'
 builtin-arith.c:14:29: error: arithmetics on pointers to functions
+builtin-arith.c:15:14: error: taking the address of built-in function '__builtin_trap'
 builtin-arith.c:15:29: error: arithmetics on pointers to functions
-builtin-arith.c:18:xx: error: ...
-builtin-arith.c:19:xx: error: ...
-builtin-arith.c:21:xx: error: ...
-builtin-arith.c:22:xx: error: ...
-builtin-arith.c:23:xx: error: ...
-builtin-arith.c:24:xx: error: ...
-builtin-arith.c:25:xx: error: ...
+builtin-arith.c:18:21: error: taking the address of built-in function '__builtin_trap'
+builtin-arith.c:19:29: error: taking the address of built-in function '__builtin_trap'
+builtin-arith.c:21:14: error: taking the address of built-in function '__builtin_trap'
+builtin-arith.c:22:14: error: taking the address of built-in function '__builtin_trap'
+builtin-arith.c:23:14: error: taking the address of built-in function '__builtin_trap'
+builtin-arith.c:24:21: error: taking the address of built-in function '__builtin_trap'
+builtin-arith.c:25:21: error: taking the address of built-in function '__builtin_trap'
+builtin-arith.c:27:9: error: taking the address of built-in function '__builtin_trap'
 builtin-arith.c:27:24: error: subtraction of functions? Share your drugs
+builtin-arith.c:28:15: error: taking the address of built-in function '__builtin_trap'
 builtin-arith.c:28:13: error: subtraction of functions? Share your drugs
  * check-error-end
  */
-- 
2.28.0

