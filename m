Return-Path: <SRS0=Zl/b=D6=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B26FC4363A
	for <linux-sparse@archiver.kernel.org>; Fri, 23 Oct 2020 16:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEBE3206B5
	for <linux-sparse@archiver.kernel.org>; Fri, 23 Oct 2020 16:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9KHSdkM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462899AbgJWQkl (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 23 Oct 2020 12:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752487AbgJWQjp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 23 Oct 2020 12:39:45 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF38C0613CE
        for <linux-sparse@vger.kernel.org>; Fri, 23 Oct 2020 09:39:45 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id c15so3275596ejs.0
        for <linux-sparse@vger.kernel.org>; Fri, 23 Oct 2020 09:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oIBL5HmiPXja7IElo6507mD6b+kb5t9yuv5+pv0EhZ4=;
        b=P9KHSdkMjqj4TSwlaNmr0F4nMLJOtwpb2bCRMaz+mRWqcLlSrkZancEk5huJvH/cGV
         ktqvpY0J7eaFj6nhX9ShUZVdTQqmgtIeqJcAR6alXYRfclWrF0Wt9argho8UEgpIQyXI
         CJmBq9Z7qoEtU6MrFaKd25T5TDOGvTcSeuKM8j++wSAwbyhb3Pmc1rSlqhQ8nPsR/iGE
         KQV1yKYCB5R9Hy47c99ORm/gUOkZyoyTrdnUuoeKUu5DWn1bUnJI588x1AzX8Rnteb7i
         iqe+c0Vg1HFVchj8Zd+aZTzvWQFxJVSC+srhGi8VdnIoK7By914TB1GJ1JzIsUUa4+Gg
         jvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oIBL5HmiPXja7IElo6507mD6b+kb5t9yuv5+pv0EhZ4=;
        b=Xhb1rlxEwi/jyaCD1fVQIx/SAZdsec5myzhPtND1sGHX4ULG42cHGe8ahj98j7ScXR
         vNaQAkYDiZYFCRXioL62VZvJStCjVdX+V0Hwh89zCtAwrKacMerObhGGtf1HmIfXLK9H
         uT+xYVD4P8aQMFEiTp+d3uUxryRcr9j14WgcQORtvzayN4v8XZjsysLBHZnxkq5Tbaf3
         7jNLwh/HovlEn5kqI20z8I5rjO38JwQpmDIsfVptUna6o+nb0+hn0sCNaSjBtGczKrSm
         6X9SVRf+ttuQ5LMaiqpf+LmLJUSjjRUuVVVcyLVaQ0Dvg+DgyOH38pBgSzWSY7gcgCa3
         e4mg==
X-Gm-Message-State: AOAM533DwVgGEFTwHBLHYyL6BbQdt8KnjgedO1WcCCoqmMNdLkkmu/eT
        IOdtKdxTYNS5GL0zLEIy6sf+HVU8YM0=
X-Google-Smtp-Source: ABdhPJwInkJqPNE9GkxdOp+TWhLhF7PXuqVDikcWY7ENiiSgCUQ3g3oB+WJ7EvZ4xb5C7OLgu9Bcmg==
X-Received: by 2002:a17:906:ae48:: with SMTP id lf8mr2808689ejb.345.1603471183443;
        Fri, 23 Oct 2020 09:39:43 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c9b0:42da:8135:1fa1])
        by smtp.gmail.com with ESMTPSA id m25sm1020734edp.36.2020.10.23.09.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:39:42 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/9] unop: add testcases for unop simplifications
