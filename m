Return-Path: <SRS0=/orK=BC=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E7DC433E0
	for <linux-sparse@archiver.kernel.org>; Thu, 23 Jul 2020 23:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02FAD20792
	for <linux-sparse@archiver.kernel.org>; Thu, 23 Jul 2020 23:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YF/aHDIU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgGWXqw (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 23 Jul 2020 19:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgGWXqv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 23 Jul 2020 19:46:51 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF6BC0619E4
        for <linux-sparse@vger.kernel.org>; Thu, 23 Jul 2020 16:46:51 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a1so5731838edt.10
        for <linux-sparse@vger.kernel.org>; Thu, 23 Jul 2020 16:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BbBhSbMkzlC0oTJ91E6fEcPBnqPn5hnAhobeToziTqk=;
        b=YF/aHDIUYtguy9hUuxGUyHIedAxBPwHbP+cim1sdDQOCoESHK9t3aM26MlHuoFy4qC
         voMXGaSonY6BgwBrRbZGDQglikyPNxJ5jnWaMv4jtPov0pyzCZs+JsAje8MX56kT3vrV
         HT6QMkYdNEPKSJrZGJVbAmodINPNPa/xNst1OlKZ7sP9Fn8WchItA0bt7Emlt5/EVsgs
         GOSYyqRux2YBYdpjqKXzBqbDd2DNhjfobiJnIk0H92UnbwdTqjxnKjKtzAynw4XvRyIy
         33qwrLGA58mRO97inKYTLIiKR+JNZ1SbMZ55IkJR1h39ngcOf2m5Izt8TbFWO6jb54CX
         dhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BbBhSbMkzlC0oTJ91E6fEcPBnqPn5hnAhobeToziTqk=;
        b=HgG6wEoV2nMPUrU3qnH/gwZIwJnzuHG3JOGBx1JQSi5VB4som4PwAry9YHfHccCG/L
         lMzC9vwXmCN2lWqnhCwZlJQ5HLJTaH92crF0d7gA82Au7MXXuJg64wVxiu+VHfgkH3W3
         prCL48ztoQpx0RHwkp/TijmN2FCWERbXwwhfTWCBAgnNM+MDyxV0biKxWSluWPEaZrzA
         uCsMh/L/hrWV2TWXFyKtjWKXaJ7n0HWgWiJvSZPUi0fDjP5KPpbAnalrtif28w9+TtPV
         LJA4VpDOvf6QRz9KPiUrT3tFLOEmBoO5obrETHUIRCCoeSox6jpqFaLMIZ+wsQMy+spV
         ki7Q==
X-Gm-Message-State: AOAM532s5R8JCIEKuHCcqL8mzq2U+zGcoG6Ku7IjmK/gsGImpjOWhWPo
        fzqHWxERo77zCaOx1zfjqJtgYDB2
X-Google-Smtp-Source: ABdhPJxJ7li3mSXZ6stOKBlxGxtZd9jyfU151HtLWhY7oaaRHVhfCg9WWh07vU0WxUOnJGpzZ14EFQ==
X-Received: by 2002:aa7:d283:: with SMTP id w3mr6534326edq.76.1595548010072;
        Thu, 23 Jul 2020 16:46:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:a981:5f61:c34f:8c32])
        by smtp.gmail.com with ESMTPSA id bq8sm3086975ejb.103.2020.07.23.16.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 16:46:49 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/6] remove now unused match_idents()
Date:   Fri, 24 Jul 2020 01:46:40 +0200
Message-Id: <20200723234641.78462-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723234641.78462-1-luc.vanoostenryck@gmail.com>
References: <20200723234641.78462-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

match_idents() is now unused and identifier matching should
preferably be done via the keyword table.

So, remove this function.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/parse.c b/parse.c
index ec69e0c6e9ca..c7ca3dce7f6b 100644
--- a/parse.c
+++ b/parse.c
@@ -678,24 +678,6 @@ static void fn_local_symbol(struct symbol *sym)
 		add_symbol(function_symbol_list, sym);
 }
 
-static int SENTINEL_ATTR match_idents(struct token *token, ...)
-{
-	va_list args;
-	struct ident * next;
-
-	if (token_type(token) != TOKEN_IDENT)
-		return 0;
-
-	va_start(args, token);
-	do {
-		next = va_arg(args, struct ident *);
-	} while (next && token->ident != next);
-	va_end(args);
-
-	return next && token->ident == next;
-}
-
-
 struct statement *alloc_statement(struct position pos, int type)
 {
 	struct statement *stmt = __alloc_statement(0);
-- 
2.27.0

