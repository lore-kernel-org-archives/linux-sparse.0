Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9CEC433ED
	for <linux-sparse@archiver.kernel.org>; Fri,  2 Apr 2021 20:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6221C6113E
	for <linux-sparse@archiver.kernel.org>; Fri,  2 Apr 2021 20:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbhDBU0I (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 2 Apr 2021 16:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhDBU0G (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 2 Apr 2021 16:26:06 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16154C061788
        for <linux-sparse@vger.kernel.org>; Fri,  2 Apr 2021 13:26:05 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l4so8783723ejc.10
        for <linux-sparse@vger.kernel.org>; Fri, 02 Apr 2021 13:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P5AEPagSqrYYahx3nGXH3wXsZo3bJssLlb3niFxTfpM=;
        b=ghBODrWwrk0qP5XYyIwJkyJcUlxtJeDHKD9JP6zdqHeBskA5OjReJFJy8DCkuWKEmf
         AuDOcxnlHTkXnniuwjvfbXzbXT22wvF/zUdTFmO04S+i70lgcdvxcx6KTcBu9+GpMJd2
         QDDBjS9P8Jf11sJx7fNMCncqgK9B8foy43cPaEHjFrNE+1HxLwUk/mkVZJq/KtxzNh5w
         el6ZvXmm9XJJ2SExtW9PKgRU4ugddGLvlRlGhArtUAHqwFVipXuDY3DUe6958bSCM7bE
         TH/nHinJls7mHgK5oirGTvAIUcdXNh/w+LYfW1MD7nlqtKn7X/1hUyE9gt5xneuen8LB
         ui+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P5AEPagSqrYYahx3nGXH3wXsZo3bJssLlb3niFxTfpM=;
        b=VvZEmAHqED7iN2ceyQWI+SWczDY1OFWUA6gM2P4sqiQGXJLdMasq0r733NW7Ct2Zpb
         lUN8imaYQ4oPEy3ypyWv9bBs41OEbHPmsQ+BrJu3TS/AiiWuK9BZ5OM8czGCijlnxjHw
         RFtjAL65Z6u5yeWq/zNwXyUTN0dlE6i/08Fhx6kYOKoE3J0WXVAQjIovie9tw6LJnhw4
         dVtZi4DaZY6Z0GwW6+9SSjA2TvsfB8wCJ73F0iGn9ZzX+9szoOJztBTnevbBsp0nnNBs
         0ppGTnHq6h+RxwIT997kOwVhQvfX5W8MUBmdV9FL9XqNAKUAwKF37o2APwQopfOzGprs
         McfQ==
X-Gm-Message-State: AOAM531nuJ/8J2obRHl2vzNGqO5FQj+/S/u6geWtbDSI7tVxAOpyu5MT
        SYKU12xL5r9Mhwai48xa2aROas4HiSU=
X-Google-Smtp-Source: ABdhPJx1yXlINJQE75WT5xNhUzEsweMyYv9BIfyEheFKHAdZAM0RP1jLNth4/ye+WpliqFOOHkYeSQ==
X-Received: by 2002:a17:906:35cf:: with SMTP id p15mr15655421ejb.379.1617395163852;
        Fri, 02 Apr 2021 13:26:03 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:e8a3:6a32:4891:b7b])
        by smtp.gmail.com with ESMTPSA id p24sm6011890edt.5.2021.04.02.13.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 13:26:03 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/4] additional testcase for remove_merging_phisrc()
Date:   Fri,  2 Apr 2021 22:25:55 +0200
Message-Id: <20210402202558.54504-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210402202558.54504-1-luc.vanoostenryck@gmail.com>
References: <20210402202558.54504-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/optim/multi-phisrc.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 validation/optim/multi-phisrc.c

diff --git a/validation/optim/multi-phisrc.c b/validation/optim/multi-phisrc.c
new file mode 100644
index 000000000000..c6f21f2db15a
--- /dev/null
+++ b/validation/optim/multi-phisrc.c
@@ -0,0 +1,24 @@
+void fun(void);
+
+void foo(int p, int a)
+{
+	if (p == p) {
+		switch (p) {
+		case 0:
+			break;
+		case 1:
+			a = 0;
+		}
+	}
+	if (a)
+		fun();
+}
+
+/*
+ * check-name: multi-phisrc
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-excludes: phi
+ */
-- 
2.31.1

