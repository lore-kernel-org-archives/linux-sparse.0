Return-Path: <SRS0=4hY4=BM=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0DEC433E0
	for <linux-sparse@archiver.kernel.org>; Sun,  2 Aug 2020 14:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76C0320738
	for <linux-sparse@archiver.kernel.org>; Sun,  2 Aug 2020 14:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8cf/XF9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbgHBOk4 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 2 Aug 2020 10:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgHBOkz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 2 Aug 2020 10:40:55 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B263C06174A
        for <linux-sparse@vger.kernel.org>; Sun,  2 Aug 2020 07:40:55 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id m20so15982151eds.2
        for <linux-sparse@vger.kernel.org>; Sun, 02 Aug 2020 07:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X6vuSgKNiDpFYZB61ePkWw1KwPd+zls/aZh7KLn1fzE=;
        b=N8cf/XF975fBylq9IHuIo7mSZqw2yrR4Nk8K4ahfLlCtqW/6NldiAhr2N+Ko60KEj6
         rYaNukpV+QiDU8p2wiZltnUuRr8PLWLaYKkHG9M7JpSbs65kAMqMV2E1C+L6mRGvuxXO
         z4ytPgCbh8TrTrQn7ey3eCVRrnLavNCdR7yqKdBV4dWvOUtZAUrXJQxlKJr8rHLWZ6mH
         Rfb7lJqO6tGfP/uEx27T4d0QfS+iysMZopMj64LgvqpC42tX3Dtkv/UHJ/XuUc2A+Erz
         658Pg/9QQ/4cjV0GbGLWxi3JWfpi5MoilfVqrx4sJsged0b3lm+A4XVknM8yBVfClVcC
         whtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X6vuSgKNiDpFYZB61ePkWw1KwPd+zls/aZh7KLn1fzE=;
        b=GRKMVK8UrzATD1u8qDmkT68+c5r1BTisvIkrL/tYiKY320C823Am4l65lM0PIQyXqy
         xAos8VRCpC0fJM1d1RXxIXS4ZKRnA5yb2iS+0zfP7F4twlHoOp32Z89zU+5JsP0tN6cr
         lQU1+eH+qf4iE7Nc6QbydHvbXiyOyn8CRhrxUnKeR1AaaD99Io4d4MwrzeVqCDH0SPVC
         BwiJMTna2ELjiVTh88kRFmL11dbpJy85cJ8RZz5EvSlZcDYGY8JHQjhf54+cOuDxsOXP
         4HZB1Rc71jg/S8sQgdrrBI49ugin9z5yRnX8MSx1JHMUPr6kWaQXDA9TMOd/pCPY0oQt
         byaQ==
X-Gm-Message-State: AOAM531CWUp5C24ttLKOu2Lfl1Qsb2Kn8YiaMzj5kx9r772guq27ZPUS
        0pyRrZZBypwKas/eQCWfJCRc/Bmm
X-Google-Smtp-Source: ABdhPJxWt7JRf87liiCPPCUon1A6FTQdLsP9Qg5IG7pWDXp1IyWZmCxnHINSlPCxiff5HK3xGgbmIQ==
X-Received: by 2002:a50:e844:: with SMTP id k4mr11702809edn.237.1596379253953;
        Sun, 02 Aug 2020 07:40:53 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:8550:5ba:d685:a42a])
        by smtp.gmail.com with ESMTPSA id w18sm9866109ejf.37.2020.08.02.07.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 07:40:53 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix diagnostic source path from command line
Date:   Sun,  2 Aug 2020 16:40:50 +0200
Message-Id: <20200802144050.53191-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Now, diagnostic messages are prepended with the source path.
But if the problem comes from a file included directly from
the command line like:
	sparse -include some-buggy-file.c

the prepended message will be:
	(null): note: in included file ...

because there isn't a source path yet.

So, initialize the source path to "command-line".

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c                                         |  2 ++
 validation/preprocessor/bad-cmdline-include.c | 11 +++++++++++
 2 files changed, 13 insertions(+)
 create mode 100644 validation/preprocessor/bad-cmdline-include.c

diff --git a/lib.c b/lib.c
index 2b600fee26cc..4bc5cd028781 100644
--- a/lib.c
+++ b/lib.c
@@ -383,6 +383,8 @@ struct symbol_list *sparse_initialize(int argc, char **argv, struct string_list
 	char **args;
 	struct symbol_list *list;
 
+	base_filename = "command-line";
+
 	// Initialize symbol stream first, so that we can add defines etc
 	init_symbols();
 
diff --git a/validation/preprocessor/bad-cmdline-include.c b/validation/preprocessor/bad-cmdline-include.c
new file mode 100644
index 000000000000..e4ee03f450c4
--- /dev/null
+++ b/validation/preprocessor/bad-cmdline-include.c
@@ -0,0 +1,11 @@
+#error some random error
+
+/*
+ * check-name: bad-cmdline-include
+ * check-command: sparse -include $file
+ *
+ * check-error-start
+command-line: note: in included file (through builtin):
+preprocessor/bad-cmdline-include.c:1:2: error: some random error
+ * check-error-end
+ */
-- 
2.28.0