Date:   Fri, 23 Oct 2020 18:39:31 +0200
Message-Id: <20201023163939.58359-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023163939.58359-1-luc.vanoostenryck@gmail.com>
References: <20201023163939.58359-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Add a few testcases for the simplification of unary operations.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/optim/simplify-neg-add-cte.c | 12 ++++++++++++
 validation/optim/simplify-neg-not.c     | 10 ++++++++++
 validation/optim/simplify-neg-sub.c     | 10 ++++++++++
 validation/optim/simplify-not-add-cte.c | 12 ++++++++++++
 validation/optim/simplify-not-neg.c     | 10 ++++++++++
 validation/optim/simplify-not-sub-cte.c | 12 ++++++++++++
 validation/optim/simplify-not-xor-cte.c | 12 ++++++++++++
 7 files changed, 78 insertions(+)
 create mode 100644 validation/optim/simplify-neg-add-cte.c
 create mode 100644 validation/optim/simplify-neg-not.c
 create mode 100644 validation/optim/simplify-neg-sub.c
 create mode 100644 validation/optim/simplify-not-add-cte.c
 create mode 100644 validation/optim/simplify-not-neg.c
 create mode 100644 validation/optim/simplify-not-sub-cte.c
 create mode 100644 validation/optim/simplify-not-xor-cte.c

diff --git a/validation/optim/simplify-neg-add-cte.c b/validation/optim/simplify-neg-add-cte.c
new file mode 100644
index 000000000000..4e425096a489
--- /dev/null
+++ b/validation/optim/simplify-neg-add-cte.c
@@ -0,0 +1,12 @@
+#define C 3
+
+int foo(int x) { return -(x + C) == (-3 - x); }
+
+/*
+ * check-name: simplify-neg-add-cte
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-contains: ret\\..*\\$1
+ */
diff --git a/validation/optim/simplify-neg-not.c b/validation/optim/simplify-neg-not.c
new file mode 100644
index 000000000000..4bd0abfb0628
--- /dev/null
+++ b/validation/optim/simplify-neg-not.c
@@ -0,0 +1,10 @@
+int foo(int x) { return -(~x) == x + 1; }
+
+/*
+ * check-name: simplify-neg-not
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-contains: ret\\..*\\$1
+ */
diff --git a/validation/optim/simplify-neg-sub.c b/validation/optim/simplify-neg-sub.c
new file mode 100644
index 000000000000..b73c9e5e66b4
--- /dev/null
+++ b/validation/optim/simplify-neg-sub.c
@@ -0,0 +1,10 @@
+int foo(int x, int y) { return -(x - y) == (y - x); }
+
+/*
+ * check-name: simplify-neg-sub
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-contains: ret\\..*\\$1
+ */
diff --git a/validation/optim/simplify-not-add-cte.c b/validation/optim/simplify-not-add-cte.c
new file mode 100644
index 000000000000..cf7fe2f27258
--- /dev/null
+++ b/validation/optim/simplify-not-add-cte.c
@@ -0,0 +1,12 @@
+#define C 3
+
+int foo(int x) { return ~(x + C) == (~C - x); }
+
+/*
+ * check-name: simplify-not-add-cte
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-contains: ret\\..*\\$1
+ */
diff --git a/validation/optim/simplify-not-neg.c b/validation/optim/simplify-not-neg.c
new file mode 100644
index 000000000000..b9675ea62049
--- /dev/null
+++ b/validation/optim/simplify-not-neg.c
@@ -0,0 +1,10 @@
+int foo(int x) { return ~(-x) == (x - 1); }
+
+/*
+ * check-name: simplify-not-neg
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-contains: ret\\..*\\$1
+ */
diff --git a/validation/optim/simplify-not-sub-cte.c b/validation/optim/simplify-not-sub-cte.c
new file mode 100644
index 000000000000..ec105beb31fe
--- /dev/null
+++ b/validation/optim/simplify-not-sub-cte.c
@@ -0,0 +1,12 @@
+#define C 3
+
+int foo(int x) { return ~(C - x) == (x + ~C); }
+
+/*
+ * check-name: simplify-not-sub-cte
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-contains: ret\\..*\\$1
+ */
diff --git a/validation/optim/simplify-not-xor-cte.c b/validation/optim/simplify-not-xor-cte.c
new file mode 100644
index 000000000000..d3046f208fce
--- /dev/null
+++ b/validation/optim/simplify-not-xor-cte.c
@@ -0,0 +1,12 @@
+#define C 3
+
+int foo(int x) { return ~(x ^ C) == (x ^ ~C); }
+
+/*
+ * check-name: simplify-not-xor-cte
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-contains: ret\\..*\\$1
+ */
-- 
2.28.0

