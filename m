Return-Path: <SRS0=+N6z=EA=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE54C388F7
	for <linux-sparse@archiver.kernel.org>; Sun, 25 Oct 2020 13:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6C232074F
	for <linux-sparse@archiver.kernel.org>; Sun, 25 Oct 2020 13:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJ4bqs+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416462AbgJYN61 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 25 Oct 2020 09:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416461AbgJYN61 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 25 Oct 2020 09:58:27 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F2FC0613CE
        for <linux-sparse@vger.kernel.org>; Sun, 25 Oct 2020 06:58:16 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p5so9676021ejj.2
        for <linux-sparse@vger.kernel.org>; Sun, 25 Oct 2020 06:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UJO9zgi3VhaMLadbpF8zAkvRfvwVwXJSR1fmOb4a4Yw=;
        b=aJ4bqs+Xu7MTlr7Iyc5LAVOQ+tJpRfFU3UYlTIbkNxNJioEeM3F5kNOA2KL7QswLqf
         3oAMCOkzj8XqjraDVEZn/VUY/txZMJuPVN+bIvomBNpTuIuaWuRCUCg9Ne07GPTIpPM0
         5wzvX9vboSSRp9poL0ftjOcJD5bJS4Gm7nHEU9vU9CcHUDOjS8iNWgxRWPjx+HUOW+Yi
         Wb8jO7OUJHpS9HrS6/a6l652BoTxulufsfh9wh5ybJFLPvf1VBEmqeoKp/cC2+UAynQK
         502twUrwPmNTvlHcqIWW++PacyTEEddubAEMGhQMQPH1J8ksQmSTwSvKgqYwLKCOpKUg
         PqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UJO9zgi3VhaMLadbpF8zAkvRfvwVwXJSR1fmOb4a4Yw=;
        b=nm/i+iWbxlDAI+DFkbuxoUZOW3hV4a++9KyrllrTAbu2jOyUJ4PslizNWr5pH15C/I
         W+CZJW1Ur3ObgJ//MAsRXYxoBYP9wbTZd5rjJuG/TQAoAjzmIsIjVD1OQ1ztzYqJTEIY
         2h6w2DAheJamqA7mn+6tlPRKFnCjKgWrMbTpFcxoKbO1DLGjjjpWuk2bp2dRjBlg0zPc
         WwKt40LYQMRnmLspozDk2mIIURNOjWFjuK2zslJyD7bcDdrTCmnokC74+4bs/Gus34pb
         FKEbR7dlOi1k1sTKWlPXYK4HJlmnOJdnqhmN996CR+vpLL/Y2GtaN8r6bbvNy5mB1DLQ
         5aug==
X-Gm-Message-State: AOAM532sia0InMSwCG7Gh0EFfy81SEEn2szkac1Mnp3KU8gynOV3s6/k
        eeSGbb9TEKCMBVGBf52wopXBEoSoW1c=
X-Google-Smtp-Source: ABdhPJzJ1I12AyYoKODf2UjxRIAJNc6fGJsyC6lJWy21zhYmM5SmQE+bRXAybc5rsv104GSWyEqfqw==
X-Received: by 2002:a17:906:80d2:: with SMTP id a18mr11061212ejx.37.1603634295342;
        Sun, 25 Oct 2020 06:58:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f136:83e9:1c3d:13f2])
        by smtp.gmail.com with ESMTPSA id g20sm4120372ejz.88.2020.10.25.06.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 06:58:14 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] add testcase for missing inline definition
Date:   Sun, 25 Oct 2020 14:58:12 +0100
Message-Id: <20201025135812.32732-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

If the address of an inline function is taken, a definition
for this function must be emitted.

However, sparse only do this if this inline function is defined
before it is used.

So add a testcase for this.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/linear/inline-definition.c | 30 +++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 validation/linear/inline-definition.c

diff --git a/validation/linear/inline-definition.c b/validation/linear/inline-definition.c
new file mode 100644
index 000000000000..2918bd5d7527
--- /dev/null
+++ b/validation/linear/inline-definition.c
@@ -0,0 +1,30 @@
+extern void use(void *);
+
+static inline int inl0(int a);
+static inline int inl1(int a);
+
+static inline int inl0(int a)
+{
+	return a;
+}
+
+void foo(void)
+{
+	use(inl0);
+	use(inl1);
+}
+
+static inline int inl1(int a)
+{
+	return a;
+}
+
+/*
+ * check-name: inline-definition
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-contains: inl0:
+ * check-output-contains: inl1:
+ */
-- 
2.29.0

