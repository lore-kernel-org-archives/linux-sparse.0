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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E37C43461
	for <linux-sparse@archiver.kernel.org>; Sun,  6 Sep 2020 21:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96DC5207BC
	for <linux-sparse@archiver.kernel.org>; Sun,  6 Sep 2020 21:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJ+yxVz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgIFVQ4 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 6 Sep 2020 17:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgIFVQz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Sep 2020 17:16:55 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6F6C061574
        for <linux-sparse@vger.kernel.org>; Sun,  6 Sep 2020 14:16:54 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p9so15454087ejf.6
        for <linux-sparse@vger.kernel.org>; Sun, 06 Sep 2020 14:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zo+NEiD/MMIF89tmV2vusuLXbCEMBh1434gun3iDK5o=;
        b=hJ+yxVz6hF1mgGOYzlNZaAhklbOQtfoWeM7ssmSWFn7TqDB5cvfiPquIeocicF9uym
         wWP5QQKsV4dsPHY9FBHt4+pomultuwLLjTh7bG0+dNsWKMZD6E5fSVch4AIqBRdIpPwi
         y1Y8sfqgeOeQWE7L2Kl0XEYBX7Vf97O9oahtNtrpQFUo/2y1Kjtq3OgcMS6vGM4nY4I5
         EzghS+GgBqD51A990GyaeCh+XnPXnRJqllCcxmN8nUgsiIL3PYRWsp8ltMsgSQpk0sA2
         4d3pmZA1DoCBgsR+Nkt6mFYToKsE0AdFAzzvAlYrQQDliovNNQkr5BmJvD+NXM1Ms1CU
         zgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zo+NEiD/MMIF89tmV2vusuLXbCEMBh1434gun3iDK5o=;
        b=Uuv0bXLhgCnnHmC7xGV+/UxkLC0vcZLZt626s3UBjLx7ghLp+ZIgWJvFHJ4GUbqyAZ
         gKlihyenpHIIJ8+HdtdNKHBIATcV4T1RYgiKgmYZdCutEs+kBQPEqD8GRmahNzjVPMI/
         WPounqJeTkUrS4dkdi10XbV13GdIf48hxgwCNMcI4l39hKkRKGGam0cXFMXg9+ctE1UZ
         VCelDQjPjmaKpgp693Q2taZ2S3FotTDzBUNO4fmxdrOWXPGAzaZjFp93h1c0G4y+/z8w
         bdku69GsWQUrIkjDmom74MHz/78okISefsTKheSJRlXqWvjJnUD1vlGQXS/+OfvDlQ2x
         GhHg==
X-Gm-Message-State: AOAM532a6gXTVJSKkpDuWopeP2Rv3Bo9uW7C5xwbb9ZQwzEoVQFPqOU8
        QjaZStI1qRMrWcgcrOXbKzMQ2Z0OXOM=
X-Google-Smtp-Source: ABdhPJz7L/Z6ciyslDbHaXcdK9VAQpU4sfjYk79S83pixzNnUkpSCg7SLNK9GzxGY8jdxqtVjtFW8g==
X-Received: by 2002:a17:907:4035:: with SMTP id nk5mr13346852ejb.418.1599427011740;
        Sun, 06 Sep 2020 14:16:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:1c0f:34d8:de78:ecc0])
        by smtp.gmail.com with ESMTPSA id e4sm13057645ejk.76.2020.09.06.14.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 14:16:51 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 2/3] add more testcases for existing AND/OR simplifications
Date:   Sun,  6 Sep 2020 23:16:45 +0200
Message-Id: <20200906211646.58946-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200906211646.58946-1-luc.vanoostenryck@gmail.com>
References: <20200906211646.58946-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Add a few more testcases to catch possible future regressions.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/optim/and-shl-or-and0.c  | 15 +++++++++++++++
 validation/optim/lsr-or-and0.c      | 22 ++++++++++++++++++++++
 validation/optim/shl-or-constant0.c | 12 ++++++++++++
 validation/optim/shl-or-constant1.c | 12 ++++++++++++
 validation/optim/shl-or-constant2.c | 12 ++++++++++++
 5 files changed, 73 insertions(+)
 create mode 100644 validation/optim/and-shl-or-and0.c
 create mode 100644 validation/optim/lsr-or-and0.c
 create mode 100644 validation/optim/shl-or-constant0.c
 create mode 100644 validation/optim/shl-or-constant1.c
 create mode 100644 validation/optim/shl-or-constant2.c

diff --git a/validation/optim/and-shl-or-and0.c b/validation/optim/and-shl-or-and0.c
new file mode 100644
index 000000000000..298dcb434fc7
--- /dev/null
+++ b/validation/optim/and-shl-or-and0.c
@@ -0,0 +1,15 @@
+// =>	(b << 12) & 0xfff00000
+unsigned and_shl_or_and0(unsigned a, unsigned b)
+{
+	return (((a & 0xfff00000) | b) << 12) & 0xfff00000;
+}
+
+/*
+ * check-name: and-shl-or-and0
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-excludes: or\\.
+ * check-output-excludes: lsr\\.
+ * check-output-excludes: %arg1\\.
+ */
diff --git a/validation/optim/lsr-or-and0.c b/validation/optim/lsr-or-and0.c
new file mode 100644
index 000000000000..fe3a2649eea2
--- /dev/null
+++ b/validation/optim/lsr-or-and0.c
@@ -0,0 +1,22 @@
+#define	S	12
+
+//	((x & M) | b) >> S;
+// ->	((x >> S) & (M >> S)) | (b >> S)
+// but	(M >> S) == 0
+// =>	(b >> S)
+
+int lsr_or_and0a(unsigned int x, unsigned int b)
+{
+	return ((x & 0x00000fff) | b) >> S;
+}
+
+/*
+ * check-name: lsr-or-and0
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-pattern(1): lsr\\.
+ * check-output-excludes: %arg1\\.
+ * check-output-excludes: and\\.
+ * check-output-excludes: or\\.
+ */
diff --git a/validation/optim/shl-or-constant0.c b/validation/optim/shl-or-constant0.c
new file mode 100644
index 000000000000..25347b4b3b20
--- /dev/null
+++ b/validation/optim/shl-or-constant0.c
@@ -0,0 +1,12 @@
+unsigned shl_or_constant0(unsigned a)
+{
+	return (a | 0xfff00000) << 12;
+}
+
+/*
+ * check-name: shl-or-constant0
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-excludes: or\\.
+ */
diff --git a/validation/optim/shl-or-constant1.c b/validation/optim/shl-or-constant1.c
new file mode 100644
index 000000000000..cd3ea8bb011b
--- /dev/null
+++ b/validation/optim/shl-or-constant1.c
@@ -0,0 +1,12 @@
+unsigned shl_or_constant1(unsigned a)
+{
+	return (a | 0x000fffff) << 12;
+}
+
+/*
+ * check-name: shl-or-constant1
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-contains: ret\\..*\\$0xfffff000
+ */
diff --git a/validation/optim/shl-or-constant2.c b/validation/optim/shl-or-constant2.c
new file mode 100644
index 000000000000..d4618eb1bab8
--- /dev/null
+++ b/validation/optim/shl-or-constant2.c
@@ -0,0 +1,12 @@
+unsigned shl_or_constant2(unsigned a)
+{
+	return (a | 0x00ffff0f) << 12;
+}
+
+/*
+ * check-name: shl-or-constant2
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-contains: or\\..*\\$0xfff0f
+ */
-- 
2.28.0

