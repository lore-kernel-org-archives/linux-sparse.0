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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DF0C43461
	for <linux-sparse@archiver.kernel.org>; Sun,  6 Sep 2020 12:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A76F9208B3
	for <linux-sparse@archiver.kernel.org>; Sun,  6 Sep 2020 12:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S733cBxu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgIFMlU (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 6 Sep 2020 08:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728542AbgIFMlI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Sep 2020 08:41:08 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B25FC061575
        for <linux-sparse@vger.kernel.org>; Sun,  6 Sep 2020 05:40:47 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id i26so14293080ejb.12
        for <linux-sparse@vger.kernel.org>; Sun, 06 Sep 2020 05:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lZmnknJgZbE5l1SQAl8BMcw2os7U3h4tWBKfEbcJqUo=;
        b=S733cBxubl1J7d/s275y6KKbfFcQSlK64mbC6Y9M8WV8v+r2arrfRw2+0pHGZlmSiJ
         Fhdn9ik2bdC4u+5394lmG9+7y04qVgIBQ0B1gkvAkrbhGoGUPnuRGVc8SmBBCGJYcBDP
         Uo0CkgXevkuwNUHxpwzt+vRZnjvV4lR/59hJq49hmurhn0WGHrQ9uhd9YgHzTbZyZU2z
         UCpxtDduuKY6b4dscvG1mC62zDUQcLADZh4kVd56hcOni99T3VKG5ac/yzO3b+9Wgycx
         tNF1jAM5leUtmec1vcrcAjv38CZBfjc5U2QXWs/Ls/VGWpuwuKn7X47QnrxVs/nwiysL
         8x0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lZmnknJgZbE5l1SQAl8BMcw2os7U3h4tWBKfEbcJqUo=;
        b=cWCgf31B1/21OadkjZM19nxAseEXP/JSoAcNRBOgPi3aVpg4PjcpAj91E85Hjf5sQ5
         ug50VhTecEe1bEBA0w+N9cPhYWVACc2PBbiWkeSjf5iIE2DWSJ0h6ZahAl7zDOcZ5G0D
         jxDoobB3X/GmVrYhYOVYmmBPruxw8h9PMfhVolLgz3gFQSDV5fOG/Wo9Tsoa0UysQLk6
         eak4LxNtuHHanksGHizBB1efaknvN95ENF68642nVm8kjj6sqrjckhNBKYf5Ye3yKiG9
         6Y/8SzRpvRCa/U+1jvvcItYQe12UAHGG00Y6STCBjjh/AG3HW7ScALhEg+NhDQtxTFlY
         varQ==
X-Gm-Message-State: AOAM530TlzwmDAaB1Xd/q89do+gw3AkPxSkulmoB5L4rZyhBjiwS6NiD
        E/ZXyC3tzOPz7kWX8H2W6DgiyjFHpY8=
X-Google-Smtp-Source: ABdhPJx0uY2kRJUq9080j0Tk/MhPvyXgU6V4/NZCLMFvuIXlsqgAMf1r/NWswrhVHE3hyyiz71YFjw==
X-Received: by 2002:a17:906:84f7:: with SMTP id zp23mr16070756ejb.203.1599396045276;
        Sun, 06 Sep 2020 05:40:45 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:6c5d:e4e0:a162:77b6])
        by smtp.gmail.com with ESMTPSA id b6sm11591124eds.46.2020.09.06.05.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 05:40:44 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/3] add more testcases for AND/OR simplification
Date:   Sun,  6 Sep 2020 14:40:37 +0200
Message-Id: <20200906124038.46786-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200906124038.46786-1-luc.vanoostenryck@gmail.com>
References: <20200906124038.46786-1-luc.vanoostenryck@gmail.com>
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
 validation/optim/and-lsr-or-shl0.c | 12 ++++++++++++
 validation/optim/and-lsr-or-shl1.c | 12 ++++++++++++
 validation/optim/and-shl-or-lsr0.c | 13 +++++++++++++
 validation/optim/lsr-or-lsr0.c     | 20 ++++++++++++++++++++
 validation/optim/trunc-or-shl0.c   | 19 +++++++++++++++++++
 5 files changed, 76 insertions(+)
 create mode 100644 validation/optim/and-lsr-or-shl0.c
 create mode 100644 validation/optim/and-lsr-or-shl1.c
 create mode 100644 validation/optim/and-shl-or-lsr0.c
 create mode 100644 validation/optim/lsr-or-lsr0.c
 create mode 100644 validation/optim/trunc-or-shl0.c

diff --git a/validation/optim/and-lsr-or-shl0.c b/validation/optim/and-lsr-or-shl0.c
new file mode 100644
index 000000000000..e2a517ab65c4
--- /dev/null
+++ b/validation/optim/and-lsr-or-shl0.c
@@ -0,0 +1,12 @@
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
index 000000000000..6f2d05a0bfdd
--- /dev/null
+++ b/validation/optim/and-lsr-or-shl1.c
@@ -0,0 +1,12 @@
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
index 000000000000..a1687ec21ff0
--- /dev/null
+++ b/validation/optim/lsr-or-lsr0.c
@@ -0,0 +1,20 @@
+#define	S	12
+
+//	((x >> S') | y) >> S;
+// ->	((x >> S >> S) | (y >> S)
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
index 000000000000..4d85a6bd4ec4
--- /dev/null
+++ b/validation/optim/trunc-or-shl0.c
@@ -0,0 +1,19 @@
+char trunc_or_shl0a(unsigned a, unsigned b)
+{
+	return (a << 8) | b;
+}
+
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
+ */
-- 
2.28.0

