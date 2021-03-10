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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F0FC4332E
	for <linux-sparse@archiver.kernel.org>; Wed, 10 Mar 2021 22:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC5F764FC3
	for <linux-sparse@archiver.kernel.org>; Wed, 10 Mar 2021 22:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbhCJWLO (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 10 Mar 2021 17:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbhCJWLC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 10 Mar 2021 17:11:02 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929B3C061574
        for <linux-sparse@vger.kernel.org>; Wed, 10 Mar 2021 14:11:02 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ox4so26299816ejb.11
        for <linux-sparse@vger.kernel.org>; Wed, 10 Mar 2021 14:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ztCjPU6H5NUjyIzKarCMxklwx0LRyOBxLTvY6YHpE1c=;
        b=WGR4ZDS1z2rCDSn96/YTUn+Xbn1PD+GMWM7+K6NkjHV2382M501LTE8cf1JE0UhASg
         4n72BcqP5OhfaChYMP3FGA3jv6Bvv7sQdLX9tq6c5ayQtPqY1I0YhXsZEwWafFAmU6VB
         VEnNtAwkKMeFb2eZAk40TsiKqL1CArEbYPIvlmiHqu7Ys6qdAg4lvK5wRsvEYxqm4Ph1
         sc6TXKIaqUrQRkYf7p4aXL29Wa/ydIIpV26BIC7NWJHvtCkTQgxywU1Lap184iZbTAGR
         yMw7SlDjjqaXmXuRdoOGOSKcIkKZX+1S8Gj5PjhpQmGkh2Hc9KLDGfeNjwHTdfCfMOVH
         ji8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ztCjPU6H5NUjyIzKarCMxklwx0LRyOBxLTvY6YHpE1c=;
        b=sSMvapWKJ6IQu80SuwGuKgDpD5DGIg0xIpTXn+9jXlDALLHC+cZs2fTbpiVtLnDndo
         6peZ0neQyrIlPaGB2Gm7ADyfiLVQpWoA7ivn3Eck2Fvkw9WZFHfmSOorRvfPeId/a1HE
         qcw+VGwU4GFMeoSbQqflMFf3st2+NIY/aNYdW5PhRLiV5iHceWmuAW/IarAEDKUjazeM
         yPLzF+srellwZnmqLQhvKtndylHJpDaxDh9btquWGTsSMQwNaLmlSdCxGzG4nkJ2iQE0
         srNJ/TMuPW19xIxqnws73JLjPqcq4Y9KEVpaQ6OSJv8hd/HfRGb9p7+sDCz9xjY3Ewif
         WhiA==
X-Gm-Message-State: AOAM530yyq9dmmYGvRFhsOT9y+Ey6dPHMYBwWcuzvu2ROnjNn0nVIgRa
        +kG7isCBQdz+do+SMuWkfaB/M4CKLrY=
X-Google-Smtp-Source: ABdhPJyQXEv1hAPrNqId1eieZju1khNoW1SJOo1iLtSqxFMYt2qIk/xDo0dKsKE2mB7slQiRC7pxgw==
X-Received: by 2002:a17:906:b4c:: with SMTP id v12mr77333ejg.330.1615414261319;
        Wed, 10 Mar 2021 14:11:01 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:196c:c08:d4ab:a1ba])
        by smtp.gmail.com with ESMTPSA id ld19sm344326ejb.102.2021.03.10.14.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 14:11:00 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/9] add testcases for constant compares against AND/OR
Date:   Wed, 10 Mar 2021 22:49:43 +0100
Message-Id: <20210310214950.84192-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210310214950.84192-1-luc.vanoostenryck@gmail.com>
References: <20210310214950.84192-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/optim/cmpe-and0.c  | 11 +++++++++++
 validation/optim/cmpe-or0.c   | 11 +++++++++++
 validation/optim/cmps-and0.c  | 22 ++++++++++++++++++++++
 validation/optim/cmps-or0.c   | 22 ++++++++++++++++++++++
 validation/optim/cmps0-and0.c | 13 +++++++++++++
 validation/optim/cmpu-and0.c  | 18 ++++++++++++++++++
 validation/optim/cmpu-or0.c   | 19 +++++++++++++++++++
 7 files changed, 116 insertions(+)
 create mode 100644 validation/optim/cmpe-and0.c
 create mode 100644 validation/optim/cmpe-or0.c
 create mode 100644 validation/optim/cmps-and0.c
 create mode 100644 validation/optim/cmps-or0.c
 create mode 100644 validation/optim/cmps0-and0.c
 create mode 100644 validation/optim/cmpu-and0.c
 create mode 100644 validation/optim/cmpu-or0.c

