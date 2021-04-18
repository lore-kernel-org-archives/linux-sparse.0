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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585FAC433B4
	for <linux-sparse@archiver.kernel.org>; Sun, 18 Apr 2021 15:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35FE3610C7
	for <linux-sparse@archiver.kernel.org>; Sun, 18 Apr 2021 15:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbhDRPdT (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 18 Apr 2021 11:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbhDRPdQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 18 Apr 2021 11:33:16 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2ABC061760
        for <linux-sparse@vger.kernel.org>; Sun, 18 Apr 2021 08:32:46 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x4so37768052edd.2
        for <linux-sparse@vger.kernel.org>; Sun, 18 Apr 2021 08:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hEy7q63scp3B3My+WUJqQUYS5JRHUfYszfzjUaKEF7Q=;
        b=lw0k0M32g1fiIYOvuR1rTw6xYtlLHjPfSOpnJHj/VNCCumXJFi1o7KgAMY056bJIuq
         uQ0ZOXR8b7iCyqsLzvpDTB+gR4DjM6bGusvn+wgg8gGwfhhlD52/e4Dy9+ezMYGB3wof
         FI5hBCaet52QlSBLe7ypXaJ6iatSghlMvXpiCsMxD+JUFESSHV8Ykk+nzEP4Y3cY1eW5
         b5PmRxFLtkNDrO3BuG36IJ8c9xWtfNfqBq5Oyx+V57u9MiFwcSZ0pg/74lKvVoPzWgNX
         /F5uwlg1SY6ifXd1B0lkKfkxFyyTZ0xYCBbzTI8ZKwioXGafE1tHgM4Xy8f4BhkXCp7q
         VQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hEy7q63scp3B3My+WUJqQUYS5JRHUfYszfzjUaKEF7Q=;
        b=Pk7zujdgglt3BSHLcG30HgYakijL3RSy5o/kvi8Nc2jSwI6VNqFgEf/d6G9EpJRPST
         CleL4LU6JLmuDQzINLBWkYo9a+zY3yNh0tUqp0WgQC0EUQj06Ca9xs7HyHW/whGBcVrs
         OFEttJYMbTZFOspzFAuIPdRZMN3cgnp50vo6LtV83etJ3Dxl24/Sdm4qBV00zQ+lU1H8
         3qebWcnkGrrNVpZF6qIWgUMOZT0N4gcPqU9x6p+tTBV5bqbpNiyF7FNljpqy6j+5eWJ8
         uCDR0Z3FH5rGqBhQq2/AgmGsjhiTqqFd4P86eD9QLZzjDGRPcSKwAgnfpoLfqVokjvV+
         /dJw==
X-Gm-Message-State: AOAM530XjHBIfef5fb3FhY/cpU1oPFzEpjlWey3wLkCe6pQO2DLsHJgv
        X9ag60zFEifUIHLOBI5yMARebhNvD2c=
X-Google-Smtp-Source: ABdhPJyVnz8pw5+1QQHMySf0CrNJ4UoGBDABUYNTu/K47kbNv6LaWxJLG+2sDQ9nv4vsWmuaocZxRw==
X-Received: by 2002:aa7:d543:: with SMTP id u3mr8401571edr.26.1618759965291;
        Sun, 18 Apr 2021 08:32:45 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:959c:c85:d486:38cf])
        by smtp.gmail.com with ESMTPSA id k9sm8632888eje.102.2021.04.18.08.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 08:32:44 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [SPARSE 2/4] add testcases for AND(x > 0, x <= C) --> x u<= C
Date:   Sun, 18 Apr 2021 17:32:31 +0200
Message-Id: <20210418153233.45234-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210418153233.45234-1-luc.vanoostenryck@gmail.com>
References: <20210418153233.45234-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/optim/range-check1.c | 17 +++++++++++++++++
 validation/optim/range-check2.c | 15 +++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 validation/optim/range-check1.c
 create mode 100644 validation/optim/range-check2.c

diff --git a/validation/optim/range-check1.c b/validation/optim/range-check1.c
new file mode 100644
index 000000000000..82b939917da4
--- /dev/null
+++ b/validation/optim/range-check1.c
@@ -0,0 +1,17 @@
+#define N	1024
+
+_Bool check_ok(long i)
+{
+	return i >= 0 && i < N;
+}
+
+/*
+ * check-name: range-check1
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-contains: setbe\\..*0x3ff
+ * check-output-excludes: set[lga][te]\\.
+ * check-output-excludes: set[ab]\\.
+ */
diff --git a/validation/optim/range-check2.c b/validation/optim/range-check2.c
new file mode 100644
index 000000000000..f565b84ea9db
--- /dev/null
+++ b/validation/optim/range-check2.c
@@ -0,0 +1,15 @@
+#define N	1024
+
+_Bool check_ok(int i)
+{
+	return (i >= 0 && i < N) == (((unsigned int)i) < N);
+}
+
+/*
+ * check-name: range-check2
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
-- 
2.31.1

