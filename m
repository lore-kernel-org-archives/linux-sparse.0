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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D477AC433C1
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 12:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB50B6194A
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 12:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhCUMfZ (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Mar 2021 08:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhCUMfP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Mar 2021 08:35:15 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C79C061763
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 05:35:14 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id r12so16831689ejr.5
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 05:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=38o/PQMi24YzHkakkTvVA4bD1js5KGyrIGSn37xp4H8=;
        b=Hw4jKyB+luH6k2vzx7HKpo7yfP9AUdwDpkFCWbC1AVGMYokbfFHmzinXHBZuOPzvS5
         KHRwzMiZ1R0Soyhfs2oUR6wW230Q1lyvHfpfB5x5XtFh2/hy37o9DQF98RaL9alF9Fb5
         nfBxL4vIpqXu7lCXAJ+hniJ7oA9o6DQMkTQKs53oRuk2e1UXMX4081PYk/U7Wfu+fHLp
         rAmCr/kbAKJBYBxcpO8/s9yHEMSz96/8FkKVzmgt8caGxbhK+XU01OUhn5Bx9YrwJb1x
         MJ/KCC2DYQ1pQz+4KftUIHui8RoD5Koiz4aRVUTBSDEst++82i2hL88I+w168jU+H55M
         QNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=38o/PQMi24YzHkakkTvVA4bD1js5KGyrIGSn37xp4H8=;
        b=Y2Sv7z5BbAzDuYXbLxpbBUd1xHb9I+y7j+s7Nrs033ZXC8ZYKgeciF1ZUmr9pHXBLj
         aMbv9KjNaIjpjBgfPc/bCRpLR8V4d2L3/4qMocKXANwManp3CpAj8icSStG7g8aMZL9z
         5HUwV4xBKPSkl5T5//ZptDhAEM1ifMg3V7qavgj6rgy87aknLr55g91fWUL+Yl6IQKp8
         GL2XHmNAEjoPXZ2tQHIxhyDG7tobdEAQDUbquqvLom0TB5niZRDG9roC1MhYxZCO/49P
         7H1jp0090QDyhjPs8Ucq/qg3L8WowbPdfrVs9eXj9tx5dkMrKmVzDC9cx5c3FLqmC5wD
         w1Wg==
X-Gm-Message-State: AOAM532Dd+p4xSCkJuGlJZf3ecjt4JcFu1qK9vix+9F3NrX9hssayPyV
        jnfOoP/SWi5+avXgL6mEV33rSVUhn9w=
X-Google-Smtp-Source: ABdhPJzQhqjwbpTOogGBVhRdheF/YmhaxAgL0HzJ5YBkEF5Wu2TvUPTBUimsKuf2nVl2/qrJ7eXBrg==
X-Received: by 2002:a17:906:f8d5:: with SMTP id lh21mr14280853ejb.64.1616330113189;
        Sun, 21 Mar 2021 05:35:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:b090:4406:df97:c155])
        by smtp.gmail.com with ESMTPSA id jv19sm6998641ejc.74.2021.03.21.05.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 05:35:12 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 02/13] add testcases to check if phi-sources from removed targets are removed too
Date:   Sun, 21 Mar 2021 13:34:54 +0100
Message-Id: <20210321123505.27993-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210321123505.27993-1-luc.vanoostenryck@gmail.com>
References: <20210321123505.27993-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/optim/bad-phisrc1.c  | 16 ++++++++++++++++
 validation/optim/bad-phisrc1a.c | 24 ++++++++++++++++++++++++
 validation/optim/bad-phisrc2.c  | 17 +++++++++++++++++
 validation/optim/bad-phisrc3.c  | 21 +++++++++++++++++++++
 4 files changed, 78 insertions(+)
 create mode 100644 validation/optim/bad-phisrc1.c
 create mode 100644 validation/optim/bad-phisrc1a.c
 create mode 100644 validation/optim/bad-phisrc2.c
 create mode 100644 validation/optim/bad-phisrc3.c

diff --git a/validation/optim/bad-phisrc1.c b/validation/optim/bad-phisrc1.c
new file mode 100644
index 000000000000..59c5e4f1e66a
--- /dev/null
+++ b/validation/optim/bad-phisrc1.c
@@ -0,0 +1,16 @@
+void foo(int a, int b)
+{
+	if (b)
+		while ((a += 5) > a)
+			;
+}
+
+/*
+ * check-name: bad-phisrc1
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-excludes: phi\\.
+ * check-output-excludes: phisource\\.
+ */
diff --git a/validation/optim/bad-phisrc1a.c b/validation/optim/bad-phisrc1a.c
new file mode 100644
index 000000000000..cf07573b1fd3
--- /dev/null
+++ b/validation/optim/bad-phisrc1a.c
@@ -0,0 +1,24 @@
+int def(void);
+
+int fun4(struct xfrm_state *net, int cnt)
+{
+	int err = 0;
+	if (err)
+		goto out;
+	for (; net;)
+		err = def();
+	if (cnt)
+out:
+		return err;
+	return 0;
+}
+
+/*
+ * check-name: bad-phisrc1a
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-contains: select\\.
+ */
+
diff --git a/validation/optim/bad-phisrc2.c b/validation/optim/bad-phisrc2.c
new file mode 100644
index 000000000000..3eade688f768
--- /dev/null
+++ b/validation/optim/bad-phisrc2.c
@@ -0,0 +1,17 @@
+int bad_phisrc2(int p, int a, int r)
+{
+	if (p)
+		r = a;
+	else if (r)
+		;
+	return r;
+}
+
+/*
+ * check-name: bad-phisrc2
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-contains: select\\.
+ */
diff --git a/validation/optim/bad-phisrc3.c b/validation/optim/bad-phisrc3.c
new file mode 100644
index 000000000000..6e437771b4b8
--- /dev/null
+++ b/validation/optim/bad-phisrc3.c
@@ -0,0 +1,21 @@
+void foo(void)
+{
+	int c = 1;
+	switch (3) {
+	case 0:
+		do {
+			;
+	case 3:	;
+		} while (c++);
+	}
+}
+
+/*
+ * check-name: bad-phisrc3
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-pattern(2): phisrc\\.
+ * check-output-pattern(1): phi\\.
+ */
-- 
2.31.0