diff --git a/validation/optim/cmpe-and0.c b/validation/optim/cmpe-and0.c
new file mode 100644
index 000000000000..7db608365568
--- /dev/null
+++ b/validation/optim/cmpe-and0.c
@@ -0,0 +1,11 @@
+int cmpe_and_eq(int a) { return ((a & 0xff00) == 0xff01) + 1; }
+int cmpe_and_ne(int a) { return ((a & 0xff00) != 0xff01) + 0; }
+
+/*
+ * check-name: cmpe-and0
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/cmpe-or0.c b/validation/optim/cmpe-or0.c
new file mode 100644
index 000000000000..bef2316120f7
--- /dev/null
+++ b/validation/optim/cmpe-or0.c
@@ -0,0 +1,11 @@
+int cmp_eq(int a) { return ((a | 1) != 0) + 0; }
+int cmp_ne(int a) { return ((a | 1) == 0) + 1; }
+
+/*
+ * check-name: cmpe-or0
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/cmps-and0.c b/validation/optim/cmps-and0.c
new file mode 100644
index 000000000000..097ec2f9f16c
--- /dev/null
+++ b/validation/optim/cmps-and0.c
@@ -0,0 +1,22 @@
+#define MINUS_ONE	-1
+#define MASK		32
+
+
+int cmps_and_lt_lt0(int a) { return ((a & MASK) <  MINUS_ONE)  + 1; }
+int cmps_and_lt_gtm(int a) { return ((a & MASK) <  (MASK + 1)) + 0; }
+int cmps_and_le_lt0(int a) { return ((a & MASK) <= MINUS_ONE)  + 1; }
+int cmps_and_le_gtm(int a) { return ((a & MASK) <= (MASK + 1)) + 0; }
+
+int cmps_and_gt_lt0(int a) { return ((a & MASK) >  MINUS_ONE)  + 0; }
+int cmps_and_gt_gtm(int a) { return ((a & MASK) >  (MASK + 1)) + 1; }
+int cmps_and_ge_lt0(int a) { return ((a & MASK) >= MINUS_ONE)  + 0; }
+int cmps_and_ge_gtm(int a) { return ((a & MASK) >= (MASK + 1)) + 1; }
+
+/*
+ * check-name: cmps-and0
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/cmps-or0.c b/validation/optim/cmps-or0.c
new file mode 100644
index 000000000000..40a2092c58a4
--- /dev/null
+++ b/validation/optim/cmps-or0.c
@@ -0,0 +1,22 @@
+#define EQ(X)		+ (X == 0)
+#define SIGN		(1 << 31)
+#define MASK		(SIGN | 32)
+
+
+int cmps_ior_lt_x(int a) { return ((a | MASK) <  4) EQ(1); }
+int cmps_ior_lt_0(int a) { return ((a | MASK) <  0) EQ(1); }
+int cmps_ior_le_x(int a) { return ((a | MASK) <= 4) EQ(1); }
+int cmps_ior_le_0(int a) { return ((a | MASK) <= 0) EQ(1); }
+int cmps_ior_ge_x(int a) { return ((a | MASK) >= 4) EQ(0); }
+int cmps_ior_ge_0(int a) { return ((a | MASK) >= 0) EQ(0); }
+int cmps_ior_gt_x(int a) { return ((a | MASK) >  4) EQ(0); }
+int cmps_ior_gt_0(int a) { return ((a | MASK) >  0) EQ(0); }
+
+/*
+ * check-name: cmps-or0
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/cmps0-and0.c b/validation/optim/cmps0-and0.c
new file mode 100644
index 000000000000..819a1dc2a793
--- /dev/null
+++ b/validation/optim/cmps0-and0.c
@@ -0,0 +1,13 @@
+#define M		32
+
+int cmps_and_sle0(int a) { return ((a & M) <= 0) == ((a & M) == 0); }
+int cmps_and_sgt0(int a) { return ((a & M) >  0) == ((a & M) != 0); }
+
+/*
+ * check-name: cmps0-and
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/cmpu-and0.c b/validation/optim/cmpu-and0.c
new file mode 100644
index 000000000000..253212941779
--- /dev/null
+++ b/validation/optim/cmpu-and0.c
@@ -0,0 +1,18 @@
+#define MASK		32U
+
+
+int cmps_and_ltu_gt(int a) { return ((a & MASK) <  (MASK + 1)) + 0; }
+int cmps_and_leu_gt(int a) { return ((a & MASK) <= (MASK + 1)) + 0; }
+int cmps_and_leu_eq(int a) { return ((a & MASK) <= (MASK + 0)) + 0; }
+int cmps_and_geu_gt(int a) { return ((a & MASK) >= (MASK + 1)) + 1; }
+int cmps_and_gtu_gt(int a) { return ((a & MASK) >  (MASK + 1)) + 1; }
+int cmps_and_gtu_eq(int a) { return ((a & MASK) >  (MASK + 0)) + 1; }
+
+/*
+ * check-name: cmpu-and0
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/cmpu-or0.c b/validation/optim/cmpu-or0.c
new file mode 100644
index 000000000000..77360d3feb0f
--- /dev/null
+++ b/validation/optim/cmpu-or0.c
@@ -0,0 +1,19 @@
+#define EQ(X)		+ (X == 0)
+#define MASK		32U
+
+
+int cmpu_ior_lt_lt(int a) { return ((a | MASK) <  (MASK - 1)) EQ(0); }
+int cmpu_ior_lt_eq(int a) { return ((a | MASK) <  (MASK    )) EQ(0); }
+int cmpu_ior_le_lt(int a) { return ((a | MASK) <= (MASK - 1)) EQ(0); }
+int cmpu_ior_ge_lt(int a) { return ((a | MASK) >= (MASK - 1)) EQ(1); }
+int cmpu_ior_ge_eq(int a) { return ((a | MASK) >= (MASK    )) EQ(1); }
+int cmpu_ior_gt_lt(int a) { return ((a | MASK) >  (MASK - 1)) EQ(1); }
+
+/*
+ * check-name: cmpu-or0
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
-- 
2.30.0

