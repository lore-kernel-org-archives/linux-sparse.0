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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EEEC433E7
	for <linux-sparse@archiver.kernel.org>; Fri, 16 Oct 2020 22:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C59422202
	for <linux-sparse@archiver.kernel.org>; Fri, 16 Oct 2020 22:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qer71GY9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390483AbgJPW24 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 16 Oct 2020 18:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390233AbgJPW24 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 16 Oct 2020 18:28:56 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95665C061755
        for <linux-sparse@vger.kernel.org>; Fri, 16 Oct 2020 15:28:55 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id u8so5510734ejg.1
        for <linux-sparse@vger.kernel.org>; Fri, 16 Oct 2020 15:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w4aXNPtkpvYlPyCj/nkrur3aAgR9AHP+Gi9svn75zvE=;
        b=qer71GY9ZCxh64r8OySqtP068K/b13JZxjOmnKOMaVXSnr7Y57UpBumvHpLxfXvgeU
         SJ/fUsvKLYWKWVKOz8tbRZt3dDa4dSuSQf1Bx2pA/ZgynTyIrIVmjWHsml1El4h0KIyJ
         s+pkZm61Zedb4lQ/U2Y/cKFVSYYWEzFOsSoARQyAiWHbDdNf6WZAEKpBerZQNZqakRFh
         YDKdTvvKzAVP2p3jWvq7FLPib7cV1pSJYtYDT8/hXejXXKlrrPBzyrF8OU4/D3rh2u3r
         8ayO1BR/GQlRI7mD+DzdKvVTrFEcXT2DYgSnXO6hPKgR8CGPx50LdLK6rjfh4m28XJyY
         +3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w4aXNPtkpvYlPyCj/nkrur3aAgR9AHP+Gi9svn75zvE=;
        b=E4gzU1j7Bhs0jgLrQ4AgwXJtZhS7/uizL8ecDT5DmM93cA5RComlqQso/EU1Y/KYQg
         C7JU0Jnbu078t3mQ2Pt8ZnCnKBaKblAO+w19JWYFQ7F5Tm+qOMf/MOk9JY7JcrInLgAQ
         ranDrikFeUPT/YoVQ25etQPO1Yirb8eChTFt1HdeiV5EAIS7CbBSi9MnYrgWG4jns9fJ
         xK4kMTQAGotn+VzEYxqxFDuXRfNoVWiGZ32dBIC9nnbKcjcX527Vnnsv1Cz94PzHwSWt
         PNLQ8SI6n6j+BBPeDNqSX7xDQeBG9IyCVr69WotzuQrPmvebRkdTTLx5gQMBTnx9T1AZ
         RFgQ==
X-Gm-Message-State: AOAM533601XBGV6nYt+ZdzMK2KHCRYNlqg6lzoZI/rfsize0OsPWWzwl
        iRI827Z5iAj+mIbpMFUH4TlPDgztxMQ=
X-Google-Smtp-Source: ABdhPJwU5Pj36asG+S1Edf7XujgtxZxyQ1uS/uGd8ki6JPonTOekn7U0G7DPE/KtmsFcHUrTUKjxxA==
X-Received: by 2002:a17:906:52c6:: with SMTP id w6mr5739774ejn.199.1602887333996;
        Fri, 16 Oct 2020 15:28:53 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:bc01:c497:d684:8944])
        by smtp.gmail.com with ESMTPSA id j24sm3044889edq.29.2020.10.16.15.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 15:28:53 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix null pointer deref on return expression with invalid type
Date:   Sat, 17 Oct 2020 00:28:31 +0200
Message-Id: <20201016222831.23305-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

If the evaluation of the return expression failed a following test
can dereference the pointer holding the expression's type ...
which is null. Bad.

Fix this by adding the missing null pointer test.

Fixes: 3bc32d46494c404df7905fceaca9156830ff97f1
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                         | 2 +-
 validation/crash-undef-in-parens.c | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)
 create mode 100644 validation/crash-undef-in-parens.c

diff --git a/evaluate.c b/evaluate.c
index 3ff76fa85e14..16e11fe1b5a2 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3611,7 +3611,7 @@ static struct symbol *evaluate_return_expression(struct statement *stmt)
 	fntype = current_fn->ctype.base_type;
 	rettype = fntype->ctype.base_type;
 	if (!rettype || rettype == &void_ctype) {
-		if (expr && !is_void_type(expr->ctype))
+		if (expr && expr->ctype && !is_void_type(expr->ctype))
 			expression_error(expr, "return expression in %s function", rettype?"void":"typeless");
 		if (expr && Wreturn_void)
 			warning(stmt->pos, "returning void-valued expression");
diff --git a/validation/crash-undef-in-parens.c b/validation/crash-undef-in-parens.c
new file mode 100644
index 000000000000..5f05f88a6776
--- /dev/null
+++ b/validation/crash-undef-in-parens.c
@@ -0,0 +1,9 @@
+void foo(void) { return (UNDEF_STUFF_IN_PARENS); }
+
+/*
+ * check-name: crash-undef-in-parens
+ *
+ * check-error-start
+crash-undef-in-parens.c:1:26: error: undefined identifier 'UNDEF_STUFF_IN_PARENS'
+ * check-error-end
+ */
-- 
2.28.0

