Return-Path: <SRS0=5g4H=CP=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0BDC10DAA
	for <linux-sparse@archiver.kernel.org>; Sun,  6 Sep 2020 21:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 857872078E
	for <linux-sparse@archiver.kernel.org>; Sun,  6 Sep 2020 21:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0tUFG+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgIFVQ4 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 6 Sep 2020 17:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgIFVQz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Sep 2020 17:16:55 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815B6C061573
        for <linux-sparse@vger.kernel.org>; Sun,  6 Sep 2020 14:16:54 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id q21so10875210edv.1
        for <linux-sparse@vger.kernel.org>; Sun, 06 Sep 2020 14:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4RvASQp697oa/3uRP/ARWgaf7UII+G8tFQcNyJvLWiE=;
        b=c0tUFG+5HKK8PjFn2RovJ3VdLi7C+xvEgxivBAakOkbmO5cHkIEo1p3sLV8AZcPJQD
         P7WGBgd5OreF9VkeNbtwJl79IMeiFzzjXLvDJXbIcmc7OzP8m+1WHDimdb59nndzTwP6
         cOVAe9eJbL55Tyqwg0fOJmhVC9YibuYp6F1xvkHgq/PWojLmabgX2kfH2oEq5gENpKpG
         +uGxTzjCYUgqyaMTQlURfUN0gTqn1yzaW2Sb9oAubcwZM69xsQMoGYBG+iFUJniv6hqr
         qQbZE0eQCUQ3rFhaW/pv6rEOU2s4om/QD+SNoTLOGX6p4YJbw5C7qedkM3rVXkHoPFZs
         TUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4RvASQp697oa/3uRP/ARWgaf7UII+G8tFQcNyJvLWiE=;
        b=VIvY/d1OOohZY+/HWmdxMjrbTWc2sH5pKZ0KNJ1sLRJwNMV0cy0oKru7QJMkt2byg3
         aJs3ojx3YIqxRZNQ+wiCgGzAQSgiqnFyeA/pCV2lLyn+vu/v4U87T9rkmxay7zYOnJQj
         z6yl3vgQe+c58SfN7xkUPHWWSMRf7xaK9UuyKP9U9umQCbsiabMx/KeQwe614IIQqoye
         5gqAD6j+PQbzn7n4PQ4PWIEkPZ6qF6xCWwyiI0GR8tiAEzexqF11r1ovPa+e+H167xm2
         o896odkrVGlNu0A302kaUVYNTCcS4R9QB2ws1jXIx9PzKY0beSyIRC4GcNkjNSxdej0q
         QMsw==
X-Gm-Message-State: AOAM531DNCtNxyRa+wtV3ELX1xoKeQT6JPUx+CuXL4PjhDrfJwfF3YZf
        L6/Iey0HHW3js9yIQHu+3395gwB968M=
X-Google-Smtp-Source: ABdhPJzUpfTf274/rbwJAG4PAcnDLvTT4k/LuS7SXwcR3ev2UmWXz7kQRxcdDQPMNtnuuAnxmV8twQ==
X-Received: by 2002:aa7:db02:: with SMTP id t2mr18581122eds.95.1599427012596;
        Sun, 06 Sep 2020 14:16:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:1c0f:34d8:de78:ecc0])
        by smtp.gmail.com with ESMTPSA id e4sm13057645ejk.76.2020.09.06.14.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 14:16:52 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 3/3] add more testcases for AND/OR simplification
