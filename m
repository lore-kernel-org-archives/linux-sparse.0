Return-Path: <SRS0=cyFV=D3=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3945CC388F2
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2C862237B
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7tnwsQo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438662AbgJTVKb (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 20 Oct 2020 17:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438655AbgJTVKb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Oct 2020 17:10:31 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA2CC0613CE
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:29 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id dt13so4830325ejb.12
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UkxCapVHmDmRNvpwtm3Z1XxedW1R1VJGl562Onw+jJk=;
        b=e7tnwsQomB6qJ9R8jzTVGSa6PYayR+oW5CzM/ki8yjDS5YbkqFhIQScOaEqjURj5br
         ryV9uSKVYWJzE4rdzAiOwwvQmxXO4w1XkU4OtVEVIWY2yebVuKGf5ieuF4dt7MnHdUt/
         YrWgDNzAtC6BfU5RQRxf+HDOvrRMS5mjcaXnyX37YGDvNzzx+F25azOB/FQH7Tlb+72a
         stMvIPZamOSkkO2veAqEgdtGEK2HBdl2RYAIzFv6oFS1xhMlKUATrpHn4kXGMTL0Nkv0
         WKYaldlhyvqTy2+6V1Saf9LUNA/mI19cLBY+XGJEpby5mnPkToUBVuvZKPIxDboo70bg
         rawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UkxCapVHmDmRNvpwtm3Z1XxedW1R1VJGl562Onw+jJk=;
        b=RJidyg/CWZSRgZKcWCmJEWqeL0zXtBYw+DQFPGRe9Y4C93A2DauM03aBdN4OyB22my
         u30kqhsfdr/7NLdaEUEmhXeNlufXAMCkU/yFYI3c035uGNjITMjut1d5NP5Rx74IWSqy
         Gfz+7G4gdXtsPa4j44rQm8TKtRoRgAr8GTl2KVaL9suSrwEaehtMf6Z6RBgZb5l//XoJ
         504r3WC1D22HEdXYa8QidZg11z5x25oxslzN3ESH8nwKlVa0KIgd6G/uFU0DkLuSLW0k
         MaGhD2jIxot4jjzLJrz5on5p6ynpQ0m9tpfYB52vWw0ose7HS9dRE2+rsyzFnmJCxAil
         YSkA==
X-Gm-Message-State: AOAM5314RI4HTu8VAM4o9L/ecgrIYYwlcqLoK2b7IVfhAcd2gCdklyRA
        B0v7LgQ7NGhGVnpaOfRmHox34Ye9E+g=
X-Google-Smtp-Source: ABdhPJwatoLpDbbzPLKHXYkgcTX7AROi94Fzgd8ggsN2rMRoG6qClqgo8NDe3M2X8uHSJiVl9yHbhA==
X-Received: by 2002:a17:906:649a:: with SMTP id e26mr71827ejm.415.1603228228002;
        Tue, 20 Oct 2020 14:10:28 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:85fe:66cb:a92b:c664])
        by smtp.gmail.com with ESMTPSA id d12sm4012848ejt.105.2020.10.20.14.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 14:10:27 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 04/22] unop: add helper eval_unop()
Date:   Tue, 20 Oct 2020 23:10:03 +0200
Message-Id: <20201020211021.82394-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020211021.82394-1-luc.vanoostenryck@gmail.com>
References: <20201020211021.82394-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Currently, eval_op() only do the evaluation of binops but unops
need sometimes to be evaluated too.

So, teach eval_op() about OP_NEG & OP_NOT and add a new helper,
eval_unop() for making it easier to use with unops.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/simplify.c b/simplify.c
index ac27debfcefb..4c6569eba036 100644
--- a/simplify.c
+++ b/simplify.c
@@ -535,6 +535,13 @@ static pseudo_t eval_op(int op, unsigned size, pseudo_t src1, pseudo_t src2)
 	ur = right & bits;
 
 	switch (op) {
+	case OP_NEG:
+		res = -left;
+		break;
+	case OP_NOT:
+		res = ~ul;
+		break;
+
 	case OP_ADD:
 		res = left + right;
 		break;
@@ -636,6 +643,11 @@ undef:
 	return NULL;
 }
 
+static inline pseudo_t eval_unop(int op, unsigned size, pseudo_t src)
+{
+	return eval_op(op, size, src, VOID);
+}
+
 ///
 // Simplifications
 // ^^^^^^^^^^^^^^^
-- 
2.28.0

