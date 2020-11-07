Return-Path: <SRS0=cH/F=EN=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA0BC388F7
	for <linux-sparse@archiver.kernel.org>; Sat,  7 Nov 2020 11:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D15DF20888
	for <linux-sparse@archiver.kernel.org>; Sat,  7 Nov 2020 11:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3Sl4HFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgKGLm3 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 7 Nov 2020 06:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgKGLm3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 7 Nov 2020 06:42:29 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19C3C0613D2
        for <linux-sparse@vger.kernel.org>; Sat,  7 Nov 2020 03:42:28 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y15so3749194ede.11
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 03:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jl0htPGtH9QazFPvsAtWtFGw2kR/JA6bW+NoZIECtxk=;
        b=i3Sl4HFNFXFvUR1tziD2xHAVWbcw4c8RaasSyx/SBKT5OPzD7S5/aT1ag9GHwjbEub
         9MEHkcvd5SuRAmw7cvEviFTKWt+Zqq7NOnldausE1lmr8DOAl4ncvaCi5/nmdOVOB9vi
         1hZEBiKtj91O6j3yIoCCH0nyQS6HJpB2brw6wRoewwbVxBp1IIavtG43KDAFDTM3k/Cg
         D7rDwoAvbpWIuN9hEZZdWPw75Fk2o8N8WJQnUhuiapeHiOmr6i1fwJvBXdQffD8pWqDq
         yadJ0zMLgKBUNVWje7h71WSd5k2Rfx713DobxZGgKk05R6lyyOghgM5Ap9hZrENEHvzL
         UqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jl0htPGtH9QazFPvsAtWtFGw2kR/JA6bW+NoZIECtxk=;
        b=RgfirK2+rKwV5TW/7UD7HndH0l2+87t2ky4T/9unRFLWzFT0znJH+JV+YvII+Zun61
         N6s5OIRVGwUDYFUhR0SXMI4gECneyKKxM3S7nmMgn1Sfhs8H2YBkVVeJL1xgNOO6MInz
         tkKUMCwBv+mQkUI2sCTFBXbkpguxkXvtp05NYP8wG2vDcnhJ10xhwDwM9CILd7HrRcAc
         MkY15XhQ1oc5fR3TmiGKmgmuMprcRsGReZXAHN84GByPqUUpW2kx9XyR9EFESvTVg5QX
         KD/ItpG1p26EBQV9FhhQukItuzBLAvWM/V7ZbD0jqrhVW82Lunge10qtu+Spb0z/Q9M6
         BpXQ==
X-Gm-Message-State: AOAM532YKydiJ8Y6Hdil5brumsyg0kwXWmh5uRRVmX9/sWXAIos/t09Q
        HvWq9ox0y7una7XGXSsEsXLg6kh0MWg=
X-Google-Smtp-Source: ABdhPJyuEqybahxKM/brkI9Mauc0SD1c9mfm51i26+DcF5zKHOHK8Sd6lGTMmx03rMoGiXMnjRyeMQ==
X-Received: by 2002:a05:6402:1c8e:: with SMTP id cy14mr6786812edb.39.1604749347112;
        Sat, 07 Nov 2020 03:42:27 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:9030:856f:68be:7b84])
        by smtp.gmail.com with ESMTPSA id s21sm3308311edc.42.2020.11.07.03.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 03:42:26 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/5] select: add some testcases for select simplification
Date:   Sat,  7 Nov 2020 12:42:18 +0100
Message-Id: <20201107114222.11866-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201107114222.11866-1-luc.vanoostenryck@gmail.com>
References: <20201107114222.11866-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/optim/select-constant-cond.c      | 10 ++++++++++
 validation/optim/select-same-args.c          |  9 +++++++++
 validation/optim/select-select-true-false0.c | 11 +++++++++++
 validation/optim/select-select-true-false1.c | 14 ++++++++++++++
 validation/optim/select-select-true-true.c   | 10 ++++++++++
 5 files changed, 54 insertions(+)
 create mode 100644 validation/optim/select-constant-cond.c
 create mode 100644 validation/optim/select-same-args.c
 create mode 100644 validation/optim/select-select-true-false0.c
 create mode 100644 validation/optim/select-select-true-false1.c
 create mode 100644 validation/optim/select-select-true-true.c

diff --git a/validation/optim/select-constant-cond.c b/validation/optim/select-constant-cond.c
new file mode 100644
index 000000000000..a9337e2ceaee
--- /dev/null
+++ b/validation/optim/select-constant-cond.c
@@ -0,0 +1,10 @@
+int t(int p, int a, int b) { return ((p == p) ? a : b) == a; }
+int f(int p, int a, int b) { return ((p != p) ? a : b) == b; }
+
+/*
+ * check-name: select-constant-cond
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/select-same-args.c b/validation/optim/select-same-args.c
new file mode 100644
index 000000000000..403af47169c3
--- /dev/null
+++ b/validation/optim/select-same-args.c
@@ -0,0 +1,9 @@
+int foo(int p, int a) { return (p ? a : a) == a; }
+
+/*
+ * check-name: select-same-args
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/select-select-true-false0.c b/validation/optim/select-select-true-false0.c
new file mode 100644
index 000000000000..46bd7667400d
--- /dev/null
+++ b/validation/optim/select-select-true-false0.c
@@ -0,0 +1,11 @@
+int fw(int p, int a, int b) { return ((p ? 42 : 0) ? a : b) == ( p ? a : b); }
+int bw(int p, int a, int b) { return ((p ? 0 : 42) ? a : b) == ( p ? b : a); }
+
+/*
+ * check-name: select-select-true-false0
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/select-select-true-false1.c b/validation/optim/select-select-true-false1.c
new file mode 100644
index 000000000000..00ffdcd1bc9b
--- /dev/null
+++ b/validation/optim/select-select-true-false1.c
@@ -0,0 +1,14 @@
+int foo(int p)
+{
+	int t = (p ? 42 : 0);
+	return (t ? 42 : 0) == ( p ? 42 : 0);
+}
+
+/*
+ * check-name: select-select-true-false1
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/select-select-true-true.c b/validation/optim/select-select-true-true.c
new file mode 100644
index 000000000000..e6fa2c89febb
--- /dev/null
+++ b/validation/optim/select-select-true-true.c
@@ -0,0 +1,10 @@
+int foo(int p, int a, int b) { return ((p ? 42 : 43) ? a : b) == a ; }
+
+/*
+ * check-name: select-select-true-true
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
-- 
2.29.2

