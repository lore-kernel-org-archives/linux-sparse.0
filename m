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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0F5C433E6
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Feb 2021 22:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A3D964EB4
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Feb 2021 22:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhBUW3V (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Feb 2021 17:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbhBUW3U (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Feb 2021 17:29:20 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AF2C061786
        for <linux-sparse@vger.kernel.org>; Sun, 21 Feb 2021 14:28:39 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id do6so26238587ejc.3
        for <linux-sparse@vger.kernel.org>; Sun, 21 Feb 2021 14:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ARYQ75+cFLLlYvbDh1z4/qaZZWa+HKeZ55Q1ba6Tm0=;
        b=okpx/bgLISs37bHfWecfFbc7m2EitlO/q14vhAEiFhgEECaQfu1ZE1QLjHkaAWmvqA
         dmsYzYahzdZBFwJB5Qn7m8KkIk19CdeMDtRfkY4EWGVoD3ngVoGjEmPj5foe/fbigB/v
         HAopHHzeruC7a3M5s37sIdT3dVpN+v6T1TzJfV4i0/4DT2ieuoXYOBQztAA4JSsycKlM
         IfFcMYcMcXCgVtPvjr7B9huxhwW6oqBXRVdjnmtjWf/ewppYhopPGtNWIaoQHPrxQreB
         Na1p9YikyO5vwrODmpwaSqmQzDYFX7rVxiUNF7yujOiQAr0qknqPNAC36DuyCSbnpojr
         y4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ARYQ75+cFLLlYvbDh1z4/qaZZWa+HKeZ55Q1ba6Tm0=;
        b=TIRA5EcpAsYyjki3DfQ+L2jiD43laqkpRv+QcLwReYrb5i/jrkFooUpGCm2rnCHsKM
         U9Mo9kf27bl0XAOKLFmIaRD21x+DowMgoaAtE0gNYT+Hxzs1Da+har51uGZx5la6QV5x
         Zto8XRx5gNGkGrsuPl30xw41imRC0aOzWnAm+7l88tuikRYSP9iH8XNvh4PqZXzGd98W
         ExSmbz9enRTCLJNyP0x3Dk36PJq+UlQSpsSLm1IbnQFhB3+oYywacUIVMJSu1KU452ui
         NkJnfkp3+r7o/jxw1WNIYDzyS//yteHgUCS0rC6ZwO2u1SZVedxPPDGLoLhzzwLrM3eV
         Iu8g==
X-Gm-Message-State: AOAM533VOyhbMzOQlsuBnFcayIMUtUMRfu7dMqaZ3DfCgdQTLmDBpdbw
        VifeYsVjWlJbhpsJxC+gveUhVc9C1VE=
X-Google-Smtp-Source: ABdhPJyZ7+CZ+8vXgZrnGfGoD8j4n2AQ7PidItnsJdOF+vSjTDCoTgCs7POH83suOew34Husfff0+A==
X-Received: by 2002:a17:906:a157:: with SMTP id bu23mr7665510ejb.491.1613946518560;
        Sun, 21 Feb 2021 14:28:38 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:9463:3f6a:e4eb:cf54])
        by smtp.gmail.com with ESMTPSA id d6sm297744ejr.59.2021.02.21.14.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 14:28:38 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] asm: add testcase for problem with output addresses
Date:   Sun, 21 Feb 2021 23:28:32 +0100
Message-Id: <20210221222834.7974-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210221222834.7974-1-luc.vanoostenryck@gmail.com>
References: <20210221222834.7974-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The addresses needed by memory output operands are linearized
(and placed) after the ASM instruction needing them.

So, add a test case for this.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/linear/asm-out0.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 validation/linear/asm-out0.c

diff --git a/validation/linear/asm-out0.c b/validation/linear/asm-out0.c
new file mode 100644
index 000000000000..64d154ed5ad7
--- /dev/null
+++ b/validation/linear/asm-out0.c
@@ -0,0 +1,26 @@
+static void asm_out0(void)
+{
+	int mem;
+	asm volatile ("[%1] <= 0" : "=m" (mem));
+}
+
+/*
+ * check-name: asm-out0
+ * check-command: test-linearize -fdump-ir $file
+ * check-known-to-fail
+ *
+ * check-output-start
+asm_out0:
+.L0:
+	<entry-point>
+	symaddr.64  %r1 <- mem
+	asm         "[%1] <= 0"
+		out: "=m" (%r1)
+	br          .L1
+
+.L1:
+	ret
+
+
+ * check-output-end
+ */
-- 
2.30.0