Date:   Sun,  6 Sep 2020 23:16:46 +0200
Message-Id: <20200906211646.58946-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200906211646.58946-1-luc.vanoostenryck@gmail.com>
References: <20200906211646.58946-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Add a few testcases showing the effectiveness of these
simplifications and to catch possible future regressions.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/optim/and-lsr-or-shl0.c | 13 +++++++++++++
 validation/optim/and-lsr-or-shl1.c | 13 +++++++++++++
 validation/optim/and-shl-or-lsr0.c | 13 +++++++++++++
 validation/optim/lsr-or-lsr0.c     | 22 ++++++++++++++++++++++
 validation/optim/trunc-or-shl0.c   | 22 ++++++++++++++++++++++
 5 files changed, 83 insertions(+)
 create mode 100644 validation/optim/and-lsr-or-shl0.c
 create mode 100644 validation/optim/and-lsr-or-shl1.c
 create mode 100644 validation/optim/and-shl-or-lsr0.c
 create mode 100644 validation/optim/lsr-or-lsr0.c
 create mode 100644 validation/optim/trunc-or-shl0.c

diff --git a/validation/optim/and-lsr-or-shl0.c b/validation/optim/and-lsr-or-shl0.c
new file mode 100644
index 000000000000..46ab1bde5249
--- /dev/null
+++ b/validation/optim/and-lsr-or-shl0.c
@@ -0,0 +1,13 @@
+// =>	0
+unsigned int and_lsr_or_shl0(unsigned int a, unsigned int b)
+{
+	return ((a | b << 12) >> 12) & 0xfff00000;
+}
+
+/*
+ * check-name: and-lsr-or-shl0
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-excludes: shl\\.
+ */
diff --git a/validation/optim/and-lsr-or-shl1.c b/validation/optim/and-lsr-or-shl1.c
new file mode 100644
index 000000000000..22fee362b16b
--- /dev/null
+++ b/validation/optim/and-lsr-or-shl1.c
@@ -0,0 +1,13 @@
+// =>	(((a | b << 12) >> 12)
+unsigned int and_lsr_or_shl1(unsigned int a, unsigned int b)
+{
+	return ((a | b << 12) >> 12) & 0x000fffff;
+}
+
+/*
+ * check-name: and-lsr-or-shl1
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-excludes: shl\\.
+ */
diff --git a/validation/optim/and-shl-or-lsr0.c b/validation/optim/and-shl-or-lsr0.c
new file mode 100644
index 000000000000..f2a7cc631258
--- /dev/null
+++ b/validation/optim/and-shl-or-lsr0.c
@@ -0,0 +1,13 @@
+unsigned and_shl_or_lsr0(unsigned a, unsigned b)
+{
+	return ((a | (b >> 12)) << 12) & 0xfff00000;
+}
+
+/*
+ * check-name: and-shl-or-lsr0
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-excludes: or\\.
+ */
diff --git a/validation/optim/lsr-or-lsr0.c b/validation/optim/lsr-or-lsr0.c
new file mode 100644
index 000000000000..aad4aa7fda56
--- /dev/null
+++ b/validation/optim/lsr-or-lsr0.c
@@ -0,0 +1,22 @@
+#define	S	12
+
+//	((x >> S') | y) >> S;
+// ->	((x >> S' >> S) | (y >> S)
+// ->	((x >> 32) | (y >> S)
+// =>	(y >> S)
+
+int lsr_or_lsr0(unsigned int x, unsigned int b)
+{
+	return ((x >> (32 - S)) | b) >> S;
+}
+
+/*
+ * check-name: lsr-or-lsr0
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-pattern(1): lsr\\.
+ * check-output-excludes: and\\.
+ * check-output-excludes: or\\.
+ */
diff --git a/validation/optim/trunc-or-shl0.c b/validation/optim/trunc-or-shl0.c
new file mode 100644
index 000000000000..ab92aca1b711
--- /dev/null
+++ b/validation/optim/trunc-or-shl0.c
@@ -0,0 +1,22 @@
+// => TRUNC(b, 8)
+char trunc_or_shl0a(unsigned a, unsigned b)
+{
+	return (a << 8) | b;
+}
+
+// => TRUNC(a, 8)
+char trunc_or_shl0b(unsigned a, unsigned b)
+{
+	return a | (b << 8);
+}
+
+/*
+ * check-name: trunc-or-shl0
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-excludes: or\\.
+ * check-output-excludes: shl\\.
+ * check-output-pattern(2): %arg
+ */
-- 
2.28.0

