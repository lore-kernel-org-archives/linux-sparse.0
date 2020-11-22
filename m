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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB98FC5519F
	for <linux-sparse@archiver.kernel.org>; Sun, 22 Nov 2020 15:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74D8720773
	for <linux-sparse@archiver.kernel.org>; Sun, 22 Nov 2020 15:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4oFMKWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbgKVP1j (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 22 Nov 2020 10:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgKVP1i (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 22 Nov 2020 10:27:38 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE68C0613CF
        for <linux-sparse@vger.kernel.org>; Sun, 22 Nov 2020 07:27:36 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id p22so15516998wmg.3
        for <linux-sparse@vger.kernel.org>; Sun, 22 Nov 2020 07:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hmr00zOWFqVtU2ZJqQ1XXCDojaeX8UGyp+GyZR8LHTU=;
        b=L4oFMKWdmod+yJtpifXvWwb+wUAkc0DAbWg9abJzaYljfYz/ITPgt8Z6wI7hcvIr5v
         JUMCQVSsMtYZIuF1zr2S0ZqWONemHLxHl/T9xLiFC5rNOtQq+C1Phnhvz0nP29Pm/X8h
         ROprJ+/TVOIQl/MDIMAWXNEwceMCZXVI5f8z46VYKY19QqyX70z7UZUDf3ao44sC4L1W
         wvuZWi7QBxQKN1H7TWGAIANyqcn2PZZ1gNeur8IsyKWeTMK3j6yVux2Xe/Qr/h5d1NAV
         cjiHVgZ/ZUcAQvbxEr/D+YeVg3Gacvf4TG0sD6M0nqcLhg3mMxHreVVFd30cYND3gsne
         aIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hmr00zOWFqVtU2ZJqQ1XXCDojaeX8UGyp+GyZR8LHTU=;
        b=dgoQIpCpp9CnPFtFK4b8/zDWO9uzma1PoKYVVJOgmWaqFDw2D5SiSLcNNJARbtYgyd
         EkV3wWQA5ILncVCXxLZe2nHO3n3rsvvgCrpT4YmhAJb5x30ZOYDmqWwWlLTJVwQrnFLX
         t/XrxcAfHxsNy2WtJA+pRgI7joXHOa3y/qYreD9jO1ubfu7ZBwf9l/50TxiBYBrFASGw
         CFkfeEBXWu9l3lM+pyYGpJzqEECPsSdLSJlv3F5b6U674WeRNWVSfyDJLGyDmjaLefsH
         Z2jbcUkT0Y2Q5eMfPvZsZECxZ+gq6CmNYZCAaLtND36vynv+oCEfFltEcdT4jbLBEfYW
         6dxg==
X-Gm-Message-State: AOAM532lbPwNXPPFfbvG/H0ZWG5UC5ya++UTNomShRKsSG3vGL4LDC0D
        FCRTwD1we9f+0sP6zH3bJbQ/boxId/E=
X-Google-Smtp-Source: ABdhPJxSSb52z2ecip1BhTYfdqikT4xAGl64IJPDjaly0mjxR2DfpdGPt61Crpu/UuYIC/+lJRJg7g==
X-Received: by 2002:a05:600c:2541:: with SMTP id e1mr20803299wma.185.1606058855288;
        Sun, 22 Nov 2020 07:27:35 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:b0e1:b041:18e2:46cf])
        by smtp.gmail.com with ESMTPSA id k1sm13712265wrp.23.2020.11.22.07.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 07:27:34 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/7] not: add testcases for canonicalization & simplification of negations
Date:   Sun, 22 Nov 2020 16:27:25 +0100
Message-Id: <20201122152731.10994-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201122152731.10994-1-luc.vanoostenryck@gmail.com>
References: <20201122152731.10994-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/optim/canonical-arg.c | 20 ++++++++++++++++++++
 validation/optim/canonical-not.c |  9 +++++++++
 validation/optim/cse-arg01.c     | 10 ++++++++++
 validation/optim/cse-not01.c     | 12 ++++++++++++
 validation/optim/cse-not02.c     | 12 ++++++++++++
 validation/optim/cse-reg01.c     | 10 ++++++++++
 6 files changed, 73 insertions(+)
 create mode 100644 validation/optim/canonical-arg.c
 create mode 100644 validation/optim/canonical-not.c
 create mode 100644 validation/optim/cse-arg01.c
 create mode 100644 validation/optim/cse-not01.c
 create mode 100644 validation/optim/cse-not02.c
 create mode 100644 validation/optim/cse-reg01.c

diff --git a/validation/optim/canonical-arg.c b/validation/optim/canonical-arg.c
new file mode 100644
index 000000000000..a8ecc9bd0083
--- /dev/null
+++ b/validation/optim/canonical-arg.c
@@ -0,0 +1,20 @@
+int def(void);
+
+int canon_arg_arg(int a, int b)
+{
+	return (a + b) == (b + a);
+}
+
+int canon_arg_reg(int a)
+{
+	int b = def();
+	return (a + b) == (b + a);
+}
+
+/*
+ * check-name: canonical-arg
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/canonical-not.c b/validation/optim/canonical-not.c
new file mode 100644
index 000000000000..9698590fd245
--- /dev/null
+++ b/validation/optim/canonical-not.c
@@ -0,0 +1,9 @@
+int canon_not(int a, int b) { return (a & ~b) == (~b & a); }
+
+/*
+ * check-name: canonical-not
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/cse-arg01.c b/validation/optim/cse-arg01.c
new file mode 100644
index 000000000000..c3f2963ffdeb
--- /dev/null
+++ b/validation/optim/cse-arg01.c
@@ -0,0 +1,10 @@
+int foo(int a, int b) { return (a < b) == (b > a); }
+
+/*
+ * check-name: cse-arg01
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/cse-not01.c b/validation/optim/cse-not01.c
new file mode 100644
index 000000000000..f87123f14f13
--- /dev/null
+++ b/validation/optim/cse-not01.c
@@ -0,0 +1,12 @@
+int and(int a) { return (~a & a) ==  0; }
+int ior(int a) { return (~a | a) == ~0; }
+int xor(int a) { return (~a ^ a) == ~0; }
+
+/*
+ * check-name: cse-not01
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/cse-not02.c b/validation/optim/cse-not02.c
new file mode 100644
index 000000000000..aa54a375a9ea
--- /dev/null
+++ b/validation/optim/cse-not02.c
@@ -0,0 +1,12 @@
+int and(int a, int b) { return ((a == b) & (a != b)) == 0; }
+int ior(int a, int b) { return ((a == b) | (a != b)) == 1; }
+int xor(int a, int b) { return ((a == b) ^ (a != b)) == 1; }
+
+/*
+ * check-name: cse-not02
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/cse-reg01.c b/validation/optim/cse-reg01.c
new file mode 100644
index 000000000000..938858f4649b
--- /dev/null
+++ b/validation/optim/cse-reg01.c
@@ -0,0 +1,10 @@
+int foo(int a, int b) { int x = a + b, y = ~b; return (x < y) == (y > x); }
+
+/*
+ * check-name: cse-reg01
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
-- 
2.29.2

